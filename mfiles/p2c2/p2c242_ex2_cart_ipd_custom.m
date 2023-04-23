% �� 2.2
% ��Ԍ^�쓮�n�� I-PD ����ɂ����闣�U���̉e��
% �i�O���t�̕`����J�X�^�}�C�Y�j

clear
format compact
close all

cdip_para
% -------------------------------------
wn = 25;
a1 = 3;
a2 = 3;
kI = wn^3/bc;
kP = a1*wn^2/bc;
kD = (a2*wn - ac)/bc;
% -------------------------------------
ts = 0.025;
t_sim = 0.001;
% -------------------------------------
sim('cart_ipd_sim')
% -------------------------------------
figure(1)
plot(t,y,t,yc,'LineWidth',2)
set(gca,'FontName','arial','FontSize',14)
ylim([0 0.2])
xlabel('Time [s]','FontName','arial','FontSize',16)
ylabel('Cart [m]','FontName','arial','FontSize',16)
legend('Discrete time control','Continuous time control','Location','NorthWest')
set(legend,'FontName','arial','FontSize',16)

figure(2)
plot(t,u,t,uc,'LineWidth',2)
set(gca,'FontName','arial','FontSize',14)
ylim([-10 10])
xlabel('Time [s]','FontName','arial','FontSize',16)
ylabel('Voltage [V]','FontName','arial','FontSize',16)
legend('Discrete time control','Continuous time control')
set(legend,'FontName','arial','FontSize',16)
