function [explMPC] = getexplMPCfun(vars, lambda, Np)
%% Unpack variables
alpha = vars.alpha;
beta = vars.beta;
b = vars.b;
c = vars.c;
gam = vars.gamma;
v_max = vars.v_max;
g = vars.g;
m = vars.m;
dt = vars.dt;
acomf = vars.a_comf;
v12 = vars.v12;
v23 = vars.v23;

%% Driving force
Fd = b./(1+gam.*g);

%% Friction approximation
k = beta/alpha;
q = (c*v_max^2 - beta)/(v_max - alpha);
r = beta - (c*v_max^2 - beta)/(v_max - alpha)*alpha;

%% Dynamics and systems
A1 = 1-dt*k/m; % v < alpha
A2 = 1-dt*q/m; % v >= alpha

f1 = 0;
f2 = -dt*r/m; % v >= alpha, constant

B = dt./m.*Fd; % Gears

C = 1;
D = 0;
g = 0;

sys1 = LTISystem('A', A1, 'B', B(1), 'C', C, 'D', D, 'f', f1, 'g', g, 'Ts', dt);
sys2 = LTISystem('A', A1, 'B', B(2), 'C', C, 'D', D, 'f', f1, 'g', g, 'Ts', dt);
sys5 = LTISystem('A', A2, 'B', B(2), 'C', C, 'D', D, 'f', f2, 'g', g, 'Ts', dt);
sys6 = LTISystem('A', A2, 'B', B(3), 'C', C, 'D', D, 'f', f2, 'g', g, 'Ts', dt);

%% Regions
X1 = Polyhedron([1;1;-1], [alpha-eps;v12-eps;0]);
X2 = Polyhedron([1;1;-1], [alpha-eps;v23-eps;-v12]);
X5 = Polyhedron([-1;1;-1], [-alpha;v23-eps;-v12]);
X6 = Polyhedron([-1;-1;1], [-alpha;-v23;v_max]);

% plot(X1, 'color', 'r', X2, 'color', 'b', X5, 'color', 'r', X6, 'color', 'b')

%% Link dynamics to regions
sys1.setDomain('x', X1);
sys2.setDomain('x', X2);
sys5.setDomain('x', X5);
sys6.setDomain('x', X6);

%% Construct system
sys = PWASystem([sys1, sys2, sys5, sys6]);

%% Add constraints
sys.x.min = 0;
sys.x.max = v_max;
sys.u.min = vars.u_min;
sys.u.max = vars.u_max;
sys.x.with('deltaMin');
sys.x.with('deltaMax');
sys.x.deltaMin = -acomf; % Comfortability constraint
sys.x.deltaMax = acomf;

sys.x.with('reference'); % The state is a tracking problem
sys.x.reference = 'free';

%% Determine cost
sys.u.penalty = OneNormFunction( lambda );
sys.x.penalty = OneNormFunction( 1 );

%% Make Explicit controller
implMPC = MPCController(sys, Np);

explMPC = implMPC.toExplicit(); % Make explicit
end