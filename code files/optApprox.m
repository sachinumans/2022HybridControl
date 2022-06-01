function [alpha, beta] = optApprox(vars)
syms alph bet
syms v
c = vars.c; vmax = vars.v_max;

r1 = (c*v^2 - bet/alph *v)^2; % region 1
r2 = (c*v^2 - (c*vmax^2 - bet)/(vmax - alph) *v - bet + ...
    (c*vmax^2 - bet)/(vmax - alph) *alph)^2; % region 2

A1 = int(r1, v, 0, alph); % Area 1
A2 = int(r2, v, alph, vmax); % Area 2

A = A1 + A2; % Total area

d_alph = diff(A, alph, 1); % deriv of A wrt to alpha
d_bet = diff(A, bet, 1); % deriv of A wrt to beta

dd_alph = diff(A, alph, 2); % double deriv of A wrt to alpha
dd_bet = diff(A, bet, 2); % double deriv of A wrt to beta

[solAlph, solBet] = solve([d_alph == 0, d_bet == 0], [alph, bet]); % Find extrema of A
solAlph = double(solAlph);
solBet = double(solBet);

idx = find(solAlph>0 & solAlph<vmax & solBet>0 & solBet<(c*vmax^2));

alpha = solAlph(idx); % Grab valid values
beta = solBet(idx);

if 1==1
    fA = matlabFunction(A); % Make a function of alpha, beta
    figure()
    fsurf(fA, [0 vmax 0 c*vmax^2])
end

val_dd_alph = double(subs(dd_alph, [alph, bet], [alpha, beta]));
val_dd_bet = double(subs(dd_bet, [alph, bet], [alpha, beta]));

end