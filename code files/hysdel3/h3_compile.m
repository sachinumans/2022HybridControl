function h3_compile(fname, simname, options)
% HYSDEL3 Main HYSDEL 3 compilator
%
% Usage:
%   h3_compile('hysdelfile.hys')
%
% converts the hysdel source file into a YALMIP equaivalent and generates
% the model extractor "hysdelfile.m" in the current working directory

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

global H3_INF H3_INF_COMMANDLINE H3_EPSILON H3_EPSILON_COMMANDLINE
global H3_EXPAND_BOUNDS_FIRST H3_REMOVE_BOUNDS H3_OPTIMIZE_AUX_BOUNDS
global H3_REMOVE_AUX_BOUNDS H3_USE_SYMBOLIC_BOUNDS
global H3_BEHAVE_LIKE_HYSDEL2 H3_CHECK_LINEARITY
global H3_REORDER_INEQS H3_DEVECTORIZE_VARIABLES

% changing these options can have significant effect on model quality and
% subsequently on the optimization time
%
% H3_BEHAVE_LIKE_HYSDEL2  master switch which forces HYSDEL3 to eliminate
%                         any binary variables automatically introduced by
%                         YALMIP
%
% H3_EXPAND_BOUNDS_FIRST  calculates symbolic bounds on auxiliary
%                         variables before it starts to construct
%                         mixed-integer models in AD and DA items
%
% H3_REMOVE_BOUNDS        removes user-defined bounds on state and input
%                         variables from the MLD constraints
%
% H3_REMOVE_AUX_BOUNDS    remove automatically generated bounds on real
%                         auxiliary variables from  the MLD constraints
%
% H3_OPTIMIZE_AUX_BOUNDS  calculates symbolic lower/upper bounds on real
%                         auxiliaries in LINEAR and/or DA items
%                         (e.g. for DA { z = {IF d THEN x ELSE y}; } it
%                         calculates the symbolic minimum/maximum of
%                         functions "x" and "y" and adds constraints
%                         "z >= min(min(x), min(y))" and "z >= max(max(x),
%                         max(y))"
%                    
% H3_USE_SYMBOLIC_BOUNDS  keeps a list of symbolic bounds and exploits them
%                         e.g. AD { d = z <= 0; } LINEAR { z = x; }
%
% H3_CHECK_LINEARITY      enables checking linearity in semantic checks.
%                         e.g. LINEAR { z = x^2; } would be rejected if
%                         this flag is true, but will pass if it's false.
%                         the non-linearity will be catched later on when
%                         translating from YALMIP to MLD.
%                         disabling this option reduces the compilation
%                         runtime


set(0, 'RecursionLimit', 1e4);

if nargin < 2
    options = []; simname = '';
end
if nargin < 3
    options = [];
end
if ~isfield(options, 'debug')
    options.debug = 0;
end

% the default value used as a +/- bound on variables for which the user
% didn't specify his own bounds
% H3_INF = Inf;
H3_INF_COMMANDLINE = false;
H3_EPSILON_COMMANDLINE = false;
if isfield(options, 'MLD_bigMbound')
    H3_INF = options.MLD_bigMbound;
    H3_INF_COMMANDLINE = true;
else
    H3_INF = 1e4;
end
if isfield(options, 'MLD_epsilon')
    H3_EPSILON_COMMANDLINE = true;
    H3_EPSILON = options.MLD_epsilon;
else
    H3_EPSILON = 1e-6;
end

% map user-provided options to global variables
options_map = { {'remove_binaries',     'H3_BEHAVE_LIKE_HYSDEL2' }, ...
               { 'expand_bounds_first', 'H3_EXPAND_BOUNDS_FIRST' }, ...
               { 'remove_var_bounds',   'H3_REMOVE_BOUNDS' }, ...
               { 'remove_aux_bounds',   'H3_REMOVE_AUX_BOUNDS' }, ...
               { 'optimize_aux_bounds', 'H3_OPTIMIZE_AUX_BOUNDS' }, ...
               { 'use_symbolic_bounds', 'H3_USE_SYMBOLIC_BOUNDS' }, ...
               { 'check_linearity',     'H3_CHECK_LINEARITY' } };
for i = 1:length(options_map)
    opt = options_map{i};
    eval(sprintf('%s = %s;', opt{2}, num2str(getfield(options, opt{1}))));
end
           
H3_REORDER_INEQS       =  true; % default is TRUE


% compile input file
[base_path, base_name] = sub_compile_file(fname);

% load the xml tree
tree = sub_load_xml(base_name);

% parse the xml tree
sub_start_parsing(tree, base_path, base_name, options)

if ~isempty(simname)
    [base_path, base_name, e] = fileparts(simname);
    h3_simulator(tree, base_path, base_name, options);
end

pause(0.1);
rehash;


%--------------------------------------------------------------------
function sub_start_parsing(tree, base_path, base_name, options)

yalmip_fname = [base_name '.m'];

fid = 0;

