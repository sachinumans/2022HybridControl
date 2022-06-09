% clc; close all; clear;
% %% Trying to understand MLD constraints
% variables
% v_max = ((b*u_max)/(c*(1+gamma*g(3))))^.5;
% a_max = (b*u_max)/(1+gamma*g(1))/m;
% a_min = (b*u_min)/(1+gamma*g(3))/m-c/m*v_max^2;
% 
% vars.v_max = v_max; % Make struct to pass to functions later
% [alpha, beta] = optApprox(vars);
% vars.alpha = alpha; vars.beta = beta;
% 
% 
% % delta P and constraints
% x = linspace(0, v_max, 100);
% delP = 0;
% 
% c1 = (-x + alpha) <= (alpha*(1- delP));
% c2 = (-x + alpha) >= (eps + (-v_max+ alpha- eps)*delP);
% 
% figure(); hold on
% plot(x, c1)
% plot(x, c2, "--")
% hold off
% 
% % z_p and constraints
% z_p = (x >= alpha).*x ;
% 
% figure(); hold on
% plot(x, z_p)
% plot(x, x-v_max*(1-delP), "--")
% plot(x, x, "--")
% hold off
% 
%% Prediction 

syms A H
Np = 5;
n = 1;
nx = 1;

T = zeros(Np*nx, Np*n)*A;
T(1:nx, 1:n) = H; % x+ = H x
for k=2:Np
    idx1 = (k-1)*nx+(1:nx);
    T(idx1, :) = A*T((k-2)*nx+(1:nx), :);
    T(idx1, (k-1)*n+(1:n)) = H;
end

q = [eye(nx) zeros(nx, n-nx)];
Q = kron(diag(ones(Np-1,1),1),q); % x+

R = T-Q; % x+ - H x = 0
R((end-nx+1):end,:) = [] % Remove zero row


% De prediction matrix is itereerbaar, het is de vorige rij
% linksvermenigvuldigt met A geappend met [A B...]

%% Check if MLD model is correct wrt PWA model
v = 5;
u = -1;

%MLD model
A = [[1 zeros(1, n-1)];... % v and u are as predefined
     [0 1 zeros(1, n-2)];...
        [E1 E2 E3 E4]]; % state is valid
b = [v; u; g5]; %   v; 

C = [1 zeros(1, n-1)];

ctype = ['SS', repmat('U', 1,size(E1,1))];
vartype = 'CCBBBCCC';

[xMLD,~,status,~] = glpk(C,A,b,[],[],ctype,vartype)%,sense,param)

xPmld = H*xMLD;

u = @(t) u*t/t;

xPfe = [0;v] + vars.dt* modelPWA(1, [0;v], u, vars, "");

Comparison_MLD_PWA = xPmld == xPfe(2)
if ~Comparison_MLD_PWA
    xPmld - xPfe(2)
    xPmld
end

%% Plot residuals
A = [[1 zeros(1, n-1)];... % v and u are as predefined
     [0 1 zeros(1, n-2)];...
     [E1 E2 E3 E4]]; % state is valid
C = [1 zeros(1, n-1)];
ctype = ['SS', repmat('U', 1,size(E1,1))];
vartype = 'CCBBBCCC';

V = 1:v_max;
figure();hold on
for u = u_min:0.2:u_max
    u_ = @(t) u*t/t;
    d = [];
    for v = V
        %MLD model
        b = [v; u; g5];
        [xMLD,~,status,~] = glpk (C,A,b,[],[],ctype,vartype);

        xPmld = H*xMLD;

        xPfe = [0;v] + vars.dt* modelPWA(1, [0;v], u_, vars, "");
        
        d = [d xPmld - xPfe(2)];
    end
    plot(V, d)
end