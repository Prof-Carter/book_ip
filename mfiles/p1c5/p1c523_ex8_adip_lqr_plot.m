% 例 5.8
% アーム型倒立振子
% 最適レギュレータの非線形シミュレーション

clear
format compact
close all

% ----------------------------------------------------------------
adip_para
theta1e = pi/4;
A = [ 0  0  1  0 
      0  0  0  1
      0  0 -a1 0
      0  alpha5/alpha2  (mu2+a1*alpha3*cos(theta1e))/alpha2  -mu2/alpha2 ];
B = [ 0
      0
      b1
     -b1*alpha3*cos(theta1e)/alpha2 ];

% ---------------------------
 theta1_0 = 0;
 theta2_0 = 0;
dtheta1_0 = 0;
dtheta2_0 = 0;

for i=1:3
    if i==1
        flag = [ 1  0  0 ];
        Q = diag([10 10 1 1]);
        R = 1;
    elseif i == 2
        flag = [ 0  1  0 ];
        Q = diag([10 10 1 1]);
        R = 10;
    elseif i == 3
        flag = [ 0  0  1 ];
        Q = diag([20 10 1 1]);
        R = 1;
    end

    K = - lqr(A,B,Q,R)

    K*[-pi/4;0;0;0]

    % D/A 変換，エンコーダの分解能を考慮しないシミュレーション
    sim('adip_lqr_sim',3) 

    % D/A 変換，エンコーダの分解能を考慮したシミュレーション
%    sim('adip_lqr2_sim',3)

    figure(1); plot(t,theta1*180/pi,'linewidth',2,'color',flag); hold on
    figure(2); plot(t,theta2*180/pi,'linewidth',2,'color',flag); hold on
    figure(3); plot(t,u,'linewidth',2,'color',flag); hold on
end

% ---------------------------
figure(1); hold off
set(gca,'FontName','arial','FontSize',14)
ylim([-15 60]) 
set(gca,'Ytick',-15:15:60)
xlabel('Time [s]','FontName','arial','FontSize',16)
ylabel('Arm angle [deg]','FontName','arial','FontSize',16)

figure(2); hold off
set(gca,'FontName','arial','FontSize',14)
ylim([-4 4]) 
set(gca,'Ytick',-4:2:4)
xlabel('Time [s]','FontName','arial','FontSize',16)
ylabel('Pendulum angle [deg]','FontName','arial','FontSize',16)

figure(3); hold off
set(gca,'FontName','arial','FontSize',14)
ylim([-4 1]) 
set(gca,'Ytick',-4:1:1)
xlabel('Time [s]','FontName','arial','FontSize',16)
ylabel('Voltage [V]','FontName','arial','FontSize',16)

figure(1)
legend('Case 1','Case 2','Case 3','Location','SouthEast')
set(legend,'FontName','arial','FontSize',16)

