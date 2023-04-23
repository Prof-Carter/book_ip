%
% 2.2.3 P制御 (図 2.14，図 2.15，図 2.16，図 2.17)
%
% Simulink モデルは PIDmodel2.slx
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
d = 0;
% d = -0.1;

alpha1 = 3; %ここでは関係ない
alpha2 = 3; %ここでは関係ない

%% P制御（図 2.14, 2.15） %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%----------------------------------
%2次の規範モデル
omegaM = 5;  
zetaM  = 1/sqrt(2);

% Pゲインの設定
kP = omegaM^2/b;              % 速応性に着目：(2.13)式
kD = 0;
kI = 0;
% simulinkシミュレーション
sim('PIDmodel2')
% 結果の表示（figure(1)）
figure(1);%subplot(2,1,1);
plot(t,r,'k','LineWidth',1); hold on
plot(t,y,'Color',[114 189 255]/255,'LineWidth',2); 
grid on

%----------------------------------
%２次の規範モデル
omegaM = 10;
zetaM  = 1/sqrt(2);
% Pゲインの設定
kP = omegaM^2/b;              % 速応性に着目：(2.13)式
kD = 0;
kI = 0;
% simulinkシミュレーション
sim('PIDmodel2')
% 結果の表示（figure(1)）
figure(1);%subplot(2,1,1);
plot(t,y,'Color',[217 83 25]/255,'LineWidth',2); hold off

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

%----------------------------------
% グラフの凡例
figure(1);
legend('r(t)','wn = 5','wn = 10')
set(legend,'FontName','arial','FontSize',14)



%% P制御（図 2.16, 2.17 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%----------------------------------
%2次の規範モデル
omegaM = 10;  
zetaM  = 1/sqrt(2);

% Pゲインの設定
kP = omegaM^2/b;              % 速応性に着目：(2.13)式
% kP = a^2/4/zetaM^2/b;       % 減衰性に着目：注6 の場合 
kD = 0;
kI = 0;
% simulinkシミュレーション
sim('PIDmodel2')
% 結果の表示（figure(1)）
figure(2);%subplot(2,1,1);
plot(t,r,'k','LineWidth',1); hold on
plot(t,y,'Color',[114 189 255]/255,'LineWidth',2); 
grid on

sys1 = tf([0 b*kP],[1 a b*kP]);
figure(3);
hold on; grid on;
plot(real(pole(sys1)),imag(pole(sys1)),'x','Color',[114 189 255]/255,'LineWidth',1.5,'markersize',10)
theta = 0:0.01:2*pi;
x_circle = omegaM*cos(theta);
y_circle  = omegaM*sin(theta);
plot(x_circle,y_circle,'k','LineWidth',1)
x_circle = sqrt(a*omegaM/2/zetaM)*cos(theta);
y_circle  = sqrt(a*omegaM/2/zetaM)*sin(theta);
plot(x_circle,y_circle,'k','LineWidth',1)
axis('square')
xlim([-15 5])
ylim([-10 10])
set(gca,'FontSize',20,'FontName','arial')

%----------------------------------
%２次の規範モデル
omegaM = 10;
zetaM  = 1/sqrt(2);
% Pゲインの設定
kP = a*omegaM/(2*b*zetaM);  % マクローリン展開の１次近似する：図 2.16 の場合
kD = 0;
kI = 0;
% simulinkシミュレーション
sim('PIDmodel2')
% 結果の表示（figure(1)）
figure(2);%subplot(2,1,1);
plot(t,y,'Color',[217 83 25]/255,'LineWidth',2);

plot(t,y_model,':','Color',[237 177 32]/255,'LineWidth',2); hold off  %%規範モデルの応答

sys2 = tf([0 b*kP],[1 a b*kP]);
figure(3);
hold on; grid on;
plot(real(pole(sys2)),imag(pole(sys2)),'ro','Color',[217 83 25]/255,'LineWidth',1.5,'markersize',10)
sys3 = tf([0 omegaM^2],[1 2*zetaM*omegaM omegaM^2]);
figure(3);
hold on; grid on;
plot(real(pole(sys3)),imag(pole(sys3)),'k*','Color',[237 177 32]/255,'LineWidth',1.5,'markersize',10)

%----------------------------------
% グラフの整形
figure(2);
xlim([0 2.0])
ylim([0 0.2])
set(gca,'xtick',0:0.5:2)
set(gca,'ytick',0:0.05:0.2)
set(gca,'FontName','arial','FontSize',14)
xlabel('t  [s]','FontName','arial','FontSize',16)
ylabel('y(t)  [m]','FontName','arial','FontSize',16)

%----------------------------------
% グラフの凡例
figure(2);
legend('$r(t)$','${k}_{\rm{P}} = {a}_{\rm{c}}{\omega}_{\rm{n}}/2{b}_{\rm{c}}\zeta$','${k}_{\rm{P}} = {\omega}_{\rm{n}}^{2}/{b}_{\rm{c}}$','Reference model')
set(legend,'interpreter','latex','FontName','arial','FontSize',16)

