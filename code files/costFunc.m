function [c, M, b] = costFunc(sys, vRef, Np, lambda)
%COSTFUNC Return the c matric for the minimisation problem min c' x with
%extra constraints M x <= b

%% Unpack system
A = sys.A;
B1 = sys.B1; B2 = sys.B2; B3 = sys.B3; 
E1 = sys.E1; E2 = sys.E2; E3 = sys.E3; E4 = sys.E4; 
g5 = sys.g5;

H = [A B1 B2 B3];
nx = size(A, 1);
nu = size(B1, 2);
n = size(H, 2);

%% The tracking cost
c_x = [zeros(1,Np*n) ones(1, Np) zeros(1,Np)]; % Sum rho_x

%% The input cost
c_u = lambda*[zeros(1,Np*n) zeros(1,Np) ones(1, Np)]; % Sum rho_u

%% The tracking constraints
x_ = [eye(nx) zeros(nx, n-nx)];
X = [kron(eye(Np), x_), zeros(Np*nx, 2*Np)]; % states

rhoX = [zeros(Np, Np*n) eye(Np) zeros(Np)]; % Extract rho_x from the state

M_x = [X - rhoX;...
        -X - rhoX]; % Double bounded matrix

b_x = [vRef; -vRef]; % Double bounded vector

%% The input constraints
u_ = [zeros(nu, nx) eye(nu) zeros(nx, n-nx-nu)];
U = [kron(eye(Np), u_), zeros(Np*nx, 2*Np)]; % inputs

rhoU = [zeros(Np, Np*n) zeros(Np) eye(Np)]; % Extract rho_u from the state

M_u = [U - rhoU;...
        -U - rhoU]; % Double bounded matrix

b_u = zeros(size(M_u, 1), 1); % Double bounded vector

%% Compile matrices (M x <= b)
c = c_x + c_u; % Cost function
M = [M_x; M_u]; % Auxilliary constraints matrix
b = [b_x; b_u]; % Auxilliary constraints vector

end

