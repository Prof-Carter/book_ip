% 台車型倒立振子
% 台車の P 制御の実験データ

clear
format compact
close all

% --------------------------------------------------------
% kP = 2.5, zc = 0.2
load cdip_cart_pcont_data_kP_025_ref_02    % 実験データの読み込み    
t = t - 1;
figure(1)
plot(t,z,'b','LineWidth',2)
hold on

% --------------------------------------------------------
% kP = 5, zc = 0.2
load cdip_cart_pcont_data_kP_050_ref_02    % 実験データの読み込み
t = t - 1;
figure(1)
plot(t,z,'g','LineWidth',2)
hold on

% --------------------------------------------------------
% kP = 10, zc = 0.2
load cdip_cart_pcont_data_kP_100_ref_02    % 実験データの読み込み
t = t - 1;
figure(1)
plot(t,z,'r','LineWidth',2)
hold on

% --------------------------------------------------------
% kP = 20, zc = 0.2
load cdip_cart_pcont_data_kP_200_ref_02    % 実験データの読み込み
t = t - 1;
figure(1)
plot(t,z,'m','LineWidth',2)
hold off

% --------------------------------------------------------
xlim([0 2]);   set(gca,'Xtick',0:0.5:2)
ylim([0 0.3]); set(gca,'Ytick',0:0.1:0.3)

set(gca,'Fontname','arial','FontSize',14)
xlabel('Time [s]','Fontname','arial','FontSize',16)
ylabel('Position [m]','Fontname','arial','FontSize',16)
legend('kP = 2.5','kP = 5','kP = 10','kP = 20','Location','SouthEast')
set(legend,'Fontname','arial','FontSize',16)
