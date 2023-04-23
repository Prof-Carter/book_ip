% �� 5.8
% �A�[���^�|���U�q
% �œK���M�����[�^�ɂ��R���g���[���݌v

clear
format compact
close all

% ----------------------------------------------------------------
adip_para
theta1e = pi/4;
A = [ 0  0  1  0 
      0  0  0  1
      0  0 -a1 0
      0  alpha5/alpha2  (mu2+a1*alpha3*cos(theta1e))/alpha2  -mu2/alpha2 ];
B = [ 0
      0
      b1
     -b1*alpha3*cos(theta1e)/alpha2 ];
Q = diag([10 10 1 1]);
R = 1;
K = - lqr(A,B,Q,R)

% ===============================================================
% ===============================================================
% �ȉ��͒ǉ�

disp('----- �V�~�����[�V�������ʂ��A�j���[�V�����\������ꍇ�� 1 ����� -----')
flag = input('input number: ');

if flag == 1

     theta1_0 = 0;
     theta2_0 = 0;
    dtheta1_0 = 0;
    dtheta2_0 = 0;

    % D/A �ϊ��C�G���R�[�_�̕���\���l�����Ȃ��V�~�����[�V����
    sim('adip_lqr_sim',3)

    % D/A �ϊ��C�G���R�[�_�̕���\���l�������V�~�����[�V����
    % sim('adip_lqr2_sim',3)

    % �\���̂͂₳�� ip_toolbox_1.0.2/iptools/adip_anime.m ����
    %   mabiki = 25; 
    % �̐��l��ύX����
    adip_anime    % �V�~�����[�V�������ʂ��A�j���[�V�����\��
end
