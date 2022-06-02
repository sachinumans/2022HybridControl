function [u] = getOptInput(k, x0, z0, del0, ref, Nc, Np, lambda, sys, vars)
%GETOPTINPUT Determine through MPC the optimal control input at time k
%% Extract system
A = sys.A;
B1 = sys.B1; B2 = sys.B2; B3 = sys.B3; 
C = sys.C;
D1 = sys.D1; D2 = sys.D2; D3 = sys.D3; 
E1 = sys.E1; E2 = sys.E2; E3 = sys.E3; E4 = sys.E4; 
g5 = sys.g5;

%% Find equilibrium state related to the reference
uref = B1\((eye(size(A)) - A) * ref.x - B2*ref.del - B3*ref.z);



end

