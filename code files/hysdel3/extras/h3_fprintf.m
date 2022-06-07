function S = h3_fprintf(fid, cmd, varargin)

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


global H3_FPRINTF_FORCEPRINT

persistent cmd_line

S = [];
switch fid
    case 'reset'
        cmd_line = '';
        
    case 'return'
        S = cmd_line;
        
    case 'write'
        fname = varargin{1};
        fid = fopen(fname, 'w');
%         fprintf(fid, '%s\n', cmd_line);
        fprintf(fid, 'h3_optimize_model = [];\n');
        r = cmd_line;
        while ~isempty(r)
            [t, r] = strtok(r, ';');
            fprintf(fid, '%s\n', t);
        end

%         fprintf(fid, 'S = h3_yalmip2mld(h3_yalmip_F, h3_yalmip_x_vars, h3_yalmip_xplus_vars, h3_yalmip_u_vars, h3_yalmip_y_vars, h3_yalmip_aux_vars, h3_yalmip_parameters, h3_names, h3_symtable, h3_optimize_model);\n');
        fclose(fid);
        
    case 'evaluate'
        if nargin > 1
            par = cmd;
        else
            par = [];
        end
        if H3_FPRINTF_FORCEPRINT
            r = cmd_line;
            while ~isempty(r)
                [t, r] = strtok(r, ';');
                disp(t);
            end
        end
            
        eval(cmd_line);
        h3_optimize_model = [];
        S = h3_yalmip2mld(h3_yalmip_F, h3_yalmip_x_vars, ...
            h3_yalmip_xplus_vars, h3_yalmip_u_vars, ...
            h3_yalmip_y_vars, h3_yalmip_aux_vars, ...
            h3_yalmip_parameters, h3_names, ...
            h3_symtable, h3_optimize_model);
        
    otherwise
        cmd = strrep(cmd, ';\n', '; ');
        cmd = strrep(cmd, '\n', ', ');
        
        if nargin > 2
            cmd = sprintf(cmd, varargin{:});
        end
        cmd_line = [cmd_line ' ' cmd];
        
end
