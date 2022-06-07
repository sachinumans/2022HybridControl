function [M,m,infbound] = h3_derivebounds(f, Flin)

% Copyright is with the following author(s):
%
% (C) 2008-2010 Michal Kvasnica, Slovak University of Technology
%               michal.kvasnica@stuba.sk

% ------------------------------------------------------------------------
% Legal note:
%       This program is free software; you can redistribute it and/or
%       modify it under the terms of the GNU General Public
%       License as published by the Free Software Foundation; either
%       version 2.1 of the License, or (at your option) any later version.
%
%       This program is distributed in the hope that it will be useful,
%       but WITHOUT ANY WARRANTY; without even the implied warranty of
%       MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
%       General Public License for more details.
%
%       You should have received a copy of the GNU General Public
%       License along with this library; if not, write to the
%       Free Software Foundation, Inc.,
%       59 Temple Place, Suite 330,
%       Boston, MA  02111-1307  USA
%
% ------------------------------------------------------------------------


global H3_PARAMETERS H3_INF H3_OPTIMIZEMODEL

if isempty(H3_PARAMETERS) && ~H3_OPTIMIZEMODEL
    % non-symbolic models not requiring bound-optimization via linear
    % programming
    [M, m] = derivebounds(f);
    M(isnan(M)) = Inf;
    M(isinf(M)) = H3_INF;
    m(isnan(m)) = -Inf;
    m(isinf(m)) = -H3_INF;

else
    M = []; m = [];
    for i = 1:length(f)
        if H3_OPTIMIZEMODEL
            % optimize bounds of non-symbolic models using linear
            % programming
            [Mo, mo] = sub_optimize_bounds(f(i), Flin);
        else
            % get symbolic bounds
            [Mo, mo] = sub_symbolic_bounds(f(i));
        end
        if isa(Mo, 'double')
            Mo = full(Mo);
        end
        if isa(mo, 'double')
            mo = full(mo);
        end
        M = [M; Mo];
        m = [m; mo];
    end
end

infbound = zeros(size(M));

%------------------------------------------------------------------------
function [M,m] = sub_symbolic_bounds(f)
% derive (symbolic) bounds of a given affine expression

global H3_NAMES H3_SYMBOLIC_BOUNDS H3_VARIABLES
global H3_USE_SYMBOLIC_BOUNDS

[M, m, infbound] = derivebounds(f);
if ~infbound
    % precise numerical bounds found, exit
    return
end

[c, v] = coefficients(f, H3_VARIABLES);

% special case -- "parameter*1"
if isa(v, 'double') && length(v) == 1
    if v == 1
        M = c;
        m = c;
    else
        error('This case is not yet handled. Please report to michal.kvasnica@stuba.sk');
    end
    return
end

nv = length(v);
[Mx, mx, symbolic_bounds] = derivebounds(v);

symbolic_bounds = symbolic_bounds && H3_USE_SYMBOLIC_BOUNDS;

if symbolic_bounds
    Mx = cell(1, nv);
    mx = cell(1, nv);
    for i = 1:nv
        % find bounds of one variable
        [Mv, mv, infbound] = derivebounds(v(i));
        if infbound
            % bounds might be symbolic
            v_var = getvariables(v(i));
            Mv = sub_safe_get_minmax(1, v_var, v(i));
            mv = sub_safe_get_minmax(-1, v_var, v(i));
            Mx{i} = Mv;
            mx{i} = mv;
        else
            Mx{i} = full(Mv);
            mx{i} = full(mv);
        end
    end

else
    % % [Mx, mx] = h3_derivebounds(v);
    %
    nv = length(v);
    for i = 1:nv
        if isa(v(i), 'double')
            Mx(i) = full(v(i));
            mx(i) = full(v(i));
        end
    end
    Mx = full(Mx); mx = full(mx);
    [Mx_mx] = [mx Mx];
end

M = sdpvar(1, 1);
m = sdpvar(1, 1);

% let's consider a function f(x) = a1*x1 + a2*x2 + b
%
% if the parameters (a1, a2, b) can change sign, general expression for
% obtaining a maximum of f(x) is given by
%   max([a1*x1max+a2*x2max+b, a1*x1max+a2*x2min+b, ...
%        a1*x1min+a2*x2max+b, a1*x1min+a2*x2min+b])
%
% therefore we first prepare all combinations of minima-maxima
combs = unique(nchoosek(repmat([1 2], 1, nv), nv), 'rows');
nc = size(combs, 1);

% now we compute individual elements of the max() function

use_interval_arithmetics = false;

if use_interval_arithmetics
    % from interval arithmetics we have:
    %   [a,b] + [c,d] = [a+c, a+d]
    %   [a,b] * [c,d] = [min(a*c a*d b*c b*d) max(a*c a*d b*c b*d)]
    MM = 0;
    for i = 1:nv
        MM = MM + max(c(i)*Mx{i}, c(i)*mx{i});
    end
