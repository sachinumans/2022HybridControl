function h3_writevariables(vars, fid)

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

global H3_REORDER_AUXS

% check for any symbolic parameters except predefined parameters
exceptions = {'pi'};
symb_params = sub_check_symbolic(vars, fid, exceptions);

% write all parameters
% h3_fprintf(fid, '%% declared parameters\n'); 
% write symbolic parameters first, derived parameters next
symb_params = [];
derived_params = [];

% write parameters, respect the order in which they have been declared
for i = 1:length(vars)
    p = vars{i};
    if isequal(p.type, 'parameter') & ~isempty(p.value)
        % derived parameter
        h3_check_semantics(p.tree, 'PARAMETER', 'rhs', p.tree);
        sub_write_parameter(p, fid);
        
    elseif isequal(p.type, 'parameter') & isempty(p.value)
        sub_write_symbolic_parameter(p, fid, exceptions);
        
    end
end

x_vars = '';
xplus_vars = '';
u_vars = '';
y_vars = '';
aux_vars = '';
n_vars = length(vars);

% reorder variables such that boolean auxiliaries come before real auxs
if H3_REORDER_AUXS
    bool_auxs = zeros(1, n_vars);
    real_auxs = zeros(1, n_vars);
    for i = 1:n_vars
        v = vars{i};
        if isequal(v.type, 'aux')
            if isequal(v.kind, 'bool')
                bool_auxs(i) = 1;
            elseif isequal(v.kind, 'real')
                real_auxs(i) = 1;
            end
        end
    end
    bool_auxs = find(bool_auxs);
    real_auxs = find(real_auxs);
    all_other_vars = setdiff(1:n_vars, [bool_auxs real_auxs]);
    vars = vars([all_other_vars bool_auxs real_auxs]);
end

% now write variables
for i = 1:n_vars
    v = vars{i};
    if ismember(v.type, {'parameter', 'index', 'module'})
        % skip parameters, indices, and modules
        continue
    end
    
    if isa(v.minmax, 'xmltree')
        % variable bounds can only be defined by means of parameters
        h3_check_semantics(v.minmax, 'INTERFACE', 'rhs', v.tree);
    end
    for i = 1:length(v.dim)
        if isa(v.dim{i}, 'xmltree')
            % variable dimension can only be defined by means of parameters
            h3_check_semantics(v.dim{i}, 'INTERFACE', 'rhs', v.tree);
        end
    end
    sub_write_var(v, fid);
    
    switch v.type
        case 'state'
            w = v;
            w.name = [v.name '_plus'];
            sub_write_var(w, fid);
            
            x_vars = [x_vars v.name '(:); '];
            xplus_vars = [xplus_vars w.name '(:); '];
            
        case 'output'
            y_vars = [y_vars v.name '(:); '];
            
        case 'input'
            u_vars = [u_vars v.name '(:); '];
            
        case 'aux'
            aux_vars = [aux_vars v.name '(:); '];
            
    end
end
h3_fprintf(fid, '\n');
h3_fprintf(fid, 'h3_yalmip_x_vars = [h3_yalmip_x_vars(:); %s];\n', x_vars(1:end-2));
h3_fprintf(fid, 'h3_yalmip_xplus_vars = [h3_yalmip_xplus_vars(:); %s];\n', xplus_vars(1:end-2));
h3_fprintf(fid, 'h3_yalmip_u_vars = [h3_yalmip_u_vars(:); %s];\n', u_vars(1:end-2));
h3_fprintf(fid, 'h3_yalmip_y_vars = [h3_yalmip_y_vars(:); %s];\n', y_vars(1:end-2));
h3_fprintf(fid, 'h3_yalmip_aux_vars = [h3_yalmip_aux_vars(:); %s];\n', aux_vars(1:end-2));
h3_fprintf(fid, 'h3_yalmip_variables = [h3_yalmip_x_vars; h3_yalmip_xplus_vars; h3_yalmip_u_vars; h3_yalmip_y_vars; h3_yalmip_aux_vars];\n');
h3_fprintf(fid, '\n');

% write names of inputs/states/outputs
sub_write_names(vars, fid)
   


%---------------------------------------------------------------------
function sub_write_parameter(p, fid)

global H3_INF

h3_fprintf(fid, '\n');
p_value = sub_xslt(p.value);
if isempty(p.dim)
    h3_fprintf(fid, 'H3_SOURCE_LINE = ''%s %s = %s'';\n', ...
        upper(p.kind), p.name, p_value);
    
