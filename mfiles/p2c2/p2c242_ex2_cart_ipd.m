% �� 2.2
% ��Ԍ^�쓮�n�� I-PD ����ɂ����闣�U���̉e��

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
plot(t,y,t,yc)
ylim([0 0.2])
xlabel('Time [s]'); ylabel('Cart [m]')
figure(2)
plot(t,u,t,uc)
ylim([-10 10])
xlabel('Time [s]'); ylabel('Voltage [V]')
