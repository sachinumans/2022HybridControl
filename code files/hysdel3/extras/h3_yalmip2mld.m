function [MLD, MLDold] = h3_yalmip2mld(F, x, xplus, u, y, w, parameters, names, symtable, optimize_model)
% extracts an MLD model from YALMIP constraints

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

global H3_NAMES H3_SYMBOLIC_BOUNDS H3_PARAMETERS H3_VARIABLES
global H3_OPTIMIZEMODEL H3_REMOVED_BINARIES H3_REMOVE_AUX_BOUNDS
global H3_REMOVE_BOUNDS

do_symbolic = ~isempty(parameters);
H3_PARAMETERS = parameters;
H3_VARIABLES = [x; xplus; u; y; w];

if do_symbolic
    h3_define_symbol('advance');
    s_names = h3_define_symbol('getnames');
else
    s_names = {};
end

H3_SYMBOLIC_BOUNDS = [];
H3_NAMES = s_names;

% eMLD format
%        x(k+1) = A*x + Bu*u + Baux*w + Baff
%         y(k)  = C*x + Du*u + Daux*w + Daff
%  Ex*x + Eu*u + Eaux*w <= Eaff

do_optimization = ~isempty(optimize_model);
if do_optimization && do_symbolic
    warning('Full model optimization not supported for symbolic models.');
    do_optimization = 0;
end
H3_OPTIMIZEMODEL = do_optimization;

F = h3_expandmodel_general(F);

% % s_names = h3_define_symbol('getnames');
if do_symbolic,
    s_names = H3_NAMES;
    h3_define_symbol('setnames', s_names);
    h3_define_symbol('advance');
    s_names = h3_define_symbol('getnames');
end

if do_symbolic
    for i = 1:length(s_names)
        if isempty(s_names{i})
            s_names{i} = '';
        end
    end
end

% set variables
allvars    = getvariables(F);
% allvars = depends(F);

statevars  = getvariables(x);
xplusvars  = getvariables(xplus);
inputvars  = getvariables(u);
outputvars = getvariables(y);
wvars = getvariables(w);

toremove = [];
[names, wvars, removed] = sub_remove_unused_vars('Aux', F, names, wvars);
allvars = setdiff(allvars, removed);
toremove = [toremove removed];
w = recover(wvars);
% [names, statevars, removed] = sub_remove_unused_vars('State', F, names, statevars);
% allvars = setdiff(allvars, removed);
% x = recover(statevars);
[names, inputvars, removed] = sub_remove_unused_vars('Input', F, names, inputvars);
allvars = setdiff(allvars, removed);
u = recover(inputvars);
toremove = [toremove removed];
[names, outputvars, removed] = sub_remove_unused_vars('Output', F, names, outputvars);
allvars = setdiff(allvars, removed);
y = recover(outputvars);
toremove = [toremove removed];

toremove = [toremove H3_REMOVED_BINARIES];

toremove = unique(toremove);

parametervars = [getvariables(parameters) H3_SYMBOLIC_BOUNDS];

% Some auxiliary variables could have been introduced automatically while
% translating real conditions into boolean statements, e.g. (x>=0) needs to
% be replaced by "d <-> x>=0". Therefore we need to take these
% new variables into account
%
% all binary variables:
binvars    = [yalmip('binvariables') yalmip('logicextvariables') yalmip('intvariables')];
binvars = setdiff(binvars, toremove);
% binvars = [binvars yalmip('extvariables')];

% state/input/output binaries are not auxiliaries:
binvars = setdiff(binvars, [statevars xplusvars inputvars outputvars]);
% parameters are not auxiliaries:
binvars = setdiff(binvars, parametervars);

% which binaries have been introduced automatically?
autobinvars = setdiff(binvars, [statevars xplusvars inputvars outputvars wvars H3_REMOVED_BINARIES]);

% automatically introduced real variables:
realvars   = setdiff(allvars, [statevars xplusvars inputvars outputvars binvars H3_REMOVED_BINARIES]);
% parameters are not auxiliaries:
realvars = setdiff(realvars, parametervars);

% hence all auxiliary variables are:
auxvars    = unique([getvariables(w) binvars realvars]);

if do_symbolic
    % expressions like 'parameter*variable' are modeled by means of
    % automaticaly introduced variables. therefore we need to remove them
    % from auxvars
    keep = ones(1, length(auxvars));
    param_additionals = strmatch('h3_additional_', s_names)';
    extvars = yalmip('extvariables');
    extvars = setdiff(extvars, toremove);
%     param_additionals = setdiff(param_additionals, extvars);
    for i = 1:length(auxvars)
        av = recover(auxvars(i));
        depends_on = depends(av);
        if any(ismember(depends_on, parametervars))
            keep(i) = 0;
        elseif any(ismember(depends_on, param_additionals))
            keep(i) = 0;
        elseif ismember(auxvars(i), param_additionals)
            keep(i) = 0;
        elseif ~all(ismember(depends_on, allvars))
            keep(i) = 0;
        elseif isempty(s_names{auxvars(i)})
            keep(i) = 0;
        end
    end
    auxvars = unique([auxvars(find(keep)) autobinvars]);
