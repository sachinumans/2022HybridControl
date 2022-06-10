function [dx] = modelExact(t, y, u, vars, mode)
%MODELEXACT The exact differential equations

%% Determine u (either a function or a double)
if convertCharsToStrings(class(u)) == "function_handle"
    ut = u(t);
else
    ut = u;
end

%% Determine the gear
if mode == "gearlock"
    gear = 1;
elseif y(2)<vars.v12
    gear = 1;
elseif y(2)<vars.v23
    gear=2;
else
    gear=3;
end

%% Determine the derivative
if mode == "SingleState"
    dx = 1/vars.m * vars.b/(1+vars.gamma*gear)*ut - 1/vars.m*vars.c*y(2)^2;
else
    dx = [ y(2);...
        1/vars.m * vars.b/(1+vars.gamma*gear)*ut - 1/vars.m*vars.c*y(2)^2];
end

end

