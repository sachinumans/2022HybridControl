clc; close all; clear; tStart = tic;
variables % Retrieve system parameters
fig = 1; % Figure number token
WorkingOn = "all"; % Token to prevent always plotting everything
%% Dynamics test
u = @(t) u_max + heaviside(t-100)*(-u_max + u_min) + heaviside(t-120)*(-u_min + u_max)...
    + heaviside(t-170)*(-u_max); % Input function
[t_0_1,y_0_1] = ode45(@(t,y) modelExact(t,y,u,vars, "")...
    , [0 t_end*step], [0 0]); % Integration of the exact model

% Plotting
if WorkingOn == "dyntest" || WorkingOn=="all"
figure(fig); fig = fig+1;
plot(t_0_1,y_0_1(:,2))
title 'ACC Car dynamics simulation'
xlabel 'time [s]'
ylabel 'speed [m/s]'
saveas(gcf,'Pics/Plot_2.1_1.jpg')

figure(fig); fig = fig+1;
plot(t_0_1, u(t_0_1))
title 'ACC Car dynamics simulation input'
xlabel 'time [s]'
ylabel 'speed [m/s]'
saveas(gcf,'Pics/Plot_2.1_2.jpg')
end

%% 2.1
v_max = ((b*u_max)/(c*(1+gamma*g(3))))^.5; % Maximum speed
a_max = (b*u_max)/(1+gamma*g(1))/m; % Maximum acceleration
a_min = (b*u_min)/(1+gamma*g(3))/m-c/m*v_max^2; % Minimum acceleration

vars.v_max = v_max; % Make struct to pass to functions later
%% 2.2

[alpha, beta] = optApprox(vars); % Determine optimal values for alpha and beta
vars.alpha = alpha; vars.beta = beta;

Vsamp = linspace(0, v_max, 200); % Speed samples
P_2 = fricApprox(Vsamp, vars); % Friction approximation

% Plotting
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
x0 = [0;0]; % Initial state
u = @(t) u_max/5 + u_max/2*sin(t/2/pi); % Input sinusoid
[t_3_1,y_3_1] = ode45(@(t,y) modelExact(t,y,u,vars, "gearlock")...
    , [0 t_end*step], x0); % Integrate exact model
[t_3_2,y_3_2] = ode45(@(t,y) modelPWA(t,y,u,vars, "gearlock")...
    , [0 t_end*step], x0); % Integrate PWA model

% Plotting
if WorkingOn == "2.3" || WorkingOn=="all"
    fig = plot2_3(t_3_1,t_3_2, u, y_3_1,y_3_2, Vsamp, P_2, vars, fig);
end

%% 2.5
T = 1:t_end; % Define time vector
U = u(T*dt).*ones(size(T)); % Define input

[t_5_1, y_5_1] = FEuler(x0, u, vars); % Forward Euler integration of
                                            % the PWA model
[t_5_2, y_5_2] = ode45(@(t,y) modelPWA(t,y,u,vars, "")...
    , [0 t_end*dt], x0); % ode45 integration of PWA model

% Plotting
if WorkingOn == "2.5" || WorkingOn=="all"
figure(fig); fig = fig+1;
plot(t_5_2,u(t_5_2)); hold on
plot(T*dt,U, "--");hold off
title 'Integration comparison input'
ylabel 'input'
xlabel 'time [s]'
legend("u(t)", 'Interpreter', 'latex')
saveas(gcf,'Pics/Plot_2.5_1.jpg')

figure(fig); fig = fig+1;
plot(t_5_2,y_5_2(:, 2)); hold on
plot(t_5_1,y_5_1(2, :), "--"); hold off
title 'Integration comparison'
ylabel 'speed [m/s]'
xlabel 'time [s]'
legend("ODE45", "FE", 'Interpreter', 'latex')
saveas(gcf,'Pics/Plot_2.5_2.jpg')
end

%% 2.6
sys = MLD(vars); % Create MLD model struct
% Unpack system
A = sys.A;
B1 = sys.B1; B2 = sys.B2; B3 = sys.B3; 
E1 = sys.E1; E2 = sys.E2; E3 = sys.E3; E4 = sys.E4; 
g5 = sys.g5;

