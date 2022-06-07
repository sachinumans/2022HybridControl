clear
yalmip('clear');
x = sdpvar(1, 1);
u = sdpvar(1, 1);
z = sdpvar(1, 1);
F = set([]);
F = F + [-2 <= x <= 2];
F = F + [-1 <= u <= 1];
F = F + [-100 <= z <= 100];
F = F + [z == x + u];
Fexp = expandmodel(F, []);

[M, m, infbound] = derivebounds(sdpvar(Fexp(end)))
