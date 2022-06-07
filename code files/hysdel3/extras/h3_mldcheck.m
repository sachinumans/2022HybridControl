function out = h3_mldcheck(S)
% Checks if the given MLD system is well-posed
% Uses feasibility check algorithm described in Appendix of 
% 
% Bemporad, A., Morari, M. (1999). Control of systems integrating
% logic, dynamics, and constraints. Automatica, 35(3), 407-427.
%
% input: MLD structure
% output:  1 - MLD is well posed
%          0 - MLD is not well posed
%         -1 - another error appeared through test
    
% Test is based on a presumption, that for MLD system to be completely
% well posed, there exist only one mapping from x_k, u_k, w_k to x_{k+1}
% Hence, if there exist more that one mappings, the following feasibility
% MILP problem will give feasible result and we know that the given MLD
% is not well posed

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

% tolerance for feasibility check
tol = 1e-4;

% temp vars
H = [S.Baux; S.Daux];
c = NaN*ones(size(H,1),1);


% for each row of the matrix [S.Baux; S.Daux] solve the feasibility MILP
for i=1:size(H,1)
    % each stage needs to clear the yalmip variables
    yalmip('clear');
    
    % declaring variables
    var.x = sdpvar(S.nx,1);
    var.u = sdpvar(S.nu,1);
    var.wm = [binvar(S.nd,1); sdpvar(S.nz,1)];
    var.wp = [binvar(S.nd,1); sdpvar(S.nz,1)];
    
    % set variable bounds
    F = set( -S.xl <= var.x <= S.xu);
    F = F + set( -S.ul <= var.u < S.uu);
    F = F + set( -S.wl <= var.wm < S.wu);
    F = F + set( -S.wl <= var.wp < S.wu);
    
    
    if ~any(H(i,:))
        % do not need the solve MILP, problem is infeasible
        c(i) = 1;
    else
        % add constraints set
        for j=1:S.nw
            F = F + set( var.wm(j) <= var.wp(j) );
        end
        F = F + set( S.Eaux(S.j.eq,:)*var.wm == S.Eaff(S.j.eq,:) - S.Ex(S.j.eq,:)*var.x - S.Eu(S.j.eq,:)*var.u );
        F = F + set( S.Eaux(S.j.ineq,:)*var.wm <= S.Eaff(S.j.ineq,:) - S.Ex(S.j.ineq,:)*var.x - S.Eu(S.j.ineq,:)*var.u );
        F = F + set( S.Eaux(S.j.ineq,:)*var.wp <= S.Eaff(S.j.ineq,:) - S.Ex(S.j.ineq,:)*var.x - S.Eu(S.j.ineq,:)*var.u );
        F = F + set( H(i,:)*(var.wm - var.wp) <= -tol);
        % solve feasibility MILP
        sol = solvesdp(F,[],sdpsettings('verbose',0));
        c(i) = sol.problem;
        % fast break
        if c(i)~=1
            % if MLD is not well posed
            if c(i)==0
                out = 0;
            % if YALMIP throws another error
            else
                fprintf(['h3_mldcheck: Well-posedness check of MLD model failed.\nYALMIP ' ...
                         'error ', num2str(c(i)),': ', ...
                         yalmiperror(c(i)),'.\n']);
                out = -1;
            end
            break;
        end
    end
end

% if all of the rows are infeasible, MLD is well-posed
if ~exist('out','var') && isempty(find(c==0))
    out = 1;
end
