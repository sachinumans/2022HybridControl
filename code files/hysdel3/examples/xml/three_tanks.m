S = [];
S.A = [1, 0, 0;
0, 1, 0;
0, 0, 1;
];
S.Bu = [10*h3_power_internal(Area, -1), 0, 0, 0;
0, 0, 0, 10*h3_power_internal(Area, -1);
0, 0, 0, 0;
];
S.Baux = [0, 0, 0, -9.36e-05*h3_power_internal(Area, -1)*sqrt(19.62*h3_power_internal((0.62+-1*hv), -1)), 0, -0.00061316895003769*h3_power_internal(Area, -1), 0, 0, 0, 0;
0, 0, 0, 0, -5.54e-05*h3_power_internal(Area, -1)*sqrt(19.62*h3_power_internal((0.62+-1*hv), -1)), 0, -0.000500098345489455*h3_power_internal(Area, -1), 0, 0, 0;
0, 0, 0, 9.36e-05*h3_power_internal(Area, -1)*sqrt(19.62*h3_power_internal((0.62+-1*hv), -1)), 5.54e-05*h3_power_internal(Area, -1)*sqrt(19.62*h3_power_internal((0.62+-1*hv), -1)), 0.00061316895003769*h3_power_internal(Area, -1), 0.000500098345489455*h3_power_internal(Area, -1), 0, 0, 0;
];
S.Baff = [0;
0;
0;
];
S.C = [0, 0, 1;
];
S.Du = [0, 0, 0, 0;
];
S.Daux = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0;
];
S.Daff = [0;
];
S.Ex = [-1, 0, 0;
1, 0, 0;
0, -1, 0;
0, 1, 0;
0, 0, -1;
0, 0, 1;
0, 0, 0;
0, 0, 0;
0, 0, 0;
0, 0, 0;
0, 0, 0;
0, 0, 0;
0, 0, 0;
0, 0, 0;
0, 0, 0;
0, 0, 0;
0, 0, 0;
0, 0, 0;
0, 0, 0;
0, 0, 0;
0, 0, 0;
0, 0, 0;
0, 0, 0;
0, 0, 0;
-1, 0, 0;
1, 0, 0;
0, -1, 0;
0, 1, 0;
0, 0, -1;
0, 0, 1;
0, 0, 0;
0, 0, 0;
0, 0, 0;
0, 0, 0;
1, 0, 0;
-1, 0, 0;
0, 0, 0;
0, 0, 0;
0, 1, 0;
0, -1, 0;
0, 0, 0;
0, 0, 0;
0, 0, 1;
0, 0, -1;
0, 0, 0;
0, 0, 0;
0, 0, 0;
0, 0, 0;
0, 0, 0;
0, 0, 0;
0, 0, 0;
0, 0, 0;
0, 0, 0;
0, 0, 0;
1, 0, -1;
-1, 0, 1;
0, 0, 0;
0, 0, 0;
0, 1, -1;
0, -1, 1;
0, 0, 0;
0, 0, 0;
-1, 0, 0;
1, 0, 0;
0, -1, 0;
0, 1, 0;
0, 0, -1;
0, 0, 1;
];
S.Eu = [0, 0, 0, 0;
0, 0, 0, 0;
0, 0, 0, 0;
0, 0, 0, 0;
0, 0, 0, 0;
0, 0, 0, 0;
-1, 0, 0, 0;
1, 0, 0, 0;
0, 0, 0, -1;
0, 0, 0, 1;
0, 0, 0, 0;
0, 0, 0, 0;
0, 0, 0, 0;
0, 0, 0, 0;
0, 0, 0, 0;
0, 0, 0, 0;
0, 0, 0, 0;
0, 0, 0, 0;
0, 0, 0, 0;
0, 0, 0, 0;
0, 0, 0, 0;
0, 0, 0, 0;
0, 0, 0, 0;
0, 0, 0, 0;
0, 0, 0, 0;
0, 0, 0, 0;
0, 0, 0, 0;
0, 0, 0, 0;
0, 0, 0, 0;
0, 0, 0, 0;
-1, 0, 0, 0;
1, 0, 0, 0;
0, 0, 0, -1;
0, 0, 0, 1;
0, 0, 0, 0;
0, 0, 0, 0;
0, 0, 0, 0;
0, 0, 0, 0;
0, 0, 0, 0;
0, 0, 0, 0;
0, 0, 0, 0;
0, 0, 0, 0;
0, 0, 0, 0;
0, 0, 0, 0;
0, 0, 0, 0;
0, 0, 0, 0;
0, 0, 30000, 0;
0, 0, 30000, 0;
0, 0, -10000, 0;
0, 0, -10000, 0;
0, 30000, 0, 0;
0, 30000, 0, 0;
0, -10000, 0, 0;
0, -10000, 0, 0;
0, 0, 10000.62, 0;
0, 0, 10000.62, 0;
0, 0, -10000, 0;
0, 0, -10000, 0;
0, 10000.62, 0, 0;
0, 10000.62, 0, 0;
0, -10000, 0, 0;
0, -10000, 0, 0;
0, 0, 0, 0;
0, 0, 0, 0;
0, 0, 0, 0;
0, 0, 0, 0;
0, 0, 0, 0;
0, 0, 0, 0;
];
S.Eaux = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0;
0, 0, 0, 0, 0, 0, 0, 0, 0, 0;
0, 0, 0, 0, 0, 0, 0, 0, 0, 0;
0, 0, 0, 0, 0, 0, 0, 0, 0, 0;
0, 0, 0, 0, 0, 0, 0, 0, 0, 0;
0, 0, 0, 0, 0, 0, 0, 0, 0, 0;
0, 0, 0, 0, 0, 0, 0, 0, 0, 0;
0, 0, 0, 0, 0, 0, 0, 0, 0, 0;
0, 0, 0, 0, 0, 0, 0, 0, 0, 0;
0, 0, 0, 0, 0, 0, 0, 0, 0, 0;
-1, 0, 0, 0, 0, 0, 0, 0, 0, 0;
1, 0, 0, 0, 0, 0, 0, 0, 0, 0;
0, -1, 0, 0, 0, 0, 0, 0, 0, 0;
0, 1, 0, 0, 0, 0, 0, 0, 0, 0;
0, 0, -1, 0, 0, 0, 0, 0, 0, 0;
0, 0, 1, 0, 0, 0, 0, 0, 0, 0;
0, 0, 0, -1, 0, 0, 0, 0, 0, 0;
0, 0, 0, 1, 0, 0, 0, 0, 0, 0;
0, 0, 0, 0, -1, 0, 0, 0, 0, 0;
0, 0, 0, 0, 1, 0, 0, 0, 0, 0;
0, 0, 0, 0, 0, -1, 0, 0, 0, 0;
0, 0, 0, 0, 0, 1, 0, 0, 0, 0;
0, 0, 0, 0, 0, 0, -1, 0, 0, 0;
0, 0, 0, 0, 0, 0, 1, 0, 0, 0;
0, 0, 0, 0, 0, 0, 0, 0, 0, 0;
0, 0, 0, 0, 0, 0, 0, 0, 0, 0;
0, 0, 0, 0, 0, 0, 0, 0, 0, 0;
0, 0, 0, 0, 0, 0, 0, 0, 0, 0;
0, 0, 0, 0, 0, 0, 0, 0, 0, 0;
0, 0, 0, 0, 0, 0, 0, 0, 0, 0;
0, 0, 0, 0, 0, 0, 0, 0, 0, 0;
0, 0, 0, 0, 0, 0, 0, 0, 0, 0;
0, 0, 0, 0, 0, 0, 0, 0, 0, 0;
0, 0, 0, 0, 0, 0, 0, 0, 0, 0;
-1, 0, 0, 0, 0, 0, 0, max( -9999.38+-1*hv,max( 9999.38+hv,max( 10000+-1*hv,-10000+hv ) ) ), 0, 0;
1, 0, 0, 0, 0, 0, 0, -1*max( -9999.38+-1*hv,max( 9999.38+hv,max( 10000+-1*hv,-10000+hv ) ) ), 0, 0;
-1, 0, 0, 0, 0, 0, 0, -10000, 0, 0;
1, 0, 0, 0, 0, 0, 0, -10000, 0, 0;
0, -1, 0, 0, 0, 0, 0, 0, max( -9999.38+-1*hv,max( 9999.38+hv,max( 10000+-1*hv,-10000+hv ) ) ), 0;
0, 1, 0, 0, 0, 0, 0, 0, -1*max( -9999.38+-1*hv,max( 9999.38+hv,max( 10000+-1*hv,-10000+hv ) ) ), 0;
0, -1, 0, 0, 0, 0, 0, 0, -10000, 0;
0, 1, 0, 0, 0, 0, 0, 0, -10000, 0;
0, 0, -1, 0, 0, 0, 0, 0, 0, max( -9999.38+-1*hv,max( 9999.38+hv,max( 10000+-1*hv,-10000+hv ) ) );
0, 0, 1, 0, 0, 0, 0, 0, 0, -1*max( -9999.38+-1*hv,max( 9999.38+hv,max( 10000+-1*hv,-10000+hv ) ) );
0, 0, -1, 0, 0, 0, 0, 0, 0, -10000;
0, 0, 1, 0, 0, 0, 0, 0, 0, -10000;
1, 0, -1, -1, 0, 0, 0, 0, 0, 0;
-1, 0, 1, 1, 0, 0, 0, 0, 0, 0;
0, 0, 0, -1, 0, 0, 0, 0, 0, 0;
0, 0, 0, 1, 0, 0, 0, 0, 0, 0;
0, 1, -1, 0, -1, 0, 0, 0, 0, 0;
0, -1, 1, 0, 1, 0, 0, 0, 0, 0;
0, 0, 0, 0, -1, 0, 0, 0, 0, 0;
0, 0, 0, 0, 1, 0, 0, 0, 0, 0;
0, 0, 0, 0, 0, -1, 0, 0, 0, 0;
0, 0, 0, 0, 0, 1, 0, 0, 0, 0;
0, 0, 0, 0, 0, -1, 0, 0, 0, 0;
0, 0, 0, 0, 0, 1, 0, 0, 0, 0;
0, 0, 0, 0, 0, 0, -1, 0, 0, 0;
0, 0, 0, 0, 0, 0, 1, 0, 0, 0;
0, 0, 0, 0, 0, 0, -1, 0, 0, 0;
0, 0, 0, 0, 0, 0, 1, 0, 0, 0;
0, 0, 0, 0, 0, 0, 0, max( -0.62+hv,max( 0.62+-1*hv,max( hv,-1*hv ) ) ), 0, 0;
0, 0, 0, 0, 0, 0, 0, -1e-06+max( -0.62+hv,max( 0.62+-1*hv,max( hv,-1*hv ) ) ), 0, 0;
0, 0, 0, 0, 0, 0, 0, 0, max( -0.62+hv,max( 0.62+-1*hv,max( hv,-1*hv ) ) ), 0;
0, 0, 0, 0, 0, 0, 0, 0, -1e-06+max( -0.62+hv,max( 0.62+-1*hv,max( hv,-1*hv ) ) ), 0;
0, 0, 0, 0, 0, 0, 0, 0, 0, max( -0.62+hv,max( 0.62+-1*hv,max( hv,-1*hv ) ) );
0, 0, 0, 0, 0, 0, 0, 0, 0, -1e-06+max( -0.62+hv,max( 0.62+-1*hv,max( hv,-1*hv ) ) );
];
S.Eaff = [0;
0.62;
0;
0.62;
0;
0.62;
0;
1;
0;
1;
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
10000;
0;
0.62;
0;
0.62;
0;
0.62;
0;
0.0001;
0;
0.0001;
hv+max( -9999.38+-1*hv,max( 9999.38+hv,max( 10000+-1*hv,-10000+hv ) ) );
-1*hv+-1*max( -9999.38+-1*hv,max( 9999.38+hv,max( 10000+-1*hv,-10000+hv ) ) );
0;
0;
hv+max( -9999.38+-1*hv,max( 9999.38+hv,max( 10000+-1*hv,-10000+hv ) ) );
-1*hv+-1*max( -9999.38+-1*hv,max( 9999.38+hv,max( 10000+-1*hv,-10000+hv ) ) );
0;
0;
hv+max( -9999.38+-1*hv,max( 9999.38+hv,max( 10000+-1*hv,-10000+hv ) ) );
-1*hv+-1*max( -9999.38+-1*hv,max( 9999.38+hv,max( 10000+-1*hv,-10000+hv ) ) );
0;
0;
30000;
30000;
0;
0;
30000;
30000;
0;
0;
10000.62;
10000.62;
0;
0;
10000.62;
10000.62;
0;
0;
-1*hv+max( -0.62+hv,max( 0.62+-1*hv,max( hv,-1*hv ) ) );
-1e-06+hv;
-1*hv+max( -0.62+hv,max( 0.62+-1*hv,max( hv,-1*hv ) ) );
-1e-06+hv;
-1*hv+max( -0.62+hv,max( 0.62+-1*hv,max( hv,-1*hv ) ) );
-1e-06+hv;
];
S.nu = 4;
S.nx = 3;
S.ny = 1;
S.nw = 10;
S.InputName = {'Q1', 'V2', 'V1', 'Q2'};
S.InputKind = {'r', 'b', 'b', 'r'};
S.InputLength = {1, 1, 1, 1};
S.StateName = {'h1', 'h2', 'h3'};
S.StateKind = {'r', 'r', 'r'};
S.StateLength = {1, 1, 1};
S.OutputName = {'y3'};
S.OutputKind = {'r'};
S.OutputLength = {1};
S.AuxName = {'z01', 'z02', 'z03', 'z1', 'z2', 'z13', 'z23', 'd01', 'd02', 'd03'};
S.AuxKind = {'r', 'r', 'r', 'r', 'r', 'r', 'r', 'b', 'b', 'b'};
S.AuxLength = {1, 1, 1, 1, 1, 1, 1, 1, 1, 1};
S.ParameterName = {'Area', 'hv'};
S.ParameterKind = {};
S.ParameterLength = {1, 1};
S.xl = [-0;-0;-0];
S.xu = [0.62;0.62;0.62];
S.ul = [-0;0;0;-0];
S.uu = [0.0001;1;1;0.0001];
S.yl = -10000;
S.yu = 10000;
S.wl = [-10000;-10000;-10000;-10000;-10000;-10000;-10000;0;0;0];
S.wu = [10000;10000;10000;10000;10000;10000;10000;1;1;1];
S.j.xr = [1;2;3];
S.j.xb = [];
S.j.ur = [1;4];
S.j.ub = [2;3];
S.j.yr = 1;
S.j.yb = [];
S.j.d = [8;9;10];
S.j.z = [1;2;3;4;5;6;7];
S.j.w_auto_bin = zeros(1,0);
S.j.eq = zeros(1,0);
S.j.ineq = [1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63 64 65 66 67 68];
S.J.X = 'rrr';
S.J.U = 'rbbr';
S.J.Y = 'r';
S.J.W = 'rrrrrrrbbb';
S.nxb = 0;
S.nxr = 3;
S.nub = 2;
S.nur = 2;
S.nyb = 0;
S.nyr = 1;
S.nd = 3;
S.nz = 7;
S.nc = 68;
S.symtable = {struct('name', 'Area', 'orig_type', 'parameter', 'type', 'parameter', 'kind', 'real'), struct('name', 'g', 'orig_type', 'parameter', 'type', 'parameter', 'kind', 'real'), struct('name', 's13', 'orig_type', 'parameter', 'type', 'parameter', 'kind', 'real'), struct('name', 's23', 'orig_type', 'parameter', 'type', 'parameter', 'kind', 'real'), struct('name', 's2', 'orig_type', 'parameter', 'type', 'parameter', 'kind', 'real'), struct('name', 's1', 'orig_type', 'parameter', 'type', 'parameter', 'kind', 'real'), struct('name', 'dT', 'orig_type', 'parameter', 'type', 'parameter', 'kind', 'real'), struct('name', 'hv', 'orig_type', 'parameter', 'type', 'parameter', 'kind', 'real'), struct('name', 'hmax', 'orig_type', 'parameter', 'type', 'parameter', 'kind', 'real'), struct('name', 'Q1max', 'orig_type', 'parameter', 'type', 'parameter', 'kind', 'real'), struct('name', 'Q2max', 'orig_type', 'parameter', 'type', 'parameter', 'kind', 'real'), struct('name', 'TdA', 'orig_type', 'parameter', 'type', 'parameter', 'kind', 'real'), struct('name', 'k1', 'orig_type', 'parameter', 'type', 'parameter', 'kind', 'real'), struct('name', 'k2', 'orig_type', 'parameter', 'type', 'parameter', 'kind', 'real'), struct('name', 'k13', 'orig_type', 'parameter', 'type', 'parameter', 'kind', 'real'), struct('name', 'k23', 'orig_type', 'parameter', 'type', 'parameter', 'kind', 'real'), struct('name', 'e', 'orig_type', 'parameter', 'type', 'parameter', 'kind', 'real'), struct('name', 'h1', 'orig_type', 'state', 'type', 'state', 'kind', 'real'), struct('name', 'h2', 'orig_type', 'state', 'type', 'state', 'kind', 'real'), struct('name', 'h3', 'orig_type', 'state', 'type', 'state', 'kind', 'real'), struct('name', 'Q1', 'orig_type', 'input', 'type', 'input', 'kind', 'real'), struct('name', 'V2', 'orig_type', 'input', 'type', 'input', 'kind', 'bool'), struct('name', 'V1', 'orig_type', 'input', 'type', 'input', 'kind', 'bool'), struct('name', 'Q2', 'orig_type', 'input', 'type', 'input', 'kind', 'real'), struct('name', 'y3', 'orig_type', 'output', 'type', 'output', 'kind', 'real'), struct('name', 'z01', 'orig_type', 'aux', 'type', 'aux', 'kind', 'real'), struct('name', 'z02', 'orig_type', 'aux', 'type', 'aux', 'kind', 'real'), struct('name', 'z03', 'orig_type', 'aux', 'type', 'aux', 'kind', 'real'), struct('name', 'z1', 'orig_type', 'aux', 'type', 'aux', 'kind', 'real'), struct('name', 'z2', 'orig_type', 'aux', 'type', 'aux', 'kind', 'real'), struct('name', 'z13', 'orig_type', 'aux', 'type', 'aux', 'kind', 'real'), struct('name', 'z23', 'orig_type', 'aux', 'type', 'aux', 'kind', 'real'), struct('name', 'd01', 'orig_type', 'aux', 'type', 'aux', 'kind', 'bool'), struct('name', 'd02', 'orig_type', 'aux', 'type', 'aux', 'kind', 'bool'), struct('name', 'd03', 'orig_type', 'aux', 'type', 'aux', 'kind', 'bool')};
S.MLDisvalid = 1;
S.connections.variables = [];
S.connections.table = [];
S.name = 'three_tanks';