%     auxvars = auxvars(find(keep));
end

% now re-create the "w" variable:
w = recover(auxvars);
if do_symbolic
    s_statevars = recover(statevars);
    s_inputvars = recover(inputvars);
    s_outputvars = recover(outputvars);
    s_auxvars = recover(auxvars);
    
    % all variables including parameters
    s_allvars = [parameters(:); s_statevars; xplus(:); s_inputvars; s_auxvars];
    s_totalvars = [s_allvars; s_outputvars];
    
    % just decision variables
    s_all_decision_vars = [s_statevars; ...
        xplus(:); s_inputvars; s_auxvars; s_outputvars];
end

% dimensions
MLD.nu = length(u);
MLD.nx = length(x);
MLD.ny = length(y);
MLD.nw = length(w);

% variables names
fn = fields(names);
for ii=1:length(fn)
    MLD = setfield(MLD,fn{ii},getfield(names,fn{ii}));
end

% assign AuxNames
%
% this automatically takes care of two things:
% 1) de-vectorization (REAL z(3,1) becomes z(1), z(2), z(3), ...
% 2) defines d_additional_1, d_additional_2 names for automatically
%    introduced binary variables
if do_symbolic
    MLD.AuxName = {};
    MLD.j.w_auto_bin = [];
    d_additional_count = 1;
    for i = 1:length(w)
        var_name = h3_sdisplay(w(i), s_names);
        var_name = var_name{1};
        if ~isempty(findstr(var_name, 'System.Math.'))
            var_name = sprintf('d_additional_%d', d_additional_count);
            d_additional_count = d_additional_count + 1;
            MLD.j.w_auto_bin = [MLD.j.w_auto_bin i];
        end
        MLD.AuxName{i} = var_name;
        MLD.AuxLength{i} = 1;
        if is(w(i), 'binary')
            MLD.AuxKind{i} = 'b';
        else
            MLD.AuxKind{i} = 'r';
        end
    end
end

% get upper/lower bounds
ulb = getbounds(F);

if ~isempty(x)
    ab =  ulb(statevars,:);
    MLD.xl = ab(:,1);
    MLD.xu = ab(:,2);
else
    MLD.xl = zeros(MLD.nx,1);
    MLD.xu = MLD.xl;
end

if ~isempty(u)
    ab =  ulb(inputvars,:);
    MLD.ul = ab(:,1);
    MLD.uu = ab(:,2);
else
    MLD.ul = zeros(MLD.nu,1);
    MLD.uu = MLD.ul;
end

if ~isempty(y)
    ab =  ulb(outputvars,:);
    MLD.yl = ab(:,1);
    MLD.yu = ab(:,2);
else
    MLD.yl = zeros(MLD.ny,1);
    MLD.yu = MLD.yl;
end
if ~isempty(w)
%     w_vars = getvariables(w);
%     dep_vars = [unique([getvariables(F) depends(F)])];
%     AA = w_vars(find(ismember(w_vars, dep_vars)));
    ab =  ulb(auxvars,:);
    MLD.wl = ab(:,1);
    MLD.wu = ab(:,2);
else
    MLD.wl = zeros(length(w),1);
    MLD.wu = MLD.wl;
end


% indices of real/binary variables
MLD.j.xr = [];
MLD.j.xb = [];
MLD.j.ur = [];
MLD.j.ub = [];
MLD.j.yr = [];
MLD.j.yb = [];
MLD.j.d = [];
MLD.j.z = [];
if ~do_symbolic
    MLD.j.w_auto_bin = find(ismember(auxvars, autobinvars));
end

% real/binary strings
MLD.J.X = [];
MLD.J.U = [];
MLD.J.Y = [];
MLD.J.W = [];

% detecting real/binary variables
for i=1:MLD.nx
    if is(x(i),'binary');
        MLD.j.xb = [MLD.j.xb; i];
        MLD.J.X = [MLD.J.X; 'b'];
    else
        MLD.j.xr = [MLD.j.xr; i];
        MLD.J.X = [MLD.J.X; 'r'];
    end
end
for i=1:MLD.nu
    if is(u(i),'binary');
        MLD.j.ub = [MLD.j.ub; i];
        MLD.J.U = [MLD.J.U; 'b'];
    else
        MLD.j.ur = [MLD.j.ur; i];
        MLD.J.U = [MLD.J.U; 'r'];
    end
