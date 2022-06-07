function F = h3_linear_item(LHS, RHS)
% Optimize bounds of a linear item

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


global H3_OPTIMIZE_AUX_BOUNDS H3_BEHAVE_LIKE_HYSDEL2

if H3_BEHAVE_LIKE_HYSDEL2
    F = set(LHS >= (RHS), 'linear');
    F = F + set(LHS <= (RHS), 'linear');
else
    F = set(LHS == (RHS), 'linear');
end
if H3_OPTIMIZE_AUX_BOUNDS
    F = F + set( h3_lowerbound(LHS, RHS), 'bounds');
    F = F + set( h3_upperbound(LHS, RHS), 'bounds');
end
