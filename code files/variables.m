m = 800;
c = 0.4;
b = 3700;
u_max = 1.3;
u_min = -1.3;
alphamax = 2.5;
gamma = 0.87;
v12 = 15;
v23 = 30;

g = [1,2,3];
step=.1;
t_end = 3*10^3;

% Make struct to pass to functions later
vars.m = m; 
vars.c = c;
vars.b = b;
vars.u_max = u_max;
vars.u_min = u_min;
vars.gamma = gamma;
vars.v12 = v12;
vars.v23 = v23;
vars.g = g;
vars.t_end = t_end;

dt = 0.15;