end
for i=1:MLD.ny
    if is(y(i),'binary');
        MLD.j.yb = [MLD.j.yb; i];
        MLD.J.Y = [MLD.J.Y; 'b'];
    else
        MLD.j.yr = [MLD.j.yr; i];
        MLD.J.Y = [MLD.J.Y; 'r'];
    end
end
for i=1:length(w)
    vars = getvariables(w(i));
    %     if all(ismember(vars, registered_binaries))
    %     if is(w(i),'binary') && ~ismember(vars, registered_binaries)
    if is(w(i), 'binary')
        MLD.j.d = [MLD.j.d i];
        MLD.J.W = [MLD.J.W 'b'];
    else
        MLD.j.z = [MLD.j.z i];
        MLD.J.W = [MLD.J.W 'r'];
    end
end
MLD.nxb = length(MLD.j.xb);
MLD.nxr = length(MLD.j.xr);
MLD.nub = length(MLD.j.ub);
MLD.nur = length(MLD.j.ur);
MLD.nyb = length(MLD.j.yb);
MLD.nyr = length(MLD.j.yr);
MLD.nd = length(MLD.j.d);
MLD.nz = length(MLD.j.z);

% obtain tags
Fst = struct(F);
for i = 1:length(Fst.clauses)
    % update section
    if isequal(Fst.clauses{i}.handle,'update')
        Fupdate = F('update');
    end
    % output section
    if isequal(Fst.clauses{i}.handle,'output')
        Foutput = F('output');
    end
end


% prepare matrices for eMLD
if ~exist('Fupdate','var')
    Fupdate = set([]);

    MLD.A  = zeros(length(x));
    MLD.Bu = zeros(length(x), length(u));
    MLD.Baux = zeros(length(x), length(w));
    MLD.Baff = zeros(length(x), 1);
else
    Fupdate_sdpvar = sdpvar(Fupdate);
    Fupdate_sdpvar = Fupdate_sdpvar(:);
    
    % for cases like:
    %   X(2) = a
    %   X(1) = b
    % without sorting we would get S.Baff=[a; b], which is wrong.
    % therefore we sort the constraints by xplusvars to bring them into the
    % correct order:
    %   X(1) = b
    %   X(2) = a
    % then S.Baff = [b; a], as expected
    Fupdate_sdpvar = sub_sortF(Fupdate_sdpvar, xplusvars);
    
    % detect multiple state-update equations
    if do_symbolic
        a = 1:length(Fupdate_sdpvar);
        b = 1:length(Fupdate_sdpvar);
    else
        base = getmatrix(Fupdate_sdpvar, xplusvars);
        [a,b] = find(base ~= 0);
    end
    
    if length(Fupdate_sdpvar) > MLD.nx
        % if there are multiple updates of a single state, we choose the one
        % which was defined last
        [aa, bb] = unique(b);
        a = a(bb);
    end
    
    Fupdate_sdpvar = Fupdate_sdpvar(a);
    Fupdate_sdpvar = Fupdate_sdpvar(:);
    if do_symbolic
%         % remove output and xplus variables from the constraints
%         Fupdate_sdpvar = replace(Fupdate_sdpvar, [s_outputvars; xplus], 0);
        MLD.A = h3_get_symb_matrix(Fupdate_sdpvar, s_statevars, s_all_decision_vars, s_names);
        MLD.Bu = h3_get_symb_matrix(Fupdate_sdpvar, s_inputvars, s_all_decision_vars, s_names);
        MLD.Baux = h3_get_symb_matrix(Fupdate_sdpvar, s_auxvars, s_all_decision_vars, s_names);
        %MLD.Baff = h3_get_symb_matrix(Fupdate_sdpvar, s_all_decision_vars, s_all_decision_vars, s_names, 1);
        MLD.Baff = h3_get_symb_matrix(Fupdate_sdpvar, s_all_decision_vars, s_totalvars, s_names, 1);
    else
        MLD.A  = getmatrix(Fupdate_sdpvar, statevars, statevars);
        MLD.Bu = getmatrix(Fupdate_sdpvar, inputvars);
        MLD.Baux = getmatrix(Fupdate_sdpvar, auxvars);
        M = full(getbase(Fupdate_sdpvar));
        MLD.Baff = M(:, 1);
    end
    if size(MLD.A, 1) < length(statevars)
        error('State-update equation missing for some state variables.');
    end
end
if ~exist('Foutput','var')
    Foutput = set([]);
    MLD.C  = zeros(length(y), length(x));
    MLD.Du = zeros(length(y), length(u));
    MLD.Daux = zeros(length(y), length(w));
    MLD.Daff = zeros(length(y), 1);
