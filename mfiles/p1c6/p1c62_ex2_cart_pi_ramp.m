% ó· 6.2
% ë‰é‘ãÏìÆånÇÃ PI êßå‰
% r(t) = r0*t, d(t) = 0

clear
format compact
close all

% --------------------------------------------------------
t_end = 2.5;

ac = 6.25; 
bc = 4.36; 
sysP = tf(bc,[1 ac 0]);

r0 = 0.1;
kP = 10;
kI = 15;

% --------------------------------------------------------
sysP = tf(bc,[1 ac 0]);
sysC = tf([kP kI],[1 0]);
tzero(1 + sysP*sysC)    % ì¡ê´ï˚íˆéÆ (1 + P(s)C(s) = 0) ÇÃâ

% --------------------------------------------------------
sim('cart_pi_ramp_sim')

% --------------------------------------------------------
figure(1)
plot(t,r,'g')
hold on
plot(t,y,'r','LineWidth',2)
hold off

ylim([0 0.25])
set(gca,'Ytick',0:0.05:0.25)

set(gca,'Fontname','arial','FontSize',14)
xlabel('Time [s]','Fontname','arial','FontSize',16)
ylabel('Position [m]','Fontname','arial','FontSize',16)

legend('Reference','PI Control')
legend('Location','SouthEast')
set(legend,'Fontname','arial','FontSize',16)