else
    h3_fprintf(fid, 'H3_SOURCE_LINE = ''%s %s(%s, %s) = %s'';\n', ...
        upper(p.kind), p.name, sub_xslt(p.dim{1}), sub_xslt(p.dim{2}), ...
        p_value);
    
end
h3_fprintf(fid, '%s = eval(''%s'');\n', p.name, p_value);
h3_fprintf(fid, 'h3_define_symbol(''advance'');\n');



%---------------------------------------------------------------------
function sub_write_symbolic_parameter(p, fid, exceptions)

% write symbolic parameters except the predefined variables
for i = 1:length(exceptions)
  if ~isequal(p.name,exceptions{i}) 
      if ~isempty(p.dim)
          [p_dim, dim1, dim2] = sub_get_dim(p);
      else
          p_dim = '1';
          dim1 = '1';
          dim2 = '1';
      end
      h3_fprintf(fid, 'if h3_isfield(par, ''%s'')\n', p.name);
      h3_fprintf(fid, '\t%s = par.%s;\n', p.name, p.name);
      h3_fprintf(fid, 'else\n');
      h3_fprintf(fid, '\tdisp(''Using symbolic parameter "%s"...'');\n', p.name);
      h3_fprintf(fid, '\t%s = sdpvar(%s, %s, ''full'');\n', p.name, dim1, dim2);
      h3_fprintf(fid, '\th3_define_symbol(''add'', ''%s'', %s, %s, %s);\n', p.name, p_dim, dim1, dim2);
      if ~isempty(p.minmax)
          v_bounds = sub_xslt(p.minmax);
          h3_fprintf(fid, '\th3_var_bounds = eval(''%s'');\n', v_bounds);
          h3_fprintf(fid, '\th3_yalmip_F = h3_yalmip_F + set(h3_var_bounds(:, 1) <= %s <= h3_var_bounds(:,2), ''bounds'');\n', ...
              p.name);
      end

      h3_fprintf(fid, '\th3_yalmip_parameters = [h3_yalmip_parameters; %s(:)];\n', p.name);
      h3_fprintf(fid, '\th3_names.ParameterName = cat(2, h3_names.ParameterName, {''%s''});\n', ...
          p.name);
      h3_fprintf(fid, '\th3_names.ParameterLength = cat(2, h3_names.ParameterLength, {eval(''%s'')});\n', ...
          p_dim);
      h3_fprintf(fid, 'end\n');
      %%h3_fprintf(fid, '%s = par.%s;\n', p.name, p.name);
  end
end
  
%---------------------------------------------------------------------
function s = sub_xslt(s)

if isa(s, 'double')
    s = mat2str(s);
elseif ~ischar(s)
    s = xslt(s);
end


%---------------------------------------------------------------------
function sub_write_var(v, fid)

h3_fprintf(fid, '\n');

[dummy, dim1, dim2] = sub_get_dim(v);

switch v.kind
    case 'bool'
        h3_fprintf(fid, 'H3_SOURCE_LINE = ''%s %s(%s, %s)'';\n', ...
            upper(v.kind), v.name, dim1, dim2);
        h3_fprintf(fid, '%s = binvar(%s, %s, ''full'');\n', v.name, dim1, dim2);
%         h3_fprintf(fid, '%s = sdpvar(%s, %s, ''full'');\n', v.name, dim1, dim2);
        h3_fprintf(fid, 'h3_define_symbol(''add'', ''%s'', (%s)*(%s), %s, %s);\n', v.name, dim1, dim2, dim1, dim2);
% %         h3_fprintf(fid, 'h3_register_binary(''add'', %s);\n', v.name);
        %         h3_fprintf(fid, 'h3_yalmip_F = h3_yalmip_F + set(binary(%s), ''binary_%s'');\n', v.name, v.name);

    case 'real'
        v_bounds = sub_xslt(v.minmax);
        if isa(v.minmax, 'double')
            % no user-specified bounds provided
            h3_fprintf(fid, 'H3_SOURCE_LINE = ''%s %s(%s, %s)'';\n', ...
                upper(v.kind), v.name, dim1, dim2);
        else
            % user bounds given
            h3_fprintf(fid, 'H3_SOURCE_LINE = ''%s %s(%s, %s) %s '';\n', ...
                upper(v.kind), v.name, dim1, dim2, v_bounds);
        end
        h3_fprintf(fid, 'h3_var_bounds = eval(''%s'');\n', v_bounds);
        h3_fprintf(fid, '%s = sdpvar(%s, %s, ''full'');\n', v.name, dim1, dim2);
        h3_fprintf(fid, 'h3_define_symbol(''add'', ''%s'', (%s)*(%s), %s, %s);\n', v.name, dim1, dim2, dim1, dim2);

        h3_fprintf(fid, 'h3_yalmip_F = h3_yalmip_F + set(h3_var_bounds(:, 1) <= %s(:) <= h3_var_bounds(:,2), ''bounds'');\n', ...
            v.name);
