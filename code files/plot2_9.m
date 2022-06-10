function [fig] = plot2_9(x0, v, u, vRef, aComf, t, dt, fig, Np, Nc)
%PLOT2_9 Plot all of the plots asked for in Q2.9

N = max(size(t));
%% Integrate v to obtain x
% x+ = x + dt*v
dx = dt.*v;
dxRef = dt.*vRef;
x = [x0; zeros(N-1, 1)];
xRef = [x0; zeros(N-1, 1)];
for k = 1:N
    x(k+1) = x(k) + dx(k);
    xRef(k+1) = x(k) + dxRef(k);
end
x = x(1:end-1);
xRef = xRef(1:end-1);
v = v(1:end-1);

%% Plot phase plane
figure(fig); fig = fig+1; hold on
plot(x, v)
plot(xRef, vRef, "--")
xlabel("Position")
ylabel("Velocity")
title("(x, v) phase plane, Np = " + Np + ", Nc = " + Nc)
hold off

%% Plot x
figure(fig); fig = fig+1; hold on
plot(t, x)
plot(t, xRef, "--")
xlabel("Time")
ylabel("Position")
title("Position evolution, Np = " + Np + ", Nc = " + Nc)
hold off

%% Plot v
figure(fig); fig = fig+1; hold on
plot(t, v)
plot(t, vRef, "--")
xlabel("Time")
ylabel("Velocity")
title("Velocity evolution, Np = " + Np + ", Nc = " + Nc)
hold off

%% Plot acceleration
a = diff(v);
aRef = diff(vRef);
figure(fig); fig = fig+1; hold on
plot(t(2:end), a)
plot(t(2:end), aRef, "--")
yline(aComf, "k")
yline(-aComf, "k")
xlabel("Time")
ylabel("Acceleration")
title("Acceleration evolution, Np = " + Np + ", Nc = " + Nc)
hold off

%% Plot reference residual
figure(fig); fig = fig+1; hold on
plot(t, v-vRef)
xlabel("Time")
ylabel("Velocity residual")
title("Residual evolution, Np = " + Np + ", Nc = " + Nc)
hold off

%% Plot input
figure(fig); fig = fig+1; hold on
plot(t, u)
xlabel("Time")
ylabel("Input")
title("Input evolution, Np = " + Np + ", Nc = " + Nc)
hold off

%% Plot diff u
figure(fig); fig = fig+1; hold on
plot(t(2:end), diff(u))
xlabel("Time")
ylabel("$\Delta u$", Interpreter = 'latex')
title("Input time derivative evolution, Np = " + Np + ", Nc = " + Nc)
hold off
end

