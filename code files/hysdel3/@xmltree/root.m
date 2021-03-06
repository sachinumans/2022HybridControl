function uid = root(tree)
% XMLTREE/ROOT Root Method
% FORMAT uid = root(tree)
% 
% tree   - XMLTree object
% uid    - UID of the root element of tree
%_______________________________________________________________________
%
% Return the uid of the root element of the tree.
%_______________________________________________________________________
% @(#)root.m                   Guillaume Flandin               02/04/17

% Actually root is necessarily the element whos UID is 1, by
% construction. However, xml_parser should return a tree with a ROOT
% element with as many children as needed but only ONE *element* child
% who would be the real root (and this method should return the UID of
% this element).

% uid = 1;

% Update:
% xml_parser has been modified (not as explained above) to handle the
% case when several nodes are at the top level of the XML.
% Example: <!-- beginning --><root>blah blah</root><!-- end -->
% Now root is the first element node of the tree.

% Look for the first element in the XML Tree

% uid = tree.root;
% return

T = tree.tree;
for i=1:length(T)
    if strcmp(T{i}.type,'element')
		uid = i;
		break
	end
end
