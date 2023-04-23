% 例 3.1
% 台車型倒立振子の振り上げ安定化制御

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
sim('cdip_swing_up_sim') 
% sim('cdip_swing_up2_sim') 
% -------------------------------------
figure(1); plot(t,z);
xlim([0 16]); set(gca,'XTick',0:2:16)
xlabel('Time [s]'); ylabel('Cart [m]')
figure(2); plot(t,theta*180/pi);
xlim([0 16]); set(gca,'XTick',0:2:16)
xlabel('Time [s]'); ylabel('Pendulum [deg]')
figure(3); plot(t,u);
xlim([0 16]); set(gca,'XTick',0:2:16)
xlabel('Time [s]'); ylabel('Voltage [V]')
% -------------------------------------
for i = 1:length(t)
    if abs(theta_up(i)) <= switch_angle
        i_sw = i;  t_sw = t(i_sw)
        break
    end
end
figure(4); plot(t(1:i_sw-1),E(1:i_sw-1))
xlim([0 16]); set(gca,'XTick',0:2:16)
xlabel('Time [s]'); ylabel('E(t) [J]')
figure(5); plot(t(i_sw:end),Sx(i_sw:end))
xlim([0 16]); set(gca,'XTick',0:2:16)
xlabel('Time [s]'); ylabel('S''x')

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