H = [A B1 B2 B3];
nx = size(A, 1);
nu = size(B1, 2);
n = size(H, 2);

A = [[1 zeros(1, n-1)];... % v and u are as predefined
     [0 1 zeros(1, n-2)];...
     [E1 E2 E3 E4]]; % state is valid
C = [1 zeros(1, n-1)]; % Minimise the speed
ctype = ['SS', repmat('U', 1,size(E1,1))]; % Two equalities, rest upper bounds
vartype = 'CCBBBCCC'; % State either Continuous or Binary

V = 1:v_max; % Sample speeds
figure(fig); fig = fig+1; 
subplot(2,2, 1:2); hold on
for u = u_min:0.2:u_max
    u_ = @(t) u*t/t;
    d = [];
    for v = V
        %MLD model
        b = [v; u; g5];
        [xMLD,~,status,~] = glpk (C,A,b,[],[],ctype,vartype);

        xPmld = H*xMLD;

        xPfe = [0;v] + vars.dt* modelPWA(1, [0;v], u_, vars, "");
        
        d = [d xPmld - xPfe(2)];
    end
    plot(V, d)
end
xlabel("Speed")
ylabel("$v_{MLD} - v_{PWA}$", 'Interpreter', 'latex')

subplot(2,2, 3); hold on
V = 14.5:0.05:15.5; % Sample speeds
for u = u_min:0.2:u_max
    u_ = @(t) u*t/t;
    d = [];
    for v = V
        %MLD model
        b = [v; u; g5];
        [xMLD,~,status,~] = glpk (C,A,b,[],[],ctype,vartype);

        xPmld = H*xMLD;

        xPfe = [0;v] + vars.dt* modelPWA(1, [0;v], u_, vars, "");
        
        d = [d xPmld - xPfe(2)];
    end
    plot(V, d, "x-")
end
xlabel("Speed")
ylabel("$v_{MLD} - v_{PWA}$", 'Interpreter', 'latex')

subplot(2,2, 4); hold on
V = 29.5:0.05:30.5; % Sample speeds
for u = u_min:0.2:u_max
    u_ = @(t) u*t/t;
    d = [];
    for v = V
        %MLD model
        b = [v; u; g5];
        [xMLD,~,status,~] = glpk (C,A,b,[],[],ctype,vartype);

        xPmld = H*xMLD;

        xPfe = [0;v] + vars.dt* modelPWA(1, [0;v], u_, vars, "");
        
        d = [d xPmld - xPfe(2)];
    end
    plot(V, d, "x-")
end
xlabel("Speed")
ylabel("$v_{MLD} - v_{PWA}$", 'Interpreter', 'latex')



%% 2.7
% From here on the state x only consists of the speed v
x0 = 52; % Initial velocity
Np = 10; % Prediction horizon
Nc = 7; % Control horizon
lambda = 0.3; % Cost function lambda

sys = MLD(vars); % Create MLD model struct
sys.dt = dt;
sys.a_comf = 2.5; % Comfortability threshold
[F, b1, Neq, Nleq] = optContstraint(sys, Np, Nc); % All time invariant 
                                %constraints regarding v, u, delta, z

vRef = 20 *ones(Np, 1); % Constant reference speed
[C, M, b2] = costFunc(sys, vRef, Np, lambda); % Get cost function and 
                    % additional constraints for the auxilliary states
                    % originating from the norms

K = [[F, zeros(size(F,1),2*Np)];... % Compile constraints matrix
            M];

L = [b1; b2]; % Compile constraints vector

if WorkingOn == "2.7" || WorkingOn=="all"
    % Perform MPC and retrieve optimal input
    [u_2_7, ~] = getOptInput(x0, vRef, sys, K, L, C, Np, Neq, Nleq, "plot"); 
    fig = fig+1;
end

%% 2.8
T = 50; % Define number of timesteps
x0 = 55; % Inital state
vRef = 5 *ones(T+Np, 1); % Constant reference

Np = 10; % Prediction horizon
Nc = 7; % Control horizon
lambda = 0.3; % Cost function lambda

[F, b1, Neq, Nleq] = optContstraint(sys, Np, Nc); % Retrieve all time 
                        % invariant constraints regarding v, u, delta, z

