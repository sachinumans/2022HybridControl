% Define all system paramaters as specified in the assignment
m = 800; % mass
c = 0.4; % friction constant
b = 3700; % driving constant
u_max = 1.3; % Maximum input
u_min = -1.3; % Minimum input
alphamax = 2.5; % Maximum acceleration
gamma = 0.87; % Gear constant
v12 = 15; % gear 2 switch
v23 = 30; % gear 3 switch 

g = [1,2,3]; % gears
step=.1; % time step size
t_end = 3*10^3; % simulation time
dt = 0.15; % time step size for integration

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
vars.dt = dt;
vars.a_comf = 2.5;

