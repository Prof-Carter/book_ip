clear
format compact
close all

adip_para

% ---------------------------
Ap21 = [ 0  0
         0  alpha5/alpha2 ];
Ap22 = [ -a1                      0
         (a1*alpha3+mu2)/alpha2  -mu2/alpha2 ];
Bp2  = [  b1
         -b1*alpha3/alpha2 ];
% ---------------------------
A = [ zeros(2,2)  eye(2)
      Ap21        Ap22   ];

B = [ zeros(2,1)
      Bp2        ];

C = [ 1  0  0  0 ];
% ---------------------------
 theta1_0 = 0;
 theta2_0 = 0;
dtheta1_0 = 0;
dtheta2_0 = 0;

% ----------------------------
At = [ A  zeros(4,1)
      -C  0 ];

Bt = [ B
       0 ];

Q = diag([0.1 10 0 0 25]);
R = 1;

Kt = -lqr(At,Bt,Q,R)

K1 = Kt(1:4)
K2 = Kt(5)

sim('adip_lqr_servo')

% ---------------------------
figure(1)
plot([0 8],30*[1 1],'g'); hold on
plot(t,theta1*180/pi,'r','LineWidth',2); hold off
set(gca,'FontName','arial','FontSize',14)
xlabel('Time [s]','FontName','arial','FontSize',16)
ylabel('Arm [deg]','FontName','arial','FontSize',16)

figure(2)
plot(t,theta2*180/pi,'r','LineWidth',2)
set(gca,'FontName','arial','FontSize',14)
xlabel('Time [s]','FontName','arial','FontSize',16)
ylabel('Pendulum [deg]','FontName','arial','FontSize',16)

figure(3)
plot(t,u,'r','LineWidth',2)
set(gca,'FontName','arial','FontSize',14)
xlabel('Time [s]','FontName','arial','FontSize',16)
ylabel('Voltage [V]','FontName','arial','FontSize',16)