h3_fprintf(fid, 'global H3_ALREADY_DISPLAYED\n');
h3_fprintf(fid, 'global H3_AND_LHS_VAR\n');
h3_fprintf(fid, 'global H3_AVOID_BINARY_IMPLICATION\n');
h3_fprintf(fid, 'global H3_REMOVED_BINARIES\n');
h3_fprintf(fid, 'global H3_BOUNDS_STACK\n');
h3_fprintf(fid, 'global H3_SOURCE_LINE\n');
h3_fprintf(fid, 'global H3_DEVECTORIZE_VARIABLES\n');
h3_fprintf(fid, 'H3_DEVECTORIZE_VARIABLES = %d;\n', options.xml);
h3_fprintf(fid, 'H3_ALREADY_DISPLAYED.max = {};\n');
h3_fprintf(fid, 'H3_ALREADY_DISPLAYED.min = {};\n');
h3_fprintf(fid, 'H3_BOUNDS_STACK.min = {};\n');
h3_fprintf(fid, 'H3_BOUNDS_STACK.max = {};\n');
h3_fprintf(fid, 'H3_REMOVED_BINARIES = [];\n');
h3_fprintf(fid, 'H3_AND_LHS_VAR = [];\n');
h3_fprintf(fid, 'H3_SOURCE_LINE = '''';\n');
h3_fprintf(fid, 'yalmip(''clear'');\n');
h3_fprintf(fid, 'h3_define_symbol(''reset'');\n');
h3_fprintf(fid, 'h3_register_binary(''reset'');\n');
h3_fprintf(fid, 'lasterr('''');\n');
% h3_fprintf(fid, 'try\n');
types = {'Input', 'State', 'Output', 'Aux', 'Parameter'};
kinds = {'Name', 'Kind', 'Length'};
for i = 1:length(types)
    for j = 1:length(kinds)
        h3_fprintf(fid, 'h3_names.%s%s = {};\n', types{i}, kinds{j});
    end
end

h3_fprintf(fid, 'h3_yalmip_F = set([]);\n');
h3_fprintf(fid, 'h3_yalmip_x_vars = [];\n');
h3_fprintf(fid, 'h3_yalmip_xplus_vars = [];\n');
h3_fprintf(fid, 'h3_yalmip_u_vars = [];\n');
h3_fprintf(fid, 'h3_yalmip_y_vars = [];\n');
h3_fprintf(fid, 'h3_yalmip_aux_vars = [];\n');
h3_fprintf(fid, 'h3_yalmip_parameters = [];\n');

h3_fprintf(fid, '\n');

options.base_name = base_name;

if options.debug
    symtable = sub_process_tree(tree, fid, base_path, options);
    
else
    try
        symtable = sub_process_tree(tree, fid, base_path, options);
    catch
%         fclose(fid);
        error(lasterr);
    end
end

% h3_fprintf(fid, 'catch\n');
% h3_fprintf(fid, 'h3_detect_error(lasterror, H3_SOURCE_LINE);\n');
% h3_fprintf(fid, 'end\n');

% write down the symbol table
sub_write_symtable(fid, symtable);

% automatically create an eMLD representation
% h3_fprintf(fid, '[S, Sold] = h3_yalmip2mld(h3_yalmip_F, ');
% h3_fprintf(fid, 'h3_yalmip_x_vars, h3_yalmip_xplus_vars, h3_yalmip_u_vars, ');
% h3_fprintf(fid, 'h3_yalmip_y_vars, h3_yalmip_aux_vars, h3_yalmip_parameters, h3_names, h3_symtable, ');
% h3_fprintf(fid, 'h3_optimize_model);\n');

% fclose(fid);


%--------------------------------------------------------------------
function [p, fname] = sub_compile_file(source_fname)

hysdel3_dir = fileparts(which(mfilename));
if isdeployed
 hys2xml_path = 'hys2xml';
else
 hys2xml_path = [hysdel3_dir filesep 'hys2xml' filesep 'hys2xml'];
end

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

[a, out] = system(sprintf('"%s" < %s', hys2xml_path, source_fname));
if a
    disp(out);
    error('hys2xml error, see message above.');
end
movefile('yyyaxx.xml', [fname '__temp.xml']);


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

% h3_fprintf(fid, '%% ===================== Start: %s =====================\n\n', options.base_name);

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

% write YALMIP equivalents of all variables
h3_writevariables(symtable, fid);

% write YALMIP equivalents of each section
respect_ordering = true;
if respect_ordering
    f = fields(imp_s);
    for i = 1:size(position_imp, 1)
        i_idx = position_imp(i, 1);
        j_idx = position_imp(i, 2);
        sec = getfield(imp_s, f{i_idx});
        h3_parse_section(sec{j_idx}, f{i_idx}, fid);
    end
else
    f = fields(imp_s);
    for i = 1:length(f)
        sec = getfield(imp_s, f{i});
        for j = 1:length(sec)
            h3_parse_section(sec{j}, f{i}, fid);
        end
    end
end

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

delete([fname '__temp.xml']);
delete([fname '_f.xml']);
delete('yyyaxx.dtd');


%--------------------------------------------------------------------
function sub_write_symtable(fid, symtable)

h3_fprintf(fid, 'h3_symtable = {};\n');
entries = {'name', 'orig_type', 'type', 'kind'};
for i = 1:length(symtable)
    h3_fprintf(fid, 'h3_symtable_entry = [];\n');
    for j = 1:length(entries)
        v = getfield(symtable{i}, entries{j});
        h3_fprintf(fid, 'h3_symtable_entry.%s = ''%s'';\n', ...
            entries{j}, v);
    end
    h3_fprintf(fid, 'h3_symtable{end+1} = h3_symtable_entry;\n');
end
