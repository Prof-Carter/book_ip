%
% 2.1.3 PID制御 (図 2.9)
%
% Simulink モデルは PIDmodel.slx
%

clear
close all
format compact


% 制御対象の初期状態
     z_0 = 0;
 theta_0 = pi;
    dz_0 = 0;
dtheta_0 = 0;

%% 台車のパラメータと目標値 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%モデル G = b/(s(s+a))
cdip_para
a  = ac;    % 台車駆動系のパラメータ
b  = bc;    % 台車駆動系のパラメータ

%目標値
ref = 0.1; %[m]

%入力外乱
d = -0.1;


%% P制御 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%----------------------------------
% PIDゲインの設定
kP = 10;
kD = 0.8;
kI = 5;
% simulinkシミュレーション
sim('PIDmodel')
% 結果の表示（figure(1)）
figure(1);%subplot(2,1,1);
plot(t,y,'k','LineWidth',2); hold on 
plot(t,r,'k','LineWidth',1); hold off
grid on

%----------------------------------
% グラフの整形
figure(1);
xlim([0 2.0])
ylim([0 0.2])
set(gca,'xtick',0:0.5:2)
set(gca,'ytick',0:0.05:0.2)
set(gca,'FontName','arial','FontSize',14)
xlabel('t  [s]','FontName','arial','FontSize',16)
ylabel('y(t)  [m]','FontName','arial','FontSize',16)



