S = [];
S.nu = 1;
S.nx = 2;
S.ny = 2;
S.nw = 3;
S.InputName = {'u'};
S.InputKind = {'r'};
S.InputLength = {1};
S.StateName = {'x'};
S.StateKind = {'r'};
S.StateLength = {2};
S.OutputName = {'y'};
S.OutputKind = {'r'};
S.OutputLength = {2};
S.AuxName = {'z', 'd_additional_1'};
S.AuxKind = {'r', 'b'};
S.AuxLength = {2, 1};
S.ParameterName = {};
S.ParameterKind = {};
S.ParameterLength = {};
S.xl = [-10;-10];
S.xu = [10;10];
S.ul = -1;
S.uu = 1;
S.yl = [-Inf;-Inf];
S.yu = [Inf;Inf];
S.wl = [-10.928;-11.928;0];
S.wu = [10.928;11.928;1];
S.j.xr = [1;2];
S.j.xb = [];
S.j.ur = 1;
S.j.ub = [];
S.j.yr = [1;2];
S.j.yb = [];
S.j.d = 3;
S.j.z = [1 2];
S.j.w_auto_bin = 3;
S.j.eq = zeros(1,0);
S.j.ineq = [1 2 3 4 5 6 7 8 9 10];
S.J.X = 'rr';
S.J.U = 'r';
S.J.Y = 'rr';
S.J.W = 'rrb';
S.nxb = 0;
S.nxr = 2;
S.nub = 0;
S.nur = 1;
S.nyb = 0;
S.nyr = 2;
S.nd = 1;
S.nz = 2;
S.A = [0 0;0 0];
S.Bu = [0;0];
S.Baux = [1 0 0;0 1 0];
S.Baff = [0;0];
S.C = [1 0;0 1];
S.Du = [0;0];
S.Daux = [0 0 0;0 0 0];
S.Daff = [0;0];
S.Ex = [-1 -0;1 -0;0.4 0.6928;-0.6928 0.4;-0.4 -0.6928;0.6928 -0.4;0.4 -0.6928;0.6928 0.4;-0.4 0.6928;-0.6928 -0.4];
S.Eu = [-0;-0;-0;1;-0;-1;-0;1;-0;-1];
S.Eaux = [-0 -0 -10.000001;-0 -0 10;-1 -0 21.856;-0 -1 23.856;1 -0 21.856;-0 1 23.856;-1 -0 -21.856;-0 -1 -23.856;1 -0 -21.856;-0 1 -23.856];
S.Eaff = [-1e-06;10;21.856;23.856;21.856;23.856;0;0;0;0];
S.nc = 10;
S.symtable = {struct('name', 'A1', 'orig_type', 'parameter', 'type', 'parameter', 'kind', 'real'), struct('name', 'A2', 'orig_type', 'parameter', 'type', 'parameter', 'kind', 'real'), struct('name', 'B', 'orig_type', 'parameter', 'type', 'parameter', 'kind', 'real'), struct('name', 'x', 'orig_type', 'state', 'type', 'state', 'kind', 'real'), struct('name', 'u', 'orig_type', 'input', 'type', 'input', 'kind', 'real'), struct('name', 'y', 'orig_type', 'output', 'type', 'output', 'kind', 'real'), struct('name', 'z', 'orig_type', 'aux', 'type', 'aux', 'kind', 'real')};
S.MLDisvalid = 1;
S.connections.variables = {'u(1)'};
S.connections.table = zeros(0,1);
S.name = 'pwa_sincos';
