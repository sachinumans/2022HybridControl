function [alpha, beta, err] = optApprox(vars)
syms alph bet
syms v
c = vars.c; vmax = vars.v_max;

r1 = (c*v^2 - bet/alph *v)^2; % region 1
r2 = (c*v^2 - (c*vmax^2 - bet)/(vmax - alph) *v - bet + ...
    (c*vmax^2 - bet)/(vmax - alph) *alph)^2; % region 2

A1 = int(r1, v, 0, alph); % Area 1
A2 = int(r2, v, alph, vmax); % Area 2

A = A1 + A2; % Total area

fA = matlabFunction(A, 'Vars', {symvar(A)}); % Make a function of the vector [alpha, beta]

[vals, err] = fmincon(fA, [vmax/2, c*(vmax/2)^2], [], []); % minimise
alpha = vals(1);
beta = vals(2);

end