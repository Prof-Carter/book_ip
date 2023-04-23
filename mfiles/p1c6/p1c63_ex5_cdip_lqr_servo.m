% �� 6.5
% ��Ԍ^�|���U�q
% �œK���M�����[�^�ɂ��ϕ��^�T�[�{����

clear
format compact
close all

% ----------------------------
cdip_para

t_end = 5;
t_dis = 2.5;

r0 = 0.5;
d0 = 5;
% ---------------------------
Ap21 = [ 0  0
         0  mp*g*lp/(Jp+mp*lp^2) ];
Ap22 = [ -ac                      0
          ac*mp*lp/(Jp+mp*lp^2)  -mup/(Jp+mp*lp^2) ];
Bp2  = [  bc
         -bc*mp*lp/(Jp+mp*lp^2) ];
% ---------------------------
A = [ zeros(2,2)  eye(2)
      Ap21        Ap22   ];
B = [ zeros(2,1)
      Bp2        ];
C = [ 1  0  0  0 ];
% ---------------------------
     z_0 = 0;
 theta_0 = 0;
    dz_0 = 0;
dtheta_0 = 0;
% ----------------------------
n = size(A,2);
p = size(B,2);

At = [ A  zeros(n,p)
      -C  zeros(p,p) ];
Bt = [ B
       0 ];
Ct = [-C          zeros(p,p)
       zeros(p,n) eye(p,p)   ];
% ----------------------------
q1 = 800;
q2 = 20000;
R  = 1;
Q  = diag([q1 q2]);

Kt = -lqr(At,Bt,Ct'*Q*Ct,R);

K1 = Kt(1:4)
K2 = Kt(5)

% ---------------------------
% D/A �ϊ��C�G���R�[�_�̕���\���l�����Ȃ��V�~�����[�V����
sim('cdip_lqr_servo_sim')

% D/A �ϊ��C�G���R�[�_�̕���\���l�������V�~�����[�V����
% sim('cdip_lqr_servo2_sim')

% ---------------------------
figure(1)
stairs(t,r,'g')
hold on
plot(t,z,'r','linewidth',2)
hold off
set(gca,'FontName','arial','FontSize',14)
xlabel('Time [s]','FontName','arial','FontSize',16)
ylabel('Cart Position [m]','FontName','arial','FontSize',16)
ylim([-0.25 0.75])
set(gca,'Ytick',-0.25:0.25:0.75)

legend('Reference','Servo Control')
legend('Location','SouthEast')
set(legend,'Fontname','arial','FontSize',16)

% ---------
figure(2)
plot(t,theta*180/pi,'r','linewidth',2)
set(gca,'FontName','arial','FontSize',14)
xlabel('Time [s]','FontName','arial','FontSize',16)
ylabel('Pendulum Angle [deg]','FontName','arial','FontSize',16)
ylim([-20 20])
set(gca,'Ytick',-20:10:20)

% ---------
figure(3)
stairs(t,d,'g')
hold on
plot(t,u,'r','linewidth',2)
hold off
set(gca,'FontName','arial','FontSize',14)
xlabel('Time [s]','FontName','arial','FontSize',16)
ylabel('Voltage [V]','FontName','arial','FontSize',16)
ylim([-8 8])

legend('Disturbance','Input Voltage')
legend('Location','SouthWest')
set(legend,'Fontname','arial','FontSize',16)

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

