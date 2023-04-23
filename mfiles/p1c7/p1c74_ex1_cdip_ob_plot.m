% 例 7.1
% 台車型倒立振子
% 出力フィードバック制御の非線形シミュレーションの結果の描画とアニメーション表示

clear
format compact
close all

% ----------------------------------------------------------------
format short e
% -----------------------------------
cdip_para
% -----------------------------------
J  = Jp + mp*lp^2;
a1 =  mp*g*lp/J;  a2 =  ac*mp*lp/J;
a3 =     -mup/J;  b1 = -bc*mp*lp/J;
% -----------------------------------
A = [ 0   0   1   0
      0   0   0   1
      0   0  -ac  0
      0   a1  a2  a3 ];
B = [ 0
      0
      bc
      b1 ];
C = [ 1   0   0   0
      0   1   0   0 ];
D = [ 0
      0 ];
% -----------------------------------
Mc = ctrb(A,B);
rank_Mc = rank(Mc)
pc = [ -6.5+1.5j
       -6.5-1.5j
       -4
       -2.5 ];
K = - place(A,B,pc)
% -----------------------------------
Mo = obsv(A,C);
rank_Mo = rank(Mo)
po = 4*pc;
L = - (place(A',C',po))'
% -----------------------------------
Ac = A + B*K + L*C + L*D*K
Bc = - L
Cc = K
% -----------------------------------
format short

% ===============================================
z_0      = 0;
theta_0  = 10*pi/180;
dz_0     = 0;
dtheta_0 = 0;

sim('cdip_ofbk_sim')

% --------------------------------------------------
figure(1)
plot(t,x(:,1),'r','LineWidth',2); hold on
plot(t,x_hat(:,1),'b--','LineWidth',2); hold off
xlim([0 0.5])
ylim([-0.05 0.15])
set(gca,'Ytick',-0.05:0.05:0.15)

set(gca,'Fontname','arial','FontSize',14)
xlabel('Time [s]','Fontname','arial','FontSize',16)
ylabel('Cart Position [m]','Fontname','arial','FontSize',16)

legend('${x}_{1}(t)$','$\widehat{x}_{1}(t)$')
legend('Location','SouthEast')
set(legend,'interpreter','latex','FontSize',16)

% --------------------------------------------------
figure(2)
plot(t,x(:,2)*180/pi,'r','LineWidth',2); hold on
plot(t,x_hat(:,2)*180/pi,'b--','LineWidth',2); hold off
xlim([0 0.5])
ylim([-10 15])
set(gca,'Ytick',-10:5:15)

set(gca,'Fontname','arial','FontSize',14)
xlabel('Time [s]','Fontname','arial','FontSize',16)
ylabel('Pendulum Angle [deg]','Fontname','arial','FontSize',16)

legend('${x}_{2}(t)$','$\widehat{x}_{2}(t)$')
legend('Location','NorthEast')
set(legend,'interpreter','latex','FontSize',16)

% --------------------------------------------------
figure(3)
plot(t,x(:,3),'r','LineWidth',2); hold on
plot(t,x_hat(:,3),'b--','LineWidth',2); hold off
xlim([0 0.5])
ylim([-0.5 1.5])
set(gca,'Ytick',-0.5:0.5:1.5)

set(gca,'Fontname','arial','FontSize',14)
xlabel('Time [s]','Fontname','arial','FontSize',16)
ylabel('Cart Velocity [m/s]','Fontname','arial','FontSize',16)

legend('${x}_{3}(t)$','$\widehat{x}_{3}(t)$')
legend('Location','NorthEast')
set(legend,'interpreter','latex','FontSize',16)

% --------------------------------------------------
figure(4)
plot(t,x(:,4)*180/pi,'r','LineWidth',2); hold on
plot(t,x_hat(:,4)*180/pi,'b--','LineWidth',2); hold off
xlim([0 0.5])
ylim([-180 60])
set(gca,'Ytick',-180:60:60)

set(gca,'Fontname','arial','FontSize',14)
xlabel('Time [s]','Fontname','arial','FontSize',16)
ylabel('Pendulum Angular Velocity [deg/s]','Fontname','arial','FontSize',16)

legend('${x}_{4}(t)$','$\widehat{x}_{4}(t)$')
legend('Location','SouthEast')
set(legend,'interpreter','latex','FontSize',16)

% --------------------------------------------------
% --------------------------------------------------
figure(5)
plot(t,x(:,1),'r','LineWidth',2)
xlim([0 2.5])
ylim([-0.05 0.15])
set(gca,'Ytick',-0.05:0.05:0.15)

set(gca,'Fontname','arial','FontSize',14)
xlabel('Time [s]','Fontname','arial','FontSize',16)
ylabel('Cart Position [m]','Fontname','arial','FontSize',16)

% --------------------------------------------------
figure(6)
plot(t,x(:,2)*180/pi,'r','LineWidth',2)
xlim([0 2.5])
ylim([-10 15])
set(gca,'Ytick',-10:5:15)

set(gca,'Fontname','arial','FontSize',14)
xlabel('Time [s]','Fontname','arial','FontSize',16)
ylabel('Pendulum Angle [deg]','Fontname','arial','FontSize',16)

% --------------------------------------------------
figure(7)
plot(t,u,'r','LineWidth',2)
xlim([0 2.5])
ylim([-5 5])
set(gca,'Ytick',-5:2.5:5)

set(gca,'Fontname','arial','FontSize',14)
xlabel('Time [s]','Fontname','arial','FontSize',16)
ylabel('Voltage [V]','Fontname','arial','FontSize',16)

% ===============================================================
% ===============================================================
disp('----- シミュレーション結果をアニメーション表示する場合は 1 を入力 -----')
flag = input('input number: ');

if flag == 1
    z = x(:,1);
    theta = x(:,2);

    % 表示のはやさは ip_toolbox_1.0.2/iptools/cdip_anime.m 内の
    %   mabiki = 25; 
    % の数値を変更する
    cdip_anime    % シミュレーション結果をアニメーション表示
end

