function h3_parse_section(tree, type, fid)

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


fprintf(fid, '%%--------------- %s ----------------\n', upper(type));
h3_parse_section_main(tree, type, fid);
fprintf(fid, '%%--------------- %s ----------------\n\n', upper(type));


%-----------------------------------------------------------------
function h3_parse_section_main(tree, type, fid)

for_name = [type '_for_t'];

x = ['//' type '_item_t'];
item_pos = xpath(tree, x);

x = ['//' for_name];
for_pos = xpath(tree, x);

% find all children of all for_t tokens (at this level we only parse
% top-level item_t tokens)
for_children = [];
for i = for_pos
    for_children = [for_children children(tree, i, 'all')];
end

% eliminate items which are inside of for_t
new_item_pos = [];
for i = item_pos
    % is the item a child of some for_t item?
    if ~ismember(i, for_children)
        % is the item just a container of a FOR statement?
        if ~isequal(get(tree, i+1, 'name'), for_name)
            % no, this is a standalone item, record it
            new_item_pos = [new_item_pos i];
        end
    end
end    

% eliminate all for_t tokens which are inside of other for_t's (at this
% level we only parse top-level for_t tokens)
new_for_pos = [];
for i = for_pos
    if ~ismember(i, for_children)
        new_for_pos = [new_for_pos i];
    end
end

% now retrieve the original order of item_t and for_t tokens
POS = [new_item_pos, new_for_pos];
TYPE = [repmat('I', 1, length(new_item_pos)), repmat('F', 1, length(new_for_pos))];
[pos, b] = sort(POS);
TYPE = TYPE(b);

% parse each token
for i = 1:length(pos)
    idx = pos(i);
    switch TYPE(i)
        case 'I'
            % parse item_t
            item_b = branch(tree, idx);
            sub_parse_section_item(item_b, type, fid);
            
        case 'F'
            % parse for_t
            for_b = branch(tree, idx);
            [iter_b, cycle_b, expr_b] = h3_parse_for_item(for_b, type);
            fprintf(fid, 'for %s = %s\n', xslt(iter_b), xslt(cycle_b));
            
            % recursively parse this for_t token
            h3_parse_section_main(expr_b, type, fid);
            
            fprintf(fid, 'end\n');
            
    end
end


%------------------------------------------------------------------
function sub_parse_section_item(item_b, type, fid)

global H3_MODULE_PATH

fprintf(fid, '%% ''%s'';\n', xslt(item_b));

if ~isempty(H3_MODULE_PATH) & isequal(type, 'output')
    % OUTPUT sections of slave files in fact becomes a LINEAR section,
    % because all local OUTPUT variables have been already converted to AUX
    % variables
    type = 'linear';
    module_output = 1;
else
    module_output = 0;
end

