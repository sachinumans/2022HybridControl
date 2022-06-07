function h3_sim2hys(name)
%
% parses a simulink scheme and writes HYSDEL master files according to
% creation of subsystems
%
% argument: name of the subsystem to parse e.g. 'schema/subsystem'
%
% Example:
%   1, parse block 'schema/subsystem'
%
%   h3_sim2hys('schema/subsystem');
%   
%   2, parse current block
%
%   h3_sim2hys(gcb);   
%
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

if ~isempty(regexp(name,'(^[0-9 ]|[^ /\n\w])'))
    error('Please, rename the given block, such that it does not contain any metacharacters and it does not begin with number.');
end

if nargin>1
   error('Only one argument is allowed.'); 
end

% open the file invisibly
load_system(strtok(name,'/'));


[p, n, e] = fileparts(name);
if ~isempty(e) && ~isempty(p)
    name = [p '/' n];
elseif ~isempty(e) && isempty(p)
    name = n;
end

% find all subsystems
subsys = find_system(name, 'FindAll', 'on', 'LookUnderMasks', 'on', 'BlockType', 'SubSystem');

% filter subsystems
i=1;
while  i<=length(subsys)
   gh = get(subsys(i)); 
   if isequal(gh.MaskType ,'HYSDEL Model Simulator')
       % remove subsystems which are HYSDEL blocks
       subsys(i) = [];
   else
       i = i+1;
   end
end


% if there exist a subsystem which name repeats and the content is
% different, throws an error to rename the block
subsys_names = cell(length(subsys),1); 
for i=1:length(subsys)
    subsys_names{i} = get_param(subsys(i),'Name');
end
for i=1:length(subsys_names)
    rest = subsys_names(setdiff(1:length(subsys_names),i));   
    cc = strcmp(rest,get_param(subsys(i),'Name'));
    if  any(cc)
        % if name matches, check the content
        content1 = get_param(subsys(i),'Blocks');
        % if name repeats more times, take only first block
        restH = subsys(setdiff(1:length(subsys_names),i));
        b = restH(cc);
        content2 = get_param(b(1),'Blocks');
        % compare the content of blocks as sorted strings
        if ~isequal([content1{:}],[content2{:}])
            % blocks has the same name but different content!
            error('Given Simulink scheme contains %d subsystems with equal names "%s" but different content.\nPlease, use different names for these blocks.',length(find(cc==true))+1, subsys_names{i} );
        end
    end
end

% take only unique blocks
[a, ia] =  unique(subsys_names);

% blocks to compile for MASTER files
blks = subsys(ia);

fprintf('Found %d subsystems to parse in "%s".\n', length(blks), regexprep(name,'[^/\w]',''));
try
    for i=1:length(blks)
        fprintf('%d/%d: Parsing block "%s" -> "%s.hys" ... ',i, length(blks), regexprep(get_param(blks(i),'Name'),'[^/\w]',''), regexprep(get_param(blks(i),'Name'),'[^/\w]','_'));
        h3_parse_subsystem(blks(i), name);
        fprintf('done.\n');
    end
    fprintf('Parsing of the block "%s" successful.\n',regexprep(name,'[^/\w]',''));
catch
   fprintf(getfield(lasterror,'message'));
   error('H3_SIM2HYS translation of the block "%s" failed.',regexprep(get_param(blks(i),'Name'),'[^/\w]',''));
end
    
    
% close the file
% close_system(name);
