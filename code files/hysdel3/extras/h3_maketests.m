function h3_maketests(maindir)
% creates tests from HYS files in a given directory

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

if maindir(end) == filesep
    maindir = maindir(1:end-1);
end
d = dir(maindir);
for i = 1:length(d)
    if d(i).isdir & ~isequal(d(i).name(1), '.')
        fprintf('Looking into "%s"...\n', [maindir filesep d(i).name]);
        h3_maketests([maindir filesep d(i).name]);
    end
    name = d(i).name;
    [p, f, ext] = fileparts([maindir filesep name]);
    if ~isequal(ext, '.hys')
        continue
    end
    if isempty(p)
        fname = ['test_' f];
    else
        fname = [p filesep 'test_' f];
    end
    
    if exist([fname '.m'], 'file')
        % do not overwrite existing files
        continue
    end
    
    fprintf('%s.hys -> %s.m\n', fname, fname);
    
    fid = fopen([fname '.m'], 'w');
    fprintf(fid, 'function %s\n', f);
    
    shouldfail = ~isempty(findstr(fname, 'fail'));
    
    if shouldfail
        fprintf(fid, '%% EXPECTERROR\n\n');
    else
        fprintf(fid, '\n');
    end
    fprintf(fid, 'try\n');
    fprintf(fid, 'h3_compile(''%s'');\n', f);
    fprintf(fid, 'catch\n');
    fprintf(fid, 'delete(''%s.m'');\n', f);
    fprintf(fid, 'rethrow(lasterror);\n');
    fprintf(fid, 'end\n');
    fprintf(fid, 'rehash\n');
    fprintf(fid, 'par.p = 1; par.p1 = 1; par.p2 = 1; par.a = 3; par.N = 4; par.ps1=1; par.ps2=1;\n');
    fprintf(fid, 'try\n');
    fprintf(fid, 'eval(''S = %s(par);'');\n', f);
    fprintf(fid, 'catch\n');
    fprintf(fid, 'delete(''%s.m'');\n', f);
    fprintf(fid, 'rethrow(lasterror);\n');
    fprintf(fid, 'end\n');
    fprintf(fid, 'delete(''%s.m'');\n', f);    
    fclose(fid);
end
