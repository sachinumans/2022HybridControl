function [sys] = MLD(vars)
dt = vars.dt;
m = vars.m;
a = vars.alpha;
uv = vars.v_max;
uu = vars.u_max;
lu = vars.u_min;
v12 = vars.v12;
v23 = vars.v23;
k = vars.beta/vars.alpha;
q = (vars.c*vars.v_max^2 - vars.beta)/(vars.v_max - vars.alpha);
r = vars.beta - q*vars.alpha;

Fd = vars.b./(1+vars.gamma.*vars.g);

sys.A = 1 - dt*k/m;
sys.B1 = dt*Fd(1)/m;
sys.B2 = [0, 0, -dt*r/m];
sys.B3 = dt/m * [Fd(2)-Fd(1), Fd(3)-Fd(2), k-q];

sys.E1 = zeros(22, 1);
sys.E1([1 6 10 12 18]) = 1;
sys.E1([2 5 9 11 17]) = -1;

sys.E2 = zeros(22, 1);
sys.E2([3 16 22]) = 1;
sys.E2([4 15 21]) = -1;

sys.E3 = zeros(22, 3);
sys.E3(5:10, 3) = [a; -uv+a-eps; -uv; 0; 0; uv];
sys.E3(11:16, 1) = [v12; -uv+v12-eps; -uu; lu; -lu; uu];
sys.E3(17:22, 2) = [v23; -uv+v23-eps; -uu; lu; -lu; uu];

sys.E4 = zeros(22, 3);
sys.E4(7:10, 3) = [1; -1; 1; -1];
sys.E4(13:16, 1) = [1; -1; 1; -1];
sys.E4(19:22, 2) = [1; -1; 1; -1];

sys.g5 = zeros(22, 1);
sys.g5([1 10]) = uv;
sys.g5([3 16 22]) = uu;
sys.g5([4 15 21]) = -lu;
sys.g5(6) = a - eps;
sys.g5(12) = v12 - eps;
sys.g5(18) = v23 - eps;
end

% function [dx] = MLD(t, y, u, vars, mode)
% %MLD Summary of this function goes here
% %   Detailed explanation goes here
% ut = u(t);
% delta_1=false;
% delta_2=false;
% delta_3=false;
% if y(2)>vars.v23
% %     warning("Here I am in gear 1")
%     delta_1=true;
%     delta_2=true;
% elseif y(2)>vars.v12
% %     warning("Here I am in gear 2")
%     delta_1=true;
% end
% if y(2)>vars.alpha
%     delta_3=true;
% end
% % gear
% F_d1=1/vars.m * vars.b/(1+vars.gamma*1);
% F_d2=1/vars.m * vars.b/(1+vars.gamma*2);
% F_d3=1/vars.m * vars.b/(1+vars.gamma*3);
% dir_1=1/vars.m*vars.beta/vars.alpha;
% slope_2 = (vars.c*vars.v_max^2-vars.beta)/(vars.v_max-vars.alpha);
% dir_2=1/vars.m*slope_2;
% res=vars.alpha*slope_2;
% dx = [ y(2);...
%         (F_d1+F_d2*delta_1+F_d3*delta_3)*ut...
%         - (dir_1+(dir_2-dir_1)*delta_3)*y(2)+delta_3*res];
% 
% end