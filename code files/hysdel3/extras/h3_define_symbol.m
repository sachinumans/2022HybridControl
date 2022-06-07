function out = h3_define_symbol(command, varname, varlength, dim1, dim2)
% keeps a list of defined yalmip variables

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

global H3_DEVECTORIZE_VARIABLES

persistent names

switch(command)
    case 'reset'
        names = {};

    case 'getnames'
        out = names;
        return
        
    case 'setnames'
        names = varname;
        return
        
    case 'advance'
        n = yalmip('nvars');
        % detect automatically introduced variables. these can be of two
        % types:
        %  1) placeholders for compositions of parameters (e.g. sin(A*A))
        %  2) placeholders for complex logic, e.g. "iff(x>=0, z>=0)"
        for i = length(names)+1:n
            names{end+1} = sprintf('h3_additional_%d', i);
        end
        
    case 'add'
        % new variable was introduced by HYSDEL
        n = yalmip('nvars');
        
        % detect automatically introduced variables. these can be of two
        % types:
        %  1) placeholders for compositions of parameters (e.g. sin(A*A))
        %  2) placeholders for complex logic, e.g. "iff(x>=0, z>=0)"
        for i = length(names)+varlength:n-1
            names{end+1} = sprintf('h3_additional_%d', i);
        end
        
        % add the variable details to the names table
        if varlength == 1
            names{end+1} = varname;
        else
            if dim1==1 || dim2==1
                for i = 1:varlength
                    if H3_DEVECTORIZE_VARIABLES
                        names{end+1} = sprintf('%s%s%d', varname, h3_delimiter, i);
                    else
                        names{end+1} = sprintf('%s(%d)', varname, i);
                    end
                end
            else
                for i1 = 1:dim1
                    for i2 = 1:dim2
                        if H3_DEVECTORIZE_VARIABLES
                            names{end+1} = sprintf('%s%s%d_%d', ...
                                varname, h3_delimiter, i1, i2);
                        else
                            names{end+1} = sprintf('%s(%d,%d)', ...
                                varname, i1, i2);
                        end
                    end
                end
            end
        end
end
