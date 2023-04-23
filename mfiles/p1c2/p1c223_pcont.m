%
% 2.2.3 P���� (�} 2.14�C�} 2.15�C�} 2.16�C�} 2.17)
%
% Simulink ���f���� PIDmodel2.slx
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
d = 0;
% d = -0.1;

alpha1 = 3; %�����ł͊֌W�Ȃ�
alpha2 = 3; %�����ł͊֌W�Ȃ�

%% P����i�} 2.14, 2.15�j %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%----------------------------------
%2���̋K�̓��f��
omegaM = 5;  
zetaM  = 1/sqrt(2);

% P�Q�C���̐ݒ�
kP = omegaM^2/b;              % �������ɒ��ځF(2.13)��
kD = 0;
kI = 0;
% simulink�V�~�����[�V����
sim('PIDmodel2')
% ���ʂ̕\���ifigure(1)�j
figure(1);%subplot(2,1,1);
plot(t,r,'k','LineWidth',1); hold on
plot(t,y,'Color',[114 189 255]/255,'LineWidth',2); 
grid on

%----------------------------------
%�Q���̋K�̓��f��
omegaM = 10;
zetaM  = 1/sqrt(2);
% P�Q�C���̐ݒ�
kP = omegaM^2/b;              % �������ɒ��ځF(2.13)��
kD = 0;
kI = 0;
% simulink�V�~�����[�V����
sim('PIDmodel2')
% ���ʂ̕\���ifigure(1)�j
figure(1);%subplot(2,1,1);
plot(t,y,'Color',[217 83 25]/255,'LineWidth',2); hold off

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

%----------------------------------
% �O���t�̖}��
figure(1);
legend('r(t)','wn = 5','wn = 10')
set(legend,'FontName','arial','FontSize',14)



%% P����i�} 2.16, 2.17 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%----------------------------------
%2���̋K�̓��f��
omegaM = 10;  
zetaM  = 1/sqrt(2);

% P�Q�C���̐ݒ�
kP = omegaM^2/b;              % �������ɒ��ځF(2.13)��
% kP = a^2/4/zetaM^2/b;       % �������ɒ��ځF��6 �̏ꍇ 
kD = 0;
kI = 0;
% simulink�V�~�����[�V����
sim('PIDmodel2')
% ���ʂ̕\���ifigure(1)�j
figure(2);%subplot(2,1,1);
plot(t,r,'k','LineWidth',1); hold on
plot(t,y,'Color',[114 189 255]/255,'LineWidth',2); 
grid on

sys1 = tf([0 b*kP],[1 a b*kP]);
figure(3);
hold on; grid on;
plot(real(pole(sys1)),imag(pole(sys1)),'x','Color',[114 189 255]/255,'LineWidth',1.5,'markersize',10)
theta = 0:0.01:2*pi;
x_circle = omegaM*cos(theta);
y_circle  = omegaM*sin(theta);
plot(x_circle,y_circle,'k','LineWidth',1)
x_circle = sqrt(a*omegaM/2/zetaM)*cos(theta);
y_circle  = sqrt(a*omegaM/2/zetaM)*sin(theta);
plot(x_circle,y_circle,'k','LineWidth',1)
axis('square')
xlim([-15 5])
ylim([-10 10])
set(gca,'FontSize',20,'FontName','arial')

%----------------------------------
%�Q���̋K�̓��f��
omegaM = 10;
zetaM  = 1/sqrt(2);
% P�Q�C���̐ݒ�
kP = a*omegaM/(2*b*zetaM);  % �}�N���[�����W�J�̂P���ߎ�����F�} 2.16 �̏ꍇ
kD = 0;
kI = 0;
% simulink�V�~�����[�V����
sim('PIDmodel2')
% ���ʂ̕\���ifigure(1)�j
figure(2);%subplot(2,1,1);
plot(t,y,'Color',[217 83 25]/255,'LineWidth',2);

plot(t,y_model,':','Color',[237 177 32]/255,'LineWidth',2); hold off  %%�K�̓��f���̉���

sys2 = tf([0 b*kP],[1 a b*kP]);
figure(3);
hold on; grid on;
plot(real(pole(sys2)),imag(pole(sys2)),'ro','Color',[217 83 25]/255,'LineWidth',1.5,'markersize',10)
sys3 = tf([0 omegaM^2],[1 2*zetaM*omegaM omegaM^2]);
figure(3);
hold on; grid on;
plot(real(pole(sys3)),imag(pole(sys3)),'k*','Color',[237 177 32]/255,'LineWidth',1.5,'markersize',10)

%----------------------------------
% �O���t�̐��`
figure(2);
xlim([0 2.0])
ylim([0 0.2])
set(gca,'xtick',0:0.5:2)
set(gca,'ytick',0:0.05:0.2)
set(gca,'FontName','arial','FontSize',14)
xlabel('t  [s]','FontName','arial','FontSize',16)
ylabel('y(t)  [m]','FontName','arial','FontSize',16)

%----------------------------------
% �O���t�̖}��
figure(2);
legend('$r(t)$','${k}_{\rm{P}} = {a}_{\rm{c}}{\omega}_{\rm{n}}/2{b}_{\rm{c}}\zeta$','${k}_{\rm{P}} = {\omega}_{\rm{n}}^{2}/{b}_{\rm{c}}$','Reference model')
set(legend,'interpreter','latex','FontName','arial','FontSize',16)

