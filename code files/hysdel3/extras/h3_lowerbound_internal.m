function varargout = h3_lowerbound_internal(varargin)

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

global H3_EPSILON H3_NAMES H3_SYMBOLIC_BOUNDS H3_BOUNDS_STACK
global H3_USE_SYMBOLIC_BOUNDS

V = varargin{1};
X = varargin{2};
Y = varargin{3};

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
        H3_BOUNDS_STACK.min{getvariables(V)} = min_x_y;
    end
else
    F = set([]);
end

varargout{1} = F;

