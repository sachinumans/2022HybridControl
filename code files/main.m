clc; close all; clear;
variables % Retrieve system parameters
fig = 1; % Figure number token
WorkingOn = "2.9"; % Token to prevent always plotting everything
%% Dynamics test
u = @(t) u_max + heaviside(t-100)*(-u_max + u_min) + heaviside(t-120)*(-u_min + u_max)...
    + heaviside(t-170)*(-u_max); % Input function
[t_0_1,y_0_1] = ode45(@(t,y) modelExact(t,y,u,vars, ""), [0 t_end*step], [0 0]); % Integration

if WorkingOn == "dyntest" || WorkingOn=="all"
figure(fig); fig = fig+1;
plot(t_0_1,y_0_1(:,2))
title 'ACC Car dynamics simulation'
xlabel 'time [s]'
ylabel 'speed [m/s]'
saveas(gcf,'Pics/Plot_2.1_1.jpg')

% figure(fig); fig = fig+1;
% plot(t_0_1, u(t_0_1))
% title 'ACC Car dynamics simulation input'
% xlabel 'time [s]'
% ylabel 'speed [m/s]'
% saveas(gcf,'Pics/Plot_2.1_2.jpg')
end

%% 2.1
v_max = ((b*u_max)/(c*(1+gamma*g(3))))^.5;
a_max = (b*u_max)/(1+gamma*g(1))/m;
a_min = (b*u_min)/(1+gamma*g(3))/m-c/m*v_max^2;

vars.v_max = v_max; % Make struct to pass to functions later
%% 2.2

[alpha, beta] = optApprox(vars);
vars.alpha = alpha; vars.beta = beta;

Vsamp = linspace(0, v_max, 200);
P_2 = fricApprox(Vsamp, vars);

if WorkingOn == "2.2" || WorkingOn=="all"
figure(fig); fig = fig+1;
plot(Vsamp, P_2); hold on
plot(Vsamp, c*Vsamp.^2); hold off
title 'PWA approximation of friction force'
ylabel 'Friction force [N]'
xlabel 'speed [m/s]'
saveas(gcf,'Pics/Plot_2.2.jpg')
end

%% 2.3
x0 = [0;0];
u = @(t) u_max/5 + u_max/2*sin(t/2/pi);
[t_3_1,y_3_1] = ode45(@(t,y) modelExact(t,y,u,vars, "gearlock"), [0 t_end*step], x0);
[t_3_2,y_3_2] = ode45(@(t,y) modelPWA(t,y,u,vars, "gearlock"), [0 t_end*step], x0);

if WorkingOn == "2.3" || WorkingOn=="all"
figure(fig); fig = fig+1;
plot(t_3_1,u(t_3_1));
title 'PWA approximation comparison input'
ylabel 'input'
xlabel 'time [s]'
% legend("Exact model", "PWA", 'Interpreter', 'latex')
saveas(gcf,'Pics/Plot_2.3_1.jpg')

figure(fig); fig = fig+1;
plot(t_3_1,y_3_1(:, 2)); hold on
plot(t_3_2,y_3_2(:, 2)); hold off
title 'PWA approximation comparison'
ylabel 'speed [m/s]'
xlabel 'time [s]'
legend("Exact model", "PWA", 'Interpreter', 'latex')
saveas(gcf,'Pics/Plot_2.3_2.jpg')

figure(fig); fig = fig+1;
plot(Vsamp, P_2); hold on
plot(Vsamp, c*Vsamp.^2);
plot(y_3_1(:, 2), t_3_1 .* P_2(end)/t_3_1(end));
plot(y_3_2(:, 2), t_3_2 .* P_2(end)/t_3_2(end)); hold off
% title 'PWA approximation comparison'
% ylabel 'speed [m/s]'
% xlabel 'time [s]'
% legend("Exact model", "PWA", 'Interpreter', 'latex')
saveas(gcf,'Pics/Plot_2.3_3.jpg')
end

%% 2.5
T = 1:t_end;
U = u(T*dt).*ones(size(T));

[t_5_1, y_5_1] = FEuler(x0, u, vars,"PWA");
[t_5_2, y_5_2] = ode45(@(t,y) modelPWA(t,y,u,vars, ""), [0 t_end*step], x0);

if WorkingOn == "2.5" || WorkingOn=="all"
% figure(fig); fig = fig+1;
% plot(t_5_2,u(t_5_2)); hold on
% plot(T*dt,U, "--");hold off
% title 'Integration comparison input'
% ylabel 'input'
% xlabel 'time [s]'
% legend("ODE45", "FE", 'Interpreter', 'latex')
% saveas(gcf,'Pics/Plot_2.3_2.jpg')

figure(fig); fig = fig+1;
plot(t_5_2,y_5_2(:, 2)); hold on
plot(t_5_1,y_5_1(2, :), "--"); hold off
title 'Integration comparison'
ylabel 'speed [m/s]'
xlabel 'time [s]'
legend("ODE45", "FE", 'Interpreter', 'latex')
% saveas(gcf,'Pics/Plot_2.3_2.jpg')
% close all
% u_new = u(0:dt:t_end);
% % V=FEuler(t_end,u,dt);

end
%% 2.7
% [t_6, y_6] = FEuler(x0, U, vars,"MLD");

