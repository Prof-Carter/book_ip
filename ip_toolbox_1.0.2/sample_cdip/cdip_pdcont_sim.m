clear
format compact
close all

cdip_para

% ---------------------------------
     z_0 = 0;
 theta_0 = pi;
    dz_0 = 0;
dtheta_0 = 0;

kP = 10;
kD = 0.75;

sim('cdip_pdcont')

% ---------------------------
figure(1)
plot(t,r,'g'); hold on
plot(t,z,'r','LineWidth',2); hold off
set(gca,'FontName','arial','FontSize',14)
xlabel('Time [s]','FontName','arial','FontSize',16)
ylabel('Cart [m]','FontName','arial','FontSize',16)

figure(2)
plot(t,theta*180/pi,'r','LineWidth',2)
set(gca,'FontName','arial','FontSize',14)
xlabel('Time [s]','FontName','arial','FontSize',16)
ylabel('Pendulum [deg]','FontName','arial','FontSize',16)
set(gca,'YTick',-360:45:360)

figure(3)
plot(t,u,'r','LineWidth',2)
set(gca,'FontName','arial','FontSize',14)
xlabel('Time [s]','FontName','arial','FontSize',16)
ylabel('Voltage [V]','FontName','arial','FontSize',16)
ylim([-5 5])
set(gca,'YTick',-5:2.5:5)



