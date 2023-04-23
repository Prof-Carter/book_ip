% 例 1.4
% アーム型倒立振子
% LMI による最適制御と最適レギュレータの
% 非線形シミュレーション結果の描画

clear
format compact
close all

% ---------------------------
adip_para
% ---------------------------
A21 = [ 0  0
        0  alpha5/alpha2 ];
A22 = [ -a1                      0
        (a1*alpha3+mu2)/alpha2  -mu2/alpha2 ];
B2  = [  b1
        -b1*alpha3/alpha2 ];
% ---------------------------
A = [ zeros(2,2)  eye(2)
      A21         A22   ];
B = [ zeros(2,1)
      B2         ];
C = [ 1  0  0  0 ];
% ----------------------------
At = [ A  zeros(4,1)
      -C  0 ];
Bt = [ B
       0 ];
% ----------------------------
ep = 1e-6;
% ----------------------------
Q  = diag([0.1 1 0.001 0.001 4]);
R  = 1;
% ----------------------------
n = length(At);
X = sdpvar(n,n,'sy');
L = sdpvar(1,n);
% ----------------------------
M = At*X + Bt*L;
LMI1 = [ M'+M         X*sqrtm(Q)   L'*sqrtm(R)
         sqrtm(Q)*X  -eye(n)       zeros(n,1)
         sqrtm(R)*L   zeros(1,n)  -1 ];
% ---------------------------------
LMI = [X >= ep*eye(n)];
LMI = LMI + [LMI1 <= -ep*eye(length(LMI1))];
% ---------------------------------
obj = -trace(X);    % objective
% ---------------------------------
solvesdp(LMI,obj)
% ---------------------------------
X  = double(X)      % solution
L  = double(L)
Kt = L*inv(X)

% J < trace(inv(X))trace(x_0x_0^T)
trace_invX = trace(inv(X))
trace_X    = trace(X)
% ---------------------------------
poles = eig(At+Bt*Kt)  % poles
% ---------------------------------
K1 = Kt(1:4)
K2 = Kt(5)
% ---------------------------------
t_end = 6;
t_dis = 0;

r0 = 30*pi/180;
d0 = 0;

theta1_0 = 0;  dtheta1_0 = 0;
theta2_0 = 0;  dtheta2_0 = 0;
% ---------------------------------
sim('adip_servo_sim')
% ---------------------------------
figure(1)
plot(t,theta1*180/pi,'r','LineWidth',2)
% --------
figure(2)
plot(t,theta2*180/pi,'r','LineWidth',2)
% --------
figure(3)
plot(t,u,'r','LineWidth',2)
% --------
figure(4)
plot(real(poles),imag(poles),'xr','LineWidth',2,'MarkerSize',10)

% ========================================
Kt_LQ = - lqr(At,Bt,Q,R)
K1 = Kt_LQ(1:4)
K2 = Kt_LQ(5)

poles_LQ = eig(At+Bt*Kt_LQ)  % poles

sim('adip_servo_sim')
% ---------------------------------
figure(1)
hold on
plot(t,theta1*180/pi,'b--','LineWidth',2)
hold off

legend('Optimal Control (LMI)','LQ Control')
legend('Location','SouthEast')
set(legend,'Fontname','arial','FontSize',16)
% --------
figure(2)
hold on
plot(t,theta2*180/pi,'b--','LineWidth',2)
hold off

legend('Optimal Control (LMI)','LQ Control')
legend('Location','SouthEast')
set(legend,'Fontname','arial','FontSize',16)
% --------
figure(3)
hold on
plot(t,u,'b--','LineWidth',2)
hold off

legend('Optimal Control (LMI)','LQ Control')
legend('Location','SouthEast')
set(legend,'Fontname','arial','FontSize',16)
% --------
figure(4)
hold on
plot(real(poles_LQ),imag(poles_LQ),'bo','LineWidth',2,'MarkerSize',6);
hold off

legend('Optimal Control (LMI)','LQ Control')
legend('Location','SouthEast')
set(legend,'Fontname','arial','FontSize',16)

% ---------------------------------------------
figure(1)
set(gca,'FontName','arial','FontSize',14)
xlabel('Time [s]','FontName','arial','FontSize',16)
ylabel('Arm Angle [deg]','FontName','arial','FontSize',16)
xlim([0 6])
ylim([-10 40])
set(gca,'ytick',-10:10:40)
% --------
figure(2)
set(gca,'FontName','arial','FontSize',14)
xlabel('Time [s]','FontName','arial','FontSize',16)
ylabel('Pendulum Angle [deg]','FontName','arial','FontSize',16)
xlim([0 6])
ylim([-2 2])
set(gca,'ytick',-2:1:2)
% --------
figure(3)
set(gca,'FontName','arial','FontSize',14)
xlabel('Time [s]','FontName','arial','FontSize',16)
ylabel('Voltage [V]','FontName','arial','FontSize',16)
xlim([0 6])
ylim([-0.15 0.45])
set(gca,'ytick',-0.15:0.15:0.45)
ylim([-0.4 0.4])
set(gca,'ytick',-0.6:0.2:0.6)
% --------
figure(4)
set(gca,'FontName','arial','FontSize',14)
xlabel('Real Part','FontName','arial','FontSize',16)
ylabel('Imaginary Part','FontName','arial','FontSize',16)
xlim([-20 0])
set(gca,'xtick',-20:4:0)
ylim([-20 20])
set(gca,'ytick',-20:10:20)

