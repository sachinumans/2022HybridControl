function Ftotal = h3_expandmodel_general(F)

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



global H3_SDPSETTINGS H3_SDPSETTINGS_LP 
global H3_IMPROVED_BOUNDS H3_OPTIMIZEMODEL
global H3_PARAMETERS
global H3_EXPAND_BOUNDS_FIRST H3_REORDER_INEQS

H3_IMPROVED_BOUNDS = 0;
H3_SDPSETTINGS = sdpsettings('verbose', 0);
H3_SDPSETTINGS_LP = H3_SDPSETTINGS;
H3_SDPSETTINGS_LP.expand = 0; 

if isempty(H3_PARAMETERS)
    sub_update_bounds(F);
end

% remember position of constraints such that we can reorder them later
F_pos = [];

% to optimize the bounds, we need to manually create implies() and iff()
% statements. therefore first we need to know which constraints correspond
% to implies() and iff() constructs

[Flin, Fimp, Fiff, Fife] = h3_classify_constraints(F);
try
    Flin = Flin - Flin('update');
end
try
    Flin = Flin - Flin('output');
end

Ftotal = set([]);
try
    Ftotal = Ftotal + expandmodel(F('update'), [], H3_SDPSETTINGS);
end
F_pos.update = [1:length(Ftotal)];

start_idx = length(Ftotal)+1;
try
    Ftotal = Ftotal + expandmodel(F('output'), [], H3_SDPSETTINGS);
end
end_idx = length(Ftotal);
F_pos.output = [start_idx:end_idx];

% after evey expandmodel() we have to update the bounds
sub_update_bounds(F+Ftotal);

% expand bounds first
if H3_EXPAND_BOUNDS_FIRST
    Fbounds = [];
    try
        Fbounds = Flin('bounds');
        Flin = Flin - Flin('bounds');
    end
    if ~isa(Fbounds, 'double')
        try
            Fboundsexp = expandmodel(Fbounds, [], H3_SDPSETTINGS);
            Ftotal = Ftotal + Fboundsexp;
            sub_update_bounds(F+Ftotal);
        catch
            fprintf('\nWARNING: failed to compute bounds!\n');
            fprintf('         report to michal.kvasnica@stuba.sk\n\n');
        end
    end
end

% MUST constraints
Fmust = set([]);
try
    Fmust = Flin('must');
    Flin = Flin - Fmust;
end

% LOGIC constraints
Flogic = set([]);
try
    Flogic = Flin('logic');
    Flin = Flin - Flogic;
end

% constraints defining additional binaries in DA, AUTOMATA and OUTPUT
Fautomata_d = set([]);
try
    Fautomata_d = Flin('automata_d');
    Flin = Flin - Fautomata_d;
end
try
    Fautomata_d = Fautomata_d + Flin('da_d');
    Flin = Flin - Flin('da_d');
end
try
    Fautomata_d = Fautomata_d + Flin('output_d');
    Flin = Flin - Flin('output_d');
end

% MUST items
start_idx = length(Ftotal)+1;
Fmustexp = expandmodel(Fmust, [], H3_SDPSETTINGS);
Ftotal = Ftotal + Fmustexp;
sub_update_bounds(F+Ftotal);
end_idx = length(Ftotal);
F_pos.must = [start_idx:end_idx];

% LOGIC items
start_idx = length(Ftotal)+1;
Flogicexp = expandmodel(Flogic, [], H3_SDPSETTINGS);
Ftotal = Ftotal + Flogicexp;
sub_update_bounds(F+Ftotal);
end_idx = length(Ftotal);
F_pos.logic = [start_idx:end_idx];

% LINEAR items
start_idx = length(Ftotal)+1;
Flinexp = expandmodel(Flin, [], H3_SDPSETTINGS);
Ftotal = Ftotal + Flinexp;
sub_update_bounds(F+Ftotal);
end_idx = length(Ftotal);
F_pos.linear = [start_idx:end_idx];

linear_constraints = Flinexp + Fmustexp + Flogicexp;

