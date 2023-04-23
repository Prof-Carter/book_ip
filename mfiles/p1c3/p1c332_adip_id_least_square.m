% アーム型倒立振子
% 最小二乗法によるパラメータ同定

clear
format compact
close all

load adip_least_square_data    % アームの P 制御の実験データの読み込み

% ---------------------------------------------------------
% 1 秒までのデータを削除
nn = length(t);

t_data = t;
phi1_data = phi1;
phi2_data = phi2;
v_data = v;

clear t phi1 phi2 v;

% ---------------------------------------------------------
k = 1;
tmin = 1;
tmax = 9;
for i = 1:nn
  if t_data(i) >= tmin & t_data(i) <= tmax
    t(k)   = t_data(i) - 1;

    phi1(k) = phi1_data(i);
    phi2(k) = phi2_data(i);
    v(k)    = v_data(i);

    k = k + 1;
  end
end

t = t';
phi1 = phi1';
phi2 = phi2';
v = v';

% サンプリング間隔 ts とデータ数 n
ts = 0.001;
n = length(t);

% ---------------------------------------------------------
% 三点微分
dphi1(1) = (- 3*phi1(1) + 4*phi1(2) - phi1(3))/(2*ts);
for i = 2:n-1
  dphi1(i) = (- phi1(i-1) + phi1(i+1))/(2*ts);
end
dphi1(n) = (phi1(n-2) - 4*phi1(n-1) + 3*phi1(n))/(2*ts);

% ---------------------------------------------------------
% 三点微分
ddphi1(1) = (- 3*dphi1(1) + 4*dphi1(2) - dphi1(3))/(2*ts);
for i = 2:n-1
  ddphi1(i) = (- dphi1(i-1) + dphi1(i+1))/(2*ts);
end
ddphi1(n) = (dphi1(n-2) - 4*dphi1(n-1) + 3*dphi1(n))/(2*ts);

% ---------------------------------------------------------
% 三点微分
dphi2(1) = (- 3*phi2(1) + 4*phi2(2) - phi2(3))/(2*ts);
for i = 2:n-1
    dphi2(i) = (- phi2(i-1) + phi2(i+1))/(2*ts);
end
dphi2(n) = (phi2(n-2) - 4*phi2(n-1) + 3*phi2(n))/(2*ts);

% ---------------------------------------------------------
% 三点微分
ddphi2(1) = (- 3*dphi2(1) + 4*dphi2(2) - dphi2(3))/(2*ts);
for i = 2:n-1
  ddphi2(i) = (- dphi2(i-1) + dphi2(i+1))/(2*ts);
end
ddphi2(n) = (dphi2(n-2) - 4*dphi2(n-1) + 3*dphi2(n))/(2*ts);

% ---------------------------------------------------------
dphi1  = dphi1';
ddphi1 = ddphi1';
dphi2  = dphi2';
ddphi2 = ddphi2';

% ---------------------------------------------------------
kP = 3;
Tf1 = 0.075;
Tf2 = 0.075;

L1 = 2.27e-001;
m2 = 9.60e-002;
l2 = 1.95e-001;
L2 = 3.00e-001;

g  = 9.81e+000;

alpha3 = m2*L1*l2;
alpha5 = m2*l2*g;

% -----------------------------------------
sim('adip_least_square_MN_sim')

p1 = inv(Mf1'*Mf1)*Mf1'*Nf1;
p2 = inv(Mf2'*Mf2)*Mf2'*Nf2;

a1 = p1(1);
b1 = p1(2);

alpha2 = p2(1);
mu2    = p2(2);

J2 = alpha2 - m2*l2^2;

fprintf(' ****************************** \n')
fprintf('a1  = %5.2e\n',a1)
fprintf('b1  = %5.2e\n',b1)
fprintf('L1  = %5.2e\n',L1)
fprintf('m2  = %5.2e\n',m2)
fprintf('l2  = %5.2e\n',l2)
fprintf('L2  = %5.2e\n',L2)
fprintf('g   = %5.2e\n',g)
fprintf('J2  = %5.2e\n',J2)
fprintf('mu2 = %5.2e\n',mu2)
fprintf(' ****************************** \n')

% ---------------------------------------------------------
 theta1_0 = 0;
 theta2_0 = pi;
dtheta1_0 = 0;
dtheta2_0 = 0;

sim('adip_pcont_least_square_sim')

% ---------------------------------------------------------
figure(1)
plot(t,phi1,'r','LineWidth',2)
hold on
plot(t_sim,phi1_sim,'b--','LineWidth',2)
hold off

xlim([0 tmax-tmin])
set(gca,'FontName','arial','FontSize',14)
xlabel('Time [s]','FontName','arial','FontSize',16)
ylabel('Arm angle [rad]','FontName','arial','FontSize',16)
legend('Experiment','Simulation')
set(legend,'FontName','arial','FontSize',16)

% ---------------------------------------------------------
figure(2)
plot(t,phi2,'r','LineWidth',2)
hold on
plot(t_sim,phi2_sim,'b--','LineWidth',2)
hold off

xlim([0 tmax-tmin])
set(gca,'FontName','arial','FontSize',14)
xlabel('Time [s]','FontName','arial','FontSize',16)
ylabel('Pendulum angle [rad]','FontName','arial','FontSize',16)
legend('Experiment','Simulation')
set(legend,'FontName','arial','FontSize',16)




