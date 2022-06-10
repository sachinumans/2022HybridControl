function [dx] = modelPWA(t, y, u, vars, mode)
%MODELEXACT The exact differential equations
if convertCharsToStrings(class(u)) == "function_handle"
    ut = u(t);
end

if mode == "gearlock"
    gear = 1;
elseif y(2)<=vars.v12
%     warning("Here I am in gear 1")
    gear = 1;
elseif y(2)<=vars.v23
%     warning("Here I am in gear 2")
    gear=2;
else
%     warning("Here I am in gear 3")
    gear=3;
end

% gear

dx = [ y(2);...
        1/vars.m * vars.b/(1+vars.gamma*gear)*ut...
        - 1/vars.m*fricApprox(y(2), vars)];

end

