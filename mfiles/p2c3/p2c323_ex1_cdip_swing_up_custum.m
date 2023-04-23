% 例 3.1
% 台車型倒立振子の振り上げ安定化制御
% （描画をカスタマイズ）

clear
cdip_para
% -------------------------------------
switch_angle = pi/4;
% -------------------------------------
K1 = 0.8;
% -------------------------------------
K2 = 30;
delta = 0;
% delta = 5;
p2c323_Sliding_Mode_Control
% -------------------------------------
z_0  = 0.1;  theta_0  = pi + 0.001;
dz_0 = 0;    dtheta_0 = 0;
% -------------------------------------
% sim('cdip_swing_up_sim') 
sim('cdip_swing_up2_sim') 
% -------------------------------------
figure(1)
plot(t,z,'r','LineWidth',2)
set(gca,'FontName','arial','FontSize',14)
xlabel('Time [s]','FontName','arial','FontSize',16)
ylabel('Cart Position [m]','FontName','arial','FontSize',16)
xlim([0 16])
set(gca,'XTick',0:2:16)
ylim([-0.4 0.4])
set(gca,'YTick',[-0.4 -0.2 0 0.1 0.2 0.4])

figure(2)
plot(t,theta*180/pi,'r','LineWidth',2)
set(gca,'FontName','arial','FontSize',14)
xlabel('Time [s]','FontName','arial','FontSize',16)
ylabel('Arm Angle [deg]','FontName','arial','FontSize',16)
xlim([0 16])
set(gca,'XTick',0:2:16)
ylim([-90 360])
set(gca,'YTick',-90:90:360)

figure(3)
plot(t,u,'r','LineWidth',2)
set(gca,'FontName','arial','FontSize',14)
xlabel('Time [s]','FontName','arial','FontSize',16)
ylabel('Voltage [V]','FontName','arial','FontSize',16)
xlim([0 16])
set(gca,'XTick',0:2:16)
ylim([-5 5])
set(gca,'YTick',-5:2.5:5)
% -------------------------------------
for i = 1:length(t)
    if abs(theta_up(i)) <= switch_angle
        i_sw = i;  t_sw = t(i_sw)
        break
    end
end
figure(4)
plot(t(1:i_sw-1),E(1:i_sw-1),'r','LineWidth',2)
set(gca,'FontName','arial','FontSize',14)
xlabel('Time [s]','FontName','arial','FontSize',16)
ylabel('E(t) [J]','FontName','arial','FontSize',16)
xlim([0 16])
set(gca,'XTick',0:2:16)
ylim([0 0.6])
set(gca,'YTick',0:0.15:0.6)

figure(5)
plot(t(i_sw:end),Sx(i_sw:end),'r','LineWidth',2)
set(gca,'FontName','arial','FontSize',14)
xlabel('Time [s]','FontName','arial','FontSize',16)
ylabel('S''x','FontName','arial','FontSize',16)
xlim([0 16])
set(gca,'XTick',0:2:16)
ylim([-1.6 1.6])
set(gca,'YTick',-1.6:0.8:1.6)

% ===============================================================
% ===============================================================
disp('----- シミュレーション結果をアニメーション表示する場合は 1 を入力 -----')
flag = input('input number: ');

if flag == 1
    % 表示のはやさは ip_toolbox_1.0.2/iptools/cdip_anime.m 内の
    %   mabiki = 25; 
    % の数値を変更する
    cdip_anime    % シミュレーション結果をアニメーション表示
end