else
    Foutput_sdpvar = sdpvar(Foutput);
    Foutput_sdpvar = Foutput_sdpvar(:);
    Foutput_sdpvar = sub_sortF(Foutput_sdpvar, outputvars);
    
    if do_symbolic
        a = 1:length(Foutput_sdpvar);
        b = 1:length(Foutput_sdpvar);
    else
        base = getmatrix(Foutput_sdpvar, outputvars);
        [a,b] = find(base ~= 0);
    end
        
    if length(Foutput_sdpvar) > MLD.ny
        % if there are multiple definitions of a single output, we choose the one
        % which was defined last
        [aa, bb] = unique(b);
        a = a(bb);
    end
    
    Foutput_sdpvar = Foutput_sdpvar(a);
    Foutput_sdpvar = Foutput_sdpvar(:);
    if do_symbolic
        % remove output and xplus variables from the constraints
        Foutput_sdpvar_orig = Foutput_sdpvar;
%         Foutput_sdpvar = replace(Foutput_sdpvar, [s_outputvars; xplus], 0);
        MLD.C = h3_get_symb_matrix(Foutput_sdpvar, s_statevars, s_all_decision_vars, s_names);
        MLD.Du = h3_get_symb_matrix(Foutput_sdpvar, s_inputvars, s_all_decision_vars, s_names);
        MLD.Daux = h3_get_symb_matrix(Foutput_sdpvar, s_auxvars, s_all_decision_vars, s_names);
%         MLD.Daff = h3_get_symb_matrix(Foutput_sdpvar, s_all_decision_vars, s_all_decision_vars, s_names, 1);
        MLD.Daff = h3_get_symb_matrix(Foutput_sdpvar_orig, s_all_decision_vars, s_totalvars, s_names, 1);
        if isempty(MLD.C) && isempty(MLD.Du) && ...
                isempty(MLD.Daux) && isempty(MLD.Daff) && ...
                length(Foutput_sdpvar) > 0
            % there are is just a constant term in the output equation
            for i = 1:length(Foutput_sdpvar)
                MLD.Daff{end+1} = h3_sdisplay(Foutput_sdpvar(i), s_names);
            end
        end
                
    else
        MLD.C  = getmatrix(Foutput_sdpvar, statevars, outputvars);
        MLD.Du = getmatrix(Foutput_sdpvar, inputvars);
        MLD.Daux = getmatrix(Foutput_sdpvar, auxvars);
        M = full(getbase(Foutput_sdpvar));
        MLD.Daff = M(:, 1);
    end
end

Fothers = F - Fupdate - Foutput;
if H3_REMOVE_BOUNDS
    try
        Fothers = Fothers - F('bounds');
    end
end
if H3_REMOVE_AUX_BOUNDS
    try
        Fothers = Fothers - F('Expansion of h3_lowerbound');
    end
    try
        Fothers = Fothers - F('Expansion of h3_upperbound');
    end
end
n_F = length(Fothers);
i_eq = []; i_ineq = [];
nc = 0;
if n_F == 0
    MLD.Ex = zeros(0,MLD.nx);
    MLD.Eu = zeros(0,MLD.nu);
    MLD.Eaux = zeros(0,MLD.nw);
    MLD.Eaff = [];
    
else
    Fothers_sdpvar = sdpvar(Fothers);

    if do_symbolic
        % remove output and xplus variables from the constraints.
        %
        % ideally, we would do
        %   Fothers_sdpvar=replace(Fothers_sdpvar,[s_outputvars; xplus],0);
        % but that gives a wrong output due to some weird bug in YALMIP.
        % therefore we have to replace the constraints one by one:
        FF = [];
        for i = 1:length(Fothers_sdpvar)
            FF = [FF; replace(Fothers_sdpvar(i), [s_outputvars; xplus], 0)];
        end
        Fothers_sdpvar = FF;
        
        % YALMIP stores constraints reversed, i.e. F(0) + F(x) >= 0
        % to get them in our format (F(x) <= F(0)), we need to reverse the
        % constraint. however, to get the affine term, we need to reverse
        % it yet again
        Fothers_sdpvar = -Fothers_sdpvar;
        MLD.Ex = h3_get_symb_matrix(Fothers_sdpvar, s_statevars, s_all_decision_vars, s_names);
        MLD.Eu = h3_get_symb_matrix(Fothers_sdpvar, s_inputvars, s_all_decision_vars, s_names);
        MLD.Eaux = h3_get_symb_matrix(Fothers_sdpvar, s_auxvars, s_all_decision_vars, s_names);
