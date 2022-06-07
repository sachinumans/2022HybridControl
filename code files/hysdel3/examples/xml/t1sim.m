function [h3_out_xplus, h3_out_w, h3_feasible, h3_out_y] = t1sim(h3_in_x, h3_in_u, h3_parameters)

h3_feasible = true;
H3_X_POS = 1; H3_U_POS = 1;
% ===================== Start: t1sim =====================

% declared parameters

% 'REAL A =  1';
A = ( 1);

% 'REAL MLD_bigMbound =  1';
MLD_bigMbound = ( 1);

% 'REAL x(1, 1) [-10 10] ';
x = h3_in_x(H3_X_POS:H3_X_POS-1+(1)*(1));
x = reshape(x, 1, 1);
H3_X_POS = H3_X_POS + (1)*(1);
h3_feasible = h3_feasible & sub_isbetween(x, [-10 10]);

% 'REAL u1(1, 1) [-10 10] ';
u1 = h3_in_u(H3_U_POS:H3_U_POS-1+(1)*(1));
u1 = reshape(u1, 1, 1);
H3_U_POS = H3_U_POS + (1)*(1);
h3_feasible = h3_feasible & sub_isbetween(u1, [-10 10]);

% 'REAL u2(1, 1) [-10 10] ';
u2 = h3_in_u(H3_U_POS:H3_U_POS-1+(1)*(1));
u2 = reshape(u2, 1, 1);
H3_U_POS = H3_U_POS + (1)*(1);
h3_feasible = h3_feasible & sub_isbetween(u2, [-10 10]);

% 'REAL y(1, 1) [-10 10] ';
y = zeros(1, 1);

% 'REAL a(1, 1) [-10 10] ';
a = zeros(1, 1);
%--------------- AUX ----------------
%--------------- AUX ----------------

%--------------- LINEAR ----------------
% ' a= u2;';
 a = ( u2);
%--------------- LINEAR ----------------

%--------------- CONTINUOUS ----------------
% ' x= x+ a+ u1;';
 x_plus = ( x+ a+ u1);
%--------------- CONTINUOUS ----------------

%--------------- OUTPUT ----------------
% ' y= x;';
 y = ( x);
%--------------- OUTPUT ----------------

h3_out_xplus = [x_plus(:); ];
h3_out_y = [y(:); ];
h3_out_w = [a(:); ];


function ok = sub_isbetween(x, lowup)
ok = all(lowup(:, 1) <= x) & all(x <= lowup(:, 2));


function x = h3_isfield(s, f)
if isempty(s)
    x = false;
    return
end
if isempty(f)
    x = true;
    return
end
n = fieldnames(s);
[first, last] = strtok(f, '.');
x = strmatch(first, n);
if isempty(x)
    x = false;
else
    x = h3_isfield(getfield(s, first), last);
end
