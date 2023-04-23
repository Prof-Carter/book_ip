% 例 1.4
% アーム型倒立振子
% LMI による多目的最適制御と最適レギュレータの
% 非線形シミュレーション結果の描画とアニメーション表示

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
St    = 1.5;;         % settring time
alpha = 3/St;         % alpha region
beta  = 8*alpha;      % beta region
theta = pi/4;  k = tan(theta);   % sector region
% ----------------------------
n = length(At);
X = sdpvar(n,n,'sy');
L = sdpvar(1,n);
% ----------------------------
M = At*X + Bt*L;
LMI1 = [ M'+M         X*sqrtm(Q)   L'*sqrtm(R)
         sqrtm(Q)*X  -eye(n)       zeros(n,1)
         sqrtm(R)*L   zeros(1,n)  -1 ];
LMI2 = M'+M+2*alpha*X;
LMI3 = [ k*(M'+M) M-M'
         M'-M     k*(M'+M) ];
LMI4 = M'+M+2*beta*X;
% ---------------------------------
LMI = [X >= ep*eye(n)];
LMI = LMI + [LMI1 <= -ep*eye(length(LMI1))];
LMI = LMI + [LMI2 <= -ep*eye(length(LMI2))];
LMI = LMI + [LMI3 <= -ep*eye(length(LMI3))];
LMI = LMI + [LMI4 >=  ep*eye(length(LMI4))];
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
K1 = Kt(1:4)
K2 = Kt(5)
% ---------------------------------
poles = eig(At+Bt*Kt)  % poles
% ---------------------------------
t_end = 6;
t_dis = 0;

r0 = 30*pi/180;
d0 = 0;

theta1_0 = 0;  dtheta1_0 = 0;
theta2_0 = 0;  dtheta2_0 = 0;
% ---------------------------------
sim('adip_servo_sim')
t_multi = t;  
theta1_multi = theta1;
theta2_multi = theta2;
u_multi = u;
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
% ---------------------------------
poles_LQ = eig(At+Bt*Kt_LQ)  % poles
% ---------------------------------
sim('adip_servo_sim')
t_LQ = t;  
theta1_LQ = theta1;
theta2_LQ = theta2;
u_LQ = u;
% ---------------------------------
figure(1)
hold on
plot(t,theta1*180/pi,'b--','LineWidth',2)
hold off

legend('Multiobjective Control','LQ Control')
legend('Location','SouthEast')
set(legend,'Fontname','arial','FontSize',16)
% --------
figure(2)
hold on
plot(t,theta2*180/pi,'b--','LineWidth',2)
hold off

legend('Multiobjective Control','LQ Control')
legend('Location','SouthEast')
set(legend,'Fontname','arial','FontSize',16)
% --------
figure(3)
hold on
plot(t,u,'b--','LineWidth',2)
hold off

legend('Multiobjective Control','LQ Control')
legend('Location','SouthEast')
set(legend,'Fontname','arial','FontSize',16)
% --------
figure(4)
hold on
plot(real(poles_LQ),imag(poles_LQ),'bo','LineWidth',2,'MarkerSize',6);
hold off

legend('Multiobjective Control','LQ Control')
legend('Location','SouthEast')
set(legend,'Fontname','arial','FontSize',16)

% ---------------------------------------------
figure(1)
hold on
plot(St*[1 1],[-10 40],'g')
plot([0 t(end)],1.05*r0*180/pi*[1 1],'g')
plot([0 t(end)],0.95*r0*180/pi*[1 1],'g')
hold off
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
hold on
plot(-alpha*[1 1],[-20 20],'g')
plot( -beta*[1 1],[-20 20],'g')
x_th = -cos(theta)*30;
y_th =  sin(theta)*30;
plot([0 x_th],[0 y_th],'g',[0 x_th],[0 -y_th],'g')
hold off

set(gca,'FontName','arial','FontSize',14)
xlabel('Real Part','FontName','arial','FontSize',16)
ylabel('Imaginary Part','FontName','arial','FontSize',16)
xlim([-20 0])
set(gca,'xtick',-20:4:0)
ylim([-20 20])
set(gca,'ytick',-20:10:20)

% =================================================================================
% =================================================================================
disp('----- シミュレーション結果のアニメーション表示 -----')
disp('　　　 　　アニメーション表示しない ===> 0 を入力 ')
disp('　　　 　　多目的制御　　　 ===> 1 を入力 ')
disp('　　　 　　最適レギュレータ ===> 2 を入力 ')
flag = input('input number: ');

% 表示のはやさは ip_toolbox_1.0.2/iptools/adip_anime.m 内の
%   mabiki = 25; 
% の数値を変更する
switch flag 
    case 1
        theta1 = theta1_multi;
        theta2 = theta2_multi;
        adip_anime    % シミュレーション結果をアニメーション表示
    case 2
        theta1 = theta1_LQ;
        theta2 = theta2_LQ;
        adip_anime    % シミュレーション結果をアニメーション表示
end