%         MLD.Eaff = h3_get_symb_matrix(-Fothers_sdpvar, s_all_decision_vars, s_totalvars, s_names, 1);
        MLD.Eaff = h3_get_symb_matrix(-Fothers_sdpvar, ...
            s_all_decision_vars, ...
            s_all_decision_vars, s_names, 1);
        nc = length(MLD.Eaff);
        i_eq = zeros(nc, 1);
        
        % determine positions of equality constraints
        i_eq = []; idx = 0;
        vars = getvariables(s_all_decision_vars);
        for i = 1:length(Fothers)
            Foi = Fothers(i);
            fosdp = sdpvar(Foi);
            fosdp = fosdp(:);
            fosdp = replace(fosdp, [s_outputvars; xplus], 0);
            is_eq = is(Foi, 'equality');
            for j = 1:length(fosdp)
                isthere = any(ismember(depends(fosdp(j)), vars));
                if isthere,
                    idx = idx + 1;
                    i_eq(idx) = is_eq;
                end
            end
        end
    else
        MLD.Ex = -getmatrix(Fothers_sdpvar, statevars);
        MLD.Eu = -getmatrix(Fothers_sdpvar, inputvars);
        MLD.Eaux = -getmatrix(Fothers_sdpvar, auxvars);
        M = full(getbase(Fothers_sdpvar));
        MLD.Eaff = M(:, 1);
        % now detect which constraints are equalities
        for i = 1:n_F
            is_F_eq = is(Fothers(i), 'equality');
            Fsdp = sdpvar(Fothers(i));
            i_eq = [i_eq; repmat(is_F_eq, length(Fsdp), 1)];
        end

    end
    i_ineq = ~i_eq;
end

if ~do_symbolic
    MLD = sub_fix_empty_matrices(MLD);
end

MLD.j.eq = find(i_eq);
MLD.j.ineq = find(i_ineq);
MLD.nc = length(MLD.Eaff);
MLD.symtable = symtable;
MLD.MLDisvalid = 1;

% remove always-feasible rows like Ex*x + Eu*u + Eaux*w <= Inf
MLD = sub_remove_inf_rows(MLD);

% remove multiple occurencies of the same constraints
if ~do_symbolic
    MLD = sub_remove_duplicates(MLD);
end

if ~do_symbolic
    %     augment MLD.AuxName information to cope with automatically introduced
    %     binaries
    MLD = sub_augment_auxs(MLD, wvars, autobinvars, auxvars);
    
    [v, map, k] = sub_devectorize_vector(MLD.AuxName, MLD.AuxLength, ...
        MLD.AuxKind);
    MLD.j.d = find(cellfun(@(x) (isequal(x, 'b')), k));
    MLD.j.z = find(cellfun(@(x) (isequal(x, 'r')), k));
end
MLD.nd = length(MLD.j.d);
MLD.nz = length(MLD.j.z);
MLD.nw = MLD.nd + MLD.nz;
MLD.J.W = repmat('r', 1, MLD.nw);
MLD.J.W(MLD.j.d) = 'b';


% extract bounds on variables from constraints
% MLD = sub_extract_bounds(MLD);

% generate table of direct interconnections between modules (i.e. equality
% constraints between auxiliary and input variables)
if do_symbolic
%     warning('Unable to generate connection table for symbolic models');
    MLD.connections.variables = [];
    MLD.connections.table = [];
else
    MLD = sub_get_connection_table(MLD);
end

if ~do_symbolic
    %creating old MLD format for checking
    MLDold.A = MLD.A;
    MLDold.B1 = MLD.Bu;
    MLDold.B2 = MLD.Baux(:,MLD.j.d);
    MLDold.B3 = MLD.Baux(:,MLD.j.z);
    MLDold.B5 = MLD.Baff;
    MLDold.C = MLD.C;
    MLDold.D1 = MLD.Du;
    MLDold.D2 = MLD.Daux(:,MLD.j.d);
    MLDold.D3 = MLD.Daux(:,MLD.j.z);
    MLDold.D5 = MLD.Daff;
    MLDold.E1 = -MLD.Eu;
    MLDold.E2 = MLD.Eaux(:,MLD.j.d);
    MLDold.E3 = MLD.Eaux(:,MLD.j.z);
    MLDold.E4 = -MLD.Ex;
    MLDold.E5 = MLD.Eaff;
    % dimensions
    MLDold.nx = length(x);
    MLDold.nxr = length(MLD.j.xr);
    MLDold.nxb = length(MLD.j.xb);
    MLDold.nu = length(u);
    MLDold.nur = length(MLD.j.ur);
    MLDold.nub = length(MLD.j.ub);
    MLDold.ny = length(y);
    MLDold.nyr = length(MLD.j.yr);
    MLDold.nyb = length(MLD.j.yb);
    MLDold.nd = length(MLD.j.d);
    MLDold.nz = length(MLD.j.z);
    MLDold.ne = size(MLD.Ex, 1);
    % upper/lower bounds
    MLDold.xl = MLD.xl;
    MLDold.xu = MLD.xu;
    MLDold.ul = MLD.ul;
    MLDold.uu = MLD.uu;
    MLDold.yl = MLD.yl;
    MLDold.yu = MLD.yu;
    MLDold.dl = MLD.wl(MLD.j.d);
    MLDold.du = MLD.wu(MLD.j.d);
    MLDold.zl = MLD.wl(MLD.j.z);
    MLDold.zu = MLD.wu(MLD.j.z);
    MLDold.symtable = [];
    MLDold.MLDisvalid = 1;

