function [u, x] = getOptInput(x0, vRef, sys, K, L, C, Np, Neq, Nleq, plt)
%GETOPTINPUT Determine through MPC the optimal control input at time k
%% Unpack system
A = sys.A;
B1 = sys.B1; B2 = sys.B2; B3 = sys.B3; 
E1 = sys.E1; E2 = sys.E2; E3 = sys.E3; E4 = sys.E4; 
g5 = sys.g5;

H = [A B1 B2 B3];
nx = size(A, 1);
nu = size(B1, 2);
n = size(H, 2);

%% Add constraint x0 == x0 (Ox == o)
O = [eye(nx), zeros(nx, size(K,2)-nx)]; % Matrix
o = x0; % Vector

%% Define and constrain terminal set ( |x_Np - xRef| <= TerSet )
TerSet = 58; % This is an inactive constraint by definition, since the
                        % whole of the state space is control invariant
S = [zeros(2*nx,n*(Np-1)) [eye(nx);-eye(nx)] zeros(2*nx,n-nx)...
    zeros(2*nx,2*Np)]; % Grab the last state
s = TerSet * ones(2*nx, 1) + [eye(nx);-eye(nx)]*vRef(end); % Vector, double
                                                            % bounded

%% Perform optimisation
ConstrA = [K;O;S]; % Compile constraint matrices
ConstrB = [L;o;s]; % Compile constraint vectors

ctype = [repmat('S', 1, Neq),... R and W == 
        repmat('U', 1, Nleq+4*Np),... E, P and M <=
        repmat('S', 1, nx),... Initial condition ==
        repmat('U', 1, 2*nx)]; % Terminal set <=
vartype = [repmat('CCBBBCCC', 1, Np), ... Np number of states
           repmat('C', 1, nx*Np), ... nx*Np number of aux variables
           repmat('C', 1, nu*Np)]; %  nu*Np number of aux variables

% Perform optimisation
[xN,~,status,~] = glpk (C,ConstrA,ConstrB,[],[],ctype,vartype);
% status
%% Return first input and state
u = xN(nx+1:nx+nu);
x = xN(n+1:n+nx);

%% Possibly plot the predicted trajectory
if plt == "plot"
    figure();
    subplot(2, 1, 1)
    x_ = [eye(nx) zeros(nx, n-nx)];
    X = [kron(eye(Np), x_), zeros(Np*nx, 2*Np)]; % states
    plot(X*xN);
    title("Velocities")
    
    subplot(2, 1, 2)
    u_ = [zeros(nu, nx) eye(nu) zeros(nx, n-nx-nu)];
    U = [kron(eye(Np), u_), zeros(Np*nx, 2*Np)]; % inputs
    plot(U*xN);
    title("Input")
end
end

