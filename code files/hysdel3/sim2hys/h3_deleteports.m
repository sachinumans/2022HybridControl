function h3_deleteports
%
% deletes given blocks inside current subsystem
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

% get name of the current block
sim_model = gcb;

% check, if the subsystem contains inports, outports, mux, demux, lines
% if yes, delete all these blocks/lines
str = {'Inport', 'Outport', 'Mux', 'Demux', 'line', 'DataTypeConversion'};
for i=1:length(str)
    if isequal(str{i},'line')
        ln = find_system(sim_model,'LookUnderMasks','all','FindAll','on','Type',str{i});
        for j=1:length(ln)
            delete_line(ln(j));
        end
    else
        blk = find_system(sim_model,'LookUnderMasks','all','blocktype',str{i});
        for j=1:length(blk)
            delete_block(get_param(blk{j},'Handle'));
        end
    end
end
