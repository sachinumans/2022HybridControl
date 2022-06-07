function [varargout] = h3_parse_item(tree, type)

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

switch lower(type)
    case { 'real', 'ad' }
        n_out = 2;
    case 'da'
        n_out = 4;
    case 'must'
        n_out = 4;
end
varargout = cell(1, n_out);

switch lower(type)
    case 'real'
        [varargout{:}] = sub_parse_cont_item(tree);
        
    case 'da'
        [varargout{:}] = sub_parse_da_item(tree);
        
    case 'ad'
        [varargout{:}] = sub_parse_ad_item(tree);
        
    case 'must'
        [varargout{:}] = sub_parse_must_item(tree);
        
    otherwise
        error('Unknown item type "%s".', type);
end


%--------------------------------------------------------------------
function [B, b1, b2, islogic] = sub_parse_must_item(tree)

b1 = '0';
b2 = '0';
affine_pos = xpath(tree, '/must_affine_t');
logic_pos = xpath(tree, '/logic_expr_t');
n_affine = length(affine_pos);
n_logic = length(logic_pos);

if n_affine == 1 & n_logic == 0
    %   must_affine_t ';'
    % 	| '(' must_affine_t ')' ';'
    B = xslt(tree, affine_pos);
    b1 = B;
    islogic = false;
 
elseif n_affine == 0 & n_logic == 1
    % | logic_expr_t ';'
    B = xslt(tree, logic_pos);
    b1 = B;
    islogic = true;
    
elseif n_affine == 0 & n_logic == 2
    % | logic_expr_t AR_IF logic_expr_t ';'
    % | logic_expr_t AR_FI logic_expr_t ';'
    % | logic_expr_t AR_IFF logic_expr_t ';'
    b1 = xslt(tree, logic_pos(1));
    b2 = xslt(tree, logic_pos(2));
    implication_type = sub_get_implication_type(tree);
    B = sub_parse_implication_item(b1, b2, implication_type, tree);
    islogic = true;

elseif n_affine == 2 & n_logic == 0
    % | '(' must_affine_t ')' AR_IF '(' must_affine_t ')' ';'
    % | '(' must_affine_t ')' AR_FI '(' must_affine_t ')' ';'
    % | '(' must_affine_t ')' AR_IFF '(' must_affine_t ')' ';'
    implication_type = sub_get_implication_type(tree);
    b1 = xslt(tree, affine_pos(1));
    b2 = xslt(tree, affine_pos(2));
    B = sub_parse_implication_item(b1, b2, implication_type, tree);
    islogic = true;
    
elseif n_affine == 1 & n_logic == 1
    %         | '(' must_affine_t ')' AR_IF logic_expr_t ';'
    %         | '(' must_affine_t ')' AR_FI logic_expr_t ';'
    %         | '(' must_affine_t ')' AR_IFF logic_expr_t ';'
    % 	      | logic_expr_t AR_IF '(' must_affine_t ')' ';'
    %         | logic_expr_t AR_FI '(' must_affine_t ')' ';'
    %         | logic_expr_t AR_IFF '(' must_affine_t ')' ';'
    %         | '(' must_affine_t ')' '|' logic_expr_t ';'
    %         | '(' must_affine_t ')' OR logic_expr_t ';'
    %         | '(' must_affine_t ')' '&' logic_expr_t ';'
    %         | '(' must_affine_t ')' AND logic_expr_t ';'
    %         | logic_expr_t '|' '(' must_affine_t ')' ';'
    %         | logic_expr_t OR '(' must_affine_t ')' ';'
    %         | logic_expr_t '&' '(' must_affine_t ')' ';'
    %         | logic_expr_t AND '(' must_affine_t ')' ';'
    if logic_pos < affine_pos
        b1 = xslt(tree, logic_pos);
        b2 = xslt(tree, affine_pos);
    else
        b1 = xslt(tree, affine_pos);
        b2 = xslt(tree, logic_pos);
    end
    implication_type = sub_get_implication_type(tree);
    if ismember(implication_type, { '|', '&' })
        B = sprintf('(%s) %s (%s)', b1, implication_type, b2);
        
    else
        B = sub_parse_implication_item(b1, b2, implication_type, tree);
        
    end
    islogic = true;
    
else
    error('Malformed must item "%s".', xslt(tree));
    
end


%--------------------------------------------------------------------
function B = sub_parse_implication_item(b1, b2, implication_type, tree)

switch implication_type
    case '->'
        % B = sprintf('h3_implies((%s), (%s))', b1, b2);
        B = sprintf('(%s) < (%s)', b1, b2);

    case '<-'
        % B = sprintf('h3_implies((%s), (%s))', b2, b1);
        B = sprintf('(%s) > (%s)', b1, b2);

    case '<->'
        % B = sprintf('h3_equivalence((%s), (%s))', b1, b2);
        B = sprintf('(%s) ~= (%s)', b1, b2);

    case '=='
        B = sprintf('(%s) == (%s)', b1, b2);
        
    otherwise
        error('Malformed MUST item "%s".', xslt(tree));
end


%--------------------------------------------------------------------
function t = sub_get_implication_type(tree)

ch = children(tree, root(tree));
e1 = xslt(tree, ch(1));
if isequal(strtrim(e1), '(')
    implication_idx = 4;
else
    implication_idx = 2;
end
t = strtrim(xslt(tree, ch(implication_idx)));


%--------------------------------------------------------------------
function [LHS, RHS] = sub_parse_cont_item(tree)

ident_pos = xpath(tree, '/indexed_ident_t[1]');
rhs_pos = xpath(tree, '/real_expr_t[1]');
if isempty(rhs_pos)
    rhs_pos = xpath(tree, '/logic_expr_t[1]');
    if isempty(rhs_pos)
        error('Malformed expression "%s", missing real or logic RHS', xslt(tree));
    end
    RHS_type = 'logic';
else
    RHS_type = 'real';
end

LHS = branch(tree, ident_pos(1));
RHS = branch(tree, rhs_pos(1));


%--------------------------------------------------------------------
function [LHS, RHS] = sub_parse_ad_item(tree)

ident_pos = xpath(tree, '/indexed_ident_t[1]');
rhs_pos = xpath(tree, '/real_cond_t[1]');
if isempty(rhs_pos)
    if isempty(rhs_pos)
        error('Malformed AD expression "%s", missing RHS', xslt(tree));
    end
end

LHS = branch(tree, ident_pos(1));
RHS = branch(tree, rhs_pos(1));


%--------------------------------------------------------------------
function [LHS_b, IF_b, THEN_b, ELSE_b] = sub_parse_da_item(tree)

else_pos = 0;
ch = children(tree, root(tree));
ident_pos = ch(1);
if_pos = ch(5);
then_pos = ch(7);
if length(ch) >= 10
    else_pos = ch(9);
end
% 
% ident_pos = xpath(tree, '/DA_item_t/indexed_ident_t');
% if_pos = xpath(tree, '/DA_item_t/IF');
% then_pos = xpath(

LHS_b = branch(tree, ident_pos);
IF_b = branch(tree, if_pos);
THEN_b = branch(tree, then_pos);
if else_pos > 0
    ELSE_b = branch(tree, else_pos);
else
    ELSE_b = xmltree;
end
