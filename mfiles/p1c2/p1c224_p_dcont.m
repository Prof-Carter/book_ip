%
% 2.2.4 P-D���� (�} 2.19)
%
% Simulink ���f���� PDmodel.slx
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


%% P-D����i�} 2.19�j %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%----------------------------------
%�Q���̋K�̓��f��
omegaM = 5;
zetaM  = 1/sqrt(2);
% P,D�Q�C���̐ݒ�
kI = 0;
kP = omegaM^2/b;
kD = (2*zetaM*omegaM-a)/b;
% simulink�V�~�����[�V����
sim('PDmodel')
% ���ʂ̕\���ifigure(2)�j
figure(1);%subplot(2,1,1); 
plot(t,r,'k','LineWidth',1); hold on 
plot(t,y,'Color',[114 189 255]/255,'LineWidth',2); 
grid on

%----------------------------------
%�Q���̋K�̓��f��
omegaM = 10;
zetaM  = 1/sqrt(2);
% P,D�Q�C���̐ݒ�
kI = 0;
kP = omegaM^2/b;
kD = (2*zetaM*omegaM-a)/b;
% simulink�V�~�����[�V����
sim('PDmodel')
% ���ʂ̕\���ifigure(2)�j
figure(1);%subplot(2,1,1);
plot(t,y,'Color',[217 83 25]/255,'LineWidth',2); hold off

%----------------------------------
% �O���t�̐��`
figure(1);
xlim([0 2.0])
ylim([0 0.2])
set(gca,'xtick',0:0.5:2)
set(gca,'ytick',0:0.05:0.2)
set(gca,'fontname','arial','fontsize',14)
xlabel('t  [s]','fontname','arial','fontsize',16)
ylabel('y(t)  [m]','fontname','arial','fontsize',16)
box on;


%----------------------------------
% �O���t�̖}��
figure(1);
legend('r(t)','wn = 5','wn = 10')
set(legend,'FontName','arial','FontSize',14)
