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
%Old version of T
%     T = zeros(Np*nx, Np*n)*A;
%     T(1:nx, 1:n) = H; % x+ = H x
%     for k=2:Np
%         idx1 = (k-1)*nx+(1:nx);
%         T(idx1, :) = A*T((k-2)*nx+(1:nx), :);
%         T(idx1, (k-1)*n+(1:n)) = H;
%     end
T = kron(eye(Np), H);

q = [eye(nx) zeros(nx, n-nx)];
Q = kron(diag(ones(Np-1,1),1),q); % x+

R = T-Q; % x+ - H x = 0
R((end-nx+1):end,:) = []; % Remove zero row

%% Create logical constraints (E x <= G)
e = [E1 E2 E3 E4];
E = kron(eye(Np), e);
G = kron(ones(Np, 1), g5);

%% Create constant u constraint after Nc (W x == 0)
w = [zeros(nu, nx) eye(nu) zeros(nx, n-nx-nu)];
W = kron(eye(Np)-diag(ones(Np-1,1),-1),w);
W = W(Nc:end, :);

%% Guarantee comfortabillity constraint ( P x <= p)
X = kron(eye(Np), q);

dX = Q - X; 
dX(end, :) = [];
P = [-1/dt*dX;...
    1/dt*dX];

p = aComf * ones(size(P,1), 1);

%% Compile to F
F = [R; W; E; P];
b = [zeros(size([R;W],1),1); G; p];

%% Determine Neq, Nleq
Neq  = size([R;W], 1);
Nleq = size([E;P], 1);
end