%         h3_fprintf(fid, 'h3_yalmip_F = h3_yalmip_F + set(h3_lowerbound(%s(:), h3_var_bounds(:, 1), h3_var_bounds(:, 1)));\n', ...
%             v.name);
%         h3_fprintf(fid, 'h3_yalmip_F = h3_yalmip_F + set(h3_upperbound(%s(:), h3_var_bounds(:, 2), h3_var_bounds(:, 2)));\n', ...
%             v.name);

    otherwise
        error('Unsupported variable kind.');
end

%---------------------------------------------------------------------
function symb_params = sub_check_symbolic(vars, fid, exceptions)

symb_params = {};
k = 0;
for i = 1:length(vars)
    p = vars{i};
    if isequal(p.type, 'parameter') & isempty(p.value)
        k = k + 1;     
        symb_params{k} = p.name;
    end
end

% exclude predefined variables from array
common_vars = intersect(symb_params,exceptions);
symb_params = setdiff(symb_params,common_vars);

if length(symb_params) > 0
    h3_fprintf(fid, 'H3_SOURCE_LINE = '''';\n');
    h3_fprintf(fid, 'symb_params = {');
    for jj = 1:length(symb_params)
        if jj ~= length(symb_params)
            h3_fprintf(fid, '''%s'',', symb_params{jj});
        else
            h3_fprintf(fid, '''%s''', symb_params{jj});
        end
    end 
    h3_fprintf(fid, '};\n');
% %     h3_fprintf(fid, 'if nargin ==1\n');
% %     h3_fprintf(fid, '    h3_checksymbvars(par,symb_params);\n');
% %     h3_fprintf(fid, 'else\n');
% %     h3_fprintf(fid, '    error(''Please, call this function with one argument (a structure array) which specifies values for symbolic variables.'');\n');
% %     h3_fprintf(fid, 'end\n');
end


%---------------------------------------------------------------------
function sub_write_names(vars, fid)

types = {'input', 'state', 'output', 'aux'};
for i = 1:length(types)
    idx = cellfun(@(x) isequal(x.type, types{i}), vars);
    of_this_type = vars(idx);
    names = cellfun( @(x) x.name, of_this_type, 'UniformOutput', false);
    kinds = cellfun( @(x) x.kind(1), of_this_type, 'UniformOutput', false);
    dims = cellfun(@sub_get_dim, of_this_type, 'UniformOutput', false);
    
    sub_write_single_name(fid, types{i}, 'Name', names);
    sub_write_single_name(fid, types{i}, 'Kind', kinds);
    sub_write_single_name(fid, types{i}, 'Length', dims);
end


%---------------------------------------------------------------------
function sub_write_single_name(fid, type, kind, values)

% h3_fprintf(fid, '%% declared "%s" variables\n', type); 
if isempty(values)
    return
end
type(1) = upper(type(1));
is_dim = isequal(kind, 'Length');

h3_fprintf(fid, 'h3_names.%s%s = ', type, kind);
h3_fprintf(fid, 'cat(2, h3_names.%s%s, {', type, kind);
for i = 1:length(values)
    if is_dim
        h3_fprintf(fid, 'eval(');
    end
    h3_fprintf(fid, '''%s''', values{i});
    if is_dim
        h3_fprintf(fid, ')');
    end
    if i < length(values)
        h3_fprintf(fid, ', ');
    end
end
h3_fprintf(fid, '});\n\n');


%---------------------------------------------------------------------
function [dim1_dim2, dim1, dim2] = sub_get_dim(v)

% if iscell(v)
%     q.dim = v;
%     v = q;
% end
if isempty(v.dim)
    v.dim = {'1', '1'};
end
% if ~iscell(v.dim)
%     dim1 = v.dim;
%     dim2 = 1;
% else
    dim1 = sub_xslt(v.dim{1});
    dim2 = sub_xslt(v.dim{2});
% end
dim1_dim2 = ['(' dim1 ') * (' dim2 ')'];
