clc; close all; clear;
%% Trying to understand MLD constraints
variables
v_max = ((b*u_max)/(c*(1+gamma*g(3))))^.5;
a_max = (b*u_max)/(1+gamma*g(1))/m;
a_min = (b*u_min)/(1+gamma*g(3))/m-c/m*v_max^2;

vars.v_max = v_max; % Make struct to pass to functions later
[alpha, beta] = optApprox(vars);
vars.alpha = alpha; vars.beta = beta;


% delta P and constraints
x = linspace(0, v_max, 100);
delP = 0;

c1 = (-x + alpha) <= (alpha*(1- delP));
c2 = (-x + alpha) >= (eps + (-v_max+ alpha- eps)*delP);

figure(); hold on
plot(x, c1)
plot(x, c2, "--")
hold off

% z_p and constraints
z_p = (x >= alpha).*x ;

figure(); hold on
plot(x, z_p)
plot(x, x-v_max*(1-delP), "--")
plot(x, x, "--")
hold off