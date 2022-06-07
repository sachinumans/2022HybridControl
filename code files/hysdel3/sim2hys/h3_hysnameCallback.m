function h3_hysnameCallback(v)
%
% compiles the given HYSDEL file and issues warning, if the given path to
% hysdel file is wrong 
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

% if the block is first time copied from the library
init = all([isempty(v.hysname), isequal(v.par,'[]'), isequal(v.Ts,'1'),  isequal(v.x0,'[]')]);

if ~init
    if isempty(v.hysname)
        error('You did not provide any HYSDEL file to compile.');
    else
        % check if hysname is correct
        [path, file, ext] = fileparts(v.hysname);
        if ~isequal(ext,'.hys')
            hfile = fullfile(path, [file,'.hys']);
        else
            hfile = fullfile(path, file);
        end

        if isempty(dir(hfile))
            error('HYSDEL file "%s" does not exist on the given Matlab path.\n',hfile);
        end

        % check if this folder contains compiled m-file of the same name
        mfile = [file, '.m'];
        if ~isempty(dir(mfile))
            dm = dir(mfile);
            dh = dir(hfile);
            if datenum(dh.date)<datenum(dm.date)
                % do not compile if there exist compiled mfile and the HYSDEL source file is older
                compile = 0;
            else
                compile = 1;
            end
        else
            compile = 1;
        end

        % do compilation
        if compile
            fprintf('HYSDEL compiles the given file "%s".\nThis may take some time ...\n',hfile);
            try
                hysdel3(hfile);
                fprintf('Generation of the file "%s" successful.\n',mfile);
            catch
                fprintf('During compilation of the file "%s" following error occured.\n',file);
                rethrow(lasterror);
            end
        end
    end
end