else
    MLDold = [];
end

%------------------------------------------------------------------------
function F = sub_sortF(F, vars)

nF = length(F);
Fvars = zeros(nF, 1);
for i = 1:nF
    idx = intersect(getvariables(F(i)), vars);
    if isempty(idx)
        % this constraint doesn't depend on LHS variable -- this is most
        % likely an error
        fprintf('Output/state equation doesn''t depend on LHS variable!\n');
        fprintf('Report this case to michal.kvasnica@stuba.sk\n');
        idx = 0;
    end
    Fvars(i) = idx(1);
end
[a, b] = sort(Fvars);
F = F(b);

return


%------------------------------------------------------------------------
function M = getmatrix(F, var, must_depend_on)

M = [];
for ii = 1:length(var),
    M = [M full(getbasematrix(F,var(ii)))];
end

% it could happen that the user has forgotten to define a state-update
% equation for certain states, e.g.:
%   STATE { REAL x1, x2; }
%   CONTINUOUS { x2 = x1 + x2; }
% in such case the "A" matrix would have just one row. if we detect this
% case, we trigger an error.
%
% the issue here is that x2(k+1) depends on x1, therefore x1 needs to be
% present in the constraints and in the state-update equation. however, we
% don't know what should x1(k+1) be.
% if nargin > 2
%     if size(M, 1) < length(must_depend_on)
%         B = getbase(F);
%         for i = 1:length(must_depend_on)
%             if all(B(:, must_depend_on(i))==0)
%                 error('State-update or output equation for some state/output variables is missing.');
%             end
%         end
%     end
% end


%------------------------------------------------------------------------
function MLD = sub_fix_empty_matrices(MLD)

f = {'A', 'Bu', 'Baux', 'Baff'};
MLD = sub_fix_empty_matrices_one(MLD, f);

f = {'C', 'Du', 'Daux', 'Daff'};
MLD = sub_fix_empty_matrices_one(MLD, f);

f = {'Ex', 'Eu', 'Eaux', 'Eaff'};
MLD = sub_fix_empty_matrices_one(MLD, f);    


%------------------------------------------------------------------------
function MLD = sub_fix_empty_matrices_one(MLD, f)

x = 0;
for i = 1:length(f)
    m = getfield(MLD, f{i});
    x = max(x, size(m, 1));
end
for i = 1:length(f)
    m = getfield(MLD, f{i});
    if isempty(m)
        m = zeros(x, size(m, 2));
        MLD = setfield(MLD, f{i}, m);
    end
end


%------------------------------------------------------------------------
function MLD = sub_remove_duplicates(MLD)

% first remove zero rows
A = [MLD.Ex MLD.Eu MLD.Eaux MLD.Eaff];
Aineq = A(MLD.j.ineq, :);
Aeq = A(MLD.j.eq, :);

Aeq = sub_eliminate_redundancies(Aeq);
Aineq = sub_eliminate_redundancies(Aineq);

MLD.Ex = [Aeq(:, 1:MLD.nx); Aineq(:, 1:MLD.nx)];
MLD.Eu = [Aeq(:, MLD.nx+1:MLD.nx+MLD.nu); Aineq(:, MLD.nx+1:MLD.nx+MLD.nu)];
MLD.Eaux = [Aeq(:, MLD.nx+MLD.nu+1:end-1); Aineq(:, MLD.nx+MLD.nu+1:end-1)];
MLD.Eaff = [Aeq(:, end); Aineq(:, end)];
MLD.j.eq = 1:size(Aeq, 1);
MLD.j.ineq = size(Aeq, 1)+1:(size(Aeq, 1)+size(Aineq, 1));
MLD.nc = size(Aeq, 1) + size(Aineq, 1);

%------------------------------------------------------------------------
function A = sub_eliminate_redundancies(A)

% first eliminate zero rows
zerorows = (sum(abs(A(:, 1:end-1)), 2) == 0);
A = A(~zerorows, :);

% now eliminate double occurencies of the same constraints
[a, b] = unique(A, 'rows');
A = A(sort(b), :);


%------------------------------------------------------------------------
function S = sub_augment_auxs(S, wvars, autobinvars, auxvars)
% include autogenerated binaries into S.AuxName, S.AuxKind and S.AuxLength

nb = 0; nz = 0;
for i = 1:length(auxvars)
    if ~ismember(auxvars(i), wvars)
        if is(recover(auxvars(i)), 'binary')
            nb = nb + 1;
            S.AuxName{end+1} = sprintf('d_additional_%d', nb);
            S.AuxKind{end+1} = 'b';
            S.AuxLength{end+1} = 1;
        else
            nz = nz + 1;
            S.AuxName{end+1} = sprintf('z_additional_%d', nz);
            S.AuxKind{end+1} = 'r';
            S.AuxLength{end+1} = 1;
        end
    end
