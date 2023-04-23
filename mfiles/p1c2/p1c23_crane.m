%
% 2.3 クレーンのPID制御 (図 2.24，図 2.25)
%
% Simulink モデルは IPDmodel_crane.slx
%


clear
close all
format compact


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
ref = 0.1;

%外乱
d = 0;
% d = -0.1;


%% 台車のI-PD制御 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%3次の規範モデル
omegaM = 10;

%----バターワース標準形---------------
alpha1 = 2;
alpha2 = 2;
% P,I,Dゲインの設定
kI = omegaM^3/b;
kP = alpha1*omegaM^2/b;
kD = (alpha2*omegaM-a)/b;


%% 振子の制御 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%振子の制御なし（図2.24）
kP2 = 0;
kD2 = 0;

%振子の制御あり（図2.25）
% kP2 = -1;
% kD2 = -0.1;

%% simulinkシミュレーション
sim('IPDmodel_crane')
% 結果の表示（figure(3)）
figure(1);%subplot(2,1,1);
plot(t,r,'k','LineWidth',1); hold on;
plot(t,y,'Color',[114 189 255]/255,'LineWidth',2);

figure(2);hold on;
plot(t,phi,'Color',[114 189 255]/255,'LineWidth',2);

%----------------------------------
% グラフの整形
figure(1);
xlim([0 10.0])
ylim([0 0.2])
set(gca,'xtick',0:2:10)
set(gca,'ytick',0:0.05:0.2)
set(gca,'FontName','arial','FontSize',14)
xlabel('t  [s]','FontName','arial','FontSize',16)
ylabel('y(t)  [m]','FontName','arial','FontSize',16)
box on; grid on;

figure(2);
xlim([0 10.0])
ylim([-pi/4 pi/4])
set(gca,'xtick',0:2:10)
set(gca,'ytick',-pi/4:pi/8:pi/4)
set(gca,'FontName','arial','FontSize',14)
set(gca,'FontName','symbol','yticklabel',{'-p/4','-p/8','0','p/8','p/4'})
xlabel('t  [s]','FontName','arial','FontSize',16)
ylabel('\phi(t)  [rad]','FontName','arial','FontSize',16)
box on; grid on;
