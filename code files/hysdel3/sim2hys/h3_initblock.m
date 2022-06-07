
% initializes HYSDEL block 
%
global HYSDEL_S

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

% check if the hysname is correct and file compiled
try
    h3_hysnameCallback(struct('hysname',hysname,'par',par,'Ts',Ts,'x0',x0));

    set_param(gcb, 'UserData', hysname);
    rehash;
    try 
        S = h3_createports(hysname,par);
    catch
        % call the compiled m-file to get MLD model
        if isstruct(par)
            f = fields(par);
            for i=1:numel(f)
               eval([f{i},'= par.',f{i},';']);
            end
            eval(fh)
        elseif isempty(par)
            eval(fh)
        else
            errordlg(sprintf('The values for symbolical parameters must be provided as structure, e.g. s.parameter1, s.parameter2, etc.'))
        end
       
    end

    % set sample time
    S.Ts = Ts;
    % set initial conditions
    if S.nx~=length(x0);
        errordlg(sprintf('Initial condition in the block "%s" for HYSDEL file "%s" must be of length %d.', gcb, hysname, S.nx));
    end
    S.x0 = x0;
    
    % export to workspace
    if ~isempty(regexp(gcb,'(^[0-9_]|[^ /\n\w])'))
        errordlg(sprintf('Please, rename the current block "%s", such that it does not contain any metacharacters and it does not begin with number or underscore.', gcb));
    end
    name = regexprep(gcb,'[^/\w]','_');
    name = strrep(name,'/','.');
    eval(['HYSDEL_S.',name,'=S;']);

catch
    if ~isequal(getfield(lasterror,'identifier'),'Simulink:SL_AddBlockCantAdd')
        errordlg(getfield(lasterror,'message'));
    end
end
