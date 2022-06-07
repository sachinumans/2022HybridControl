S = [];
S.A = [0, 0;
0, 0;
];
S.Bu = [0, 0, 0, 0, 0;
0, 0, 0, 0, 0;
];
S.Baux = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0;
0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1;
];
S.Baff = [0;
0;
];
S.C = [1, 0;
];
S.Du = [0, 0, 0, 0, 0;
];
S.Daux = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0;
];
S.Daff = [0;
];
S.Ex = [1, 0;
0, 1;
-1, 0;
0, -1;
0, 0;
0, 0;
0, 0;
0, 0;
0, 0;
0, 0;
0, 0;
0, 0;
0, 0;
0, 0;
0, 0;
0, 0;
0, 0;
0, 0;
0, 0;
0, 0;
0, 0;
0, 0;
0, 0;
0, 0;
0, 0;
0, 0;
0, 0;
0, 0;
0, 0;
0, 0;
0, 0;
0, 0;
0, 0;
0, 0;
0, 0;
0, 0;
0, 0;
0, 0;
0, 0;
0, 0;
0, 0;
0, 0;
0, 0;
0, 0;
0, 0;
0, 0;
0, 0;
0, 0;
];
S.Eu = [0, 0, 0, 0, 0;
0, 0, 0, 0, 0;
0, 0, 0, 0, 0;
0, 0, 0, 0, 0;
1, 0, 0, 0, 0;
0.5, 0, 0, 0, 0;
-1, 0, 0, 0, 0;
-0.5, 0, 0, 0, 0;
0, 1, 0, 0, 0;
0, 0.5, 0, 0, 0;
0, -1, 0, 0, 0;
0, -0.5, 0, 0, 0;
0, 0, 1, 0, 0;
0, 0, 0.5, 0, 0;
0, 0, -1, 0, 0;
0, 0, -0.5, 0, 0;
0, 0, 0, 1, 0;
0, 0, 0, 0.5, 0;
0, 0, 0, -1, 0;
0, 0, 0, -0.5, 0;
0, 0, 0, 0, 1;
0, 0, 0, 0, 0.5;
0, 0, 0, 0, -1;
0, 0, 0, 0, -0.5;
0, 0, 0, 0, 0;
0, 0, 0, 0, 0;
0, 0, 0, 0, 0;
0, 0, 0, 0, 0;
0, 0, 0, 0, 0;
0, 0, 0, 0, 0;
0, 0, 0, 0, 0;
0, 0, 0, 0, 0;
0, 0, 0, 0, 0;
0, 0, 0, 0, 0;
0, 0, 0, 0, 0;
0, 0, 0, 0, 0;
0, 0, 0, 0, 0;
0, 0, 0, 0, 0;
0, 0, 0, 0, 0;
0, 0, 0, 0, 0;
0, 0, 0, 0, 0;
0, 0, 0, 0, 0;
0, 0, 0, 0, 0;
0, 0, 0, 0, 0;
0, 0, 0, 0, 0;
0, 0, 0, 0, 0;
0, 0, 0, 0, 0;
0, 0, 0, 0, 0;
];
S.Eaux = [-1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0;
0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0;
1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0;
0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0;
A(1), A(3), -1, 0, 0, 0, 0, 0, 0, 0, 0, 0;
A(2), A(4), 0, -1, 0, 0, 0, 0, 0, 0, 0, 0;
-1*A(1), -1*A(3), 1, 0, 0, 0, 0, 0, 0, 0, 0, 0;
-1*A(2), -1*A(4), 0, 1, 0, 0, 0, 0, 0, 0, 0, 0;
0, 0, A(1), A(3), -1, 0, 0, 0, 0, 0, 0, 0;
0, 0, A(2), A(4), 0, -1, 0, 0, 0, 0, 0, 0;
0, 0, -1*A(1), -1*A(3), 1, 0, 0, 0, 0, 0, 0, 0;
0, 0, -1*A(2), -1*A(4), 0, 1, 0, 0, 0, 0, 0, 0;
0, 0, 0, 0, A(1), A(3), -1, 0, 0, 0, 0, 0;
0, 0, 0, 0, A(2), A(4), 0, -1, 0, 0, 0, 0;
0, 0, 0, 0, -1*A(1), -1*A(3), 1, 0, 0, 0, 0, 0;
0, 0, 0, 0, -1*A(2), -1*A(4), 0, 1, 0, 0, 0, 0;
0, 0, 0, 0, 0, 0, A(1), A(3), -1, 0, 0, 0;
0, 0, 0, 0, 0, 0, A(2), A(4), 0, -1, 0, 0;
0, 0, 0, 0, 0, 0, -1*A(1), -1*A(3), 1, 0, 0, 0;
0, 0, 0, 0, 0, 0, -1*A(2), -1*A(4), 0, 1, 0, 0;
0, 0, 0, 0, 0, 0, 0, 0, A(1), A(3), -1, 0;
0, 0, 0, 0, 0, 0, 0, 0, A(2), A(4), 0, -1;
0, 0, 0, 0, 0, 0, 0, 0, -1*A(1), -1*A(3), 1, 0;
0, 0, 0, 0, 0, 0, 0, 0, -1*A(2), -1*A(4), 0, 1;
1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0;
0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0;
0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0;
0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0;
0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0;
0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0;
0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0;
0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0;
0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0;
0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0;
0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0;
0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1;
-1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0;
0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0;
0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0;
0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0;
0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0;
0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0;
0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0;
0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0;
0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0;
0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0;
0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0;
0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1;
];
S.Eaff = [0;
0;
0;
0;
0;
0;
0;
0;
0;
0;
0;
0;
0;
0;
0;
0;
0;
0;
0;
0;
0;
0;
0;
0;
10;
10;
10;
10;
10;
10;
10;
10;
10;
10;
10;
10;
10;
10;
10;
10;
10;
10;
10;
10;
10;
10;
10;
10;
];
S.nu = 5;
S.nx = 2;
S.ny = 1;
S.nw = 12;
S.InputName = {'U'};
S.InputKind = {'r'};
S.InputLength = {5};
S.StateName = {'X'};
S.StateKind = {'r'};
S.StateLength = {2};
S.OutputName = {'y'};
S.OutputKind = {'r'};
S.OutputLength = {1};
S.AuxName = {'z(1)', 'z(2)', 'z(3)', 'z(4)', 'z(5)', 'z(6)', 'z(7)', 'z(8)', 'z(9)', 'z(10)', 'z(11)', 'z(12)'};
S.AuxKind = {'r', 'r', 'r', 'r', 'r', 'r', 'r', 'r', 'r', 'r', 'r', 'r'};
S.AuxLength = {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1};
S.ParameterName = {'A'};
S.ParameterKind = {};
S.ParameterLength = {4};
S.j.w_auto_bin = [];
S.j.xr = [1;2];
S.j.xb = [];
S.j.ur = [1;2;3;4;5];
S.j.ub = [];
S.j.yr = 1;
S.j.yb = [];
S.j.d = [];
S.j.z = [1 2 3 4 5 6 7 8 9 10 11 12];
S.j.eq = zeros(1,0);
S.j.ineq = [1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48];
S.xl = [-10;-10];
S.xu = [10;10];
S.ul = [-1;-1;-1;-1;-1];
S.uu = [1;1;1;1;1];
S.yl = -Inf;
S.yu = Inf;
S.wl = [-10;-10;-10;-10;-10;-10;-10;-10;-10;-10;-10;-10];
S.wu = [10;10;10;10;10;10;10;10;10;10;10;10];
S.J.X = 'rr';
S.J.U = 'rrrrr';
S.J.Y = 'r';
S.J.W = 'rrrrrrrrrrrr';
S.nxb = 0;
S.nxr = 2;
S.nub = 0;
S.nur = 5;
S.nyb = 0;
S.nyr = 1;
S.nd = 0;
S.nz = 12;
S.nc = 48;
S.symtable = {struct('name', 'N', 'orig_type', 'parameter', 'type', 'parameter', 'kind', 'real'), struct('name', 'nx', 'orig_type', 'parameter', 'type', 'parameter', 'kind', 'real'), struct('name', 'nu', 'orig_type', 'parameter', 'type', 'parameter', 'kind', 'real'), struct('name', 'A', 'orig_type', 'parameter', 'type', 'parameter', 'kind', 'real'), struct('name', 'B', 'orig_type', 'parameter', 'type', 'parameter', 'kind', 'real'), struct('name', 'X', 'orig_type', 'state', 'type', 'state', 'kind', 'real'), struct('name', 'U', 'orig_type', 'input', 'type', 'input', 'kind', 'real'), struct('name', 'y', 'orig_type', 'output', 'type', 'output', 'kind', 'real'), struct('name', 'z', 'orig_type', 'aux', 'type', 'aux', 'kind', 'real'), struct('name', 'i', 'orig_type', 'index', 'type', 'index', 'kind', 'index')};
S.MLDisvalid = 1;
S.connections.variables = [];
S.connections.table = [];
S.name = 'mpc_lti';