clear
format compact
close all

% ---------------------------------------------------
cdip_para
% ---------------------------------------------------
z_0      = 0;
theta_0  = pi;
dz_0     = 0;
dtheta_0 = 0;
% ---------------------------------------------------
sim('cdip_pcont_sim')
% ---------------------------------------------------
% figure(1); plot(t,z)
% figure(2); plot(t,phi)

figure(1); plot(t,z,'LineWidth',2)
set(gca,'Fontname','arial','FontSize',14)
xlabel('Time [s]','Fontname','arial','FontSize',16)
ylabel('Position [m]','Fontname','arial','FontSize',16)

figure(2); plot(t,phi,'LineWidth',2)
set(gca,'Fontname','arial','FontSize',14)
xlabel('Time [s]','Fontname','arial','FontSize',16)
ylabel('Angle [rad]','Fontname','arial','FontSize',16)
% ---------------------------------------------------
theta = phi + pi;
cdip_anime

