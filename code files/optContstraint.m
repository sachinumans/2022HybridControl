function [F, b, Neq, Nleq] = optContstraint(sys, Np, Nc)
%OPTCONTSTRAINT Returns the time invariant constraint matrix F and vector b
%such that the constraints F x ~ b can be passed to the optimiser, where
%the relation ~ is to be specified in glpk.m. Neq is the number of ==
%constraints, and Nleq the number of <= constraints. F will begin with all
%of the == constraints, then the <=, then the >=.

%% Unpack system
A = sys.A;
B1 = sys.B1; B2 = sys.B2; B3 = sys.B3; 
E1 = sys.E1; E2 = sys.E2; E3 = sys.E3; E4 = sys.E4; 
g5 = sys.g5;

H = [A B1 B2 B3];
nx = size(A, 1);
nu = size(B1, 2);
n = size(H, 2);

aComf = sys.a_comf;
dt = sys.dt;

%% Create dynamic projection constraint (R x == 0)
T = kron(eye(Np), H); % Block diagonal with H

q = [eye(nx) zeros(nx, n-nx)]; % Extract x(k) for one timestep
Q = kron(diag(ones(Np-1,1),1),q); % Extract x(k+1) for all timesteps

R = T-Q; % x+ - H x = 0
R((end-nx+1):end,:) = []; % Remove zero row

%% Create logical constraints (E x <= G)
e = [E1 E2 E3 E4];
E = kron(eye(Np), e); % Block diagonal with E
G = kron(ones(Np, 1), g5); % Repeat g5 Np times

%% Create constant u constraint after Nc (W x == 0)
w = [zeros(nu, nx) eye(nu) zeros(nx, n-nx-nu)]; % Extract u(k) for one timestep
W = kron(eye(Np)-diag(ones(Np-1,1),-1),w); % u(k) - u(k+1) = 0
W = W(Nc:end, :); % Only from Nc and onwards

%% Guarantee comfortabillity constraint ( P x <= p)
X = kron(eye(Np), q); % Extract all states

dX = Q - X; % x(k+1) - x(k)
dX(end, :) = []; % Last row is invalid
P = [-1/dt*dX;...
      1/dt*dX]; % Double bound

p = aComf * ones(size(P,1), 1); % Constraint vector

%% Compile to F
F = [R; W; E; P];
b = [zeros(size([R;W],1),1); G; p];

%% Determine Neq, Nleq
Neq  = size([R;W], 1); % Number of equality constraints
Nleq = size([E;P], 1); % Number of inequality constraints
end

