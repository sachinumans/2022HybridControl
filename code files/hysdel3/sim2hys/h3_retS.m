function S = h3_retS(HYSDEL_S, block)
%
% extracts a particular stucture from global "HYSDEL_S" variable
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

S = HYSDEL_S;
name = fileparts(block);
name = regexprep(name,'[^/\w]','_');
[field, rem] = strtok(name,'/');
while ~isempty(rem)
    S = getfield(S,field);
    [field, rem] = strtok(rem(2:end),'/');
end
S = getfield(S,field);
