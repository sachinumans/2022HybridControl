function F = h3_ifthenelse(lhs_e, if_e, then_e, else_e, tag)

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

global H3_OPTIMIZE_AUX_BOUNDS
global H3_BEHAVE_LIKE_HYSDEL2

use_custom_ifthenelse_operator = H3_BEHAVE_LIKE_HYSDEL2;

if nargin < 5
    tag = '';
end

F = set([]);
if isa(if_e, 'constraint')
    % replace a constraint with a boolean variable
    d = binvar(1, 1);
    F = F + set( iff(if_e, d), tag );
else
    d = if_e;
end


if use_custom_ifthenelse_operator
    % here we must be 100% sure that "d" is a single logic statement
    % ("d1&d2" CANNOT be handled)
    %
    % this is ensured in h3_parse_section where we introduce additional
    % binaries to model complex logic
    for i = 1:length(d)
        F = F + set(yalmip('define',mfilename, lhs_e, d(i), then_e, else_e) == 1, 'da');
    end

else
    % more general, but has poor bounds detection
    for i = 1:length(d)
        F = F + set( implies(d(i), lhs_e == then_e), tag );
        F = F + set( implies(~d(i), lhs_e == else_e), tag );
    end

end
    
if H3_OPTIMIZE_AUX_BOUNDS
    F = F + set( h3_lowerbound(lhs_e, then_e, else_e), 'bounds');
    F = F + set( h3_upperbound(lhs_e, then_e, else_e), 'bounds');
end