switch lower(type)
    case 'ad'
        [lhs_b, rhs_b] = h3_parse_item(item_b, 'ad');
        h3_check_semantics(lhs_b, 'ad', 'lhs', item_b);
        h3_check_semantics(rhs_b, 'ad', 'rhs', item_b);
        
        rhs_x = sub_real_cast(xslt(rhs_b));
        lhs_x = xslt(lhs_b);
        
        fprintf(fid, '%s = (%s);\n', lhs_x, rhs_x);

    case 'da'
        [lhs_b, if_b, then_b, else_b] = h3_parse_item(item_b, 'da');
        h3_check_semantics(lhs_b, 'da', 'lhs', item_b);
        h3_check_semantics(if_b, 'da', 'rhs', item_b);
        h3_check_semantics(then_b, 'da', 'rhs', item_b);
        
        if length(else_b) == 1
            % if no ELSE part defined -- set it to zero
            else_x = '0';
        else
            h3_check_semantics(else_b, 'da', 'rhs', item_b);
            else_x = sub_real_cast(xslt(else_b));
        end
        lhs_x = xslt(lhs_b);
        if_x = sub_real_cast(xslt(if_b));
        then_x = sub_real_cast(xslt(then_b));

        fprintf(fid, 'if (%s)\n', if_x);
        fprintf(fid, '\t%s = (%s);\n', lhs_x, then_x);
        fprintf(fid, 'else\n');
        fprintf(fid, '\t%s = (%s);\n', lhs_x, else_x);
        fprintf(fid, 'end\n');
        
    case 'must'
        h3_check_semantics(item_b, 'must', 'rhs', item_b);
        [B, b1, b2] = h3_parse_item(item_b, 'must');
        B = sub_real_cast(B);
        b1 = sub_real_cast(b1);
        b2 = sub_real_cast(b2);

        fprintf(fid, 'h3_feasible = h3_feasible & all(all(%s));\n', B);

    case 'aux'
        % nothing to do here

    case { 'continuous', 'automata' }
        [lhs_b, rhs_b] = h3_parse_item(item_b, 'real');
        h3_check_semantics(lhs_b, lower(type), 'lhs', item_b);
        h3_check_semantics(rhs_b, lower(type), 'rhs', item_b);
        
        rhs_x = sub_real_cast(xslt(rhs_b));
        lhs_x = xslt(lhs_b);

        fprintf(fid, '%s = (%s);\n', sub_real_cast(xslt(sub_plussed(lhs_b))), rhs_x);

    case { 'output' }
        [lhs_b, rhs_b] = h3_parse_item(item_b, 'real');
        h3_check_semantics(lhs_b, 'output', 'lhs', item_b);
        h3_check_semantics(rhs_b, 'output', 'rhs', item_b);
        
        rhs_x = sub_real_cast(xslt(rhs_b));
        lhs_x = xslt(lhs_b);

        fprintf(fid, '%s = (%s);\n', lhs_x, rhs_x);

    case { 'logic', 'linear', }
        [lhs_b, rhs_b] = h3_parse_item(item_b, 'real');
        if module_output
            % OUTPUT sections of slave files in fact becomes a LINEAR section,
            % because all local OUTPUT variables have been already converted to AUX
            % variables. however, we cannot distinguish whether the OUTPUT
            % statement is linear or logical. therefore if we hit such an
            % OUTPUT statement converted to a LINEAR one, we must tell
            % h3_check_semantics that LHS arguments can also be boolean in
            % this particular case.
            type = 'linear_or_logic';
        end
        h3_check_semantics(lhs_b, lower(type), 'lhs', item_b);
        h3_check_semantics(rhs_b, lower(type), 'rhs', item_b);
        
        rhs_x = sub_real_cast(xslt(rhs_b));
        lhs_x = xslt(lhs_b);

        fprintf(fid, '%s = (%s);\n', lhs_x, rhs_x);
        
    otherwise
        error('Unknown section "%s".', type);

end


%---------------------------------------------------------------------
function tree = sub_plussed(tree)

xident_pos = xpath(tree, '/XIDENT');
ch = children(tree, xident_pos(1));
v = get(tree, ch, 'value');
tree = set(tree, ch, 'value', [v '_plus']);


%---------------------------------------------------------------------
function [iter_b, cycle_b, expr_b] = h3_parse_for_item(tree, type)

iter_pos = xpath(tree, '/iterator_ident_t[1]');
cycle_pos = xpath(tree, '/cycle_item_t[1]');
expr_pos = xpath(tree, [type '_item_t[1]']);
if isempty(expr_pos)
    expr_pos = xpath(tree, [type '_list_t[1]']);
    if isempty(expr_pos)
        error('Empty FOR cycle.');
    end
end

iter_b = branch(tree, iter_pos);
cycle_b = branch(tree, cycle_pos);
expr_b = branch(tree, expr_pos);


%---------------------------------------------------------------------
function s = sub_real_cast(s)

s = strrep(s, 'REAL', '');
s = strrep(s, '<->', '==');
s = strrep(s, '->', '<=');
s = strrep(s, '<-', '>=');
