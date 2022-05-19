clc
close all, clear all
variables
%% Dynamics test
x=0;
v=0;
u=u_max;
for t=2:t_end
    if v<v12
        gear = 1;
    elseif v<v23
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