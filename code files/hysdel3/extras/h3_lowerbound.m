function varargout = h3_lowerbound(varargin)
% Calculates the (symbolic) lower bound of a LINEAR or DA expression
%
% for a linear item "LINEAR { LHS = RHS }" this function calculates the
% (symbolic) minimum of RHS
%
% for a DA time "DA { LHS = {IF selector THEN x ELSE y} }" the (symbolic)
% minimum of "LHS" is calculated by "min(x, y)"

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

% quickly handle special cases when RHS is a fixed value
is_double_input = false;
if nargin == 3
    % DA { V = {IF d THEN 1 ELSE 2}; }
    V = varargin{1};
    X = varargin{2};
    Y = varargin{3};
    if isa(X, 'double') && isa(Y, 'double')
        min_x_y = min(X, Y);
        is_double_input = true;
    end
elseif nargin == 2
    % LINEAR { z = 3; }
    V = varargin{1};
    X = varargin{2};
    if isa(X, 'double')
        min_x_y = X;
        is_double_input = true;
    end
end
if is_double_input
    if H3_USE_SYMBOLIC_BOUNDS
        H3_BOUNDS_STACK.min = h3_update_stack(H3_BOUNDS_STACK.min, getvariables(V), min_x_y);
    end
    varargout{1} = set( V >= min_x_y, 'bounds' );
    return
end


switch class(varargin{1})
    case {'constraint','sdpvar'}
        varargout{1} = set(yalmip('define', mfilename, varargin{:}) == 1);

    case 'char'
        if nargin >= 5
            % lower bound of V in DA { V = {IF selector THEN x ELSE y} }
            out = set([]);
            V = varargin{3};
            X = varargin{4};
            Y = varargin{5};
            for i = 1:length(V)
                out = out + h3_lowerbound_da(V(i), X(i), Y(i));
            end
            varargout{1} = out;
%             varargout{1} = h3_lowerbound_da(varargin{3:5});
        else
            % lower bound of V in LINEAR { V = X; }
            out = set([]);
            V = varargin{3};
            X = varargin{4};
            for i = 1:length(V)
                out = out + h3_lowerbound_linear(V(i), X(i));
            end
            varargout{1} = out;
%             varargout{1} = h3_lowerbound_linear(varargin{3:4});
        end
        varargout{2} = struct('convexity','none','monotonicity','none','definiteness','none','extra','marker','model','integer');
        varargout{3} = varargin{3};
end


%-----------------------------------------------------------------
function F = h3_lowerbound_linear(V, X)
% lower bound of V in LINEAR { V = X; }

global H3_EPSILON H3_NAMES H3_SYMBOLIC_BOUNDS H3_BOUNDS_STACK
global H3_USE_SYMBOLIC_BOUNDS

if isa(X, 'double')
    mx = X;
    infboundx = 0;
else
    [Mx, mx, infboundx] = h3_derivebounds(X);
end
if isa(mx, 'double')
    mx = full(mx);
end

if ~infboundx
    F = set( V >= mx, 'bounds');
    if H3_USE_SYMBOLIC_BOUNDS
        H3_BOUNDS_STACK.min = h3_update_stack(H3_BOUNDS_STACK.min, getvariables(V), mx);
    end
else
    F = set([]);
end



%-----------------------------------------------------------------
function F = h3_lowerbound_da(V, X, Y)
% lower bound of V in DA { V = {IF selector THEN x ELSE y} }

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

if isa(mx, 'double')
    mx = full(mx);
end
if isa(my, 'double')
    my = full(my);
end

infboundx = any(infboundx);
infboundy = any(infboundy);
if ~infboundx && ~infboundy
    if symbolic_bounds_Y && symbolic_bounds_X
        min_x_y = sdpvar(1, 1);
        mx_name = h3_sdisplay(mx, H3_NAMES);
        my_name = h3_sdisplay(my, H3_NAMES);
        min_x_y_var = getvariables(min_x_y);
        H3_SYMBOLIC_BOUNDS = [H3_SYMBOLIC_BOUNDS min_x_y_var];
        if isa(mx_name, 'cell')
            mx_name = mx_name{1};
        end
        if isa(my_name, 'cell')
            my_name = my_name{1};
        end
        H3_NAMES{min_x_y_var} = ['System.Math.Min((' mx_name '), (' my_name '))'];
    else
        min_x_y = min(mx, my);
    end
    F = set( V >= min_x_y, 'bounds');
    if H3_USE_SYMBOLIC_BOUNDS
        H3_BOUNDS_STACK.min = h3_update_stack(H3_BOUNDS_STACK.min, getvariables(V), min_x_y);
    end
else
    F = set([]);
end

