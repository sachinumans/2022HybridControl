function h3_detect_error(L, H3_SOURCE_LINE)

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



err_msg = L.message;
newline_pos = sort([find(err_msg == 10), find(err_msg == 13)]);
if ~isempty(newline_pos)
    err_msg = err_msg(newline_pos(1)+1:end);
end
fprintf('\n%s\n', err_msg);
fprintf('  %s\n\n', H3_SOURCE_LINE);
error('HYSDEL3 error occurred, see message above.');
