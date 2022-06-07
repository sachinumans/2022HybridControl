function h3_parse_subsystem(blk, name)
%
% parses a simulink subsystem and returns HYSDEL code
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

gb = get(blk);
path = [gb.Path,'/',gb.Name];

% check if any block name in this subsystem does not begin with number
if ~isempty(regexp(gb.Name,'^[0-9 ]'));
    error('Please, rename the block "%s" because it contains number or white space at the beginning.',regexprep(gb.Name,'[^/\w]',''));
end
for i=1:length(gb.Blocks)
   if ~isempty(regexp(get_param([path,'/',gb.Blocks{i}],'Name'),'^[0-9 ]'));
      error('Please, rename the block "%s" because it contains number or white space at the beginning.',regexprep([path,'/',gb.Blocks{i}],'[^/\w]',''));
   end
end

% select lines which are in this subsystem
lns = find_system(name, 'FindAll', 'on', 'LookUnderMasks', 'on',...
    'type', 'line', 'Parent', path);
if isempty(lns)
    str = sprintf(['When parsing the block "%s" it did not find any lines ',...
        'inside.\nThis might be because blocks inside this subsystem are not connected ',...
        'or this block links to other subsystem from Simulink library which are not allowed here.'],...
        regexprep(path,'( |\n)',''));
    error(str);
end

% level of parsing is given by number of slashes in the path plus one for
% child
lev = length(find(path=='/')) + 1;

% find inport-outport connections
T = sub_connections(lns, lev);

% other blocks than "HYSDEL Model Simulator',
% Inport, and Outport and currently are not allowed
sub_checkports(T);


% find all inports in this subsystem
inports = find_system(name, 'BlockType', 'Inport','Parent', path);
% find all outports in this subsystem
outports = find_system(name, 'BlockType', 'Outport', 'Parent', path);


% separate OUTPUT ports for IMPLEMENTATION section
if ~isempty(outports)
    [Tf, out] = sub_sepoutputs(T, outports);
else
    Tf = T;
    out = [];
end
% separate REAL/BOOL/Nonspecified ports
[R, B, N] = sub_RBN(Tf);

% write hysdel code
fid  = fopen([regexprep(gb.Name,'\W','_'),'.hys'],'w');

fprintf(fid, 'SYSTEM %s {\n',regexprep(gb.Name,'\W','_'));
fprintf(fid, '/* Automatically generated master file for HYSDEL3 */\n');
fprintf(fid, '/* Created at: %s. */\n',date);

% INTERFACE
fprintf(fid, ' INTERFACE {\n');
% write INPUT section
if ~isempty(inports)
    fprintf(fid, '  INPUT {\n');
    sub_write(fid, inports);
    fprintf(fid, '  }\n');
end
% write OUTPUT section
if ~isempty(outports)
    fprintf(fid, '  OUTPUT {\n');
    sub_write(fid, outports);
    fprintf(fid, '  }\n');
end
% write MODULE section
if ~isempty(gb.Blocks)
    fprintf(fid, '  MODULE {\n');
    sub_write_module(fid, gb.Blocks, path);
    fprintf(fid, '  }\n');
end
fprintf(fid, ' }\n');

% IMPLEMENTATION
fprintf(fid, ' IMPLEMENTATION {\n');
% write LINEAR section
if ~isempty(R{1})
    fprintf(fid, '  LINEAR {\n');
    sub_write_connections(fid, R, lev);
    fprintf(fid, '  }\n');
end
% write LOGIC section
if ~isempty(B{1})
    fprintf(fid, '  LOGIC {\n');
    sub_write_connections(fid, B, lev);
    fprintf(fid, '  }\n');
end
% write OUTPUT section
if ~isempty(out{1})
    fprintf(fid, '  OUTPUT {\n');
    sub_write_connections(fid, out, lev);
    fprintf(fid, '  }\n');
end
fprintf(fid, ' }\n');
fprintf(fid, '}\n');
fclose(fid);


%------------------------------
function sub_write(fid, blk_name)
% 
% writes IO section
% 

for i=1:length(blk_name)
    % get type
    val = get_param(blk_name{i},'DataType');
    % replace not a word character with underscore
    fn = regexprep(blk_name{i},'[^/\w]','_');
    [path, name] = fileparts(fn);
    if isequal(val,'boolean')
        fprintf(fid, '    BOOL %s;\n', name);
    else
        fprintf(fid, '    REAL %s;\n', name);
    end
end

%------------------------------
function sub_write_module(fid, blks, path)
% 
% writes MODULE section
% 

% loop thru all blocks and select only subsystems
hblk = struct;
for ii=1:length(blks)
    blk = [path,'/',blks{ii}];
    name = get_param(blk,'BlockType');
    mask = get_param(blk,'MaskType');
    [p, n] = fileparts(blk);
    if isequal(name,'SubSystem') 
        if isequal(mask,'HYSDEL Model Simulator')
            field = get_param(blk,'hysname');
            if isfield(hblk,field)
                hblk = setfield(hblk, field, [getfield(hblk, field); n]);
            else
                hblk = setfield(hblk, field, {n});
            end
        else
            hblk = setfield(hblk, n, {n});
        end
    end
end

ff = fields(hblk);
for i=1:length(ff)
    fprintf(fid, '    %s ', ff{i});
    gf = getfield(hblk, ff{i});
    for j = 1:length(gf)
        % replace not a word character with underscore
        fname = regexprep(gf{j},'[^/\w]','_');
        if j == length(gf)
            fprintf(fid, '%s;\n', fname);
        else
            fprintf(fid, '%s, ', fname);
        end
    end
