clear
format compact
close all

load cdip_least_square_data  


% 1 秒までのデータを削除
nn = length(t);

t_data = t;
z_data = z;
phi_data = phi;
v_data = v;

clear t z phi v;

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

%%% 三点微分
dz(1) = (- 3*z(1) + 4*z(2) - z(3))/(2*ts);
for i = 2:n-1
    dz(i) = (- z(i-1) + z(i+1))/(2*ts);
end
dz(n) = (z(n-2) - 4*z(n-1) + 3*z(n))/(2*ts);

% --------------------------------------
ddz(1) = (- 3*dz(1) + 4*dz(2) - dz(3))/(2*ts);
for i = 2:n-1
  ddz(i) = (- dz(i-1) + dz(i+1))/(2*ts);
end
ddz(n) = (dz(n-2) - 4*dz(n-1) + 3*dz(n))/(2*ts);

% --------------------------------------
dphi(1) = (- 3*phi(1) + 4*phi(2) - phi(3))/(2*ts);
for i = 2:n-1
  dphi(i) = (- phi(i-1) + phi(i+1))/(2*ts);
end
dphi(n) = (phi(n-2) - 4*phi(n-1) + 3*phi(n))/(2*ts);

% --------------------------------------
ddphi(1) = (- 3*dphi(1) + 4*dphi(2) - dphi(3))/(2*ts);
for i = 2:n-1
  ddphi(i) = (- dphi(i-1) + dphi(i+1))/(2*ts);
end
ddphi(n) = (dphi(n-2) - 4*dphi(n-1) + 3*dphi(n))/(2*ts);

% ---------------------------------
dz  = dz';
ddz = ddz';
dphi  = dphi';
ddphi = ddphi';

% -----------------------------------------
kP = 10;
Tf1 = 0.05;
Tf2 = 0.05;

mp = 1.07e-001;
lp = 2.30e-001;
g  = 9.81e+000;

% -----------------------------------------
sim('cdip_least_square_MN_sim') 

% -----------------------------------------
figure(1);
stairs(t,M1(:,1),'b','LineWidth',2)
hold on
stairs(t,Mf1(:,1),'r','LineWidth',2)
hold off

set(gca,'FontName','arial','FontSize',14)
xlabel('Time [s]','FontName','arial','FontSize',16)
ylabel('{M}_{1,1}(t) and {M}_{f1,1}(t)','FontName','arial','FontSize',16)
legend('{M}_{1,1}(t)','{M}_{f1,1}(t)','Location','SouthEast')
set(legend,'FontName','arial','FontSize',16)

% -----------------------------------------
figure(2);
stairs(t,M1(:,2),'b','LineWidth',2)
hold on
stairs(t,Mf1(:,2),'r','LineWidth',2)
hold off

set(gca,'FontName','arial','FontSize',14)
xlabel('Time [s]','FontName','arial','FontSize',16)
ylabel('{M}_{1,2}(t) and {M}_{f1,2}(t)','FontName','arial','FontSize',16)
legend('{M}_{1,2}(t)','{M}_{f1,2}(t)','Location','NorthEast')
set(legend,'FontName','arial','FontSize',16)

% -----------------------------------------
figure(3);
stairs(t,N1,'b','LineWidth',2)
hold on
stairs(t,Nf1,'r','LineWidth',2)
hold off

set(gca,'FontName','arial','FontSize',14)
xlabel('Time [s]','FontName','arial','FontSize',16)
ylabel('{N}_{1}(t) and {N}_{f1}(t)','FontName','arial','FontSize',16)
legend('{N}_{1}(t)','{N}_{f1}(t)','Location','NorthEast')
set(legend,'FontName','arial','FontSize',16)

% -----------------------------------------
figure(4);
stairs(t,M2(:,1),'b','LineWidth',2)
hold on
stairs(t,Mf2(:,1),'r','LineWidth',2)
hold off
ylim([-300 300])

set(gca,'FontName','arial','FontSize',14)
xlabel('Time [s]','FontName','arial','FontSize',16)
ylabel('{M}_{2,1}(t) and {M}_{f2,1}(t)','FontName','arial','FontSize',16)
legend('{M}_{2,1}(t)','{M}_{f2,1}(t)','Location','SouthEast')
set(legend,'FontName','arial','FontSize',16)

% -----------------------------------------
figure(5);
stairs(t,M2(:,2),'b','LineWidth',2)
hold on
stairs(t,Mf2(:,2),'r','LineWidth',2)
hold off

set(gca,'FontName','arial','FontSize',14)
xlabel('Time [s]','FontName','arial','FontSize',16)
ylabel('{M}_{2,2}(t) and {M}_{f2,2}(t)','FontName','arial','FontSize',16)
legend('{M}_{2,2}(t)','{M}_{f2,2}(t)','Location','SouthEast')
set(legend,'FontName','arial','FontSize',16)

% -----------------------------------------
figure(6);
stairs(t,N2,'b','LineWidth',2)
hold on
stairs(t,Nf2,'r','LineWidth',2)
hold off
ylim([-1 1])

set(gca,'FontName','arial','FontSize',14)
xlabel('Time [s]','FontName','arial','FontSize',16)
ylabel('{N}_{2}(t) and {N}_{f2}(t)','FontName','arial','FontSize',16)
legend('{N}_{2}(t)','{N}_{f2}(t)','Location','NorthEast')
set(legend,'FontName','arial','FontSize',16)

% =======================================================================
% 図 3.13
% =======================================================================
figure(11);
stairs(t,N2(:,1),'b','LineWidth',2);
xlim([2.2 2.4])
set(gca,'xtick',2.2:0.04:2.4)

set(gca,'FontName','arial','FontSize',14)
xlabel('Time [s]','FontName','arial','FontSize',16)
ylabel('{N}_{2}(t)','FontName','arial','FontSize',16)
set(legend,'FontName','arial','FontSize',16)

% -----------------------------------------
figure(12);
stairs(t,Nf2(:,1),'r','LineWidth',2)
xlim([2.2 2.4])
set(gca,'xtick',2.2:0.04:2.4)
ylim([-0.02 0.04])

set(gca,'FontName','arial','FontSize',14)
xlabel('Time [s]','FontName','arial','FontSize',16)
ylabel('{N}_{f2}(t)','FontName','arial','FontSize',16)
set(legend,'FontName','arial','FontSize',16)


