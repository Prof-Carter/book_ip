%
% 2.2.1 台車のモデリング (図 2.10，図 2.11)
%
% Simulink モデルは cart_model.slx
% cartident.m を使用 

clear
close all
format compact


% 制御対象の初期状態
     z_0 = 0;
 theta_0 = pi;
    dz_0 = 0;
dtheta_0 = 0;

%% 台車のパラメータ（真値）%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  Simulinkを用いて仮想的に同定実験を行うための設定
%  実験を行う場合は必要ない

%モデル G = b/(s(s+a))
cdip_para
a  = ac;    % 台車駆動系のパラメータ
b  = bc;    % 台車駆動系のパラメータ


%% 台車のパラメータ同定 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%----------------------------------


ref = 0.8;
% simulinkシミュレーション
sim('cart_model')
[dy,K1,T1] = cartident(t,y_raw,ref,0.001,1.5);
% 結果の表示（figure(1)）
figure(1);%subplot(2,2,1);
plot(t,dy,'Color',[114 189 255]/255,'LineWidth',2); hold on 
grid on

ref = 0.9;
% simulinkシミュレーション
sim('cart_model')
[dy,K2,T2] = cartident(t,y_raw,ref,0.001,1.5);
% 結果の表示（figure(1)）
figure(1);%subplot(2,1,1);
plot(t,dy,'Color',[217 83 25]/255,'LineWidth',2); hold on 
grid on

ref = 1.0;
% simulinkシミュレーション
sim('cart_model')
[dy,K3,T3] = cartident(t,y_raw,ref,0.001,1.5);
% 結果の表示（figure(1)）
figure(1);%subplot(2,1,1);
plot(t,dy,'Color',[237 177 32]/255,'LineWidth',2); hold on 
grid on

ref = 1.1;
% simulinkシミュレーション
sim('cart_model')
[dy,K4,T4] = cartident(t,y_raw,ref,0.001,1.5);
% 結果の表示（figure(1)）
plot(t,dy,'Color',[126 47 142]/255,'LineWidth',2); hold off 
grid on


Tave = round( ((T1+T2+T3+T4)/4)*10^3) / 10^3;
Kave = round( ((K1+K2+K3+K4)/4)*10^3) / 10^3;

fprintf('\n\n ************************ ')
fprintf('\n K = %3.3e',Kave)
fprintf('\n T = %3.3e',Tave)
fprintf('\n a = %3.3e',1/Tave)
fprintf('\n b = %3.3e',Kave/Tave)
fprintf('\n ************************ \n\n ')


%----------------------------------
% グラフの整形
figure(1);
xlim([0 1.5])
ylim([0 1])
set(gca,'xtick',0:0.5:1.5)
% set(gca,'ytick',0:1:4)
set(gca,'FontName','arial','FontSize',14)
xlabel('t [s]','FontName','arial','FontSize',16)
ylabel('dy(t)/dt [m]','FontName','arial','FontSize',16)

%----------------------------------
% グラフの凡例
figure(1);
legend('u(t) = 0.8','u(t) = 0.9','u(t) = 1.0','u(t) = 1.1','Location','SouthEast')
set(legend,'FontName','arial','FontSize',14)

%----------------------------------
figure(5);
subplot(2,1,1);
plot([0.8 0.9 1.0 1.1],[T1 T2 T3 T4],'bo-','Linewidth',2);
xlim([0.7 1.2])
ylim([0.1 0.2])
set(gca,'xtick',0.7:0.1:1.2)
set(gca,'ytick',0.1:0.05:0.2)
set(gca,'FontName','arial','FontSize',14)
xlabel('u [V]','FontName','arial','FontSize',16)
ylabel('T','FontName','arial','FontSize',16)
grid on

figure(6);
subplot(2,1,1);
plot([0.8 0.9 1.0 1.1],[K1 K2 K3 K4],'bo-','Linewidth',2);
xlim([0.7 1.2])
ylim([0.65 0.75])
set(gca,'xtick',0.7:0.1:1.2)
set(gca,'ytick',0.65:0.05:0.75)
set(gca,'FontName','arial','FontSize',14)
xlabel('u [V]','FontName','arial','FontSize',16)
ylabel('K','FontName','arial','FontSize',16)
grid on

