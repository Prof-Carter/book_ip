% アーム型倒立振子
% アームの P 制御の実験データ

clear
format compact
close all

% --------------------------------------------------------
% kP = 1, theta1c = 1
load adip_pcont_data_kP_1_ref_1
t = t - 1;
figure(1)
plot(t,theta1,'b','LineWidth',2)
hold on

% --------------------------------------------------------
% kP = 2, theta1c = 1
load adip_pcont_data_kP_2_ref_1
t = t - 1;
figure(1)
plot(t,theta1,'g','LineWidth',2)
hold on

% --------------------------------------------------------
% kP = 3, theta1c = 1
load adip_pcont_data_kP_3_ref_1
t = t - 1;
figure(1)
plot(t,theta1,'r','LineWidth',2)
hold on

% --------------------------------------------------------
% kP = 4, theta1c = 1
load adip_pcont_data_kP_4_ref_1
t = t - 1;
figure(1)
plot(t,theta1,'m','LineWidth',2)
hold on

% --------------------------------------------------------
% kP = 5, theta1c = 1
load adip_pcont_data_kP_5_ref_1
t = t - 1;
figure(1)
plot(t,theta1,'c','LineWidth',2)
hold off

xlim([0 2])
ylim([0 1.5])

set(gca,'Fontname','arial','FontSize',14)
xlabel('Time [s]','Fontname','arial','FontSize',16)
ylabel('Arm angle [rad]','Fontname','arial','FontSize',16)
legend('kP = 1','kP = 2','kP = 3','kP = 4','kP = 5','Location','SouthEast')
set(legend,'Fontname','arial','FontSize',16)
