S = [];
S.A = [0;
];
S.Bu = [1;
];
S.Baux = [0, 0, 0, 0;
];
S.Baff = [0;
];
S.C = [0;
0;
];
S.Du = [0;
0;
];
S.Daux = [0, 1, 0, 0;
0, 0, 0, 1;
];
S.Daff = [0;
0;
];
S.Ex = [-1;
1;
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
];
S.Eu = [0;
0;
-1;
1;
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
];
S.Eaux = [0, 0, 0, 0;
0, 0, 0, 0;
0, 0, 0, 0;
0, 0, 0, 0;
-1, 0, 0, 0;
0, -1, 0, 0;
0, 0, -1, 0;
0, 0, 0, -1;
1, 0, 0, 0;
0, 1, 0, 0;
0, 0, 1, 0;
0, 0, 0, 1;
1, 0, 0, 0;
0, 1, 0, 0;
0, 0, 1, 0;
0, 0, 0, 1;
];
S.Eaff = [10000;
10000;
10000;
10000;
10000;
10000;
10000;
10000;
10000;
10000;
10000;
10000;
711;
721;
712;
722;
];
S.nu = 1;
S.nx = 1;
S.ny = 2;
S.nw = 4;
S.InputName = {'U'};
S.InputKind = {'r'};
S.InputLength = {1};
S.StateName = {'X'};
S.StateKind = {'r'};
S.StateLength = {1};
S.OutputName = {'Y'};
S.OutputKind = {'r'};
S.OutputLength = {2};
S.AuxName = {'Z'};
S.AuxKind = {'r'};
S.AuxLength = {4};
S.ParameterName = {'p1'};
S.ParameterKind = {};
S.ParameterLength = {2};
S.xl = -10000;
S.xu = 10000;
S.ul = -10000;
S.uu = 10000;
S.yl = [-10000;-10000];
S.yu = [10000;10000];
S.wl = [711;721;712;722];
S.wu = [711;721;712;722];
S.j.xr = 1;
S.j.xb = [];
S.j.ur = 1;
S.j.ub = [];
S.j.yr = [1;2];
S.j.yb = [];
S.j.d = [];
S.j.z = [1;2;3;4];
S.j.w_auto_bin = zeros(1,0);
S.j.eq = [13 14 15 16];
S.j.ineq = [1 2 3 4 5 6 7 8 9 10 11 12];
S.J.X = 'r';
S.J.U = 'r';
S.J.Y = 'rr';
S.J.W = 'rrrr';
S.nxb = 0;
S.nxr = 1;
S.nub = 0;
S.nur = 1;
S.nyb = 0;
S.nyr = 2;
S.nd = 0;
S.nz = 4;
S.nc = 16;
S.symtable = {struct('name', 'p1', 'orig_type', 'parameter', 'type', 'parameter', 'kind', 'real'), struct('name', 'X', 'orig_type', 'state', 'type', 'state', 'kind', 'real'), struct('name', 'U', 'orig_type', 'input', 'type', 'input', 'kind', 'real'), struct('name', 'Y', 'orig_type', 'output', 'type', 'output', 'kind', 'real'), struct('name', 'Z', 'orig_type', 'aux', 'type', 'aux', 'kind', 'real')};
S.MLDisvalid = 1;
S.connections.variables = [];
S.connections.table = [];
S.name = 'test0051b';
