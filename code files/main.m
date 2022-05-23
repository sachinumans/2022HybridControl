clc
close all, clear all
variables
%% Dynamics test
x=0;
v=0;
u=u_max;
for t=2:t_end
    if v<v12
%         warning("Here I am in gear 1")
        gear = 1;
    elseif v<v23
%         warning("Here I am in gear 2")
        gear=2;
    else
        gear=3;
    end
    if t>10
        if v(t-1)-v(t-8)<10^-5
            u=u_min;
        end
    if v(t-1)<0
        u=u_max;
    end
    end
    
    x(t)=x(t-1)+v(t-1)*step;
    v(t)=v(t-1)+((b/(gamma*gear+1)*u-c*v(t-1)^2)/m)*step;
end

figure(1)
plot(v)
title 'ACC Car dynamics simulation'
xlabel 'time [s]'
ylabel 'speed [m/s]'
saveas(gcf,'Pics/Plot_2.1.jpg')


%% 2.1
v_max = ((b*u_max)/(c*(1+gamma*g(3))))^.5;
a_max = (b*u_max)/(1+gamma*g(1))/m;
a_min = (b*u_min)/(1+gamma*g(3))/m-c/m*v_max^2;

vars.v_max = v_max; % Make struct to pass to functions later
%% 2.2
Vsamp = linspace(0, v_max, 200);
alpha = 35; beta = 230;
vars.alpha = alpha; vars.beta = beta;

P_2 = fricApprox(Vsamp, vars);

figure(2)
plot(Vsamp, P_2); hold on
% plot(Vsamp, Vsamp);
plot(Vsamp, c*Vsamp.^2); hold off
title 'PWA approximation of friction force'
ylabel 'Friction force [N]'
xlabel 'speed [m/s]'
saveas(gcf,'Pics/Plot_2.2.jpg')

%% 2.3
x0 = [0;10];
u = @(t) 0.01 + u_max/2*sin(t/2/pi);
[t_3_1,y_3_1] = ode45(@(t,y) modelExact(t,y,u,vars, "gearlock"), [0 t_end], x0);
[t_3_2,y_3_2] = ode45(@(t,y) modelPWA(t,y,u,vars, "gearlock"), [0 t_end], x0);

figure(3)
plot(t_3_1,u(t_3_1));
title 'PWA approximation comparison input'
ylabel 'input'
xlabel 'time [s]'
% legend("Exact model", "PWA", 'Interpreter', 'latex')
saveas(gcf,'Pics/Plot_2.3_1.jpg')

figure(4)
plot(t_3_1,y_3_1(:, 2)); hold on
plot(t_3_2,y_3_2(:, 2)); hold off
title 'PWA approximation comparison'
ylabel 'speed [m/s]'
xlabel 'time [s]'
legend("Exact model", "PWA", 'Interpreter', 'latex')
saveas(gcf,'Pics/Plot_2.3_2.jpg')

figure(5)
plot(Vsamp, P_2); hold on
plot(Vsamp, c*Vsamp.^2);
plot(y_3_1(:, 2), t_3_1 .* P_2(end)/t(end));
plot(y_3_2(:, 2), t_3_2 .* P_2(end)/t(end)); hold off
% title 'PWA approximation comparison'
% ylabel 'speed [m/s]'
% xlabel 'time [s]'
% legend("Exact model", "PWA", 'Interpreter', 'latex')
saveas(gcf,'Pics/Plot_2.3_3.jpg')