% DA items
%
% DA section should be processed before AD, since we can have something
% like this:
%   AD { d1 = z <= 0; }
%   DA { z = {IF d2 THEN a ELSE b}; }
% hence by processing the DA item first we can set bounds on "z", which
% will be exploited when translating the AD section
start_idx = length(Ftotal)+1;
for i = 1:length(Fife)
    Ftotal = Ftotal + sub_optimize_ifthenelse(Fife(i), linear_constraints);
    % after evey expandmodel() we have to update the bounds
    sub_update_bounds(F+Ftotal);
end
end_idx = length(Ftotal);
F_pos.da = [start_idx:end_idx];

% AD items
start_idx = length(Ftotal)+1;
for i = 1:length(Fiff)
    Ftotal = Ftotal + sub_optimize_iff(Fiff(i), linear_constraints);
    sub_update_bounds(F+Ftotal);
end
end_idx = length(Ftotal);
F_pos.iff = [start_idx:end_idx];

% additional binaries
start_idx = length(Ftotal)+1;
Fautodexp = expandmodel(Fautomata_d, [], H3_SDPSETTINGS);
Ftotal = Ftotal + Fautodexp;
sub_update_bounds(F+Ftotal);
end_idx = length(Ftotal);
F_pos.auto_d = [start_idx:end_idx];

% IMPLIES items
start_idx = length(Ftotal)+1;
for i = 1:length(Fimp)
    Ftotal = Ftotal + sub_optimize_implies(Fimp(i), linear_constraints);
    % after evey expandmodel() we have to update the bounds
    sub_update_bounds(F+Ftotal);
end
end_idx = length(Ftotal);
F_pos.implies = [start_idx:end_idx];

% reorder constraints
if H3_REORDER_INEQS
    %     new_order = [F_pos.update F_pos.output F_pos.iff F_pos.logic ...
    %         F_pos.linear F_pos.da F_pos.must F_pos.implies];
    %     new_order = [F_pos.update F_pos.output F_pos.linear F_pos.iff F_pos.logic ...
    %         F_pos.da F_pos.must F_pos.implies];
    new_order = [F_pos.update F_pos.output F_pos.iff F_pos.logic ...
        F_pos.da F_pos.must F_pos.linear F_pos.auto_d F_pos.implies];

    Ftotal = Ftotal(new_order);
end

if H3_OPTIMIZEMODEL
    fprintf('Number of bounds improved via model optimization: %d\n', H3_IMPROVED_BOUNDS);
end


%------------------------------------------------------------------------
function sub_update_bounds(F)

nv = yalmip('nvars');
yalmip('setbounds',1:nv,repmat(-Inf,nv,1),repmat(Inf,nv,1));
LU = getbounds(F);
yalmip('setbounds',1:nv,LU(:,1),LU(:,2));


%------------------------------------------------------------------------
function F = sub_optimize_ifthenelse(Fclause, Flin)

% d=1 -> z=x
% d=0 -> z=y
%
% mixed-integer model:
%    z >= x + (my - Mx)*(1-d)
%    z <= x - (mx - My)*(1-d)
%    z >= y + (mx - My)*d
%    z <= y - (my - Mx)*d
%
% where
%   Mx (mx) is the upper (lower) bound of "x"
%   My (my) is the upper (lower) bound of "y"

global H3_SDPSETTINGS H3_PARAMETERS

s = yalmip('extstruct', getvariables(Fclause));
z = s.arg{1};
d = s.arg{2};
x = s.arg{3};
y = s.arg{4};

% special case: { z = {IF d THEN constant1 ELSE constant2}; }
if isa(x, 'double') && isa(y, 'double')
    F = [z == y - (y-x)*d];
    F = expandmodel(F, [], H3_SDPSETTINGS);
    return
end

% special case: { z = {IF d THEN parameter1 ELSE parameter2}; }
x_vars = getvariables(x);
y_vars = getvariables(y);
param_vars = getvariables(H3_PARAMETERS);
if all(ismember(x_vars, param_vars)) && all(ismember(y_vars, param_vars))
    % THEN-part and ELSE-part are symbolic parameters
    F = [ d*x + y*(1-d) <= z; z <= d*x + y*(1-d) ];
    F = expandmodel(F, [], H3_SDPSETTINGS);
    return
end

