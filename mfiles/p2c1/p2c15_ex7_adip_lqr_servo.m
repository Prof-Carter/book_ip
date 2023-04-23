% 例 1.7
% アーム型倒立振子
% 最適レギュレータの非線形シミュレーション結果とアニメーション表示

clear
format compact
close all

% ---------------------------
adip_para
% ---------------------------
A21_0 = [ 0  0
           0  alpha5/alpha2 ];
A22_0 = [ -a1                      0
          (a1*alpha3+mu2)/alpha2  -mu2/alpha2];     
B2_0 = [  b1
         -b1*alpha3/alpha2 ];
% ---------------------------
A_0 = [ zeros(2,2)  eye(2)
        A21_0       A22_0  ];
B_0 = [ zeros(2,1)
        B2_0       ];
C_0 = [ 1  0  0  0 ];
% ----------------------------
At_0 = [ A_0  zeros(4,1)
        -C_0  0          ];
Bt_0 = [ B_0
         0  ];
% ---------------------------------
% optimal control
Q = diag([0.1 1 0.001 0.001 4]);
R = 1;
% ----------------------------
Kt = - lqr(At_0,Bt_0,Q,R)
K1 = Kt(1:4)
K2 = Kt(5)

% ==================================================
% reference, disturbance
t_dis = 0;
r0 = 60*pi/180;
d0 = 0;
% ----------------------------
% initial state
theta1_0 = 0;
theta2_0 = 0;
dtheta1_0 = 0;
dtheta2_0 = 0;
% ----------------------------
% simulation
sim('adip_lqr_servo_sim',12)
% ----------------------------
% plot
figure(1)
plot([0 6 6 12],r0*180/pi*[1 1 0 0],'g')
hold on
plot(t,theta1*180/pi,'r','LineWidth',2)
hold off
set(gca,'FontName','arial','FontSize',14)
xlabel('Time [s]','FontName','arial','FontSize',16)
ylabel('Arm Angle [deg]','FontName','arial','FontSize',16)
xlim([0 12])
ylim([-20 80])
% ---
figure(2)
plot(t,theta2*180/pi,'r','LineWidth',2)
set(gca,'FontName','arial','FontSize',14)
xlabel('Time [s]','FontName','arial','FontSize',16)
ylabel('Pendulum Angle [deg]','FontName','arial','FontSize',16)
xlim([0 12])
ylim([-4 4])
% ---
figure(3)
plot(t,u,'r','LineWidth',2)
set(gca,'FontName','arial','FontSize',14)
xlabel('Time [s]','FontName','arial','FontSize',16)
ylabel('Voltage [V]','FontName','arial','FontSize',16)
xlim([0 12])
ylim([-0.8 0.8])

% ===============================================================
% ===============================================================
disp('----- シミュレーション結果をアニメーション表示する場合は 1 を入力 -----')
flag = input('input number: ');

if flag == 1
    % 表示のはやさは ip_toolbox_1.0.2/iptools/adip_anime.m 内の
    %   mabiki = 25; 
    % の数値を変更する
    adip_anime    % シミュレーション結果をアニメーション表示
end