end
% 
% nb = 0;
% for i = 1:length(autobinvars)
%     idx = find(autobinvars==auxvars(i));
%     if isempty(idx)
%         nb = nb + 1;
%         S.AuxName{end+1} = sprintf('d_additional_%d', nb);
%         S.AuxKind{end+1} = 'b';
%         S.AuxLength{end+1} = 1;
%     end
% end
return

% the code below is broken:

nw = length(auxvars);
names = cell(1, nw);
kinds = cell(1, nw);
lengths = cell(1, nw);

% copy already defined variables
for i = 1:nw
    idx = find(wvars==auxvars(i));
    if ~isempty(idx)
        names{i} = S.AuxName{idx};
        kinds{i} = S.AuxKind{idx};
        lengths{i} = S.AuxLength{idx};
    end
end


% add automatically generated binaries
nb = 0;
for i = 1:nw
    idx = find(autobinvars==auxvars(i));
    if ~isempty(idx)
        nb = nb + 1;
        names{i} = sprintf('d_additional_%d', nb);
        kinds{i} = 'b';
        lengths{i} = 1;
    end
end

% % include automatically generated binaries
% names = S.AuxName;
% kinds = S.AuxKind;
% lengths = S.AuxLength;
% 
% for i = 1:length(autobinvars)
%     names{end+1} = sprintf('d_additional_%d', i);
%     kinds{end+1} = 'b';
%     lengths{end+1} = 1;
% end

S.AuxName = names;
S.AuxKind = kinds;
S.AuxLength = lengths;

return

% 
% nvars = length(auxvars);
% names = cell(nvars, 1);
% kinds = cell(nvars, 1);
% lengths = cell(nvars, 1);
% 
% % w_idx = find(ismember(auxvars, wvars));
% w_idx = 1:length(wvars);
% d_idx = find(ismember(auxvars, autobinvars));
% 
% if nvars == 0 % | isempty(d_idx)
%     % nothing to do, save time and exit quickly
%     return
% end
% 
% % let's say we have a variable on positions 3:5 and we know it's called "w"
% % then this procedure sets names = {[], [], 'w', 'w', 'w', [], [], ...}
% if isempty(w_idx)
%     w_idx = 1;
% end
% start_idx = 1;
% for i = 1:length(names);
%     stop_idx = start_idx + lengths{i} - 1;
%     [names{w_idx(start_idx:stop_idx)}] = deal(names{i});
%     [kinds{w_idx(start_idx:stop_idx)}] = deal(kinds{i});
%     [lengths{w_idx(start_idx:stop_idx)}] = deal(lengths{i});
%     start_idx = stop_idx+1;
% end
% 
% % store additional binaries
% for i = 1:length(autobinvars)
%     names{d_idx(i)} = sprintf('d_additional_%d', i);
%     kinds{d_idx(i)} = 'b';
%     lengths{d_idx(i)} = 1;
% end
% % [kinds{d_idx}] = deal('b');
% % [lengths{d_idx}] = deal(1);
% 
% % now collapse the names by kicking out duplicates
% [a, b] = unique(names);
% b_sorted = sort(b);
% 
% % and update the respective fields
% S.AuxName = names(b_sorted)';
% S.AuxKind = kinds(b_sorted)';
% S.AuxLength = lengths(b_sorted)';


%------------------------------------------------------------------------
function S = sub_get_connection_table(S)

v_u = sub_devectorize_vector(S.InputName, S.InputLength);

% from Aux vars we must first pick only those variables, which once have
% been defined as inputs/outputs and only then converted to aux. this
% information is in S.symtable{i}.orig_type
converted_auxs = cellfun(@(x) ~isequal(x.orig_type, x.type), ...
    S.symtable, 'UniformOutput', false);
c_auxs = find([converted_auxs{:}]);
keep = [];
for i = c_auxs
    k = cellfun(@(x) isequal(x, S.symtable{i}.name), S.AuxName);
    keep = [keep find(k)];
end

% de-vectorize variables, i.e. if a variable was defined as "x(3,1)", then we
% write "x(1)", "x(2)", "x(3)" 
v_aux = sub_devectorize_vector(S.AuxName(keep), S.AuxLength(keep));

v_total = cat(2, v_u, v_aux);
n_u = length(v_u);
n_aux = length(v_aux);
n_total = n_u + n_aux;

S.connections.variables = v_total';
S.connections.table = zeros(n_total);

% all equality constraints involving input and aux variables:
T = [S.Eu(S.j.eq, :) S.Eaux(S.j.eq, keep)];

% number of non-zero elements in each row
t_nnz = sum(abs(T), 2);

% a row represents a direct connection between several variables if the
% number of non-zero elements is greater 1
%
% for a single constraint in the form M1.y = M2.u t_nnz(i) will be 2.
% however, hysdel allows fancy constructs like M1.y + M2.y = M3.u
T = T(find(t_nnz > 1), :);

