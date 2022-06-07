function H3_SYMTABLE = h3_getvariables(int_s, imp_s)

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

global H3_SYMTABLE

H3_SYMTABLE = {};

if ~isempty(int_s.parameter)
    sub_parse_parameters(int_s.parameter);
end

if ~isempty(int_s.module)
    sub_parse_modules(int_s.module);
end

sections = { 'state', 'input', 'output' };
for i = 1:length(sections)
    sec = getfield(int_s, sections{i}); 
    if ~isempty(sec)
        sub_parse_section(sec);
    end
end

for i = 1:length(imp_s.aux)
    sub_parse_section(imp_s.aux{i});
end

for i = 1:length(imp_s.aux)
    sub_parse_indexes(imp_s.aux{i});
end

% check that some variables weren't defined more than once
var_names = {};
for i = 1:length(H3_SYMTABLE)
%     if isreserved(H3_SYMTABLE{i}.name)
%         error('Symbol "%s" is a reserved keyword.', H3_SYMTABLE{i}.name);
%     end
    var_names{end+1} = H3_SYMTABLE{i}.name;
end
[a, b] = unique(var_names);
redundant_vars = setdiff(1:length(H3_SYMTABLE), b);
if ~isempty(redundant_vars)
    error('Variable "%s" defined more than once.', var_names{redundant_vars(1)});
end


%----------------------------------------------------------------
function sub_parse_parameters(tree)

global H3_SYMTABLE H3_INF H3_INF_COMMANDLINE H3_EPSILON H3_EPSILON_COMMANDLINE

param_kinds = { 'real', 'bool' };
type = 'parameter';

for i = 1:length(param_kinds)
    kind = param_kinds{i};
    prefix = ['//parameter_' kind '_ident_t'];
    p_pos = xpath(tree, prefix);
    for j = p_pos
        param_b = branch(tree, j);
        [xident, dim, value, minmax] = sub_parse_param_item(param_b);
        H3_SYMTABLE{end+1} = sub_definevar(param_b, xident, dim, ...
            type, kind, minmax, value);
        if ~H3_INF_COMMANDLINE && isequal(xident, 'MLD_bigMbound')
            if isempty(value)
                error('MLD_bigMbound cannot be a symbolic parameter.');
            end
            try
                H3_INF = eval(xslt(value));
            catch
                error('Wrong settings of MLD_bigMbound.');
            end
            if H3_INF <= 0
                error('MLD_bigMbound must be positive.');
            end
        end
        if ~H3_EPSILON_COMMANDLINE && isequal(xident, 'MLD_epsilon')
            if isempty(value)
                error('MLD_epsilon cannot be a symbolic parameter.');
            end
            try
                H3_EPSILON = eval(xslt(value));
            catch
                error('Wrong settings of MLD_epsilon.');
            end
            if H3_EPSILON <= 0
                error('MLD_epsilon must be positive.');
            end
        end
    
    end
end


%----------------------------------------------------------------
function sub_parse_modules(tree)

global H3_SYMTABLE

module_decl_pos = xpath(tree, '//module_decl_t');
for i = 1:length(module_decl_pos)
    module_b = branch(tree, module_decl_pos(i));
    module_name_pos = xpath(module_b, '//module_name_t//XIDENT[1]');
    module_name = sub_remove_dots(xslt(module_b, module_name_pos));
    module_idents = {};
    module_ident_pos = xpath(module_b, '//module_ident_t/ident_t/XIDENT');
    for j = 1:length(module_ident_pos)
        module_idents{end+1} = sub_remove_dots(strtrim(xslt(module_b, module_ident_pos(j))));
    end
    if length(unique(module_idents)) ~= length(module_idents)
        error('Duplicit module name found.');
    end
    dim = [1 length(module_idents)];
    H3_SYMTABLE{end+1} = sub_definevar(module_b, module_name, ...
        dim, 'module', '', {}, module_idents);
end


%----------------------------------------------------------------
function s = sub_remove_dots(s)

dpos = find(s == '.');
if ~isempty(dpos)
    s = s(dpos(end)+1:end);
end



%----------------------------------------------------------------
function sub_parse_indexes(tree)

global H3_SYMTABLE
type = 'index';
kind = 'index';

