function [T, x] = FEuler(x0, u, vars)
%FEULER Forward Euler integration with initial condition x0 and input u

%% Initialisation
x = zeros(2, vars.t_end);
x(:, 1) = x0;
T = 1:vars.t_end;
T = T*vars.dt;

%% Integration
for t = 2:vars.t_end
    x(:, t) = x(:, t-1) + vars.dt* modelPWA(t*vars.dt, x(:, t-1), u, vars, "");
end

end