S.connections.table = T;

%------------------------------------------------------------------------
function [v, map, k] = sub_devectorize_vector(names, lengths, kinds)

n = sum([lengths{:}]);
v = cell(1, n);
k = cell(1, n);
map = {};
start_idx = 1;
for i = 1:length(names)
    stop_idx = start_idx + lengths{i} - 1;
    counter = 0;
    for j = start_idx:stop_idx
        counter = counter + 1;
        v{j} = sprintf('%s(%d)', names{i}, counter);
        if nargin > 2
            k{j} = kinds{i};
        end
        map{j} = i;
    end
    start_idx = stop_idx + 1;
end


%------------------------------------------------------------------------
function S = sub_extract_bounds(S)

Ex = S.Ex(S.j.ineq, :);
Eu = S.Eu(S.j.ineq, :);
Eaux = S.Eaux(S.j.ineq, :);
Eaff = S.Eaff(S.j.ineq, :);

LHS = [Ex Eu Eaux];
RHS = Eaff;
LHS_bounds = [[eye(S.nx); -eye(S.nx)] zeros(2*S.nx, S.nu+S.nw);
    zeros(2*S.nu, S.nx) [eye(S.nu); -eye(S.nu)] zeros(2*S.nu, S.nw);
    zeros(2*S.nw, S.nx) zeros(2*S.nw, S.nu) [eye(S.nw); -eye(S.nw)]];
RHS_bounds = [S.xu; -S.xl; S.uu; -S.ul; S.wu; -S.wl];

[a, b] = intersect([LHS RHS], [LHS_bounds RHS_bounds], 'rows');

S.Ex = [Ex(b, :); S.Ex(S.j.eq, :)];
S.Eu = [Eu(b, :); S.Eu(S.j.eq, :)];
S.Eaux = [Eaux(b, :); S.Eaux(S.j.eq, :)];
S.Eaff = [Eaff(b, :); S.Eaff(S.j.eq, :)];
S.nc = size(S.Ex, 1);
S.j.ineq = 1:length(b);
S.j.eq = length(b)+1:S.nc;


%------------------------------------------------------------------------
function [names, vars, removed] = sub_remove_unused_vars(type, F, names, vars)

removed = [];
try
    F_depends_on = depends(F - F('bounds'));
catch
    F_depends_on = depends(F);
end
% F_depends_on = depends(F);
s = setdiff(vars, F_depends_on);
removed = s;
if ~isempty(s)
    % unused variable detected
    idx = find(ismember(vars, s));
    if ~isempty(idx)
        v_name = getfield(names, [type 'Name']);
        v_length = getfield(names, [type 'Length']);
        v_kind = getfield(names, [type 'Kind']);
        [n, map] = sub_devectorize_vector(v_name, v_length);
        for j = idx
            fprintf('Variable "%s" declared but not used, removing...\n', ...
                n{j});
        end
        for j = 1:length(idx)
            % variable is not used, decrease the length by one
            v_length{map{idx(j)}} = v_length{map{idx(j)}} - 1;
        end
        % should we remove a vector variable alltogether?
        toremove = find(cellfun(@(x) (x <= 0), v_length));
        v_name(toremove) = [];
        v_length(toremove) = [];
        v_kind(toremove) = [];
        names = setfield(names, [type 'Name'], v_name);
        names = setfield(names, [type 'Length'], v_length);
        names = setfield(names, [type 'Kind'], v_kind);
        vars = setdiff(vars, s);
    end
end


%------------------------------------------------------------------------
function MLD = sub_remove_inf_rows(MLD)
% remove always-feasible rows like Ex*x + Eu*u + Eaux*w <= Inf

nr = size(MLD.Eaff, 1);
row_type = zeros(nr, 1);
row_type(MLD.j.ineq) = 1;
row_type(MLD.j.eq) = 2;
inf_row = zeros(nr, 1);
if iscell(MLD.Eaff)
    for i = 1:nr
        if isa(MLD.Eaff{i}{1}, 'char')
            inf_row(i) = isequal(MLD.Eaff{i}{1}, 'Inf');
        else
            inf_row(i) = isequal(MLD.Eaff{i}{1}, Inf);
        end
    end
    noninfrows = find(~inf_row);
else
    noninfrows = find(MLD.Eaff ~= Inf);
end

MLD.Ex = MLD.Ex(noninfrows, :);
MLD.Eu = MLD.Eu(noninfrows, :);
MLD.Eaux = MLD.Eaux(noninfrows, :);
MLD.Eaff = MLD.Eaff(noninfrows);
row_type = row_type(noninfrows);
MLD.j.eq = find(row_type == 2);
MLD.j.ineq = find(row_type == 1);
MLD.nc = length(noninfrows);