end


%------------------------------
function sub_write_connections(fid, ports, lev)
% 
% writes LINEAR/LOGIC/OUTPUT section
% 

fn = cell(1,2);
for i=1:size(ports,1)
    for j=1:2
        % replace not a word character with underscore
        str1 = regexprep(ports{i,j},'[^/\w]','_');
        % remove the top level names
        isl = find(str1=='/');
        str2 = str1(isl(lev)+1:end);
        % replace the remaining backslashes with dots
        fn{j} = strrep(str2,'/','.');
    end
    fprintf(fid, '    %s = %s;\n', fn{2}, fn{1});
end

%------------------------------
function [R, B, N] = sub_RBN(ports)
%
% separates ports of type REAL/BOOL/Nonspecified
%

% output:
% [ real_ports  boolean_ports  non-specified_ports]

R = {[], []};
B = {[], []};
N = {[], []};
kb = 1;
kr = 1;
kn = 1;
for i=1:size(ports,1)
    for j=1:2
        h = get(get_param(ports{i,j},'Handle'));
        if isfield(h,'DataType')
            type = h.DataType;
            if isequal(type,'boolean')
                tr(j) = {'b'};
            else
                tr(j) = {'r'};
            end
        else
            % nonspecified field
            tr(j) = {'n'};
        end
    end
    % checks if ports are of the same type
    % {'b','b'} or {'n','b'} or {'b','n'}
    if (isequal(tr{1},'b') && isequal(tr{2},'b')) || ...
            (isequal(tr{1},'n') && isequal(tr{2},'b')) || ...
            (isequal(tr{1},'b') && isequal(tr{2},'n'))
        B(kb,1:2) = ports(i,:);
        kb = kb+1;
    % {'r','r'} or {'n','r'} or {'r','n'}
    elseif (isequal(tr{1},'r') && isequal(tr{2},'r')) || ...
            (isequal(tr{1},'n') && isequal(tr{2},'r')) || ...
            (isequal(tr{1},'r') && isequal(tr{2},'n'))
        R(kr,1:2) = ports(i,:);
        kr = kr+1;
    % {'n','n'}
    elseif isequal(tr{1},'n') && isequal(tr{2},'n')
        N(kn,1:2) = ports(i,:);
        kn = kn+1;
    % {'r','b'} or {'b','r'}
    else
        error('Ports ''%s'' and ''%s'' must be of the same type!',ports{i,1},ports{i,2});
    end
end
    
%------------------------------
function T = sub_connections(lns, lev)
%
% find interconnections between hysdel blocks
%


% loop through lines to get inport-outport connections
j=1;
dstH = [];
for i=1:length(lns)
    lh = get(lns(i));
    % get line inport handle
    lin_handle = get(lh.SrcPortHandle);
    for ii=1:length(lh.DstPortHandle)
        % get line outport handle
        lout_handle = get(lh.DstPortHandle(ii));
        dstH = [dstH; lh.DstPortHandle(ii)];
        % avoid repetition of output ports
        if length(find(lh.DstPortHandle(ii)==dstH))<=1
            connections(j,1:4) = {lin_handle.Parent lin_handle.PortNumber ...
                lout_handle.Parent lout_handle.PortNumber};
            j=j+1;
        end
    end
end

% connections represent a matrix with info about 
% {inport-name, inport-number, outport-name, outport-number}

% now we have to find which port corresponds to which connection
% loop thru each connection
T = cell(size(connections,1),2);
for i=1:size(connections,1)
    for j=[1 3]
        % find all outports 
        op = find_system(connections{i,j},'LookUnderMasks','all',...
            'BlockType','Outport','Port',int2str(connections{i,j+1}));
        % find all inports
        ip = find_system(connections{i,j},'LookUnderMasks','all',...
            'BlockType','Inport','Port',int2str(connections{i,j+1}));
        % sort the ports appropriately
        if ~isempty(op) && isempty(ip)
            op = sub_remchildports(op, lev+1);
            T(i,j/2+1/2) = op;
        elseif isempty(op) && ~isempty(ip)
            ip = sub_remchildports(ip, lev+1);
            T(i,j/2+1/2) = ip;
        elseif ~isempty(op) && ~isempty(ip) && j==1
            % remove children ports 
            op = sub_remchildports(op, lev+1);
            T(i,j/2+1/2) = op;
        elseif ~isempty(op) && ~isempty(ip) && j==3
            % remove children ports 
            ip = sub_remchildports(ip, lev+1);
            T(i,j/2+1/2) = ip;
        else
            T(i,j/2+1/2) = connections(i,j);
        end
    end
end

%------------------------------
function p = sub_remchildports(port, lev)
%
% removes ports which are of higher level than lev
%

i = 1;
while i<=length(port)
    if length(find(port{i}=='/'))>lev
        port(i) = [];
    else
        i = i+1;
    end
end
p = port;


%------------------------------
function [Tf, out] = sub_sepoutputs(T, outports)
%
% separates outputs from IO connections

[is_out, i1] = intersect(T(:,2),outports);

out = T(i1,:);
T(i1,:) = [];
Tf = T;

%------------------------------
function sub_checkports(ports)
%
% if the scheme contains other blocks than which are allowed, it throws an
% error

for i=1:size(ports,1)
    for j=1:2
       h = get_param(ports{i,j},'BlockType');
       if ~isequal(h,'Inport') && ~isequal(h,'Outport')
          error('Other blocks than ''Inport'', ''Outport'', and ''HYSDEL Model Simulator'' are not allowed to be present in subsystem.');
       end
    end
end