% we require "d" to be single logic statement. "d1|d2" is not allowed
%
% this case should never happen with H3_BEHAVE_LIKE_HYSDEL2=true, since
% there we automatically add a new binary "d3 = (d1|d2)" to model complex
% logic in DA statements
if length(getvariables(d)) > 1
    error('Complex switching conditions in IF-THEN-ELSE statements are not allowed.');
end

[Mx, mx, infb] = h3_derivebounds(x);
[My, my, infb] = h3_derivebounds(y);

% use the same order of constraints as in HYSDEL2
F = [ z >= x + (my - Mx)*(1-d); ...
    z <= x - (mx-My)*(1-d); ...
    z >= y + (mx - My)*d; ...
    z <= y - (my - Mx)*d ];
% F = F([3 4 1 2]);
% F = F([4 3 2 1]);
% F = set( z >= x + (my - Mx)*(1-d) ) + set( z <= x - (mx-My)*(1-d) ) + ...
%     set(z >= y + (mx - My)*d) + set( z <= y - (my - Mx)*d );

% update bounds on "z" if they are numerical
% TODO: allow symbolic bounds on "z" vars, e.g.
%    z = { IF d THEN a ELSE b};
% where "a" and "b" are both symbolic parameters
%
% setting bounds on aux variables is important if they are subsequently
% used in an AD statement:
%   AD { d1 = z <= 0; }
%   DA { z = {IF d2 THEN x ELSE u}; }
% without bounds, we would get a poor model of the AD section
if isa(Mx, 'double') && isa(mx, 'double') && ...
        isa(My, 'double') && isa(my, 'double')
    F = F + set(min(mx, my) <= z <= max(Mx, My), 'bounds');
end

F = expandmodel(F, [], H3_SDPSETTINGS);


%------------------------------------------------------------------------
function F = sub_optimize_implies(Fclause, Flin)

global H3_SDPSETTINGS

s = yalmip('extstruct', getvariables(Fclause));
lhs = s.arg{1};
rhs = s.arg{2};
F = sub_implies_internal(lhs, rhs, Flin);
F = expandmodel(F, [], H3_SDPSETTINGS);


%------------------------------------------------------------------------
function F = sub_optimize_iff(Fclause, Flin)

global H3_SDPSETTINGS

s = yalmip('extstruct', getvariables(Fclause));
lhs = s.arg{1};
rhs = s.arg{2};
F = sub_iff_internal(lhs, rhs, Flin);
F = expandmodel(F, [], H3_SDPSETTINGS);


%------------------------------------------------------------------------
function F = sub_implies_internal(lhs, rhs, Flin)

global H3_EPSILON

% Call recursicely on X -> (A,B,...)
if isa(lhs, 'sdpvar') & isa(rhs, 'lmi')
    if length(lhs)==1 & length(rhs) >1
        F = set([]);
        for i = 1:length(rhs)
            F = F + sub_implies_internal(lhs, rhs(i), Flin);
        end
        return
    end
end

X = lhs;
Y = rhs;

switch class(X)

    case 'sdpvar'

        switch class(Y)

            case 'sdpvar'              % X --> Y
                F = set(Y >= X);

            case {'lmi','constraint'}
                if isa(Y,'constraint')
                    Y = set(Y,[],[],1);
                end
                switch settype(Y)

                    case 'elementwise' % X --> (Y(:)>=0)
                        Y = sdpvar(Y);
                        [M,m,infbound] = h3_derivebounds(Y, Flin);
                        if infbound
                            warning('You have unbounded variables in IMPLIES leading to a lousy big-M relaxation.');
                        end
                        F = set(Y - (1-X).*m);

                    case 'equality'    % X --> (Y(:)==0)
                        Y = sdpvar(Y);
                        [M,m,infbound] = h3_derivebounds(Y, Flin);
                        if infbound
                            warning('You have unbounded variables in IMPLIES leading to a lousy big-M relaxation.');
                        end
                        % varargout{1} = set((1-X).*M >= Y) + set(Y >= (1-X).*m);
                        % Better display and somewhat faster
                        temp = 1-X;
                        F = set([temp.*M - Y;Y - temp.*m]);

                    otherwise
                        error('IMPLIES not implemented for this case');
                end
            otherwise
                error('IMPLIES not implemented for this case');
        end

    case {'lmi','constraint'}
        if isa(X,'constraint')
            X = set(X,[],[],1);
        end
        if isa(Y,'constraint')
            Y = set(Y,[],[],1);
        end
        if length(Y) == 1
            if isa(Y,'sdpvar') | isequal(settype(Y),'elementwise')
                Y = sdpvar(Y);
                switch settype(X)
                    case 'elementwise'
                        X = sdpvar(X);X=X(:);
                        [Mx,mx,infbound] = h3_derivebounds(X, Flin);
                        if infbound
                            warning('You have unbounded variables in IMPLIES leading to a lousy big-M relaxation.');
                        end
                        di = binvar(length(X),1);
