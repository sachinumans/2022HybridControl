S = [];
S.A = [0.950129285147175, 0.891298966148902, 0.821407164295253, 0.921812970744803;
0.231138513574288, 0.762096833027395, 0.444703364353194, 0.738207245810665;
0.606842583541787, 0.456467665168341, 0.615432348100095, 0.176266144494618;
0.4859824687093, 0.0185036432482244, 0.791937037427035, 0.405706213062095;
];
S.Bu = [B(1), B(5), B(9);
B(2), B(6), B(10);
B(3), B(7), B(11);
B(4), B(8), B(12);
];
S.Baux = [;
;
;
;
];
S.Baff = [0;
0;
0;
0;
];
S.C = [0.935469699107605, 0.410270206990945, 0.0578913047842686, 0.813166497303758;
0.916904439913408, 0.893649530913534, 0.352868132217, 0.00986130066092356;
1, 0, 0, 0;
];
S.Du = [D(1), D(3), D(5);
D(2), D(4), D(6);
0, 0, 0;
];
S.Daux = [;
;
;
];
S.Daff = [0;
0;
0;
];
S.Ex = [-1, 0, 0, 0;
0, -1, 0, 0;
0, 0, -1, 0;
0, 0, 0, -1;
1, 0, 0, 0;
0, 1, 0, 0;
0, 0, 1, 0;
0, 0, 0, 1;
0, 0, 0, 0;
0, 0, 0, 0;
0, 0, 0, 0;
0, 0, 0, 0;
0, 0, 0, 0;
0, 0, 0, 0;
];
S.Eu = [0, 0, 0;
0, 0, 0;
0, 0, 0;
0, 0, 0;
0, 0, 0;
0, 0, 0;
0, 0, 0;
0, 0, 0;
-1, 0, 0;
0, -1, 0;
0, 0, -1;
1, 0, 0;
0, 1, 0;
0, 0, 1;
];
S.Eaux = [;
;
;
;
;
;
;
;
;
;
;
;
;
;
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
10000;
10000;
];
S.nu = 3;
S.nx = 4;
S.ny = 3;
S.nw = 0;
S.InputName = {'u'};
S.InputKind = {'r'};
S.InputLength = {3};
S.StateName = {'x'};
S.StateKind = {'r'};
S.StateLength = {4};
S.OutputName = {'y', 'TR'};
S.OutputKind = {'r', 'r'};
S.OutputLength = {2, 1};
S.AuxName = {};
S.AuxKind = {};
S.AuxLength = {};
S.ParameterName = {'B', 'D'};
S.ParameterKind = {};
S.ParameterLength = {12, 6};
S.xl = [-10000;-10000;-10000;-10000];
S.xu = [10000;10000;10000;10000];
S.ul = [-10000;-10000;-10000];
S.uu = [10000;10000;10000];
S.yl = [-10000;-10000;-10000];
S.yu = [10000;10000;10000];
S.wl = zeros(0,1);
S.wu = zeros(0,1);
S.j.xr = [1;2;3;4];
S.j.xb = [];
S.j.ur = [1;2;3];
S.j.ub = [];
S.j.yr = [1;2;3];
S.j.yb = [];
S.j.d = [];
S.j.z = [];
S.j.w_auto_bin = zeros(0,1);
S.j.eq = zeros(1,0);
S.j.ineq = [1 2 3 4 5 6 7 8 9 10 11 12 13 14];
S.J.X = 'rrrr';
S.J.U = 'rrr';
S.J.Y = 'rrr';
S.J.W = [];
S.nxb = 0;
S.nxr = 4;
S.nub = 0;
S.nur = 3;
S.nyb = 0;
S.nyr = 3;
S.nd = 0;
S.nz = 0;
S.nc = 14;
S.symtable = {struct('name', 'nx', 'orig_type', 'parameter', 'type', 'parameter', 'kind', 'real'), struct('name', 'nu', 'orig_type', 'parameter', 'type', 'parameter', 'kind', 'real'), struct('name', 'ny', 'orig_type', 'parameter', 'type', 'parameter', 'kind', 'real'), struct('name', 'A', 'orig_type', 'parameter', 'type', 'parameter', 'kind', 'real'), struct('name', 'C', 'orig_type', 'parameter', 'type', 'parameter', 'kind', 'real'), struct('name', 'B', 'orig_type', 'parameter', 'type', 'parameter', 'kind', 'real'), struct('name', 'D', 'orig_type', 'parameter', 'type', 'parameter', 'kind', 'real'), struct('name', 'xNo_Troom', 'orig_type', 'parameter', 'type', 'parameter', 'kind', 'real'), struct('name', 'x', 'orig_type', 'state', 'type', 'state', 'kind', 'real'), struct('name', 'u', 'orig_type', 'input', 'type', 'input', 'kind', 'real'), struct('name', 'y', 'orig_type', 'output', 'type', 'output', 'kind', 'real'), struct('name', 'TR', 'orig_type', 'output', 'type', 'output', 'kind', 'real')};
S.MLDisvalid = 1;
S.connections.variables = [];
S.connections.table = [];