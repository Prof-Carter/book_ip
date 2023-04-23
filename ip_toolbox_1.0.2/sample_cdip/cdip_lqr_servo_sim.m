clear
format compact
close all

cdip_para

% ---------------------------
Ap21 = [ 0  0
         0  mp*g*lp/(Jp+mp*lp^2) ];
Ap22 = [ -ac                      0
          ac*mp*lp/(Jp+mp*lp^2)  -mup/(Jp+mp*lp^2) ];
Bp2  = [  bc
         -bc*mp*lp/(Jp+mp*lp^2) ];
% ---------------------------
A = [ zeros(2,2)  eye(2)
      Ap21        Ap22   ];

B = [ zeros(2,1)
      Bp2        ];

C = [ 1  0  0  0 ];
% ---------------------------
     z_0 = 0;
 theta_0 = 0;
    dz_0 = 0;
dtheta_0 = 0;

% ----------------------------
At = [ A  zeros(4,1)
      -C  0 ];

Bt = [ B
       0 ];

Q = diag([1 5 0 0 100]);
R = 1;

Kt = -lqr(At,Bt,Q,R)

K1 = Kt(1:4)
K2 = Kt(5)

% ---------------------------
sim('cdip_lqr_servo')

% ---------------------------
figure(1)
plot([0 8],0.5*[1 1],'g'); hold on
plot(t,z,'r','LineWidth',2); hold off
set(gca,'FontName','arial','FontSize',14)
xlabel('Time [s]','FontName','arial','FontSize',16)
ylabel('Cart [m]','FontName','arial','FontSize',16)

figure(2)
plot(t,theta*180/pi,'r','LineWidth',2)
set(gca,'FontName','arial','FontSize',14)
xlabel('Time [s]','FontName','arial','FontSize',16)
ylabel('Pendulum [deg]','FontName','arial','FontSize',16)

figure(3)
plot(t,u,'r','LineWidth',2)
set(gca,'FontName','arial','FontSize',14)
xlabel('Time [s]','FontName','arial','FontSize',16)
ylabel('Voltage [V]','FontName','arial','FontSize',16)



