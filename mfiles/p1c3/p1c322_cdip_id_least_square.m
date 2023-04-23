% 台車型倒立振子
% 最小二乗法によるパラメータ同定

clear
format compact
close all

load cdip_least_square_data    % 台車の P 制御の実験データの読み込み

% ---------------------------------------------------------
% 1 秒までのデータを削除
nn = length(t);

t_data = t;
z_data = z;
phi_data = phi;
v_data = v;

clear t z phi v;

% ---------------------------------------------------------
k = 1;
tmin = 1;
tmax = 5;
for i = 1:nn
  if t_data(i) >= tmin & t_data(i) <= tmax
    t(k)   = t_data(i) - 1;

    z(k)   = z_data(i);
    phi(k) = phi_data(i);
    v(k)   = v_data(i);

    k = k + 1;
  end
end

t = t';
z = z';
phi = phi';
v = v';

% サンプリング間隔 ts とデータ数 n
ts = 0.001;
n = length(t);

% ---------------------------------------------------------
% 三点微分
dz(1) = (- 3*z(1) + 4*z(2) - z(3))/(2*ts);
for i = 2:n-1
    dz(i) = (- z(i-1) + z(i+1))/(2*ts);
end
dz(n) = (z(n-2) - 4*z(n-1) + 3*z(n))/(2*ts);

% ---------------------------------------------------------
% 三点微分
ddz(1) = (- 3*dz(1) + 4*dz(2) - dz(3))/(2*ts);
for i = 2:n-1
  ddz(i) = (- dz(i-1) + dz(i+1))/(2*ts);
end
ddz(n) = (dz(n-2) - 4*dz(n-1) + 3*dz(n))/(2*ts);

% ---------------------------------------------------------
% 三点微分
dphi(1) = (- 3*phi(1) + 4*phi(2) - phi(3))/(2*ts);
for i = 2:n-1
  dphi(i) = (- phi(i-1) + phi(i+1))/(2*ts);
end
dphi(n) = (phi(n-2) - 4*phi(n-1) + 3*phi(n))/(2*ts);

% ---------------------------------------------------------
% 三点微分
ddphi(1) = (- 3*dphi(1) + 4*dphi(2) - dphi(3))/(2*ts);
for i = 2:n-1
  ddphi(i) = (- dphi(i-1) + dphi(i+1))/(2*ts);
end
ddphi(n) = (dphi(n-2) - 4*dphi(n-1) + 3*dphi(n))/(2*ts);

% ---------------------------------------------------------
dz  = dz';
ddz = ddz';
dphi  = dphi';
ddphi = ddphi';

% ---------------------------------------------------------
kP = 10;
Tf1 = 0.075;
Tf2 = 0.075;

mp = 1.07e-001;
lp = 2.30e-001;
g  = 9.81e+000;

% ---------------------------------------------------------
sim('cdip_least_square_MN_sim')

p1 = inv(Mf1'*Mf1)*Mf1'*Nf1;
p2 = inv(Mf2'*Mf2)*Mf2'*Nf2;

ac = p1(1);
bc = p1(2);

Jp  = p2(1);
mup = p2(2);

fprintf(' ****************************** \n')
fprintf('ac  = %5.2e\n',ac)
fprintf('bc  = %5.2e\n',bc)
fprintf('mp  = %5.2e\n',mp)
fprintf('lp  = %5.2e\n',lp)
fprintf('Jp  = %5.2e\n',Jp)
fprintf('mup = %5.2e\n',mup)
fprintf('g   = %5.2e\n',g)
fprintf(' ****************************** \n')

% ---------------------------------------------------------
     z_0 = 0;
 theta_0 = pi;
    dz_0 = 0;
dtheta_0 = 0;

sim('cdip_pcont_least_square_sim')

% ---------------------------------------------------------
figure(1)
plot(t,z,'r','LineWidth',2)
hold on
plot(t_sim,z_sim,'b--','LineWidth',2)
hold off

xlim([0 tmax-tmin])
ylim([0 0.3])
set(gca,'ytick',0:0.1:0.3)
set(gca,'FontName','arial','FontSize',14)
xlabel('Time [s]','FontName','arial','FontSize',16)
ylabel('Cart position [m]','FontName','arial','FontSize',16)
legend('Experiment','Simulation')
set(legend,'FontName','arial','FontSize',16)

% ---------------------------------------------------------
figure(2)
plot(t,phi*180/pi,'r','LineWidth',2)
hold on
plot(t_sim,phi_sim*180/pi,'b--','LineWidth',2)
hold off

xlim([0 tmax-tmin])
ylim([-60 60])
set(gca,'Ytick',-60:30:60)
set(gca,'FontName','arial','FontSize',14)
xlabel('Time [s]','FontName','arial','FontSize',16)
ylabel('Pendulum angle [deg]','FontName','arial','FontSize',16)
legend('Experiment','Simulation')
set(legend,'FontName','arial','FontSize',16)



