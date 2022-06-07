function h3_check_semantics(expr_b, section, position, main_item)

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


% AD, DA, continuous, automata, linear, logic, output, must
position = lower(position);

switch position
    case 'lhs'

        switch lower(section)
            
            case {'ad', 'logic'}
                sub_check_item(expr_b, position, main_item, 'aux', {'bool', 'index'});

            case {'da', 'linear'}
                sub_check_item(expr_b, position, main_item, 'aux', {'real', 'index'});
                
            case 'linear_or_logic'
                sub_check_item(expr_b, position, main_item, 'aux', {'real', 'bool', 'index'});

            case 'automata'
                sub_check_item(expr_b, position, main_item, 'state', {'bool', 'index'});

            case 'continuous'
                sub_check_item(expr_b, position, main_item, 'state', {'real', 'index'});

            case 'must'
                sub_check_item(expr_b, position, main_item, 'defined', 'all');

            case 'output'
                sub_check_item(expr_b, position, main_item, 'output', 'all');

        end
        

    case 'rhs'
        switch lower(section)
            
            case 'parameter'
                sub_check_item(expr_b, position, main_item, 'parameter', {'real', 'bool'});
                
            case 'interface'
                sub_check_item(expr_b, position, main_item, 'parameter', 'all');
            
            case {'logic', 'automata'}
                sub_check_item(expr_b, position, main_item, 'defined', {'bool', 'index'});

            otherwise
                sub_check_item(expr_b, position, main_item, 'defined', 'all');
        end
                
end


%------------------------------------------------------------------------
function sub_check_item(expr_b, position, main_item, lhs_type, lhs_kind)

if isequal(position, 'lhs')
    V = sub_get_all_idents(expr_b, 1);
else
    V = sub_get_all_idents(expr_b);
end
sub_check_all_defined(V, main_item);
if isequal(position, 'rhs')
    if any(h3_is_a(V, 'output'))
        sub_error('RHS must not contain an OUTPUT variable.', main_item);
    end
end

if ~all(h3_is_a(V, lhs_type, lhs_kind))
    if isequal(lhs_kind, 'all')
        lhs_kind = '';
    end
    
    sub_error(sprintf('%s can only contain %s %s variables.', ...
        upper(position), sub_cell_strcat(upper(lhs_kind)), ...
        sub_cell_strcat(upper(lhs_type))), main_item);
end


%------------------------------------------------------------------------
function c = sub_cell_strcat(c)

if ~iscell(c)
    c = { c };
end
n = length(c);
dlmtrs = cell(1, n);
[dlmtrs{1:end-1}] = deal('/');
dlmtrs{end} = '';
c = strcat(c, dlmtrs);
c = cat(2, c{:});


%------------------------------------------------------------------------
function sub_check_all_defined(V, main_item)

def = h3_is_a(V, 'defined', 'all');
undef = ~def;
if any(undef)
    Vundef = V(undef);
    V_str = '';
    n_undef = sum(undef);
    for i = 1:n_undef-1
        V_str = [V_str Vundef{i} ', '];
    end
    if n_undef > 0
        V_str = [V_str Vundef{end}];
    end
    sub_error(sprintf('Undefined variable(s) "%s".', V_str), main_item);
end
    

%------------------------------------------------------------------------
function sub_error(errmsg, item)

fprintf('Error at:\n');
fprintf('  %s\n\n', xslt(item));
error(sprintf('\n\nSemantics error: %s\n', errmsg));


%------------------------------------------------------------------------
function V = sub_get_all_idents(tree, index)

if nargin < 2
    index = 0;
end

V = {};
if index
    xident_pos = xpath(tree, sprintf('//XIDENT[%d]', index));
else
    xident_pos = xpath(tree, '//XIDENT');
end
for i = xident_pos
    V{end+1} = getvalue(tree, i);
end

%------------------------------------------------------------------------
function [xident, c1, c2] = sub_parse_indexed_ident(tree)

c1 = []; c2 = [];
xident_pos = xpath(tree, '/XIDENT');
xident = xslt(tree, xident_pos);

if nargout > 1
    cycle_pos = xpath(tree, '/cycle_item_t');
    n_dim = length(cycle_pos);
    if n_dim > 0
        c1 = branch(tree, cycle_pos(1));
        if n_dim > 1
            c2 = branch(tree, cycle_pos(2));
        end
    end
end
