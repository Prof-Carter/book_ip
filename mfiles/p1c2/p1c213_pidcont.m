%
% 2.1.3 PID���� (�} 2.9)
%
% Simulink ���f���� PIDmodel.slx
%

clear
close all
format compact


% ����Ώۂ̏������
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
ref = 0.1; %[m]

%���͊O��
d = -0.1;


%% P���� %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%----------------------------------
% PID�Q�C���̐ݒ�
kP = 10;
kD = 0.8;
kI = 5;
% simulink�V�~�����[�V����
sim('PIDmodel')
% ���ʂ̕\���ifigure(1)�j
figure(1);%subplot(2,1,1);
plot(t,y,'k','LineWidth',2); hold on 
plot(t,r,'k','LineWidth',1); hold off
grid on

%----------------------------------
% �O���t�̐��`
figure(1);
xlim([0 2.0])
ylim([0 0.2])
set(gca,'xtick',0:0.5:2)
set(gca,'ytick',0:0.05:0.2)
set(gca,'FontName','arial','FontSize',14)
xlabel('t  [s]','FontName','arial','FontSize',16)
ylabel('y(t)  [m]','FontName','arial','FontSize',16)