u_2_8 = zeros(T, nu);
x_2_8 = [x0; zeros(T-1, nx)];
for k = 1:T
vRef_k = vRef(k:k+Np-1); % Get reference at time k
[C, M, b2] = costFunc(sys, vRef_k, Np, lambda); % Get cost function

K = [[F, zeros(size(F,1),2*Np)];...
    M]; % Compile constraints matrix

L = [b1; b2]; % Compile constraints vector

[u_2_8(k, :), ~] = getOptInput(x_2_8(k, :), vRef_k, sys, K, L, C...
    , Np, Neq, Nleq, ""); % Get optimal input
x_2_8(k+1, :) = x_2_8(k, :) + modelExact(k*dt, [0;x_2_8(k, :)]...
    , u_2_8(k, :), vars, "SingleState"); % Integrate timestep with input
end

% Plotting
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
x0 = 0.9*alpha; % Define initial state

Tarr = 0:dt:25; % Create time array
N = max(size(Tarr)); % Number of timesteps

vRef = zeros(N,nx); % Create reference speed array
for k = 1:N
    vRef(k) = vref(alpha, Tarr(k));
end
vRef = [vRef; vRef(end)*ones(Np,nx)];

lambda = 0.1; % Prediction horizon
Np = 5; % Prediction horizon
Nc = 4; % Control horizon

[F, b1, Neq, Nleq] = optContstraint(sys, Np, Nc); % All time invariant 
                                %constraints regarding v, u, delta, z

u_2_9 = zeros(N, nu);
x_2_9 = [x0; zeros(N-1, nx)];
for k = 1:N % Same loop as in 2.8
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

% Second Np, Nc combo, exactly the same as above otherwise
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

% Create explicit formulas
Np = 2;
explMPC2 = getexplMPCfun(vars, lambda, Np);

Np = 3;
explMPC3 = getexplMPCfun(vars, lambda, Np);

Np = 4;
explMPC4 = getexplMPCfun(vars, lambda, Np);

% Runtime counters
toc2 = 0; toc2i = 0; toc3 = 0; toc3i = 0; toc4 = 0; toc4i = 0;

for idx = 1:30
% Simulate with horizon 2
Np = 2;
vRef = zeros(N,nx);
for k = 1:N
    vRef(k) = vref(alpha, Tarr(k));
end
vRef = [vRef; vRef(end)*ones(Np,nx)];

u_2_10a = zeros(N, nu);
x_2_10a = [x0; zeros(N-1, nx)];
tic
for k = 1:N
    u_2_10a(k) = explMPC2.evaluate(x_2_10a(k, :), 'x.reference', vRef(k));
    x_2_10a(k+1, :) = x_2_10a(k, :) + modelExact(k*dt, [0;x_2_10a(k, :)], u_2_10a(k, :)...
        , vars, "SingleState");
end
toc2 = toc2 + toc;

% Implicit method
Np = 2; % Prediction horizon
Nc = 2; % Control horizon

vRef = zeros(N,nx);
for k = 1:N
    vRef(k) = vref(alpha, Tarr(k));
end
vRef = [vRef; vRef(end)*ones(Np,nx)];

[F, b1, Neq, Nleq] = optContstraint(sys, Np, Nc); % All time invariant 
                                %constraints regarding v, u, delta, z

u_2_10ai = zeros(N, nu);
x_2_10ai = [x0; zeros(N-1, nx)];
tic
for k = 1:N
vRef_k = vRef(k:k+Np-1);
[C, M, b2] = costFunc(sys, vRef_k, Np, lambda);

K = [[F, zeros(size(F,1),2*Np)];...
    M];

L = [b1; b2];

[u_2_10ai(k, :), ~] = getOptInput(x_2_10ai(k, :), vRef_k, sys, K, L, C, Np, Neq, Nleq, "");
x_2_10ai(k+1, :) = x_2_10ai(k, :) + modelExact(k*dt, [0;x_2_10ai(k, :)], u_2_10ai(k, :)...
        , vars, "SingleState");
end
toc2i = toc2i + toc;


% Simulate with horizon 3
Np = 3;
vRef = zeros(N,nx);
for k = 1:N
    vRef(k) = vref(alpha, Tarr(k));
end
vRef = [vRef; vRef(end)*ones(Np,nx)];

