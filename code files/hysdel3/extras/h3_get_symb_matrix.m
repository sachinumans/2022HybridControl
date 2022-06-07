function [M, isthere] = h3_get_symb_matrix(F, x, vars, names, getoffset)

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


if nargin < 5
    getoffset = false;
end

if isa(F, 'double')
    M = {}; isthere = [];
    return
end
if ~isa(F, 'sdpvar')
    F = sdpvar(F);
end
M  = {};
x_vars = getvariables(x);
v_vars = getvariables(vars);
isthere = zeros(length(F), 1);

% if getoffset
%     vars_Fi = cell(1, length(F));
%     for i = 1:length(F)
%         vars_Fi{i} = intersect(getvariables(F(i)), x_vars);
%     end
%     vars_Fi;
% end

for i = 1:length(F)
    dep_Fi = depends(F(i));
    if ~any(ismember(dep_Fi, v_vars))
        % this constraint doesn't depend on any decision variables
        continue
    end
    isthere(i) = 1;   
    if getoffset
        % get the constant term
        m = 0;
        [c, v] = coefficients(F(i), x);
        for k = 1:length(v)
            if ~any(ismember(depends(v(k)), x_vars))
                m = m + c(k);
            end
        end
        m = {sub_print_symb_element(m, names)};

    else
        % get multipliers of decision variables
        m = cell(1, length(x));
        [m{:}] = deal(0);
        process = any(ismember(dep_Fi, x_vars));
        if ~process
            % this constraint doesn't depend on x, therefore the
            % multipliers are all zeros
            if isempty(M)
                M{1} = m;
            else
                M{end+1} = m;
            end
            continue
        end
        [c, v] = coefficients(F(i), x);
        v_disp = h3_sdisplay(v, names);
        added = false;
        deps_v = cell(1, length(v));
        for k = 1:length(v)
            deps_v{k} = depends(v(k));
        end
        n_x = length(x);
        n_v = length(v);
        for j = 1:n_x
            for k = 1:n_v;
                deps = deps_v{k};
                if length(deps) > 1
                    error('Nonlinear terms are not allowed.');
                end
                if isequal(x_vars(j), deps)
                    vv = v_disp{k};
                    if isempty(vv)
                        vv = '1';
                    end
                    if isa(c(k), 'double')
                        c_k = full(c(k));
                    else
                        c_k = c(k);
                    end
                    if vv(1) == '-'
                        m{j} = sub_print_symb_element(-c_k, names);
                    else
                        m{j} = sub_print_symb_element(c_k, names);
                    end
                    added = true;
                    break
                end
            end
        end
    end
    if isempty(M)
        M{1} = m;
    else
        M{end+1} = m;
    end
end
M = M';

%-------------------------------------------------
function a = sub_print_symb_element(m, names, i, j)

if isa(m, 'sdpvar')
    a = h3_sdisplay(m, names);
    a = a{1};
    % remove all "_internal" suffices automatically introduced by YALMIP's
    % internal operators
%     a = strrep(a, 'max_internal(', 'max(');
%     a = strrep(a, 'min_internal(', 'min(');
%     a = strrep(a, 'mpower_internal(', '(');
    
    
elseif isa(m, 'char')
    a = m;
else
    a = mat2str(m);
end
