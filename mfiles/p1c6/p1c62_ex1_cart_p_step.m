% ó· 6.1
% ë‰é‘ãÏìÆånÇÃ P êßå‰
% r(t) = r0, d(t) = 0

clear
format compact
close all

% --------------------------------------------------------
t_end = 2.5;

ac = 6.25; 
bc = 4.36; 

r0 = 0.5;
kP = 10;

% --------------------------------------------------------
sysP = tf(bc,[1 ac 0]);
sysC = kP;
tzero(1 + sysP*sysC)    % ì¡ê´ï˚íˆéÆ (1 + P(s)C(s) = 0) ÇÃâ

% --------------------------------------------------------
sim('cart_p_step_sim') 

% --------------------------------------------------------
figure(1)
plot(t,r,'g')
hold on
plot(t,y,'r','LineWidth',2)
hold off

ylim([0 1])
set(gca,'Ytick',0:0.25:1)

set(gca,'Fontname','arial','FontSize',14)
xlabel('Time [s]','Fontname','arial','FontSize',16)
ylabel('Position [m]','Fontname','arial','FontSize',16)

legend('Reference','P Control')
set(legend,'Fontname','arial','FontSize',16)


