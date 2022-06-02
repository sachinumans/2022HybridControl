function [T, x] = FEuler(x0, u, vars)
x = zeros(2, vars.t_end);
x(:, 1) = x0;
T = 1:vars.t_end;
T = T*vars.dt;
for t = 2:vars.t_end
    x(:, t) = x(:, t-1) + vars.dt* modelPWA(t, x(:, t-1), u, vars, "");
end
end
