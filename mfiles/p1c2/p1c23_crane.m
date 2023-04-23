%
% 2.3 �N���[����PID���� (�} 2.24�C�} 2.25)
%
% Simulink ���f���� IPDmodel_crane.slx
%


clear
close all
format compact


     z_0 = 0;
 theta_0 = pi;
    dz_0 = 0;
dtheta_0 = 0;

%% ��Ԃ̃p�����[�^�ƖڕW�l %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%���f�� G = b/(s(s+a))
cdip_para
a  = ac;    % ��ԋ쓮�n�̃p�����[�^
b  = bc;    % ��ԋ쓮�n�̃p�����[�^

%�ڕW�l
ref = 0.1;

%�O��
d = 0;
% d = -0.1;


%% ��Ԃ�I-PD���� %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%3���̋K�̓��f��
omegaM = 10;

%----�o�^�[���[�X�W���`---------------
alpha1 = 2;
alpha2 = 2;
% P,I,D�Q�C���̐ݒ�
kI = omegaM^3/b;
kP = alpha1*omegaM^2/b;
kD = (alpha2*omegaM-a)/b;


%% �U�q�̐��� %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%�U�q�̐���Ȃ��i�}2.24�j
kP2 = 0;
kD2 = 0;

%�U�q�̐��䂠��i�}2.25�j
% kP2 = -1;
% kD2 = -0.1;

%% simulink�V�~�����[�V����
sim('IPDmodel_crane')
% ���ʂ̕\���ifigure(3)�j
figure(1);%subplot(2,1,1);
plot(t,r,'k','LineWidth',1); hold on;
plot(t,y,'Color',[114 189 255]/255,'LineWidth',2);

figure(2);hold on;
plot(t,phi,'Color',[114 189 255]/255,'LineWidth',2);

%----------------------------------
% �O���t�̐��`
figure(1);
xlim([0 10.0])
ylim([0 0.2])
set(gca,'xtick',0:2:10)
set(gca,'ytick',0:0.05:0.2)
set(gca,'FontName','arial','FontSize',14)
xlabel('t  [s]','FontName','arial','FontSize',16)
ylabel('y(t)  [m]','FontName','arial','FontSize',16)
box on; grid on;

figure(2);
xlim([0 10.0])
ylim([-pi/4 pi/4])
set(gca,'xtick',0:2:10)
set(gca,'ytick',-pi/4:pi/8:pi/4)
set(gca,'FontName','arial','FontSize',14)
set(gca,'FontName','symbol','yticklabel',{'-p/4','-p/8','0','p/8','p/4'})
xlabel('t  [s]','FontName','arial','FontSize',16)
ylabel('\phi(t)  [rad]','FontName','arial','FontSize',16)
box on; grid on;