else 
    elements = {};
    Mx_mx_considered = zeros(0, nv);
    for i = 1:nc
        % combs(i, j)==1 means that now we take the minimum of the i-th variable
        % combs(i, j)==2 corresponds to the maximum
        comb_i = combs(i, :);
        e = 0;
        if symbolic_bounds
            for j = 1:nv
                if comb_i(j) == 1
                    e = e + mx{j}*c(j);
                else
                    e = e + Mx{j}*c(j);
                end
            end
            elements{end+1} = e;
        else
            minmax = zeros(nv, 1);
            minmax(comb_i==1) = Mx_mx(comb_i==1, 1);
            minmax(comb_i==2) = Mx_mx(comb_i==2, 2);
            minmax = minmax';
            if ~ismember(minmax, Mx_mx_considered, 'rows')
                % don't check the same combination of minima-maxima more than once
                Mx_mx_considered = [Mx_mx_considered; minmax];
                elements{end+1} = minmax*c;
            end
        end
    end
    
    % in matlab, we would now just take max([elements{:}]),
    % e.g. max([e1, e2, e3, e4]). in c#, however, we need to write it like
    % max(e1, max(e2, max(e3, e4)))
    MM = sub_recurse_minmax('max', elements);
end

name = h3_sdisplay(MM, H3_NAMES);
name = name{1};
name_max = strrep(name, 'max_internal(', 'max(');

% mm = min(Mx'*c, mx'*c);
if use_interval_arithmetics
    mm = 0;
    for i = 1:nv
        mm = mm + min(c(i)*Mx{i}, c(i)*mx{i});
    end
else
    mm = sub_recurse_minmax('min', elements);
end

name = h3_sdisplay(mm, H3_NAMES);
name = name{1};
name_min = strrep(name, 'min_internal(', 'min(');

Mv = getvariables(M);
mv = getvariables(m);
MMv = getvariables(MM);
mmv = getvariables(mm);
H3_SYMBOLIC_BOUNDS = [H3_SYMBOLIC_BOUNDS Mv];
H3_SYMBOLIC_BOUNDS = [H3_SYMBOLIC_BOUNDS mv];
H3_SYMBOLIC_BOUNDS = [H3_SYMBOLIC_BOUNDS MMv];
H3_SYMBOLIC_BOUNDS = [H3_SYMBOLIC_BOUNDS mmv];
for i = 1:length(Mv)
    H3_NAMES{Mv(i)} = name_max;
    H3_NAMES{mv(i)} = name_min;
end
for i = 1:length(MMv)
    H3_NAMES{MMv(i)} = 'h3_additional_minmax_placeholder';
end
for i = 1:length(mmv)
    H3_NAMES{mmv(i)} = 'h3_additional_minmax_placeholder';
end

%------------------------------------------------------------------------
function [M, m] = sub_optimize_bounds(f, Flin)

global H3_SDPSETTINGS_LP H3_IMPROVED_BOUNDS

obj = f;

sol = solvesdp(Flin, obj, H3_SDPSETTINGS_LP);
if sol.problem ~= 0
    % Johan said, if there are numerical problems, don't trust the solution!
    fprintf('Numerical problems, switching to derivebounds.\n');
    [M, m, infbound] = derivebounds(f);
    return
end
m = double(obj);

sol = solvesdp(Flin, -obj, H3_SDPSETTINGS_LP);
if sol.problem ~= 0
    % Johan said, if there are numerical problems, don't trust the solution!
    fprintf('Numerical problems, switching to derivebounds.\n');
    [M, m, infbound] = derivebounds(f);
    return
end
M = double(obj);

[MM, mm] = derivebounds(f);
if abs(mm - m) > abs(m)*1e-3
    H3_IMPROVED_BOUNDS = H3_IMPROVED_BOUNDS + 1;
end
if abs(MM - M) > abs(M)*1e-3
    H3_IMPROVED_BOUNDS = H3_IMPROVED_BOUNDS + 1;
end
% full([mm MM; m M])
% full([mm-m MM-M])


%---------------------------------------------------------
function out = sub_recurse_minmax(operator, elements)

if isempty(elements)
    out = [];
    return
end
if length(elements)==1
    out = elements{1};
    return
end
if isequal(operator, 'max')
    out = max(elements{1}, sub_recurse_minmax(operator, elements(2:end)));
else
    out = min(elements{1}, sub_recurse_minmax(operator, elements(2:end)));
end

%---------------------------------------------------------
function Mv = sub_safe_get_minmax(sign, v_var, v)

global H3_NAMES H3_BOUNDS_STACK H3_ALREADY_DISPLAYED H3_INF

failed = false;
try
    if sign==1
        Mv = H3_BOUNDS_STACK.max{v_var};
    else
        Mv = H3_BOUNDS_STACK.min{v_var};
    end
catch
    failed = true;
    Mv = [];
end
failed = failed | isempty(Mv);

if failed 
    % bounds are necessary but were not provided by the user, use default
    % and display a warning
    Mv = sign*H3_INF;
    var_name = h3_sdisplay(v, H3_NAMES);
    var_name = var_name{1};
    % was the message already displayed?
    if sign==1 && ~isempty(strmatch(var_name, H3_ALREADY_DISPLAYED.max, 'exact'))
        return
    elseif sign==-1 && ~isempty(strmatch(var_name, H3_ALREADY_DISPLAYED.min, 'exact'))
        return
    end
    
    if sign==1
        bound_type = 'upper';
    else
        bound_type = 'lower';
    end
    fprintf('Failed to compute %s bound of "%s", assuming ', ...
        bound_type, var_name);
    % remember that we have already displayed a warning
    if sign==1
        H3_ALREADY_DISPLAYED.max{end+1} = var_name;
        fprintf('%s\n', mat2str(H3_INF));
    else
        H3_ALREADY_DISPLAYED.min{end+1} = var_name;
        fprintf('-%s\n', mat2str(H3_INF));
    end
    
end
