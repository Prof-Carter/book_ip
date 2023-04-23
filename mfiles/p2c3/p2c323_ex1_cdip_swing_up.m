% �� 3.1
% ��Ԍ^�|���U�q�̐U��グ���艻����

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
disp('----- �V�~�����[�V�������ʂ��A�j���[�V�����\������ꍇ�� 1 ����� -----')
flag = input('input number: ');

if flag == 1
    % �\���̂͂₳�� ip_toolbox_1.0.2/iptools/cdip_anime.m ����
    %   mabiki = 25; 
    % �̐��l��ύX����
    cdip_anime    % �V�~�����[�V�������ʂ��A�j���[�V�����\��
end
