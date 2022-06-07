function h3_simulator(tree, base_path, base_name, options)
% H3sim Create a standalone simulator
%
% Usage:
%   h3_simulator('hysdelfile.hys', 'simulatorname')
%
% Creates a file "simulatorname.m" in the current working directory
%
% If simulator name is not given, the simulator will be exported to
% "hysdelfile_sim.m"

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

if isa(tree, 'char')
    % compile input file
    fname = tree;
    sim_name = '';
    if nargin > 1 && isa(base_path, 'char')
        sim_name = base_path;
    end
    [base_path, base_name] = sub_compile_file(fname);
    % load the xml tree
    tree = sub_load_xml(base_name);
    if isempty(sim_name)
        base_name = [base_name '_sim'];
    else
        base_name = sim_name;
    end
    options.debug = 0;
end


% parse the xml tree
sub_start_parsing(tree, base_path, base_name, options)


%--------------------------------------------------------------------
function sub_start_parsing(tree, base_path, base_name, options)

yalmip_fname = [base_name '.m'];

fid = fopen(yalmip_fname, 'w');
if fid < 0
    error('Couldn''t open file "%s" for writing.', yalmip_fname);
end

fprintf(fid, 'function [h3_out_xplus, h3_out_w, h3_feasible, h3_out_y] = %s(h3_in_x, h3_in_u, h3_parameters)\n\n', ...
    base_name);
fprintf(fid, 'h3_feasible = true;\n');
fprintf(fid, 'H3_X_POS = 1; H3_U_POS = 1;\n');

options.base_name = base_name;

if options.debug
    symtable = sub_process_tree(tree, fid, base_path, options);
    
else
    try
        symtable = sub_process_tree(tree, fid, base_path, options);
    catch
        fclose(fid);
        error(lasterr);
    end
end

fprintf(fid, 'h3_out_xplus = [');
sub_write_vars(fid, symtable, 'state');
fprintf(fid, '];\n');
fprintf(fid, 'h3_out_y = [');
sub_write_vars(fid, symtable, 'output');
fprintf(fid, '];\n');
fprintf(fid, 'h3_out_w = [');
sub_write_vars(fid, symtable, 'aux');
fprintf(fid, '];\n');

% write subfunctions
fprintf(fid, '\n\n');
fprintf(fid, 'function ok = sub_isbetween(x, lowup)\n');
fprintf(fid, 'ok = all(lowup(:, 1) <= x) & all(x <= lowup(:, 2));\n');

fprintf(fid, '\n\n');
fprintf(fid, 'function x = h3_isfield(s, f)\n');
fprintf(fid, 'if isempty(s)\n');
fprintf(fid, '    x = false;\n');
fprintf(fid, '    return\n');
fprintf(fid, 'end\n');
fprintf(fid, 'if isempty(f)\n');
fprintf(fid, '    x = true;\n');
fprintf(fid, '    return\n');
fprintf(fid, 'end\n');
fprintf(fid, 'n = fieldnames(s);\n');
fprintf(fid, '[first, last] = strtok(f, ''.'');\n');
fprintf(fid, 'x = strmatch(first, n);\n');
fprintf(fid, 'if isempty(x)\n');
fprintf(fid, '    x = false;\n');
fprintf(fid, 'else\n');
fprintf(fid, '    x = h3_isfield(getfield(s, first), last);\n');
fprintf(fid, 'end\n');

fclose(fid);

%--------------------------------------------------------------------
function sub_write_vars(fid, symtable, type, delim)

if isequal(type, 'state')
    suffix = '_plus';
else
    suffix = '';
end
for i = 1:length(symtable)
    if isequal(symtable{i}.type, type)
        fprintf(fid, '%s%s(:); ', symtable{i}.name, suffix);
    end
end

%--------------------------------------------------------------------
function [p, fname] = sub_compile_file(source_fname)

hysdel3_dir = fileparts(which(mfilename));
hys2xml_path = [hysdel3_dir filesep 'hys2xml' filesep 'hys2xml'];

[p, fname, e] = fileparts(source_fname);

if isempty(e)
    source_fname = [fname '.hys'];
end
if isempty(p)
    source_fname = ['./' source_fname];
else
    source_fname = [p filesep source_fname];
end
if ~exist(source_fname, 'file')
    error(sprintf('File "%s" not found.', source_fname));
end

[a, out] = system(sprintf('%s < %s', hys2xml_path, source_fname));
if a
    disp(out);
    error('hys2xml error, see message above.');
