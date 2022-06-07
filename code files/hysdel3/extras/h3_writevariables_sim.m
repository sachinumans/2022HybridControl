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

% check for any symbolic parameters except predefined parameters
exceptions = {'pi'};
symb_params = sub_check_symbolic(vars, fid, exceptions);

% write all parameters
fprintf(fid, '%% declared parameters\n'); 
% write symbolic parameters first, derived parameters next
symb_params = [];
derived_params = [];
for i = 1:length(vars)
    p = vars{i};
    if isequal(p.type, 'parameter') & ~isempty(p.value)
        % derived parameter
        derived_params = [derived_params i];
    elseif isequal(p.type, 'parameter') & isempty(p.value)
        symb_params = [symb_params i];
    end
end
for i = symb_params
    % symbolic parameters
    p = vars{i};
    fprintf(fid, 'if nargin < 3\n');
    fprintf(fid, '\terror(''Parameters must be provided as a structure in the third input.'');\n');
    fprintf(fid, 'end\n');
    sub_write_symbolic_parameter(p, fid, exceptions);
end
for i = derived_params
    % derived parameters or parameters with value
    p = vars{i};
    h3_check_semantics(p.tree, 'PARAMETER', 'rhs', p.tree);
    sub_write_parameter(p, fid);
end

x_vars = '';
xplus_vars = '';
u_vars = '';
y_vars = '';
aux_vars = '';

% now write variables
for i = 1:length(vars)
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
%             sub_write_var(w, fid);
            
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
% fprintf(fid, '\n');
% fprintf(fid, 'h3_yalmip_x_vars = [h3_yalmip_x_vars(:); %s];\n', x_vars(1:end-2));
% fprintf(fid, 'h3_yalmip_xplus_vars = [h3_yalmip_xplus_vars(:); %s];\n', xplus_vars(1:end-2));
% fprintf(fid, 'h3_yalmip_u_vars = [h3_yalmip_u_vars(:); %s];\n', u_vars(1:end-2));
% fprintf(fid, 'h3_yalmip_y_vars = [h3_yalmip_y_vars(:); %s];\n', y_vars(1:end-2));
% fprintf(fid, 'h3_yalmip_aux_vars = [h3_yalmip_aux_vars(:); %s];\n', aux_vars(1:end-2));
% fprintf(fid, 'h3_yalmip_variables = [h3_yalmip_x_vars; h3_yalmip_xplus_vars; h3_yalmip_u_vars; h3_yalmip_y_vars; h3_yalmip_aux_vars];\n');
% fprintf(fid, '\n');

% write names of inputs/states/outputs
sub_write_names(vars, fid)
   


%---------------------------------------------------------------------
function sub_write_parameter(p, fid)

fprintf(fid, '\n');
p_value = sub_xslt(p.value);
if isempty(p.dim)
    fprintf(fid, '%% ''%s %s = %s'';\n', ...
        upper(p.kind), p.name, p_value);
    
else
    fprintf(fid, '%% ''%s %s(%s, %s) = %s'';\n', ...
        upper(p.kind), p.name, sub_xslt(p.dim{1}), sub_xslt(p.dim{2}), ...
        p_value);
    
end
fprintf(fid, '%s = (%s);\n', p.name, p_value);

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
      fprintf(fid, 'if h3_isfield(h3_parameters, ''%s'')\n', p.name);
      fprintf(fid, '\t%s = h3_parameters.%s;\n', p.name, p.name);
      fprintf(fid, 'else\n');
      fprintf(fid, '\terror(''Parameter "%s" undefined.'');\n', p.name);
      fprintf(fid, 'end\n');
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

fprintf(fid, '\n');

[dummy, dim1, dim2] = sub_get_dim(v);

