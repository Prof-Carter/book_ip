%
% 2.2.4 P-D制御 (図 2.19)
%
% Simulink モデルは PDmodel.slx
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


%% P-D制御（図 2.19） %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%----------------------------------
%２次の規範モデル
omegaM = 5;
zetaM  = 1/sqrt(2);
% P,Dゲインの設定
kI = 0;
kP = omegaM^2/b;
kD = (2*zetaM*omegaM-a)/b;
% simulinkシミュレーション
sim('PDmodel')
% 結果の表示（figure(2)）
figure(1);%subplot(2,1,1); 
plot(t,r,'k','LineWidth',1); hold on 
plot(t,y,'Color',[114 189 255]/255,'LineWidth',2); 
grid on

%----------------------------------
%２次の規範モデル
omegaM = 10;
zetaM  = 1/sqrt(2);
% P,Dゲインの設定
kI = 0;
kP = omegaM^2/b;
kD = (2*zetaM*omegaM-a)/b;
% simulinkシミュレーション
sim('PDmodel')
% 結果の表示（figure(2)）
figure(1);%subplot(2,1,1);
plot(t,y,'Color',[217 83 25]/255,'LineWidth',2); hold off

%----------------------------------
% グラフの整形
figure(1);
xlim([0 2.0])
ylim([0 0.2])
set(gca,'xtick',0:0.5:2)
set(gca,'ytick',0:0.05:0.2)
set(gca,'fontname','arial','fontsize',14)
xlabel('t  [s]','fontname','arial','fontsize',16)
ylabel('y(t)  [m]','fontname','arial','fontsize',16)
box on;


%----------------------------------
% グラフの凡例
figure(1);
legend('r(t)','wn = 5','wn = 10')
set(legend,'FontName','arial','FontSize',14)
