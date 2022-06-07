function h3_export(MLD, fname, doxml)
% Exports a given (symbolic) MLD model to a desired format
%
%    To export the model into an XML file out.xml, call: 
%        h3_export(S, 'out.xml')
%
%    To export the model into an m-file out.m, call:
%        h3_export(S, 'out')
%            or
%        h3_export(S, 'out.m')
%    

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

include_vector_info = false;

error(nargchk(2, 3, nargin));

if nargin < 3
    doxml = false;
end

[p, n, e] = fileparts(fname);
if isempty(p)
    p = '.';
end
% do we need XML export?
if doxml || isequal(lower(e), '.xml')
    if ~isequal(lower(e), '.xml')
        fname = [fname '.xml'];
    end
    h3_export_xml(MLD, fname, include_vector_info);
end

% how should we call the structure
prefix = 'S';

% always export to m-file
sub_export_m(MLD, [p filesep n '.m'], prefix);


%----------------------------------------
function sub_export_m(MLD, fname, prefix)
% export MLD matrices into m-file

fid = fopen(fname, 'w');
if fid < 0
    error('Couldn''t open file "%s" for writing.', fname);
end

fprintf(fid, '%s = [];\n', prefix);

m = {'A', 'Bu', 'Baux', 'Baff', 'C', 'Du', 'Daux', 'Daff', 'Ex', 'Eu', 'Eaux', 'Eaff'};
for i = 1:length(m)
    f = getfield(MLD, m{i});
    if iscell(f)
        % print a symbolic matrix and remove it from the structure
        fprintf(fid, '%s.%s = [', prefix, m{i});
        h3_print_symb_matrix(f, fid);
        MLD = rmfield(MLD, m{i});
        fprintf(fid, '];\n');
    end
end

% now print the remaining fields
h3_printmatrix(MLD, fid, prefix);

fclose(fid);
