function [fig] = plot2_3(t_3_1,t_3_2, u, y_3_1,y_3_2, Vsamp, P_2, vars, fig)
%UNTITLED Make plots for Q2.3
figure(fig); fig = fig+1;
plot(t_3_1,u(t_3_1));
title 'PWA approximation comparison input'
ylabel 'input'
xlabel 'time [s]'
% legend("Exact model", "PWA", 'Interpreter', 'latex')
saveas(gcf,'Pics/Plot_2.3_1.jpg')

figure(fig); fig = fig+1;
plot(t_3_1,y_3_1(:, 2)); hold on
plot(t_3_2,y_3_2(:, 2)); hold off
title 'PWA approximation comparison'
ylabel 'speed [m/s]'
xlabel 'time [s]'
legend("Exact model", "PWA", 'Interpreter', 'latex')
saveas(gcf,'Pics/Plot_2.3_2.jpg')

figure(fig); fig = fig+1;
plot(Vsamp, P_2); hold on
plot(Vsamp, vars.c*Vsamp.^2);
plot(y_3_1(:, 2), t_3_1 .* P_2(end)/t_3_1(end));
plot(y_3_2(:, 2), t_3_2 .* P_2(end)/t_3_2(end)); hold off
% title 'PWA approximation comparison'
% ylabel 'speed [m/s]'
% xlabel 'time [s]'
% legend("Exact model", "PWA", 'Interpreter', 'latex')
saveas(gcf,'Pics/Plot_2.3_3.jpg')

end

