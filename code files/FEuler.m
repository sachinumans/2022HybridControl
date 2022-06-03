function [T, x] = FEuler(x0, u, vars,option)
x = zeros(2, vars.t_end);
x(:, 1) = x0;
T = 1:vars.t_end;
T = T*vars.dt;
if option=="PWA"
for t = 2:vars.t_end
    x(:, t) = x(:, t-1) + vars.dt* modelPWA(t, x(:, t-1), u, vars, "");
end
elseif option=="MLD"
for t = 2:vars.t_end
    
    x(:, t) = x(:, t-1) + vars.dt* MLD(t, x(:, t-1), u, vars, "");
    
end
end
end
