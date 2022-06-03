function [dx] = MLD(t, y, u, vars, mode)
%MLD Summary of this function goes here
%   Detailed explanation goes here
ut = u(t);
delta_1=false;
delta_2=false;
delta_3=false;
if y(2)>vars.v23
%     warning("Here I am in gear 1")
    delta_1=true;
    delta_2=true;
elseif y(2)>vars.v12
%     warning("Here I am in gear 2")
    delta_1=true;
end
if y(2)>vars.alpha
    delta_3=true;
end
% gear
F_d1=1/vars.m * vars.b/(1+vars.gamma*1);
F_d2=1/vars.m * vars.b/(1+vars.gamma*2);
F_d3=1/vars.m * vars.b/(1+vars.gamma*3);
dir_1=1/vars.m*vars.beta/vars.alpha;
slope_2 = (vars.c*vars.v_max^2-vars.beta)/(vars.v_max-vars.alpha);
dir_2=1/vars.m*slope_2;
res=vars.alpha*slope_2;
dx = [ y(2);...
        (F_d1+F_d2*delta_1+F_d3*delta_3)*ut...
        - (dir_1+(dir_2-dir_1)*delta_3)*y(2)+delta_3*res];

end