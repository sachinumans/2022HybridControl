function [str, B] = xslt(tree, root_id)
% returns a tree in text representation (eliminates all XML tags and returns
% only values

% Copyright is with the following author(s)
% (C) 2008 Michal Kvasnica, Slovak University of Technology in Bratislava
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

if nargin < 2
    root_id = root(tree);
end
if isempty(root_id)
    error('Root cannot be empty.');
end
str = '';
T = tree.tree;
T_children = sub_allchildren(T, root_id);

if nargout > 1
    T_children = sort(T_children);
    B = tree;
    BT = T([root_id T_children]);
    root_id = root_id - 1;
    for i = 1:length(BT)
        BTi = BT{i};
        BTi.contents = BTi.contents - root_id;
        BTi.parent = BTi.parent - root_id;
        BTi.uid = i;
        BT{i} = BTi;
    end
    BT{1}.parent = [];
    B.tree = BT;
end

delimiter = ' ';
for i = T_children
    Ti = T{i};
    V = Ti.value;
    if ~isempty(V)
        if ismember(V, {'!', '@', '#', '$', '%', '^', '&', '*', '(', ')', ...
                '[', ']', ':', '{', '}', '<', '>', ';', '-', '+', '='} )
            delimiter = '';
        else
            delimiter = ' ';
        end
        str = [str delimiter V];
    end
end
