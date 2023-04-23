% �� 2.1
% ��Ԍ^�|���U�q�̗ʎq�����͐���

clear
format compact
format short e
close all

cdip_para
% -------------------------------------
Ap21 = [ 0  0
         0  mp*g*lp/(Jp+mp*lp^2) ];
Ap22 = [ -ac                      0
          ac*mp*lp/(Jp+mp*lp^2)  -mup/(Jp+mp*lp^2) ];
Bp2  = [  bc
         -bc*mp*lp/(Jp+mp*lp^2) ];
% -------------------------------------
A   = [ zeros(2,2)  eye(2)
        Ap21        Ap22   ];
B   = [ zeros(2,1)
        Bp2        ];
Cd1 = [ eye(2)  zeros(2,2) ];
Cd2 =   eye(4);
% -------------------------------------
Q = diag([10 10 0 0]);
R = 1;
K = - lqr(A,B,Q,R); 
% -------------------------------------
ts = 0.01; 
[Ad Bd] = c2d(A,B,ts); 
Sigma_Pd.a  = Ad;
Sigma_Pd.b  = Bd;
Sigma_Pd.c1 = Cd1;
Sigma_Pd.c2 = Cd2;
% -------------------------------------
Sigma_K.a  = zeros(4,4);
Sigma_K.b1 = zeros(4,1);
Sigma_K.b2 = zeros(4,4);
Sigma_K.c  = zeros(1,4);
Sigma_K.d1 = 0;
Sigma_K.d2 = K;
% -------------------------------------
Sigma_G = compg(Sigma_Pd,Sigma_K,'fbiq')
% -------------------------------------
d = 2;
T = 300;
% gamma.vu = 1;
% gamma.wu = 3.35;
gamma.uv = 1;
gamma.wv = 3.35;
dim = 2;
% -------------------------------------
[Sigma_Q E H] = odq(Sigma_G,T,d,gamma,dim,'sedumi')
% -------------------------------------
z_0  = 0;  theta_0  = pi/18;   % <---- 10 [deg]
dz_0 = 0;  dtheta_0 = 0;
t_end = 5;
% -------------------------------------
sim('cdip_odq_sim')
% -------------------------------------
figure(1)
plot(t,z_d,'r',t,z_c,'g')
xlabel('Time [s]'); ylabel('Cart [m]')
figure(2)
plot(t,theta_d*180/pi,'r',t,theta_c*180/pi,'g')
xlabel('Time [s]'); ylabel('Pendulum [deg]')
figure(3)
plot(t,u_d,'r',t,u_c,'g')
xlabel('Time [s]'); ylabel('Voltage [V]')


% ===============================================================
% ===============================================================
% �ȉ��͒ǉ�

disp(' ')
disp('----- �V�~�����[�V�������ʂ̃A�j���[�V�����\�� -----')
disp('�@�@�@ �@�@�A�j���[�V�����\�����Ȃ� ===> 0 ����� ')
disp('�@�@�@ �@�@�ʎq�����͐���@ ===> 1 ����� ')
disp('�@�@�@ �@�@�œK���M�����[�^ ===> 2 ����� ')
flag = input('input number: ');

% �\���̂͂₳�� ip_toolbox_1.0.2/iptools/cdip_anime.m ����
%   mabiki = 25; 
% �̐��l��ύX����
switch flag 
    case 1
        z = z_d;
        theta = theta_d;
        cdip_anime    % �V�~�����[�V�������ʂ��A�j���[�V�����\��
    case 2
        z = z_c;
        theta = theta_c;
        cdip_anime    % �V�~�����[�V�������ʂ��A�j���[�V�����\��
end
