S = [];
S.A = [1+-21.7391304347826*q, 0, 0;
0, 4.6573611058094+-21.7391304347826*q, 0.342638894190599;
0, -0.368686177894264, 4.53607572686764;
];
S.Bu = [0;
0;
0.0952380952380952;
];
S.Baux = [0, -5;
0, 102.429031314018;
0, 0;
];
S.Baff = [21.7391304347826*cva*q;
4.34782608695652*tv*q;
0;
];
S.C = [1, 0, 0;
0, 1, 0;
0, 0, 1;
];
S.Du = [0;
0;
0;
];
S.Daux = [0, 0;
0, 0;
0, 0;
];
S.Daff = [0;
0;
0;
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
knek*exp(-0.00318471337579618*g), 3.80339973224066e-05*knek*g*exp(-0.00318471337579618*g), 0;
-1*knek*exp(-0.00318471337579618*g), -3.80339973224066e-05*knek*g*exp(-0.00318471337579618*g), 0;
knek*exp(-0.00305810397553517*g), 3.506999971944e-05*knek*g*exp(-0.00305810397553517*g), 0;
-1*knek*exp(-0.00305810397553517*g), -3.506999971944e-05*knek*g*exp(-0.00305810397553517*g), 0;
0, 1, 0;
0, -1, 0;
];
S.Eu = [0;
0;
0;
0;
0;
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
];
S.Eaux = [0, 0;
0, 0;
0, 0;
0, 0;
0, 0;
0, 0;
0, 0;
0, 0;
0, -1;
0, 1;
max([-10000+4.1*knek*exp(-0.00318471337579618*g)+0.000608543957158505*knek*g*exp(-0.00318471337579618*g),10000+-4.1*knek*exp(-0.00318471337579618*g)+-0.000608543957158505*knek*g*exp(-0.00318471337579618*g),10000+3.5*knek*exp(-0.00318471337579618*g)+-0.000152135989289627*knek*g*exp(-0.00318471337579618*g),-10000+-3.5*knek*exp(-0.00318471337579618*g)+0.000152135989289627*knek*g*exp(-0.00318471337579618*g)]), -1;
-1*min([-10000+4.1*knek*exp(-0.00318471337579618*g)+0.000608543957158505*knek*g*exp(-0.00318471337579618*g),10000+-4.1*knek*exp(-0.00318471337579618*g)+-0.000608543957158505*knek*g*exp(-0.00318471337579618*g),10000+3.5*knek*exp(-0.00318471337579618*g)+-0.000152135989289627*knek*g*exp(-0.00318471337579618*g),-10000+-3.5*knek*exp(-0.00318471337579618*g)+0.000152135989289627*knek*g*exp(-0.00318471337579618*g)]), 1;
-1*max([-10000+4.1*knek*exp(-0.00305810397553517*g)+0.000105209999158319*knek*g*exp(-0.00305810397553517*g),10000+-4.1*knek*exp(-0.00305810397553517*g)+-0.000105209999158319*knek*g*exp(-0.00305810397553517*g),10000+3.5*knek*exp(-0.00305810397553517*g)+-0.00059618999523048*knek*g*exp(-0.00305810397553517*g),-10000+-3.5*knek*exp(-0.00305810397553517*g)+0.00059618999523048*knek*g*exp(-0.00305810397553517*g)]), -1;
min([-10000+4.1*knek*exp(-0.00305810397553517*g)+0.000105209999158319*knek*g*exp(-0.00305810397553517*g),10000+-4.1*knek*exp(-0.00305810397553517*g)+-0.000105209999158319*knek*g*exp(-0.00305810397553517*g),10000+3.5*knek*exp(-0.00305810397553517*g)+-0.00059618999523048*knek*g*exp(-0.00305810397553517*g),-10000+-3.5*knek*exp(-0.00305810397553517*g)+0.00059618999523048*knek*g*exp(-0.00305810397553517*g)]), 1;
10, 0;
-10.00000001, 0;
];
S.Eaff = [-3.5;
4.1;
-310;
330;
-306;
320;
-275;
300;
10000;
10000;
0.0119426751592357*knek*g*exp(-0.00318471337579618*g)+max([-10000+4.1*knek*exp(-0.00318471337579618*g)+0.000608543957158505*knek*g*exp(-0.00318471337579618*g),10000+-4.1*knek*exp(-0.00318471337579618*g)+-0.000608543957158505*knek*g*exp(-0.00318471337579618*g),10000+3.5*knek*exp(-0.00318471337579618*g)+-0.000152135989289627*knek*g*exp(-0.00318471337579618*g),-10000+-3.5*knek*exp(-0.00318471337579618*g)+0.000152135989289627*knek*g*exp(-0.00318471337579618*g)]);
-0.0119426751592357*knek*g*exp(-0.00318471337579618*g)+-1*min([-10000+4.1*knek*exp(-0.00318471337579618*g)+0.000608543957158505*knek*g*exp(-0.00318471337579618*g),10000+-4.1*knek*exp(-0.00318471337579618*g)+-0.000608543957158505*knek*g*exp(-0.00318471337579618*g),10000+3.5*knek*exp(-0.00318471337579618*g)+-0.000152135989289627*knek*g*exp(-0.00318471337579618*g),-10000+-3.5*knek*exp(-0.00318471337579618*g)+0.000152135989289627*knek*g*exp(-0.00318471337579618*g)]);
0.00318471337579618*g+h3_additional_21;
0.0114678899082569*knek*g*exp(-0.00305810397553517*g);
-0.0114678899082569*knek*g*exp(-0.00305810397553517*g);
0.00305810397553517*g+h3_additional_27;
330;
-320.00000001;
];
S.nu = 1;
S.nx = 3;
S.ny = 3;
S.nw = 2;
S.InputName = {'tcv'};
S.InputKind = {'r'};
S.InputLength = {1};
S.StateName = {'ca', 't', 'tc'};
S.StateKind = {'r', 'r', 'r'};
S.StateLength = {1, 1, 1};
S.OutputName = {'y1', 'y2', 'y3'};
S.OutputKind = {'r', 'r', 'r'};
S.OutputLength = {1, 1, 1};
S.AuxName = {'d', 'z'};
S.AuxKind = {'b', 'r'};
S.AuxLength = {1, 1};
S.ParameterName = {'cva', 'tv', 'q', 'knek', 'g'};
S.ParameterKind = {};
S.ParameterLength = {1, 1, 1, 1, 1};
S.xl = [3.5;310;306];
S.xu = [4.1;330;320];
S.ul = 275;
S.uu = 300;
S.yl = [-10000;-10000;-10000];
S.yu = [10000;10000;10000];
S.wl = [0;-10000];
S.wu = [1;10000];
S.j.xr = [1;2;3];
S.j.xb = [];
S.j.ur = 1;
S.j.ub = [];
S.j.yr = [1;2;3];
S.j.yb = [];
S.j.d = 1;
S.j.z = 2;
S.j.w_auto_bin = zeros(1,0);
S.j.eq = zeros(1,0);
S.j.ineq = [1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16];
S.J.X = 'rrr';
S.J.U = 'r';
S.J.Y = 'rrr';
S.J.W = 'br';
S.nxb = 0;
S.nxr = 3;
S.nub = 0;
S.nur = 1;
S.nyb = 0;
S.nyr = 3;
S.nd = 1;
S.nz = 1;
S.nc = 18;
S.symtable = {struct('name', 'cva', 'orig_type', 'parameter', 'type', 'parameter', 'kind', 'real'), struct('name', 'tv', 'orig_type', 'parameter', 'type', 'parameter', 'kind', 'real'), struct('name', 'q', 'orig_type', 'parameter', 'type', 'parameter', 'kind', 'real'), struct('name', 'knek', 'orig_type', 'parameter', 'type', 'parameter', 'kind', 'real'), struct('name', 'g', 'orig_type', 'parameter', 'type', 'parameter', 'kind', 'real'), struct('name', 'qc', 'orig_type', 'parameter', 'type', 'parameter', 'kind', 'real'), struct('name', 'ro', 'orig_type', 'parameter', 'type', 'parameter', 'kind', 'real'), struct('name', 'roc', 'orig_type', 'parameter', 'type', 'parameter', 'kind', 'real'), struct('name', 'cp', 'orig_type', 'parameter', 'type', 'parameter', 'kind', 'real'), struct('name', 'cpc', 'orig_type', 'parameter', 'type', 'parameter', 'kind', 'real'), struct('name', 'V', 'orig_type', 'parameter', 'type', 'parameter', 'kind', 'real'), struct('name', 'Vc', 'orig_type', 'parameter', 'type', 'parameter', 'kind', 'real'), struct('name', 'A', 'orig_type', 'parameter', 'type', 'parameter', 'kind', 'real'), struct('name', 'k', 'orig_type', 'parameter', 'type', 'parameter', 'kind', 'real'), struct('name', 'rH', 'orig_type', 'parameter', 'type', 'parameter', 'kind', 'real'), struct('name', 'Ts', 'orig_type', 'parameter', 'type', 'parameter', 'kind', 'real'), struct('name', 'cas1', 'orig_type', 'parameter', 'type', 'parameter', 'kind', 'real'), struct('name', 'ts1', 'orig_type', 'parameter', 'type', 'parameter', 'kind', 'real'), struct('name', 'ts2', 'orig_type', 'parameter', 'type', 'parameter', 'kind', 'real'), struct('name', 'ca', 'orig_type', 'state', 'type', 'state', 'kind', 'real'), struct('name', 't', 'orig_type', 'state', 'type', 'state', 'kind', 'real'), struct('name', 'tc', 'orig_type', 'state', 'type', 'state', 'kind', 'real'), struct('name', 'tcv', 'orig_type', 'input', 'type', 'input', 'kind', 'real'), struct('name', 'y1', 'orig_type', 'output', 'type', 'output', 'kind', 'real'), struct('name', 'y2', 'orig_type', 'output', 'type', 'output', 'kind', 'real'), struct('name', 'y3', 'orig_type', 'output', 'type', 'output', 'kind', 'real'), struct('name', 'd', 'orig_type', 'aux', 'type', 'aux', 'kind', 'bool'), struct('name', 'z', 'orig_type', 'aux', 'type', 'aux', 'kind', 'real')};
S.MLDisvalid = 1;
S.connections.variables = [];
S.connections.table = [];