%                         tol = min(abs(Mx - mx)*1e-4,1e-4);
%                         tol = min(abs(Mx - mx)*H3_EPSILON, H3_EPSILON);
                        tol = H3_EPSILON;
                        if is(Y,'binary')
                            F = set(X <= tol + Mx.*di) + set(Y>=0.5*(sum(di)-length(di)+1));
                        else
                            [My,my] = h3_derivebounds(Y, Flin);
                            F = set(X <= tol + Mx.*di) + set(Y>=my*(1-(sum(di)-length(di)+1)));
                        end

                    otherwise
                        error('IMPLIES not implemented for this case');
                end

            else
                error('IMPLIES not implemented for this case');
            end
        end
    otherwise
        error('IMPLIES not implemented for this case');
end


%------------------------------------------------------------------------
function F = sub_iff_internal(X, Y, Flin)

global H3_EPSILON

switch class(X)

    case 'sdpvar'

        if length(X)>1
            error('IMPLIES not implemented for this case');
        end

        switch class(Y)
            case 'sdpvar'               % X <--> Y
                F = set(Y == X);

            case {'lmi','constraint'}
                Y=set(Y,[],[],1);
                switch settype(Y)
                    case 'elementwise'  % X <--> Y(:)>=0
                        F = binary_iff_lp(X, -sdpvar(Y), Flin);
                    case 'equality'     % X <--> Y(:)==0
                        F = binary_iff_eq(X, sdpvar(Y), Flin);
                    otherwise
                        error('IFF not implemented for this case');
                end

            otherwise
                error('IFF not implemented for this case');
        end

    case {'lmi','constraint'}

        if isa(X,'constraint')
            X = set(X,[],[],1); % FIX: passes one to avoid pruning infeasible constraints
        end
        switch class(Y)
            case 'sdpvar'
                switch settype(X)
                    case 'elementwise'
                        F = binary_iff_lp(Y, -sdpvar(X), Flin);
                    case 'equality'                        
                        % eps = 1e-3;
                        eps = H3_EPSILON;

                        %                        varargout{1} = set(implies(Z&W,Y))+binary_iff_lp(Z,sdpvar(X)+eps)+binary_iff_lp(W,-sdpvar(X)+eps);
                        X = [sdpvar(X)+eps;eps-sdpvar(X)];
                        F = binary_iff_lp(Y,-X, Flin);%,sdpvar(X)+eps)+binary_iff_lp(W,-sdpvar(X)+eps);
                        %                        varargout{1} = binary_iff_eq(Y,sdpvar(X));
                    otherwise
                        error('IFF not implemented for this case');
                end

            case {'lmi','constraint'} % F(X) <--> F(Y)
                d = binvar(1,1);
                F = sub_iff_internal(X, d, Flin) + sub_iff_internal(Y, d, Flin);

            otherwise
                error('IFF not implemented for this case');
        end

    otherwise
        error('IFF not implemented for this case');
end


%------------------------------------------------------------------------
function F = binary_iff_eq(X, f, Flin)

global H3_EPSILON
[M,m,infbound] = h3_derivebounds(f, Flin);
if infbound
    warning('You have unbounded variables in IFF leading to a lousy big-M relaxation.');
end
% eps = 1e-2;
eps = H3_EPSILON;

[nf,mf]=size(f);
if mf>1
    f = reshape(f,nf*mf,1);
end

