function value = getvalue(tree, path);
% returns value of an element in TREE found by PATH or ID

% Copyright is with the following author(s)
% (C) 2008 Slovak University of Technology in Bratislava
%          michal.kvasnica@stuba.sk

% ---------------------------------------------------------------------------
% Legal note:
%          This program is free software; you can redistribute it and/or
%          modify it under the terms of the GNU General Public License
%          as published by the Free Software Foundation; either version 2.1 of
%          the License, or (at your option) any later version. 
%
%          This program is distributed in the hope that it will be useful,
%          but WITHOUT ANY WARRANTY; without even the implied warranty of
%          MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
%          General Public License for more details.
% 
%          You should have received a copy of the GNU General Public
%          License along with this library; if not, write to the 
%          Free Software Foundation, Inc., 
%          59 Temple Place, Suite 330, 
%          Boston, MA  02111-1307  USA
%
% ---------------------------------------------------------------------------

if ischar(path),
    pos = xpath(tree, path);
else
    pos = path;
end
if isempty(pos),
    error(sprintf('No element found in "%s".', path));
end

T = tree.tree;
npos = length(pos);
value = cell(npos, 1);
for i = 1:npos
    c = T{pos(i)}.contents;
    value{i} = T{c}.value;
end
if npos == 1
    value = value{1};
end
