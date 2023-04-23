% アーム型倒立振子
% 2 次遅れ系の特性に注目したアームのパラメータ同定

clear
format compact
close all

% --------------------------------------------------------
% kP = 3, theta1c = 1
load adip_pcont_data_kP_3_ref_1    % 台車の P 制御の実験データの読み込み
kP = 3;

theta1c = 1;

t_data = t;
theta1_data = theta1;
theta2_data = theta2;

clear t theta1 theta2

k = 1;
for i = 1:length(t_data)
    if t_data(i) >= 1
        t(k) = t_data(i) - 1;
        theta1(k) = theta1_data(i);
        theta2(k) = theta2_data(i);
        k = k + 1;
    end
end

% -----------------------
[theta1_max imax] = max(theta1);

for i = imax:length(t)
    if theta1(i) == theta1_max
        imax_last = i;
    end
    if theta1(i) < theta1_max
        break
    end
end

Tp = (t(imax) + t(imax_last))/2;

% -----------------------
figure(1)
stairs(t,theta1,'r','linewidth',2);
hold on

% -----------------------
Amax = theta1_max - theta1c;

gamma = - (1/Tp)*log(Amax/theta1c);
delta = pi/Tp;

omega_n = sqrt(gamma^2 + delta^2);
zeta    = gamma/omega_n;

a1 = 2*zeta*omega_n;
b1 = omega_n^2/kP;

% -----------------------
fprintf(' ****************************** \n')
fprintf('Tp   = %5.2e\n',Tp)
fprintf('Amax = %5.2e\n',Amax)
fprintf('gamma_1  = %5.2e\n',gamma)
fprintf('delta_1  = %5.2e\n',delta)
fprintf('zeta_1   = %5.2e\n',zeta)
fprintf('omega_n1 = %5.2e\n',omega_n)
fprintf('a1  = %5.2e\n',a1)
fprintf('b1  = %5.2e\n',b1)
fprintf(' ****************************** \n')

% -----------------------
sysGyr = tf(omega_n^2,[1 2*zeta*omega_n omega_n^2])
theta1_sim = theta1c*step(sysGyr,t);

% -----------------------
figure(1)
plot(t,theta1_sim,'b--','linewidth',2);

plot(Tp*[0 1],theta1_max*[1 1],'k')
plot(Tp*[1 1],theta1_max*[0 1],'k')
hold off

% -----------------------
xlim([0 2]);   set(gca,'xtick',0:0.5:2)
ylim([0 1.5]); set(gca,'ytick',0:0.5:2.5)

% --------------------------------------------------------
set(gca,'FontName','arial','FontSize',14)
xlabel('Time [s]','FontName','arial','FontSize',16)
ylabel('Arm angle [rad]','FontName','arial','FontSize',16)
legend('Experiment','Simulation')
set(legend,'FontName','arial','FontSize',16)
