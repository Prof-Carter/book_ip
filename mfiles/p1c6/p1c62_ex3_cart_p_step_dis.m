% 例 6.3
% 台車駆動系の P 制御
% r(t) = r0, d(t) = d0

clear
format compact
close all

% --------------------------------------------------------
t_end = 5;
t_dis = 2.5;

ac = 6.25; 
bc = 4.36; 
sysP = tf(bc,[1 ac 0]);

r0 = 0.5;
d0 = 3;

% --------------------------------------------------------
% P 制御
kP = 10;
kI = 0;
sim('cart_pi_step_dis_sim')

sysC = kP;
Delta = 1 + sysP*sysC
tzero(Delta)    % 特性方程式 (1 + P(s)C(s) = 0) の解

% --------------------------------------------------------
figure(1)
plot(t,r,'g')
hold on
plot(t,y,'b','LineWidth',2)
hold off

ylim([0 1])
set(gca,'Ytick',0:0.25:1)

set(gca,'Fontname','arial','FontSize',14)
xlabel('Time [s]','Fontname','arial','FontSize',16)
ylabel('Position [m]','Fontname','arial','FontSize',16)

legend('Reference','P Control')
legend('Location','SouthEast')
set(legend,'Fontname','arial','FontSize',16)

