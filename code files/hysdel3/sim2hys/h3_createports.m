function S = h3_createports(hysname, par)
%
% creates input-output ports
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

[path, fh] = fileparts(hysname);

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

% get name of the current block
sim_model = gcb;

if length(S.InputName)<1
    fprintf('HYSDEL file "%s" does not contain any inputs.\n',hysname);
else
    % create inports
    add_block('built-in/Mux',[sim_model,'/Mux'],'Position','[135,36,140,74]','ShowName','off','DisplayOption','bar','Inputs','1');
    set_param([sim_model,'/Mux'],'Inputs',int2str(length(S.InputName)));
    add_line(sim_model,'Mux/1','h3_sfun/1', 'autorouting','off');
    for i=1:length(S.InputName)
        inport_str = [sim_model,'/',S.InputName{i}];
        in_str = [S.InputName{i},'/1'];
        in_mux_str = ['Mux/',int2str(i)];
        add_block('built-in/Inport', inport_str);
        if isequal(S.InputKind{i},'r')
            set_param(inport_str,'OutDataTypeStr','double');
            add_line(sim_model,in_str,in_mux_str, 'autorouting','off');
        else
            set_param(inport_str,'OutDataTypeStr','boolean','ForegroundColor','red');
            add_block('built-in/DataTypeConversion',[sim_model,'/Convert_',S.InputName{i}],'Position','[50,15,100,35]','ShowName','on');
            add_line(sim_model,in_str, ['Convert_',S.InputName{i},'/1'], 'autorouting','off');
            add_line(sim_model,['Convert_',S.InputName{i},'/1'], in_mux_str, 'autorouting','off');
        end
        if i>=2
            inport_prev_str = [sim_model,'/',S.InputName{i-1}];
            inport_pos = get_param(inport_prev_str,'Position');
            new_inport_pos = inport_pos + [0 35 0 35];
            set_param(inport_str,'Position',new_inport_pos);
            if isequal(S.InputKind{i},'b')
                new_convert_pos = inport_pos + [40 35 60 35];
                set_param([sim_model,'/Convert_',S.InputName{i}],'Position',new_convert_pos);
            end
        end
    end
end

% create outports
if length(S.OutputName)<1
    errordlg(sprintf('Given HYSDEL file "%s" does not contain any outputs.\nPlease, define OUTPUT section in the IMPLEMENTATION mode.',hysname));
else
    add_block('built-in/Demux',[sim_model,'/Demux'],'Position','[295,36,300,74]','ShowName','off','DisplayOption','bar','Outputs','1');
    n_out = ['[',num2str(cellfun(@double,S.OutputLength)),']'];
    set_param([sim_model,'/Demux'],'Outputs',n_out);
    add_line(sim_model,'h3_sfun/1','Demux/1','autorouting','off');
    for i=1:length(S.OutputName)
        outport_str = [sim_model,'/',S.OutputName{i}];
        out_str = [S.OutputName{i},'/1'];
        out_demux_str = ['Demux/',int2str(i)];
        add_block('built-in/Outport', outport_str,'Position','[395,15,415,35]');
        if isequal(S.OutputKind{i},'r')
            set_param(outport_str,'OutDataTypeStr','double');
            add_line(sim_model,out_demux_str,out_str, 'autorouting','off');
        else
            set_param(outport_str,'OutDataTypeStr','boolean','ForegroundColor','red');
            add_block('built-in/DataTypeConversion',[sim_model,'/Convert_',S.OutputName{i}],'Position','[325,15,365,35]','ShowName','on');
            add_line(sim_model,out_demux_str, ['Convert_',S.OutputName{i},'/1'], 'autorouting','off');
            add_line(sim_model,['Convert_',S.OutputName{i},'/1'], out_str, 'autorouting','off');
        end
        if i>=2
            outport_prev_str = [sim_model,'/',S.OutputName{i-1}];
            outport_pos = get_param(outport_prev_str,'Position');
            new_outport_pos = outport_pos + [0 35 0 35];
            set_param(outport_str,'Position',new_outport_pos);
            if isequal(S.OutputKind{i},'b')
                new_convert_pos = outport_pos + [-60 35 -40 35];
                set_param([sim_model,'/Convert_',S.OutputName{i}],'Position',new_convert_pos);
            end
        end
    end
end