x = '//INDEX';
x_pos = xpath(tree, x);
for i = x_pos
    index_b = branch(tree, parent(tree, i));
    xident_pos = xpath(index_b, '//XIDENT');
    for j = xident_pos
        xident = getvalue(index_b, j);
        value = {};
        dim = {};
        kind = 'index';
        H3_SYMTABLE{end+1} = sub_definevar(index_b, xident, dim, type, kind);
    end
end


%----------------------------------------------------------------
function [xident, dim, value, minmax] = sub_parse_param_item(tree)

value = {};
dim = {};
indexed_ident_pos = xpath(tree, '/indexed_ident_t[1]');
if ~isempty(indexed_ident_pos)
    prefix = '/indexed_ident_t[1]';
    [xident, dim] = sub_parse_indexed_ident(tree, prefix);
else
    ident_pos = xpath(tree, '/ident_t[1]');
    if ~isempty(ident_pos)
        xident = xslt(tree, ident_pos(1));
    end
end
xident = strtrim(xident);


% is the parameter value defined?
matrix_pos = xpath(tree, '/matrix_t[1]');
if ~isempty(matrix_pos)
    value = branch(tree, matrix_pos(1));
else
    real_pos = xpath(tree, '/real_expr_t[1]');
    if ~isempty(real_pos)
        value = branch(tree, real_pos(1));
    end
end

minmax = {};
minmax_pos = xpath(tree, '/opt_var_minmax_t[1]');
if ~isempty(minmax_pos)
    minmax = branch(tree, minmax_pos(1));
end

%----------------------------------------------------------------
function sub_parse_section(tree)

global H3_SYMTABLE

ios_pos = xpath(tree, '//ios_ident_t');
for i = ios_pos
    ident_b = branch(tree, i);
    [xident, dim, minmax] = sub_parse_ios_item(ident_b);
        
    ident_parent = get(tree, parent(tree, i), 'name');
    ppos = findstr(ident_parent, '_');
    type = ident_parent(1:ppos(1)-1);
    kind = ident_parent(ppos(1)+1:ppos(2)-1);
    
    H3_SYMTABLE{end+1} = sub_definevar(ident_b, xident, dim, type, kind, minmax);
end


%----------------------------------------------------------------
function [xident, dim, minmax] = sub_parse_ios_item(ident_b)

% global H3_INF
H3_INF = Inf;

dim = {};
minmax = [-H3_INF H3_INF];

prefix = '/ios_ident_t[1]/indexed_ident_t[1]';
[xident, dim] = sub_parse_indexed_ident(ident_b, prefix);

minmax_pos = xpath(ident_b, '/ios_ident_t[1]/opt_var_minmax_t[1]');
if ~isempty(minmax_pos)
    minmax = branch(ident_b, minmax_pos);
end


%----------------------------------------------------------------
function [xident, dim] = sub_parse_indexed_ident(ident_b, prefix)

dim = {};
xident_pos = xpath(ident_b, [prefix '/XIDENT']);
xident = xslt(ident_b, xident_pos);

dim_pos = xpath(ident_b, [prefix '/cycle_item_t']);
n_dim = length(dim_pos);
if n_dim > 0
    dim{1} = branch(ident_b, dim_pos(1));
    if n_dim > 1
        dim{2} = branch(ident_b, dim_pos(2));
    end
end


%----------------------------------------------------------------
function var = sub_definevar(tree, name, dim, type, kind, minmax, value)

global H3_MODULE_PATH

if nargin < 6
    value = {};
    minmax = {};
elseif nargin < 7
    value = {};
end

if length(dim) == 1
    dim{2} = '1';
end
if isequal(kind, 'bool')
    minmax = [0 1];
end

is_parameter = isequal(type, 'parameter');
is_index = isequal(type, 'index');
var.name = strtrim(name);
var.orig_type = type;
if ~isempty(H3_MODULE_PATH)
    if ismember(type, {'input', 'output'})
        % all submodule inputs and outputs become auxiliary variables
        %
        % only inputs/output defined in the master file are the true
        % inputs/outputs of the overall system
        type = 'aux';
    end
end
var.type = type;
var.kind = kind;
var.dim = dim;
var.value = value;
var.minmax = minmax;
var.tree = tree;
