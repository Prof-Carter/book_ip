%
% 2.2.4 I-PD���� (�} 2.21)
%
% Simulink ���f���� IPDmodel.slx
%


clear
close all
format compact


     z_0 = 0;
 theta_0 = pi;
    dz_0 = 0;
dtheta_0 = 0;

%% ��Ԃ̃p�����[�^�ƖڕW�l %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%���f�� G = b/(s(s+a))
cdip_para
a  = ac;    % ��ԋ쓮�n�̃p�����[�^
b  = bc;    % ��ԋ쓮�n�̃p�����[�^

%�ڕW�l
ref = 0.1;

%�O��
% d = 0;
d = -0.1;


%% I-PD����i�} 2.21�j %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%3���̋K�̓��f��
omegaM = 10;

%----�񍀌W���W���`------------------
alpha1 = 3;
alpha2 = 3;
% P,I,D�Q�C���̐ݒ�
kI = omegaM^3/b;
kP = alpha1*omegaM^2/b;
kD = (alpha2*omegaM-a)/b;
% simulink�V�~�����[�V����
sim('IPDmodel')
% ���ʂ̕\���ifigure(1)�j
figure(1);%subplot(2,1,1); 
plot(t,r,'k','LineWidth',1); hold on 
plot(t,y,'Color',[114 189 255]/255,'LineWidth',2); 
grid on

%----�o�^�[���[�X�W���`---------------
alpha1 = 2;
alpha2 = 2;
% P,I,D�Q�C���̐ݒ�
kI = omegaM^3/b;
kP = alpha1*omegaM^2/b;
kD = (alpha2*omegaM-a)/b;
% simulink�V�~�����[�V����
sim('IPDmodel')
% ���ʂ̕\���ifigure(1)�j
figure(1);%subplot(2,1,1);
plot(t,y,'Color',[217 83 25]/255,'LineWidth',2);


%----ITAE�W���`---------------
alpha1 = 2.15;
alpha2 = 1.75;
% P,I,D�Q�C���̐ݒ�
kI = omegaM^3/b;
kP = alpha1*omegaM^2/b;
kD = (alpha2*omegaM-a)/b;
% simulink�V�~�����[�V����
sim('IPDmodel')
% ���ʂ̕\���ifigure(1)�j
figure(1);%subplot(2,1,1);
plot(t,y,'Color',[237 177 32]/255,'LineWidth',2); hold off


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
box on;


%----------------------------------
% �O���t�̖}��
figure(1);
legend('r(t)','Binomial coefficients','Butterworth','ITAE')
set(legend,'FontName','arial','FontSize',14)
