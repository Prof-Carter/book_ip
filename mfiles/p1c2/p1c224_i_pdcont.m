%
% 2.2.4 I-PD制御 (図 2.21)
%
% Simulink モデルは IPDmodel.slx
%


clear
close all
format compact


     z_0 = 0;
 theta_0 = pi;
    dz_0 = 0;
dtheta_0 = 0;

%% 台車のパラメータと目標値 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%モデル G = b/(s(s+a))
cdip_para
a  = ac;    % 台車駆動系のパラメータ
b  = bc;    % 台車駆動系のパラメータ

%目標値
ref = 0.1;

%外乱
% d = 0;
d = -0.1;


%% I-PD制御（図 2.21） %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%3次の規範モデル
omegaM = 10;

%----二項係数標準形------------------
alpha1 = 3;
alpha2 = 3;
% P,I,Dゲインの設定
kI = omegaM^3/b;
kP = alpha1*omegaM^2/b;
kD = (alpha2*omegaM-a)/b;
% simulinkシミュレーション
sim('IPDmodel')
% 結果の表示（figure(1)）
figure(1);%subplot(2,1,1); 
plot(t,r,'k','LineWidth',1); hold on 
plot(t,y,'Color',[114 189 255]/255,'LineWidth',2); 
grid on

%----バターワース標準形---------------
alpha1 = 2;
alpha2 = 2;
% P,I,Dゲインの設定
kI = omegaM^3/b;
kP = alpha1*omegaM^2/b;
kD = (alpha2*omegaM-a)/b;
% simulinkシミュレーション
sim('IPDmodel')
% 結果の表示（figure(1)）
figure(1);%subplot(2,1,1);
plot(t,y,'Color',[217 83 25]/255,'LineWidth',2);


%----ITAE標準形---------------
alpha1 = 2.15;
alpha2 = 1.75;
% P,I,Dゲインの設定
kI = omegaM^3/b;
kP = alpha1*omegaM^2/b;
kD = (alpha2*omegaM-a)/b;
% simulinkシミュレーション
sim('IPDmodel')
% 結果の表示（figure(1)）
figure(1);%subplot(2,1,1);
plot(t,y,'Color',[237 177 32]/255,'LineWidth',2); hold off


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
box on;


%----------------------------------
% グラフの凡例
figure(1);
legend('r(t)','Binomial coefficients','Butterworth','ITAE')
set(legend,'FontName','arial','FontSize',14)
