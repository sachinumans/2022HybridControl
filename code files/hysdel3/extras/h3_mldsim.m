function [xn,y,w,feasible]=h3_mldsim(S, x0, u)
%H3_MLDSIM Simulates an MLD system for one time step
%
% [xn,y,w,feasible]=h3_mldsim(S, x0, u)
%
% ---------------------------------------------------------------------------
% DESCRIPTION
% ---------------------------------------------------------------------------
% Simulates an MLD system for one time step.
%
% ---------------------------------------------------------------------------
% INPUT
% ---------------------------------------------------------------------------
% S        - structure contianing matrices of MLD system
% x0       - initial state
% u        - current input
%
% ---------------------------------------------------------------------------
% OUTPUT
% ---------------------------------------------------------------------------
% xn       - next state
% y        - current output
% w        - current values of boolean/auxiliary variables
% feasible - 1 if a feasible solution exists, 0 or -1 otherwise
%


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

global mptOptions

error(nargchk(3,3,nargin));

if ~isfield(S, 'A')
    error('Malformed input.');
end
if iscell(S.A)
    error('Symbolic models can''t be simulated.');
end

x0 = x0(:);
u = u(:);

nx = S.nx;
nu = S.nu;
ny = S.ny;
nw = S.nw;
nc = S.nc;

if length(x0) ~= nx,
    error('MPT_MLDSIM: Wrong dimension of x0.');
end
if length(u) ~= nu,
    error('MPT_MLDSIM: Wrong dimension of u.');
end

xn = [];
y = [];
w = [];


if nc==0,
    % no inequalities, compute xn and y directly
    xn = zeros(size(x0));
    if ~isempty(S.A)
        xn = xn + S.A*x0;
    end
    if ~isempty(S.Bu)
        xn = xn + S.Bu*u;
    end
    y = 0;
    if ~isempty(S.C)
        y = y + S.C*x0;
    end
    if ~isempty(S.Du)
        y = y + S.Du*u;
    end
%     xn = S.A * x0 + S.Bu * u;
%     y = S.C * x0 + S.Du * u;
    if isfield(S, 'Baff'),
        % add affine term if available
        xn = xn + S.Baff;
    end
    if isfield(S, 'Daff'),
        % add affine term if available
        y = y + S.Daff;
    end
    feasible = 1;

elseif isempty(S.Eaux)
    % constraints given, but no "z" and "d" variables
    eq_holds = all(S.Ex(S.j.eq, :)*x0 + S.Eu(S.j.eq, :)*u == S.Eaff(S.j.eq, :));
    ineq_holds = all(S.Ex(S.j.ineq, :)*x0 + S.Eu(S.j.ineq, :)*u <= S.Eaff(S.j.ineq, :));
    
    if ~(eq_holds & ineq_holds)
        disp('Warning: Constraints lead to infeasible or unbounded solution.');
        xn = zeros(nx, 1);
        y = zeros(ny, 1);
        w = zeros(nw, 1);
        feasible = 0;
    else
        xn = zeros(size(x0));
        if ~isempty(S.A)
            xn = xn + S.A*x0;
        end
        if ~isempty(S.Bu)
            xn = xn + S.Bu*u;
        end
        y = 0;
        if ~isempty(S.C)
            y = y + S.C*x0;
        end
        if ~isempty(S.Du)
            y = y + S.Du*u;
        end
%         xn = S.A*x0 + S.Bu*u;
%         y = S.C*x0 + S.Du*u;
        w = zeros(nw, 1);
        if isfield(S, 'Baff')
            % add affine term if available
            xn = xn + S.Baff;
        end
        if isfield(S, 'Daff'),
            % add affine term if available
            y = y + S.Daff;
        end
        feasible = 1;
    end

else
    % general case, solve feasiblity MILP to get "d" and "z"

    % no cost, just solve feasibility problem
    f = zeros(nw, 1);

    % matrices containing inequality constraints
    Aineq = S.Eaux(S.j.ineq, :);
    Bineq = S.Eaff(S.j.ineq, :) - S.Ex(S.j.ineq, :)*x0 - S.Eu(S.j.ineq, :)*u;
    Aeq = S.Eaux(S.j.eq, :);
    Beq = S.Eaff(S.j.eq, :) - S.Ex(S.j.eq, :)*x0 - S.Eu(S.j.eq, :)*u;

    % lower and upper bounds of "d" and "z" variables
    lb = S.wl;
    ub = S.wu;
    
    if ~isempty(mptOptions)
        % use MPT's mpt_solveMILP as a faster interface to MILP solvers
        vartype = repmat('C', nw, 1);
        vartype(S.j.d) = 'B';
        [dzmin, fmin, how] = mpt_solveMILP(f, Aineq, Bineq, ...
            Aeq, Beq, lb, ub, vartype);
        feasible = strcmpi(how, 'ok');
        
    else
        % use YALMIP if MPT is not present
        dec_vars = sdpvar(nw, 1);
        dec_set = set(Aeq*dec_vars == Beq) + ...
            set(Aineq*dec_vars <= Bineq) + ...
            set(lb <= dec_vars <= ub) + ...
            set(binary(dec_vars(S.j.d)));
        
        diagnostics = solvesdp(dec_set, f, sdpsettings('verbose', 0));
        feasible = (diagnostics.problem == 0);
        dzmin = double(dec_vars);
    end

    if feasible==1,
        % problem is feasible
        w = dzmin;

        % compute state update and output
        if any(S.j.d)
            % if d vector is present
            xn = S.A*x0 + S.Bu*u + S.Baux*dzmin;
            y = S.C*x0 + S.Du*u + S.Daux*dzmin;
        else
            % if there is no d vector
            xn = S.A*x0 + S.Bu*u + S.Baux(:,S.j.z)*dzmin;
            y = S.C*x0 + S.Du*u + S.Daux(:,S.j.z)*dzmin;
        end
        if isfield(S, 'Baff'),
            % add affine term if available
            xn = xn + S.Baff;
        end
        if isfield(S, 'Daff'),
            % add affine term if available
            y = y + S.Daff;
        end
    else
        disp(['Warning: Constraints lead to infeasible or unbounded solution. (wrn:2)']);
        xn = zeros(nx, 1);
        y = zeros(ny, 1);
        w = zeros(nw, 1);
    end
end
