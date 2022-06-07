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

% h3_fprintf(fid, '%%--------------- %s ----------------\n', upper(type));
h3_parse_section_main(tree, type, fid);
% h3_fprintf(fid, '%%--------------- %s ----------------\n\n', upper(type));


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
            h3_fprintf(fid, 'for %s = %s\n', xslt(iter_b), xslt(cycle_b));
            
            % recursively parse this for_t token
            h3_parse_section_main(expr_b, type, fid);
            
            h3_fprintf(fid, 'end\n');
            
    end
end


%------------------------------------------------------------------
function sub_parse_section_item(item_b, type, fid)

global H3_MODULE_PATH
global H3_BEHAVE_LIKE_HYSDEL2
global H3_CHECK_LINEARITY

check_linearity = H3_CHECK_LINEARITY;

h3_fprintf(fid, 'H3_SOURCE_LINE = ''%s'';\n', xslt(item_b));

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
        
        if check_linearity
            h3_fprintf(fid, 'h3_yalmip_state(''save'');\n');
            h3_fprintf(fid, 'h3_check_linearity(h3_yalmip_variables, %s, %s);\n', lhs_x, rhs_x);
            h3_fprintf(fid, 'h3_yalmip_state(''load'');\n');
        end
        h3_fprintf(fid, 'h3_yalmip_F = h3_yalmip_F + h3_iff(%s, %s);\n', ...
            rhs_x, lhs_x);
        h3_fprintf(fid, 'h3_define_symbol(''advance'');\n');

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
        if H3_BEHAVE_LIKE_HYSDEL2 && sub_is_logic(if_x)
            % replace complex logic by an additional binary
            %
            % e.g. z = {IF d1&d2 THEN a ELSE b} will be replaced by
            %   d3 = d1&d2
            %   z = {IF d3 THEN a ELSE b}
            h3_fprintf(fid, 'new_binary = binvar(1,1);\n');
            h3_fprintf(fid, 'h3_define_symbol(''advance'');\n');
            h3_fprintf(fid, 'h3_yalmip_F = h3_yalmip_F + h3_logic_item(new_binary, (%s), ''additional_d'');\n', if_x);
            if_x = 'new_binary';
        end
        
        if check_linearity
            h3_fprintf(fid, 'h3_yalmip_state(''save'');\n');
            h3_fprintf(fid, 'h3_check_linearity(h3_yalmip_variables, %s, %s, %s, %s);\n', ...
            lhs_x, if_x, then_x, else_x);
            h3_fprintf(fid, 'h3_yalmip_state(''load'');\n');
        end
        h3_fprintf(fid, 'h3_yalmip_F = h3_yalmip_F + h3_ifthenelse(%s, %s, %s, %s) ;\n', ...
            lhs_x, if_x, then_x, else_x );
        h3_fprintf(fid, 'h3_define_symbol(''advance'');\n');
        
    case 'must'
        h3_check_semantics(item_b, 'must', 'rhs', item_b);
        [B, b1, b2, islogic] = h3_parse_item(item_b, 'must');
        B = sub_real_cast(B);
        b1 = sub_real_cast(b1);
        b2 = sub_real_cast(b2);

        if check_linearity
            h3_fprintf(fid, 'h3_yalmip_state(''save'');\n');
            h3_fprintf(fid, 'h3_check_linearity(h3_yalmip_variables, %s, %s);\n', b1, b2);
            h3_fprintf(fid, 'h3_yalmip_state(''load'');\n');
        end
        if H3_BEHAVE_LIKE_HYSDEL2 && islogic
            % create a mixed-integer model of a logic MUST item, but
            % eliminate any binaries automatically introduced by YALMIP
            h3_fprintf(fid, 'h3_yalmip_F = h3_yalmip_F + h3_logic_item((%s), ''must'');\n', B);
        elseif islogic
            % keep additional binaries generated by YALMIP
            h3_fprintf(fid, 'h3_yalmip_F = h3_yalmip_F + set( true(%s), ''must'' );\n', B);
        else
            % MUST item containing only real expressions
            h3_fprintf(fid, 'h3_yalmip_F = h3_yalmip_F + set( %s, ''must'' );\n', B);
        end
        h3_fprintf(fid, 'h3_define_symbol(''advance'');\n');

    case 'aux'
        % nothing to do here

    case { 'continuous', 'automata' }
        [lhs_b, rhs_b] = h3_parse_item(item_b, 'real');
        h3_check_semantics(lhs_b, lower(type), 'lhs', item_b);
        h3_check_semantics(rhs_b, lower(type), 'rhs', item_b);
        
        rhs_x = sub_real_cast(xslt(rhs_b));
        lhs_x = xslt(lhs_b);

        if check_linearity
            h3_fprintf(fid, 'h3_yalmip_state(''save'');\n');
            h3_fprintf(fid, 'h3_check_linearity(h3_yalmip_variables, %s, %s);\n', lhs_x, rhs_x);
            h3_fprintf(fid, 'h3_yalmip_state(''load'');\n');
        end
        if H3_BEHAVE_LIKE_HYSDEL2 && sub_is_logic(rhs_x)
            % replace complex logic by an additional binary
            %
            % e.g. xb(k+1) = (d1 & d2)|xb1 will be replaced by
            %   d3 = (d1&d2)|xb1
            %   xb(k+1) = d3
            h3_fprintf(fid, 'new_binary = binvar(1,1);\n');
            h3_fprintf(fid, 'h3_define_symbol(''advance'');\n');
            h3_fprintf(fid, 'h3_yalmip_F = h3_yalmip_F + h3_logic_item(new_binary, (%s), ''additional_d'');\n', rhs_x);
            rhs_x = 'new_binary';
        end
        h3_fprintf(fid, 'h3_yalmip_F = h3_yalmip_F + set(%s == (%s), ''update'');\n', ...
            sub_real_cast(xslt(sub_plussed(lhs_b))), rhs_x);
        h3_fprintf(fid, 'h3_define_symbol(''advance'');\n');

    case { 'output' }
        [lhs_b, rhs_b] = h3_parse_item(item_b, 'real');
        h3_check_semantics(lhs_b, 'output', 'lhs', item_b);
        h3_check_semantics(rhs_b, 'output', 'rhs', item_b);

        rhs_x = sub_real_cast(xslt(rhs_b));
        lhs_x = xslt(lhs_b);
        
        if check_linearity
            h3_fprintf(fid, 'h3_yalmip_state(''save'');\n');
            h3_fprintf(fid, 'h3_check_linearity(h3_yalmip_variables, %s, %s);\n', lhs_x, rhs_x);
            h3_fprintf(fid, 'h3_yalmip_state(''load'');\n');
        end
        if H3_BEHAVE_LIKE_HYSDEL2 && sub_is_logic(rhs_x)
            % replace complex logic by an additional binary
            %
            % e.g. y = (d1 & d2)|xb1 will be replaced by
            %   d3 = (d1&d2)|xb1
            %   y = d3
            h3_fprintf(fid, 'new_binary = binvar(1,1);\n');
            h3_fprintf(fid, 'h3_define_symbol(''advance'');\n');
            h3_fprintf(fid, 'h3_yalmip_F = h3_yalmip_F + h3_logic_item(new_binary, (%s), ''additional_d'');\n', rhs_x);
            rhs_x = 'new_binary';
        end
        h3_fprintf(fid, 'h3_yalmip_F = h3_yalmip_F + set(%s == (%s), ''output'');\n', ...
                lhs_x, rhs_x);
        h3_fprintf(fid, 'h3_define_symbol(''advance'');\n');

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

        if check_linearity
            h3_fprintf(fid, 'h3_yalmip_state(''save'');\n');
            h3_fprintf(fid, 'h3_check_linearity(h3_yalmip_variables, %s, %s);\n', lhs_x, rhs_x);
            h3_fprintf(fid, 'h3_yalmip_state(''load'');\n');
        end
        
        if H3_BEHAVE_LIKE_HYSDEL2 && sub_is_logic(rhs_x)
            % use HYSDEL2-like expansion of complex logic constraints
            %
            % for complex logic like "d4 = ((d1|d2)&d3)" YALMIP would
            % introduce additional binaries "d5=(d1|d2)" and "d6="d5&d3".
            % HYSDEL2, on the other hand, doesn't do that. therefore in
            % h3_logic_item we first let YALMIP to model the statement
            % using additional binaries, and we subsequently remove them
            % using Fourier-Motzkin elimination
            %
            % as a consequence we get a model of exactly the same
            % complexity (in terms of number of variables) as in HYSDEL2.
            %
            % since Fourier-Motzkin elimination introduces additional
            % constraints, we perform removal of redundant inequalities. it
            % could, however, happen, that we don't catch all of them.
            h3_fprintf(fid, 'h3_yalmip_F = h3_yalmip_F + h3_logic_item((%s), (%s));\n', ...
                lhs_x, rhs_x);
            
        elseif H3_BEHAVE_LIKE_HYSDEL2 && ~sub_is_logic(rhs_x)
            % linear item with additional bound detection
            h3_fprintf(fid, 'h3_yalmip_F = h3_yalmip_F + h3_linear_item((%s), (%s));\n', ...
                lhs_x, rhs_x);
            
        else
            % use standard YALMIP modeling of complex logic using more
            % binaries
            h3_fprintf(fid, 'H3_AND_LHS_VAR = [];\n');
            h3_fprintf(fid, 'h3_yalmip_F = h3_yalmip_F + set(%s == (%s));\n', ...
                lhs_x, rhs_x);
        end
        h3_fprintf(fid, 'h3_define_symbol(''advance'');\n');

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

global H3_USE_SUBSTITUTION

s = strrep(s, 'REAL', '');
if H3_USE_SUBSTITUTION
    s = strrep(s, '<->', '==');
else
    s = strrep(s, '<->', '~=');
end
s = strrep(s, '->', '<');
s = strrep(s, '<-', '>');


%---------------------------------------------------------------------
function out = sub_is_logic(s)

logic_tokens = {'|', '&', '~=', '<', '>'};

for i = 1:length(logic_tokens)
    if ~isempty(findstr(s, logic_tokens{i}))
        out = true;
        return
    end
end
out = false;


%---------------------------------------------------------------------
function B = sub_process_logic(B)

% logic_expr_pos = xpath(B, '/logic_expr_t');
% if isempty(logic_expr_pos)
%     % this is not a logic expression
%     return
% end
% 
% 
% elseif logic_expr_pos(1) ~= 1
%     % this is not a logic expression
% end
% 
% % are there any implications?
% ar_if_pos = xpath(B, '/AR_IF');
B;
