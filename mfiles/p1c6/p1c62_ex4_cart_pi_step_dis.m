% —á 6.4
% ‘äÔ‹ì“®Œn‚Ì PI §Œä
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
% P §Œä
kP = 10;
kI = 0;
sim('cart_pi_step_dis_sim')  % R2013a
y1 = y;

disp(' ')
disp(' ----- P Control ----- ')
sysC = kP;
Delta = 1 + sysP*sysC
tzero(Delta)    % “Á«•û’ö® (1 + P(s)C(s) = 0) ‚Ì‰ğ

% --------------------------------------------------------
% PI §Œä
kP = 10;
kI = 15;
sim('cart_pi_step_dis_sim')  % R2013a
y2 = y;

disp(' ')
disp(' ----- PI Control ----- ')
sysC = tf([kP kI],[1 0]);
Delta = 1 + sysP*sysC
tzero(Delta)    % “Á«•û’ö® (1 + P(s)C(s) = 0) ‚Ì‰ğ

% --------------------------------------------------------
figure(1)
plot(t,r,'g')
hold on
plot(t,y1,'b','LineWidth',2)
plot(t,y2,'r','LineWidth',2)
hold off

ylim([0 1])
set(gca,'Ytick',0:0.25:1)

set(gca,'Fontname','arial','FontSize',14)
xlabel('Time [s]','Fontname','arial','FontSize',16)
ylabel('Position [m]','Fontname','arial','FontSize',16)

legend('Reference','P Control','PI Control')
legend('Location','SouthEast')
set(legend,'Fontname','arial','FontSize',16)