u_2_10b = zeros(N, nu);
x_2_10b = [x0; zeros(N-1, nx)];
tic
for k = 1:N
    u_2_10b(k) = explMPC3.evaluate(x_2_10b(k, :), 'x.reference', vRef(k));
    x_2_10b(k+1, :) = x_2_10b(k, :) + modelExact(k*dt, [0;x_2_10b(k, :)], u_2_10b(k, :)...
        , vars, "SingleState");
end
toc3 = toc3 + toc;


% Implicit method
Np = 3; % Prediction horizon
Nc = 3; % Control horizon

vRef = zeros(N,nx);
for k = 1:N
    vRef(k) = vref(alpha, Tarr(k));
end
vRef = [vRef; vRef(end)*ones(Np,nx)];

[F, b1, Neq, Nleq] = optContstraint(sys, Np, Nc); % All time invariant 
                                %constraints regarding v, u, delta, z

u_2_10bi = zeros(N, nu);
x_2_10bi = [x0; zeros(N-1, nx)];
tic
for k = 1:N
vRef_k = vRef(k:k+Np-1);
[C, M, b2] = costFunc(sys, vRef_k, Np, lambda);

K = [[F, zeros(size(F,1),2*Np)];...
    M];

L = [b1; b2];

[u_2_10bi(k, :), ~] = getOptInput(x_2_10bi(k, :), vRef_k, sys, K, L, C, Np, Neq, Nleq, "");
x_2_10bi(k+1, :) = x_2_10bi(k, :) + modelExact(k*dt, [0;x_2_10bi(k, :)], u_2_10bi(k, :)...
        , vars, "SingleState");
end
toc3i = toc3i + toc;


% Simulate with horizon 4
Np = 4;
vRef = zeros(N,nx);
for k = 1:N
    vRef(k) = vref(alpha, Tarr(k));
end
vRef = [vRef; vRef(end)*ones(Np,nx)];

u_2_10c = zeros(N, nu);
x_2_10c = [x0; zeros(N-1, nx)];
tic
for k = 1:N
    u_2_10c(k) = explMPC4.evaluate(x_2_10c(k, :), 'x.reference', vRef(k));
    x_2_10c(k+1, :) = x_2_10c(k, :) + modelExact(k*dt, [0;x_2_10c(k, :)], u_2_10c(k, :)...
        , vars, "SingleState");
end
toc4 = toc4 + toc;


% Implicit method
Np = 4; % Prediction horizon
Nc = 4; % Control horizon

vRef = zeros(N,nx);
for k = 1:N
    vRef(k) = vref(alpha, Tarr(k));
end
vRef = [vRef; vRef(end)*ones(Np,nx)];

[F, b1, Neq, Nleq] = optContstraint(sys, Np, Nc); % All time invariant 
                                %constraints regarding v, u, delta, z

u_2_10ci = zeros(N, nu);
x_2_10ci = [x0; zeros(N-1, nx)];
tic
for k = 1:N
vRef_k = vRef(k:k+Np-1);
[C, M, b2] = costFunc(sys, vRef_k, Np, lambda);

K = [[F, zeros(size(F,1),2*Np)];...
    M];

L = [b1; b2];

[u_2_10ci(k, :), ~] = getOptInput(x_2_10ci(k, :), vRef_k, sys, K, L, C, Np, Neq, Nleq, "");
x_2_10ci(k+1, :) = x_2_10ci(k, :) + modelExact(k*dt, [0;x_2_10ci(k, :)], u_2_10ci(k, :)...
        , vars, "SingleState");
end
toc4i = toc4i + toc;
end

% Average runtimes
toc2 = toc2/idx;
toc2i = toc2i/idx;
toc3 = toc3/idx;
toc3i = toc3i/idx;
toc4 = toc4/idx;
toc4i = toc4i/idx;

if WorkingOn == "2.10" || WorkingOn=="all"
figure(fig); fig = fig+1; hold on
plot([2 3 4], [toc2 toc3 toc4], "o-");
plot([2 3 4], [toc2i toc3i toc4i], "o-");
xlabel("$N_p$", 'Interpreter', 'latex')
ylabel("Runtime [s]")
title("Mean runtimes, N=30")
legend("Explicit", "Implicit")
end

tEnd = toc(tStart) 