function subtree = branch(tree,uid)
% XMLTREE/BRANCH Branch Method
% FORMAT uid = parent(tree,uid)
% 
% tree    - XMLTree object
% uid     - UID of the root element of the subtree
% subtree - XMLTree object (a subtree from tree)
%_______________________________________________________________________
%
% Return a subtree from a tree.
%_______________________________________________________________________
% @(#)branch.m                  Guillaume Flandin              02/04/17

error(nargchk(2,2,nargin));

if ischar(uid)
    uid = xpath(tree, uid);
    if length(uid) ~= 1
        error('[XMLTree] Xpath expression found none or more than one element.');
    end
end

% subtree = tree;
% subtree.root = uid;
% return

% if uid > length(tree) || ...
%         numel(uid)~=1 || ...
%         ~strcmp(tree.tree{uid}.type,'element')
% 	error('[XMLTree] Invalid UID.');
% end

if 1
    T = tree.tree;
    T_children = sort(sub_allchildren(T, uid));
    BT = T([uid T_children]);
    uid = uid - 1;
    for i = 1:length(BT)
        BTi = BT{i};
        BTi.contents = BTi.contents - uid;
        BTi.parent = BTi.parent - uid;
        BTi.uid = i;
        BT{i} = BTi;
    end
    BT{1}.parent = [];
    subtree = tree;
    subtree.tree = BT;
    return
end

subtree = xmltree;

% exploit the fact that root(tree) is always 1 unless special cases which
% are described in xmltree/root.m
speed_hack = 1;

if speed_hack
    root_subtree = 1;
    subtree = set(subtree,root_subtree,'name',tree.tree{uid}.name);
else
    subtree = set(subtree,root(subtree),'name',tree.tree{uid}.name);
end

child = children(tree,uid);
l = 1;

for i=1:length(child)
    if speed_hack
        [subtree, q] = sub_branch(tree,subtree,child(i),root_subtree,l);
        subtree.tree{root_subtree}.contents = [subtree.tree{root_subtree}.contents l+1];
        l = q;
    else        
        l = length(subtree);
        subtree = sub_branch(tree,subtree,child(i),root(subtree));
        subtree.tree{root(subtree)}.contents = [subtree.tree{root(subtree)}.contents l+1];
    end

end

%=======================================================================
function [tree, m] = sub_branch(t,tree,uid,p,l)

% l = length(tree.tree);

subtree = t.tree{uid};
if isfield(subtree, 'contents')
    contents = subtree.contents;
    L = length(contents);
else
    contents = [];
    L = 0;
end
subtree.uid = l + 1;
subtree.parent = p;
subtree.contents = [];
tree.tree{l+1} = subtree;

% L = length(contents);
m = l+1;
for i=1:L
    tree.tree{l+1}.contents = [tree.tree{l+1}.contents m+1];
    [tree, m] = sub_branch(t,tree,contents(i),l+1,m);
end
