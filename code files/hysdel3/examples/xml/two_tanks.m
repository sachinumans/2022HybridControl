S = [];
S.nu = 1;
S.nx = 2;
S.ny = 2;
S.nw = 2;
S.InputName = {'inflow'};
S.InputKind = {'r'};
S.InputLength = {1};
S.StateName = {'h'};
S.StateKind = {'r'};
S.StateLength = {2};
S.OutputName = {'full_out'};
S.OutputKind = {'b'};
S.OutputLength = {2};
S.AuxName = {'full'};
S.AuxKind = {'b'};
S.AuxLength = {2};
S.ParameterName = {};
S.ParameterKind = {};
S.ParameterLength = {};
S.xl = [-0;-0];
S.xu = [1;1];
S.ul = -0;
S.uu = 0.5;
S.yl = [0;0];
S.yu = [1;1];
S.wl = [0;0];
S.wu = [1;1];
S.j.xr = [1;2];
S.j.xb = [];
S.j.ur = 1;
S.j.ub = [];
S.j.yr = [];
S.j.yb = [1;2];
S.j.d = [1;2];
S.j.z = [];
S.j.w_auto_bin = zeros(1,0);
S.j.eq = zeros(1,0);
S.j.ineq = [1 2 3 4 5 6 7 8 9 10];
S.J.X = 'rr';
S.J.U = 'r';
S.J.Y = 'bb';
S.J.W = 'bb';
S.nxb = 0;
S.nxr = 2;
S.nub = 0;
S.nur = 1;
S.nyb = 2;
S.nyr = 0;
S.nd = 2;
S.nz = 0;
S.A = [0.5 0;0.5 0.5];
S.Bu = [1;0];
S.Baux = [0 0;0 0];
S.Baff = [0;0];
S.C = [0 0;0 0];
S.Du = [0;0];
S.Daux = [1 0;0 1];
S.Daff = [0;0];
S.Ex = [-1 -0;-0 -1;1 -0;-0 1;-0 -0;-0 -0;-1 -0;1 -0;-0 -1;-0 1];
S.Eu = [-0;-0;-0;-0;-1;1;-0;-0;-0;-0];
S.Eaux = [-0 -0;-0 -0;-0 -0;-0 -0;-0 -0;-0 -0;0.5 -0;-0.500001 -0;-0 0.5;-0 -0.500001];
S.Eaff = [0;0;1;1;0;0.5;0;0.499999;0;0.499999];
S.nc = 10;
S.symtable = {struct('name', 'k', 'orig_type', 'parameter', 'type', 'parameter', 'kind', 'real'), struct('name', 'h', 'orig_type', 'state', 'type', 'state', 'kind', 'real'), struct('name', 'inflow', 'orig_type', 'input', 'type', 'input', 'kind', 'real'), struct('name', 'full_out', 'orig_type', 'output', 'type', 'output', 'kind', 'bool'), struct('name', 'full', 'orig_type', 'aux', 'type', 'aux', 'kind', 'bool'), struct('name', 'i', 'orig_type', 'index', 'type', 'index', 'kind', 'index')};
S.MLDisvalid = 1;
S.connections.variables = {'inflow(1)'};
S.connections.table = zeros(0,1);
S.name = 'two_tanks';
