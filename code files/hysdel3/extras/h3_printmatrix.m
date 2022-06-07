function h3_printmatrix(S, fid, prefix)
% prints a given structure to the output stream
% runs recursivelly, i.e. proceeds nested structures as well

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

if nargin < 3
    prefix = 'S';
end

if ~isstruct(S)
    return
end

fields = fieldnames(S);
for i = 1:length(fields)
    f = fields{i};
    v = getfield(S, f);
    if isa(v, 'cell')
        fprintf(fid, '%s.%s = ', prefix, f);
        sub_printcell(fid, v);
        fprintf(fid, ';\n');
    elseif isa(v, 'double')
        fprintf(fid, '%s.%s = %s;\n', prefix, f, mat2str(v, 10));
    elseif isa(v, 'char')
        fprintf(fid, '%s.%s = ''%s'';\n', prefix, f, v);
    elseif isa(v, 'struct')
        h3_printmatrix(v, fid, [prefix '.' f]);
    else
        error('Unrecognized type');
    end
end


%----------------------------------------------
function sub_printcell(fid, v)

fprintf(fid, '{');
for i = 1:length(v)
    a = v{i};
    if isa(a, 'cell')
        sub_printcell(fid, a);
    elseif isa(a, 'double')
        fprintf(fid, '%s', mat2str(a, 10));
    elseif isa(a, 'char')
        fprintf(fid, '''%s''', a);
    elseif isa(a, 'struct')
        sub_printstruct(fid, a)
    else
        error('Unrecognized type.');
    end
    if i < length(v)
        fprintf(fid, ', ');
    end
end
fprintf(fid, '}');


%----------------------------------------------
function sub_printstruct(fid, v)

fprintf(fid, 'struct(');
fields = fieldnames(v);
for i = 1:length(fields)
    f = fields{i};
    a = getfield(v, f);
    fprintf(fid, '''%s'', ', f);
    if isa(a, 'cell')
        sub_printcell(fid, a);
    elseif isa(a, 'char')
        fprintf(fid, '''%s''', a);
    elseif isa(a, 'double')
        fprintf(fid, '%s', mat2str(a, 10));
    elseif isa(a, 'struct')
        sub_printstruct(fid, a);
    else
        error('Unrecognized type.');
    end
    if i < length(fields)
        fprintf(fid, ', ');
    end
end
fprintf(fid, ')');

