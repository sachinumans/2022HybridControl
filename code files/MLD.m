function [sys] = MLD(vars)
%MLD Returns a struct with all of the MLD matrices

%% Unpack variables
dt = vars.dt;
m = vars.m;
a = vars.alpha;
uv = vars.v_max;
uu = vars.u_max;
lu = vars.u_min;
v12 = vars.v12;
v23 = vars.v23;
k = vars.beta/vars.alpha;
q = (vars.c*vars.v_max^2 - vars.beta)/(vars.v_max - vars.alpha);
r = vars.beta - q*vars.alpha;

%% Driving force
Fd = vars.b./(1+vars.gamma.*vars.g);

%% Define matrices
sys.A = 1 - dt*k/m;
sys.B1 = dt*Fd(1)/m;
sys.B2 = [0, 0, -dt*r/m];
sys.B3 = dt/m * [Fd(2)-Fd(1), Fd(3)-Fd(2), k-q];

sys.E1 = zeros(22, 1);
sys.E1([1 6 10 12 18]) = 1;
sys.E1([2 5 9 11 17]) = -1;

sys.E2 = zeros(22, 1);
sys.E2([3 16 22]) = 1;
sys.E2([4 15 21]) = -1;

sys.E3 = zeros(22, 3);
sys.E3(5:10, 3) = [a; -uv+a-eps; -uv; 0; 0; uv];
sys.E3(11:16, 1) = [v12; -uv+v12-eps; -uu; lu; -lu; uu];
sys.E3(17:22, 2) = [v23; -uv+v23-eps; -uu; lu; -lu; uu];

sys.E4 = zeros(22, 3);
sys.E4(7:10, 3) = [1; -1; 1; -1];
sys.E4(13:16, 1) = [1; -1; 1; -1];
sys.E4(19:22, 2) = [1; -1; 1; -1];

sys.g5 = zeros(22, 1);
sys.g5([1 10]) = uv;
sys.g5([3 16 22]) = uu;
sys.g5([4 15 21]) = -lu;
sys.g5(6) = a - eps;
sys.g5(12) = v12 - eps;
sys.g5(18) = v23 - eps;
end