x0 = 52;
Np = 10; % Prediction horizon
Nc = 7; % Control horizon
lambda = 0.3;

sys = MLD(vars);
sys.dt = dt;
sys.a_comf = 2.5;
[F, b1, Neq, Nleq] = optContstraint(sys, Np, Nc); % All time invariant 
                                %constraints regarding v, u, delta, z

vRef = 20 *ones(Np, 1);
[C, M, b2] = costFunc(sys, vRef, Np, lambda);

K = [[F, zeros(size(F,1),2*Np)];...
    M];

L = [b1; b2];

if WorkingOn == "2.7" || WorkingOn=="all"
    [u_2_7, ~] = getOptInput(x0, vRef, sys, K, L, C, Np, Neq, Nleq, "plot"); fig = fig+1;
end

%% 2.8
A = sys.A;
B1 = sys.B1; B2 = sys.B2; B3 = sys.B3; 
E1 = sys.E1; E2 = sys.E2; E3 = sys.E3; E4 = sys.E4; 
g5 = sys.g5;

H = [A B1 B2 B3];
nx = size(A, 1);
nu = size(B1, 2);
n = size(H, 2);

T = 50;
x0 = 55;
vRef = 5 *ones(T+Np, 1);

Np = 10; % Prediction horizon
Nc = 7; % Control horizon
lambda = 0.3;

[F, b1, Neq, Nleq] = optContstraint(sys, Np, Nc); % All time invariant 
                                %constraints regarding v, u, delta, z

u_2_8 = zeros(T, nu);
x_2_8 = [x0; zeros(T-1, nx)];
for k = 1:T
vRef_k = vRef(k:k+Np-1);
[C, M, b2] = costFunc(sys, vRef_k, Np, lambda);

K = [[F, zeros(size(F,1),2*Np)];...
    M];

L = [b1; b2];

[u_2_8(k, :), ~] = getOptInput(x_2_8(k, :), vRef_k, sys, K, L, C, Np, Neq, Nleq, "");
x_2_8(k+1, :) = x_2_8(k, :) + modelExact(k*dt, [0;x_2_8(k, :)], u_2_8(k, :)...
        , vars, "SingleState");
end

if WorkingOn == "2.8" || WorkingOn=="all"
    figure(fig); fig = fig+1;
    subplot(2, 1, 1)
    plot(x_2_8);
    title("Velocities")
    
    subplot(2, 1, 2)
    plot(u_2_8);
    title("Input")
end

%% 2.9
T = 25/dt;
x0 = 0.9*alpha;

Tarr = 0:dt:25;
N = max(size(Tarr));
vRef = zeros(N,nx);
for k = 1:N
    vRef(k) = vref(alpha, Tarr(k));
end
vRef = [vRef; vRef(end)*ones(Np,nx)];

lambda = 0.1;
Np = 5; % Prediction horizon
Nc = 4; % Control horizon

[F, b1, Neq, Nleq] = optContstraint(sys, Np, Nc); % All time invariant 
                                %constraints regarding v, u, delta, z

u_2_9 = zeros(N, nu);
x_2_9 = [x0; zeros(N-1, nx)];
for k = 1:N
vRef_k = vRef(k:k+Np-1);
[C, M, b2] = costFunc(sys, vRef_k, Np, lambda);

K = [[F, zeros(size(F,1),2*Np)];...
    M];

L = [b1; b2];

[u_2_9(k, :), ~] = getOptInput(x_2_9(k, :), vRef_k, sys, K, L, C, Np, Neq, Nleq, "");
x_2_9(k+1, :) = x_2_9(k, :) + modelExact(k*dt, [0;x_2_9(k, :)], u_2_9(k, :)...
        , vars, "SingleState");
end

if WorkingOn == "2.9" || WorkingOn=="all"
    fig = plot2_9(0, x_2_9, u_2_9, vRef(1:N), sys.a_comf, Tarr, dt, fig, Np, Nc);
end

% Second Np, Nc combo
Np = 10; % Prediction horizon
Nc = 9; % Control horizon

vRef = zeros(N,nx);
for k = 1:N
    vRef(k) = vref(alpha, Tarr(k));
end
vRef = [vRef; vRef(end)*ones(Np,nx)];

[F, b1, Neq, Nleq] = optContstraint(sys, Np, Nc); % All time invariant 
                                %constraints regarding v, u, delta, z

u_2_9b = zeros(N, nu);
x_2_9b = [x0; zeros(N-1, nx)];
for k = 1:N
vRef_k = vRef(k:k+Np-1);
[C, M, b2] = costFunc(sys, vRef_k, Np, lambda);

K = [[F, zeros(size(F,1),2*Np)];...
    M];

L = [b1; b2];

[u_2_9b(k, :), ~] = getOptInput(x_2_9b(k, :), vRef_k, sys, K, L, C, Np, Neq, Nleq, "");
x_2_9b(k+1, :) = x_2_9b(k, :) + modelExact(k*dt, [0;x_2_9b(k, :)], u_2_9b(k, :)...
        , vars, "SingleState");
end

if WorkingOn == "2.9" || WorkingOn=="all"
    fig = plot2_9(0, x_2_9b, u_2_9b, vRef(1:N), sys.a_comf, Tarr, dt, fig, Np, Nc);
end

%% 2.10