switch v.kind
    case 'bool'
        fprintf(fid, '%% ''%s %s(%s, %s)'';\n', ...
            upper(v.kind), v.name, dim1, dim2);
        switch(v.type)
            case 'state',
                fprintf(fid, '%s = h3_in_x(H3_X_POS:H3_X_POS-1+(%s)*(%s));\n', v.name, ...
                    dim1, dim2);
                fprintf(fid, '%s = reshape(%s, %s, %s);\n', v.name, v.name, dim1, dim2);
                fprintf(fid, 'H3_X_POS = H3_X_POS + (%s)*(%s);\n', dim1, dim2);
%                 fprintf(fid, 'h3_feasible = h3_feasible & sub_isbetween(%s, %s);\n', v.name, v_bounds);
                
            case 'input',
                fprintf(fid, '%s = h3_in_u(H3_U_POS:H3_U_POS-1+(%s)*(%s));\n', v.name, ...
                    dim1, dim2);
                fprintf(fid, '%s = reshape(%s, %s, %s);\n', v.name, v.name, dim1, dim2);
                fprintf(fid, 'H3_U_POS = H3_U_POS + (%s)*(%s);\n', dim1, dim2);
                
            case {'output', 'aux'}
                fprintf(fid, '%s = zeros(%s, %s);\n', v.name, dim1, dim2);
                
%                 fprintf(fid, 'h3_feasible = h3_feasible & sub_isbetween(%s, %s);\n', v.name, v_bounds);

        end

    case 'real'
        v_bounds = sub_xslt(v.minmax);
        fprintf(fid, '%% ''%s %s(%s, %s) %s '';\n', ...
            upper(v.kind), v.name, dim1, dim2, v_bounds);
        switch(v.type)
            case 'state',
                fprintf(fid, '%s = h3_in_x(H3_X_POS:H3_X_POS-1+(%s)*(%s));\n', v.name, ...
                    dim1, dim2);
                fprintf(fid, '%s = reshape(%s, %s, %s);\n', v.name, v.name, dim1, dim2);
                fprintf(fid, 'H3_X_POS = H3_X_POS + (%s)*(%s);\n', dim1, dim2);
                fprintf(fid, 'h3_feasible = h3_feasible & sub_isbetween(%s, %s);\n', v.name, v_bounds);
                
            case 'input',
                fprintf(fid, '%s = h3_in_u(H3_U_POS:H3_U_POS-1+(%s)*(%s));\n', v.name, ...
                    dim1, dim2);
                fprintf(fid, '%s = reshape(%s, %s, %s);\n', v.name, v.name, dim1, dim2);
                fprintf(fid, 'H3_U_POS = H3_U_POS + (%s)*(%s);\n', dim1, dim2);
                
                fprintf(fid, 'h3_feasible = h3_feasible & sub_isbetween(%s, %s);\n', v.name, v_bounds);
                
            case {'output', 'aux'}
                fprintf(fid, '%s = zeros(%s, %s);\n', v.name, dim1, dim2);
                
        end

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

% fprintf(fid, '%% declared "%s" variables\n', type); 
% if isempty(values)
%     return
% end
% type(1) = upper(type(1));
% is_dim = isequal(kind, 'Length');
% 
% fprintf(fid, 'h3_names.%s%s = ', type, kind);
% fprintf(fid, 'cat(2, h3_names.%s%s, {', type, kind);
% for i = 1:length(values)
%     if is_dim
%         fprintf(fid, 'eval(');
%     end
%     fprintf(fid, '''%s''', values{i});
%     if is_dim
%         fprintf(fid, ')');
%     end
%     if i < length(values)
%         fprintf(fid, ', ');
%     end
% end
% fprintf(fid, '});\n\n');

%---------------------------------------------------------------------
function [dim1_dim2, dim1, dim2] = sub_get_dim(v)

if isempty(v.dim)
    v.dim = {'1', '1'};
end
dim1 = sub_xslt(v.dim{1});
dim2 = sub_xslt(v.dim{2});
dim1_dim2 = ['(' dim1 ') * (' dim2 ')'];
