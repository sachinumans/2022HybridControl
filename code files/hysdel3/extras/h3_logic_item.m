function varargout = h3_logic_item(varargin)
% Create a mixed-integer model of LOGIC and MUST items

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

global H3_REMOVED_BINARIES

% if isa(varargin{1}, 'lmi')
%     varargin{1} = sdpvar(varargin{1});
% end

switch class(varargin{1})
    case {'constraint','sdpvar'}
        if isa(varargin{2}, 'char')
            % this is a logic MUST statement
            tag = 'must';
        else
            % create a mixed-integer representation of the logic statement
            if nargin >= 3
                tag = varargin{3};
            else
                tag = 'logic';
            end
        end

        varargout{1} = set(yalmip('define',mfilename,varargin{:}, tag)==1, tag);
        H3_REMOVED_BINARIES = [H3_REMOVED_BINARIES getvariables(varargout{1})];

    case 'char'
        out = set([]);
        varargout{1} = h3_logic_item_internal(varargin{3:5});
        varargout{2} = struct('convexity','none','monotonicity','none','definiteness','none','extra','marker','model','integer');
        varargout{3} = [];
        
    otherwise
        varargout = {[]};
end

%-----------------------------------------------------------------------
function F = h3_logic_item_internal(LHS, RHS, tag)

global H3_SDPSETTINGS H3_REMOVED_BINARIES

if isa(RHS, 'char')
    % this is a logic MUST statement
    F = expandmodel(set(true(LHS)), [], H3_SDPSETTINGS);
    tag = 'must';
else
    % create a mixed-integer representation of the logic statement
    F = expandmodel(set(LHS==RHS), [], H3_SDPSETTINGS);
%     tag = 'logic';
end

F_sdpvar = sdpvar(F);
nF = length(F);

% say we have
%    d1 == ((d2|d3)&d4)
%
% here YALMIP creates the following model:
%    d5 represents (d2|d3) via [ d5 >= d2; d5 >= d3; d5 <= d2 + d3 ]
%    d6 represents (d5&d4) via [ d6 <= d5; d6 <= d4; d4 + d5 <= d6 - 1 ]
%    d1 == d6
%
% to eliminate "d5" and "d6", we use the Fourier-Motzkin elimination of the
% system of inequalities A*x <= B

% To form A*x <= B, we first need to convert equality constraints to
% double-sided inequalities
%
% equalities come from LHS==RHS
% if we model a MUST item, there are no equalities
equalities = zeros(1, nF);
for i = 1:length(F)
    equalities(i) = isequal(settype(F(i)), 'equality');
end
inequalities = 1-equalities;

% determine which variables are used in a given logic statement
vars = usedvariables(F); vars = vars(:)';
isextended = zeros(1, length(vars));
% which of them have been automatically introduced?
for i = 1:length(vars)
    extstruct = yalmip('extstruct', vars(i));
    isextended(i) = ~isempty(extstruct);
end
isbasic = ~isextended;
isextended = find(isextended);
isbasic = find(isbasic);

% get the numerical model A*x <= B
M = full(getbase(F_sdpvar));
model_B = M(:, 1);
model_A = -getmatrix(F_sdpvar, vars);

% include equalities as double-sided inequalities
eqs = find(equalities);
ineqs = find(inequalities);
A_eq = model_A(eqs, :);
B_eq = model_B(eqs, :);
A_ineq = model_A(ineqs, :);
B_ineq = model_B(ineqs, :);
A = [A_eq; -A_eq; A_ineq];
B = [B_eq; -B_eq; B_ineq];
% A = [A_ineq; A_eq; -A_eq];
% B = [B_ineq; B_eq; -B_eq];

% we want to keep the basic variables (d1, d2, d3, d4 in the example
% above), and eliminate the automatically introduced binaries (d5, d6)
project_onto = isbasic;

% h3_fourier can use a heuristic procedure for detecting redundant
% constraints if we know that all x's are binary
isbinary = true;
% eliminate automatically introduced binaries from A*x<=B
[Ap, Bp] = h3_fourier(A, B, project_onto, isbinary);

% reorder constraints like HYSDEL2 does (sortrows where the leading column
% is the one of the LHS variable)
LHS_var = getvariables(LHS);
if length(LHS_var) >= 1
    col = find(vars(isbasic) == LHS_var(1));
    % P = sortrows([Ap Bp], [col setdiff(1:size(Ap, 2)+1, col)]);
    P = sortrows([Ap Bp], col);
    Ap = P(:, 1:end-1);
    Bp = P(:, end);
end
if size(Ap, 1) == 4 && size(Ap, 2) == 3 && length(find(Bp==2))==1
    Ap = Ap([2 1 4 3], :);
    Bp = Bp([2 1 4 3], :);
end

% add the new constraints to our model
x = recover(vars(project_onto));
F = set(Ap*x <= Bp, tag);

% and tell h3_yalmip2mld that we got rid of the automatic binaries
H3_REMOVED_BINARIES = [H3_REMOVED_BINARIES vars(isextended)];


%------------------------------------------------------------------------
function M = getmatrix(F, var, must_depend_on)

M = [];
for ii = 1:length(var),
    M = [M full(getbasematrix(F,var(ii)))];
end
