function varargout = h3_upperbound(varargin)
% Calculates the (symbolic) upper bound of a LINEAR or DA expression
%
% for a linear item "LINEAR { LHS = RHS }" this function calculates the
% (symbolic) maximum of RHS
%
% for a DA time "DA { LHS = {IF selector THEN x ELSE y} }" the (symbolic)
% maximum of "LHS" is calculated by "max(x, y)"

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

global H3_USE_SYMBOLIC_BOUNDS H3_BOUNDS_STACK

% quickly handle special cases when RHS is a fixed number
is_double_input = false;
if nargin == 3
    % DA { V = {IF d THEN 1 ELSE 2}; }
    V = varargin{1};
    X = varargin{2};
    Y = varargin{3};
    if isa(X, 'double') && isa(Y, 'double')
        max_x_y = max(X, Y);
        is_double_input = true;
    end
elseif nargin == 2
    % LINEAR { z = 3; }
    V = varargin{1};
    X = varargin{2};
    if isa(X, 'double')
        max_x_y = X;
        is_double_input = true;
    end
end
if is_double_input
    if H3_USE_SYMBOLIC_BOUNDS
        H3_BOUNDS_STACK.max = h3_update_stack(H3_BOUNDS_STACK.max, getvariables(V), max_x_y);
    end
    varargout{1} = set( V <= max_x_y, 'bounds' );
    return
end


switch class(varargin{1})
    case {'constraint','sdpvar'}
        varargout{1} = set(yalmip('define',mfilename,varargin{:})==1);

    case 'char'
        if nargin >= 5
            % upper bound of V in DA { V = {IF selector THEN x ELSE y} }
            out = set([]);
            V = varargin{3};
            X = varargin{4};
            Y = varargin{5};
            for i = 1:length(V)
                out = out + h3_upperbound_da(V(i), X(i), Y(i));
            end
            varargout{1} = out;
%             varargout{1} = h3_upperbound_da(varargin{3:5});
        else
            % upper bound of V in LINEAR { V = X; }
            out = set([]);
            V = varargin{3};
            X = varargin{4};
            for i = 1:length(V)
                out = out + h3_upperbound_linear(V(i), X(i));
            end
            varargout{1} = out;
%             varargout{1} = h3_upperbound_linear(varargin{3:4});
        end
        varargout{2} = struct('convexity','none','monotonicity','none','definiteness','none','extra','marker','model','integer');
        varargout{3} = varargin{3};
end


%-----------------------------------------------------------------
function F = h3_upperbound_linear(V, X)
% upper bound of V in LINEAR { V = X; }

global H3_EPSILON H3_NAMES H3_SYMBOLIC_BOUNDS H3_BOUNDS_STACK
global H3_USE_SYMBOLIC_BOUNDS

if isa(X, 'double')
    Mx = X;
    infboundx = 0;
else
    [Mx, mx, infboundx] = h3_derivebounds(X);
end
if isa(Mx, 'double')
    Mx = full(Mx);
end

if ~infboundx
    F = set( V <= Mx, 'bounds');
    if H3_USE_SYMBOLIC_BOUNDS
        H3_BOUNDS_STACK.max = h3_update_stack(H3_BOUNDS_STACK.max, getvariables(V), Mx);
    end
else
    F = set([]);
end


%-----------------------------------------------------------------
function F = h3_upperbound_da(V, X, Y)
% upper bound of V in DA { V = {IF selector THEN x ELSE y} }

global H3_EPSILON H3_NAMES H3_SYMBOLIC_BOUNDS H3_BOUNDS_STACK
global H3_USE_SYMBOLIC_BOUNDS

if isa(X, 'double')
    Mx = X;
    mx = X;
    infboundx = 0;
    symbolic_bounds_X = false;
else
    [Mx, mx, infboundx] = h3_derivebounds(X);
    symbolic_bounds_X = isa(Mx, 'sdpvar') | isa(mx, 'sdpvar');
end
if isa(Y, 'double')
    My = Y;
    my = Y;
    infboundy = 0;
    symbolic_bounds_Y = false;
else
    [My, my, infboundy] = h3_derivebounds(Y);
    symbolic_bounds_Y = isa(My, 'sdpvar') | isa(my, 'sdpvar');
end

if isa(Mx, 'double')
    Mx = full(Mx);
end
if isa(my, 'double')
    My = full(My);
end

infboundx = any(infboundx);
infboundy = any(infboundy);
if ~infboundx && ~infboundy
    if symbolic_bounds_Y && symbolic_bounds_X
        max_x_y = sdpvar(1, 1);
        Mx_name = h3_sdisplay(Mx, H3_NAMES);
        My_name = h3_sdisplay(My, H3_NAMES);
        max_x_y_var = getvariables(max_x_y);
        H3_SYMBOLIC_BOUNDS = [H3_SYMBOLIC_BOUNDS max_x_y_var];
        if isa(Mx_name, 'cell')
            Mx_name = Mx_name{1};
        end
        if isa(My_name, 'cell')
            My_name = My_name{1};
        end
        H3_NAMES{max_x_y_var} = ['System.Math.Max((' Mx_name '), (' My_name '))'];
    else
        max_x_y = max(Mx, My);
    end
    if H3_USE_SYMBOLIC_BOUNDS
        H3_BOUNDS_STACK.max = h3_update_stack(H3_BOUNDS_STACK.max, getvariables(V), max_x_y);
    end
    F = set( V <= max_x_y, 'bounds');
else
    F = set([]);
end