end
movefile('yyyaxx.xml', [fname '.xml']);


%--------------------------------------------------------------------
function tree = sub_load_xml(fname)

% remove <?xml?> type of declarations and the "yaxx:" prefix from tag names
h3_xmlformatter(fname);

try
    tree = xmltree([fname '_f.xml']);
catch
    sub_delete_files(fname);
    error('Couldn''t parse XML representation of "%s".', fname);
end
sub_delete_files(fname);


%--------------------------------------------------------------------
function full_table = sub_process_tree(tree, fid, base_path, options, full_table)

global H3_SYMTABLE H3_MODULE_PATH

if ~isfield(options, 'supermodule')
    options.supermodule = '';
end

if nargin < 5
    full_table = {};
end

supermodule = options.supermodule;

fprintf(fid, '%% ===================== Start: %s =====================\n\n', options.base_name);

% tell h3_getvariables we are processing a submodule
H3_MODULE_PATH = supermodule;

% replace all XIDENT values by [supermodule '.' XIDENT] to cope with
% submodules
tree = sub_modularize_tree(tree, supermodule);

% split the tree into interface and implementation parts
[int_s, imp_s, position_imp] = h3_split_tree(tree);

% process the interface part, create the symbol table
symtable = h3_getvariables(int_s, imp_s);

% create instances of all submodules if they are defined
for i = 1:length(symtable)
    if isequal(symtable{i}.type, 'module')
        error('Simulator cannot be generated for models involving modules.');
        
        module_fname = symtable{i}.name;
        
        if isempty(base_path)
            module_full_path = module_fname;
        else
            module_full_path = [base_path filesep module_fname];
        end
        
        % compile the submodule HYS file
        sub_compile_file(module_full_path);
        
        % load the XML representation
        module_tree = sub_load_xml(module_fname);
        
        % create an instance of each submodule
        for j = 1:length(symtable{i}.value)
            if isempty(supermodule)
                options.supermodule = symtable{i}.value{j};
            else
                options.supermodule = [supermodule '.' symtable{i}.value{j}];
            end
            
            fprintf('Creating instance "%s" of "%s"...\n', ...
                options.supermodule, module_fname);
            
            options.base_name = module_fname;
            
            full_table = sub_process_tree(module_tree, fid, ...
                base_path, options, full_table);

        end

    end
end

H3_MODULE_PATH = supermodule;

% add symtable of this submodule to the common storage
full_table = cat(2, full_table, symtable);
H3_SYMTABLE = full_table;

% write simulator equivalents of all variables
h3_writevariables_sim(symtable, fid);

% write simulator equivalents of each section, respect the ordering of
% sections
f = fields(imp_s);
for i = 1:size(position_imp, 1)
    i_idx = position_imp(i, 1);
    j_idx = position_imp(i, 2);
    sec = getfield(imp_s, f{i_idx});
    h3_parse_section_sim(sec{j_idx}, f{i_idx}, fid);
end

% f = fields(imp_s);
% for i = 1:length(f)
%     sec = getfield(imp_s, f{i});
%     for j = 1:length(sec)
%         h3_parse_section_sim(sec{j}, f{i}, fid);
%     end
% end

%--------------------------------------------------------------------
function tree = sub_modularize_tree(tree, supermodule)
% replaces all XIDENT elements in an XML tree by [supermodule '.' XIDENT]

if ~isempty(supermodule)
    xident_pos = xpath(tree, '//XIDENT');
    for i = xident_pos
        oldvalue = getvalue(tree, i);
        newvalue = [supermodule '.' oldvalue];
        tree = set(tree, get(tree, i, 'contents'), 'value', newvalue);
    end
end


%--------------------------------------------------------------------
function sub_delete_files(fname);
% remove unneeded data

delete([fname '.xml']);
delete([fname '_f.xml']);
delete('yyyaxx.dtd');


%--------------------------------------------------------------------
function sub_write_symtable(fid, symtable)

fprintf(fid, 'h3_symtable = {};\n');
entries = {'name', 'orig_type', 'type', 'kind'};
for i = 1:length(symtable)
    fprintf(fid, 'h3_symtable_entry = [];\n');
    for j = 1:length(entries)
        v = getfield(symtable{i}, entries{j});
        fprintf(fid, 'h3_symtable_entry.%s = ''%s'';\n', ...
            entries{j}, v);
    end
    fprintf(fid, 'h3_symtable{end+1} = h3_symtable_entry;\n');
end
