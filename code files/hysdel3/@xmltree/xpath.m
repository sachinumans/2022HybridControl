function nodes = xpath(tree, path, root_id)
% quick XPATH find

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

if nargin < 3
    root_id = root(tree);
end

S = struct(tree);
T = S.tree; 
nodes = [];

if isequal(path(1:2), '//')
    searchall = 1;
else
    searchall = 0;
end

slash_pos = find(path == '/');
if any(slash_pos > 2)
    [token, rest] = strtok(path, '/');
    has_rest = ~isempty(rest);
else
    has_rest = 0;
    rest = '';
    token = path;
    token(slash_pos) = [];
end

% //element1[id1]/element2[id2]/...
[t1, t2] = regexp(token, '\[\d+\]');
if ~isempty(t1)
    has_index = 1;
    %     index = str2double(token(t1+1:t2-1));
    index = eval(token(t1+1:t2-1));
    token = token(1:t1-1);
else
    has_index = 0;
    index = 0;
end

if searchall==0,
    % searchindex = [root_id children(tree, root_id)];
    searchindex = [root_id T{root_id}.contents];
elseif nargin == 3
    searchindex = sub_allchildren(T, root_id);
else
    searchindex = 1:length(T);
end

% if length(searchindex) > 0
%     fprintf('Nodes: %d, Path: %s\n', length(searchindex), path);
% end


% <matrix_t>
% <rows_t>A1</rows_t>
% <rows_t>A2</rows_t>
% </matrix_t>
% <matrix_t>
% <rows_t>B1</rows_t>
% <rows_t>B2</rows_t>
% </matrix_t>
% <matrix_t>
% <rows_t>C1</rows_t>
% <rows_t>C2</rows_t>
% <rows_t>C3</rows_t>
% </matrix_t>
% 
% co ma vratit "xpath(tree, '//matrix_t/rows_t[1]')" ?
% momentalne vraciame A1, B1 aj C1
% xmltree/find pritom vrati iba A1

ctr = 0;
for ii = searchindex,
    if xml_cell_find(T, ii, token)
        ctr = ctr + 1;
        if has_index & index ~= ctr
            % user is not interested in this element
            continue
        end
        
        if has_rest
            nodes = [nodes xpath(tree, rest, ii)];
        else
            nodes = [nodes ii];
        end
        
        if has_index & index == ctr
            % user was only interested in this element
            break
        end
        
    end
end

% a fast version of unique(nodes):
if length(nodes) > 1
    if ~issorted(nodes)
        nodes = sort(nodes);
    end
    d = [1 diff(nodes)];
    nodes = nodes(d~=0);
end
% [a, b] = unique(nodes);
% nodes = a(b);