if nf*mf ==1
    x1 = binvar(nf*mf,1);
    x2 = binvar(nf*mf,1);
    
    F = set(f <= M*(1-x1)) + set(f >= eps + (m-eps)*x1);
    F = F + set(-f <= M*(1-x2)) + set(-f >= eps + (m-eps)*x2);
    F = F + [-x1 + X <= 0; -x2 + X <= 0; x1 + x2 - X <= 1];
    
else
    di1 = binvar(nf*mf,1);
    di2 = binvar(nf*mf,1);
    F = set(M*(1-X) >= f >= m*(1-X));
    % F = F + set(-eps + (M+eps).*(1-di) >= f >= eps + (m-eps).*(1-di))+set(X>=sum(di)-length(di)+1);
    % F = F + set(-eps + (M+eps).*di >= f >= eps + (m-eps).*di)+set(X>=sum(di)-length(di)+1);

    F  = F + set(f>=eps+(m-eps).*di1)+set(-f>=-eps+(-M+eps).*di2)+set(X>=sum(di1)-length(di1)+1)+set(X>=sum(di2)-length(di2)+1);
% 
% else
%     x1 = binvar(1,1);
%     x2 = binvar(1,1);
%     
%     F = set(M*(1-x1) + eps >= f >= -eps + m*(1-x2));
%     F = F + set(f  >=  eps + m.*x1);
%     F = F + set(f  <= -eps + M.*x2);
%     F = F + set(x1+x2-1 <=X);
% 
%     %   F = F + set(iff(~X,~W | ~Z));% >= 1-Z) + set(X >= 1-W);
%     % F = F + set(f >= eps + (m-eps).*X)+set(-f >= eps + (-M-eps).*X);
%     % F = F + set(f >= eps + (m-eps)*Z)+set(-f >= eps + (-M-eps)*W);
%     % F = F + set(X == (Z | W));
end

%------------------------------------------------------------------------
function F = binary_iff_lp(X, f, Flin)

global H3_EPSILON

[M,m,infbound] = h3_derivebounds(f, Flin);
if infbound
    warning('You have unbounded variables in IFF leading to a lousy big-M relaxation.');
end
% eps = 1e-8;
eps = H3_EPSILON;

[nf,mf]=size(f);
if nf*mf==1
    % F  = set(f <= M*(1-X)) + set(f>=eps+(m-eps)*X);
    F  = set(f>=eps+(m-eps)*X) + set(f <= M*(1-X));
else
    if mf>1
        f = reshape(f,nf*mf,1);
    end
    if nf*mf>1
        di = binvar(nf*mf,1);
        % di=0 means the ith hypeplane is violated
        % X=1 means we are in the polytope
        F  = set(f <= M*(1-X)) + set(f>=eps+(m-eps).*di)+set(X>=sum(di)-length(di)+1) + set(X <= di);
        
        % Add some cuts for c < a'x+b < d
        [bA] = getbase(f);
        b = bA(:,1);
        A = bA(:,2:end);
        S = zeros(0,length(di));
        for i = 1:length(b)
            j = findrows(abs(A),abs(A(i,:)));
            j = j(j > i);
            if length(j)==1               
                S(end+1,[i j]) = 1;             
            end
        end
        if size(S,1) > 0
            % Add cut cannot be outside both constraints
            F = F + set(S*di >= 1);           
        end              
    else
        F  = set(f>=eps+(m-eps)*X) + set(f <= M*(1-X));
    end
end


%---------------------------------------------------------------------
function ctype = sub_classify_constraint(F)

ctype = 'linear';
s = yalmip('extstruct', getvariables(F));
if ~isempty(s)
    if ~iscell(s)
        if strcmpi(s.fcn, 'implies')
            ctype = 'implies';
        elseif strcmpi(s.fcn, 'iff')
            ctype = 'iff';
        elseif strcmpi(s.fcn, 'h3_ifthenelse')
            ctype = 'ife';
        elseif strcmpi(s.fcn, 'h3_upperbound')
            ctype = 'upperbound';
        elseif strcmpi(s.fcn, 'h3_lowerbound')
            ctype = 'lowerbound';
        elseif strcmpi(s.fcn, 'h3_logic_item')
            ctype = 'logic';
        else
            error('Unknown constraint, report this case to michal.kvasnica@stuba.sk.');
        end
    end
end
