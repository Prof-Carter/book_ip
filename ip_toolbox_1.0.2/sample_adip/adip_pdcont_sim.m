clear
format compact
close all

adip_para

% ---------------------------------
 theta1_0 = 0;
 theta2_0 = pi;
dtheta1_0 = 0;
dtheta2_0 = 0;

kP = 4;
kD = 0.25;

sim('adip_pdcont')

% ---------------------------
figure(1)
plot(t,r*180/pi,'g'); hold on
plot(t,theta1*180/pi,'r','LineWidth',2); hold off
set(gca,'FontName','arial','FontSize',14)
xlabel('Time [s]','FontName','arial','FontSize',16)
ylabel('Arm [deg]','FontName','arial','FontSize',16)
set(gca,'YTick',-360:30:360)

figure(2)
plot(t,theta2*180/pi,'r','LineWidth',2)
set(gca,'FontName','arial','FontSize',14)
xlabel('Time [s]','FontName','arial','FontSize',16)
ylabel('Pendulum [deg]','FontName','arial','FontSize',16)
set(gca,'YTick',-360:30:360)

figure(3)
plot(t,u,'r','LineWidth',2)
set(gca,'FontName','arial','FontSize',14)
xlabel('Time [s]','FontName','arial','FontSize',16)
ylabel('Voltage [V]','FontName','arial','FontSize',16)


