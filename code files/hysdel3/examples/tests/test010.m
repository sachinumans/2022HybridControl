S = [];
S.nu = 2;
S.nx = 2;
S.ny = 2;
S.nw = 3;
S.InputName = {'U', 'U2'};
S.InputKind = {'r', 'r'};
S.InputLength = {1, 1};
S.StateName = {'X', 'X2'};
S.StateKind = {'r', 'r'};
S.StateLength = {1, 1};
S.OutputName = {'Y', 'Y2'};
S.OutputKind = {'r', 'r'};
S.OutputLength = {1, 1};
S.AuxName = {'Z', 'Z2'};
S.AuxKind = {'r', 'r'};
S.AuxLength = {2, 1};
S.ParameterName = {};
S.ParameterKind = {};
S.ParameterLength = {};
S.xl = [-4;-10000];
S.xu = [5;10000];
S.ul = [-10;-10000];
S.uu = [9;10000];
S.yl = [-2;-10000];
S.yu = [2;10000];
S.wl = [-10000;-10000;-1];
S.wu = [10000;10000;1];
S.j.xr = [1;2];
S.j.xb = [];
S.j.ur = [1;2];
S.j.ub = [];
S.j.yr = [1;2];
S.j.yb = [];
S.j.d = [];
S.j.z = [1;2;3];
S.j.w_auto_bin = zeros(1,0);
S.j.eq = [1 2];
S.j.ineq = [3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20];
S.J.X = 'rr';
S.J.U = 'rr';
S.J.Y = 'rr';
S.J.W = 'rrr';
S.nxb = 0;
S.nxr = 2;
S.nub = 0;
S.nur = 2;
S.nyb = 0;
S.nyr = 2;
S.nd = 0;
S.nz = 3;
S.A = [0 0;1 0];
S.Bu = [1 0;0 0];
S.Baux = [0 0 0;0 0 0];
S.Baff = [0;0];
S.C = [0 0;1 0];
S.Du = [0 0;0 0];
S.Daux = [0 1 0;0 0 0];
S.Daff = [0;0];
S.Ex = [-1 -0;-0 -0;-1 -0;1 -0;-0 -1;-0 1;-0 -0;-0 -0;-0 -0;-0 -0;-0 -0;-0 -0;-0 -0;-0 -0;-0 -0;-0 -0;-0 -0;-0 -0;-1 -0;1 -0];
S.Eu = [-0 -0;-1 -0;-0 -0;-0 -0;-0 -0;-0 -0;-1 -0;1 -0;-0 -1;-0 1;-0 -0;-0 -0;-0 -0;-0 -0;-0 -0;-0 -0;-1 -0;1 -0;-0 -0;-0 -0];
S.Eaux = [1 -0 -0;-0 1 -0;-0 -0 -0;-0 -0 -0;-0 -0 -0;-0 -0 -0;-0 -0 -0;-0 -0 -0;-0 -0 -0;-0 -0 -0;-1 -0 -0;-0 -1 -0;1 -0 -0;-0 1 -0;-0 -0 -1;-0 -0 1;-0 -0 -0;-0 -0 -0;-0 -0 -0;-0 -0 -0];
S.Eaff = [0;0;5;5;10000;10000;10;10;10000;10000;10000;10000;10000;10000;1;1;11;9;4;6];
S.nc = 20;
S.symtable = {struct('name', 'X', 'orig_type', 'state', 'type', 'state', 'kind', 'real'), struct('name', 'X2', 'orig_type', 'state', 'type', 'state', 'kind', 'real'), struct('name', 'U', 'orig_type', 'input', 'type', 'input', 'kind', 'real'), struct('name', 'U2', 'orig_type', 'input', 'type', 'input', 'kind', 'real'), struct('name', 'Y', 'orig_type', 'output', 'type', 'output', 'kind', 'real'), struct('name', 'Y2', 'orig_type', 'output', 'type', 'output', 'kind', 'real'), struct('name', 'Z', 'orig_type', 'aux', 'type', 'aux', 'kind', 'real'), struct('name', 'Z2', 'orig_type', 'aux', 'type', 'aux', 'kind', 'real')};
S.MLDisvalid = 1;
S.connections.variables = {'U(1)', 'U2(1)'};
S.connections.table = zeros(0,2);
S.name = 'test010';
