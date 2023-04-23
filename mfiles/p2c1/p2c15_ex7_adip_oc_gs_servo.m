% 例 1.7
% アーム型倒立振子
% ゲインスケジューリング制御の非線形シミュレーション結果とアニメーション表示

clear
format compact
close all

% ---------------------------
adip_para
% ---------------------------
A21_0 = [ 0  0
          0  alpha5/alpha2 ];
A21_1 = zeros(2,2);     
A22_0 = [ -a1                      0
          (a1*alpha3+mu2)/alpha2  -mu2/alpha2];     
A22_1 = [ 0                        0
         -a1*alpha3/alpha2        0 ];
B2_0 = [  b1
         -b1*alpha3/alpha2 ];
B2_1 = [  0
          b1*alpha3/alpha2];
% ---------------------------
A_0 = [ zeros(2,2)  eye(2)
        A21_0       A22_0 ];
A_1 = [ zeros(2,2)  zeros(2,2)
        A21_1       A22_1 ];
B_0 = [ zeros(2,1)
        B2_0       ];
B_1 = [ zeros(2,1)
        B2_1       ];
C_0 = [ 1  0  0  0 ];
C_1 = [ 0  0  0  0 ];
% ----------------------------
At_0 = [ A_0  zeros(4,1)
        -C_0  0          ];
At_1 = [ A_1  zeros(4,1)
        -C_1  0          ];
Bt_0 = [ B_0
         0   ];
Bt_1 = [ B_1
         0   ];
% ----------------------------
n = length(At_0);
m = size(Bt_0,2);
% ----------------------------
% optimal control
Q = diag([0.1 1 0.001 0.001 4]);
R = 1;
% ----------------------------
% parameter region
th1_max = 65*pi/180;
drho_max = 0.75;
rho_max = 1 - cos(th1_max);

th10_max = 65*pi/180;
rho0_max = 1 - cos(th10_max);
% ----------------------------
% constraints
sdpvar rho0 rho drho;
g1  = rho*(rho_max - rho); 
g2  = rho0*(rho0_max - rho0); 
g3a = drho_max - drho;
g3b = drho_max + drho;
% ----------------------------
% X and L
gamma = sdpvar(1,1);
X_0 = sdpvar(n,n,'symmetric');
X_1 = sdpvar(n,n,'symmetric');
X_2 = sdpvar(n,n,'symmetric');
L_0 = sdpvar(1,n);
L_1 = sdpvar(1,n);
L_2 = sdpvar(1,n);

X  = X_0 + rho*X_1 + rho^2*X_2;
dX = drho*X_1 + 2*rho*drho*X_2;
L  = L_0 + rho*L_1 + rho^2*L_2;
X_rho0 = X_0 + rho0*X_1 + rho0^2*X_2;
% ----------------------------
% matrix SOS polynomials
z1 = monolist(rho,1);
z2 = monolist(rho0,1);
z3 = monolist(rho,3);
S11  = qf_polynomial(z1,n); 
S22  = qf_polynomial(z2,n); 
S31  = qf_polynomial(z3,n);
Sa33 = qf_polynomial(z3,n);
Sb33 = qf_polynomial(z3,n);
% ----------------------------
% constraints
At = At_0 + rho*At_1;
Bt = Bt_0 + rho*Bt_1;
M1 = X;
M2 = [ X_rho0  eye(n)
       eye(n)  gamma*eye(n)];
M3 = - [ -dX+(At*X+Bt*L)'+(At*X+Bt*L)   X*sqrtm(Q)   L'*sqrtm(R)
          sqrtm(Q)*X                   -eye(n)       zeros(n,1)
          sqrtm(R)*L                    zeros(1,n)  -1           ];
ep = 1e-6;
M1 = M1 - S11*g1 - ep*eye(n);
M2 = M2 - blkdiag(S22*g2+ep*eye(n),zeros(n));
M3 = M3 - blkdiag(S31*g1+Sa33*g3a+Sb33*g3b+ep*eye(n),zeros(n),zeros(m));
% ----------------------------
% SOS set
CON = [sos(S11),sos(S22),sos(S31),sos(Sa33),sos(Sb33)];
CON = [CON,sos(M1),sos(M2),sos(M3)];
params = recover(setdiff(depends(CON),depends([rho0,rho,drho])));
% ----------------------------
% objective
OBJ = gamma;
% ----------------------------
% call solver
% options = sdpsettings;
% options.solver = 'sedumi';
% solinfo = solvesos(CON,OBJ,options,params)
solvesos(CON,OBJ,[],params)

% ----------------------------
% solution
gamma_obj = 1.06*double(gamma);

% ==================================================
[sol,monos,calQ] = solvesos([CON,gamma<=gamma_obj],[],[],params)

% ----------------------------
for ii=1:length(CON)
	h = sosd(CON(ii));
    if max(abs(double(coefficients(CON{ii}-h'*h,[rho0;rho;drho])))) > 1e-6
        disp('Infeasible!!')
    else
        disp('Feasible!!')        
	end
end
% ----------------------------
X_0 = double(X_0);
X_1 = double(X_1);
X_2 = double(X_2);
L_0 = double(L_0);
L_1 = double(L_1);
L_2 = double(L_2);

% ==================================================
Kt_lq = - lqr(At_0,Bt_0,Q,R);
K1_lq = Kt_lq(1:4);
K2_lq = Kt_lq(5);

num = 0;
for th = linspace(0,65*pi/180,100)
    num = num + 1;

    para = 1 - cos(th);
    X = X_0 + para*X_1 + para^2*X_2;
    L = L_0 + para*L_1 + para^2*L_2;

    K = L*inv(X);

    K11(1,num) = K(1);
    K12(1,num) = K(2);
    K13(1,num) = K(3);
    K14(1,num) = K(4);
    K2(1,num)  = K(5); 
end

th = linspace(0,65,100);
% -----
figure(11)
plot(th,K11,'r',[0 65],Kt_lq(1)*[1 1],'b--','LineWidth',2)
set(gca,'FontName','arial','FontSize',14)
xlabel('$\theta$ [deg]', 'interpreter', 'latex','FontSize',16)
ylabel('${k}_{11}$', 'interpreter', 'latex','FontSize',16)
xlim([0 70])
set(gca,'XTick',0:10:70)
ylim([0 20])
legend('Gain Scheduling Control','LQ Control');
legend('Location','NorthEast')
set(legend,'Fontname','arial','FontSize',16)

% -----
figure(12)
plot(th,K12,'r',[0 65],Kt_lq(2)*[1 1],'b--','LineWidth',2)
set(gca,'FontName','arial','FontSize',14)
xlabel('$\theta$ [deg]', 'interpreter', 'latex','FontSize',16)
ylabel('${k}_{12}$', 'interpreter', 'latex','FontSize',16)
xlim([0 70])
set(gca,'XTick',0:10:70)
ylim([0 120])
set(gca,'YTick',0:30:120)
legend('Gain Scheduling Control','LQ Control');
legend('Location','NorthEast')
set(legend,'Fontname','arial','FontSize',16)

% -----
figure(13)
plot(th,K13,'r',[0 65],Kt_lq(3)*[1 1],'b--','LineWidth',2)
set(gca,'FontName','arial','FontSize',14)
xlabel('$\theta$ [deg]', 'interpreter', 'latex','FontSize',16)
ylabel('${k}_{13}$', 'interpreter', 'latex','FontSize',16)
xlim([0 70])
set(gca,'XTick',0:10:70)
ylim([0 10])
set(gca,'YTick',0:2.5:10)
legend('Gain Scheduling Control','LQ Control');
legend('Location','NorthEast')
set(legend,'Fontname','arial','FontSize',16)

% -----
figure(14)
plot(th,K14,'r',[0 65],Kt_lq(4)*[1 1],'b--','LineWidth',2)
set(gca,'FontName','arial','FontSize',14)
xlabel('$\theta$ [deg]', 'interpreter', 'latex','FontSize',16)
ylabel('${k}_{14}$', 'interpreter', 'latex','FontSize',16)
xlim([0 70])
set(gca,'XTick',0:10:70)
ylim([0 20])
set(gca,'YTick',0:5:20)
legend('Gain Scheduling Control','LQ Control');
legend('Location','NorthEast')
set(legend,'Fontname','arial','FontSize',16)

% -----
figure(15)
plot(th,K2,'r',[0 65],Kt_lq(5)*[1 1],'b--','LineWidth',2)
set(gca,'FontName','arial','FontSize',14)
xlabel('$\theta$ [deg]', 'interpreter', 'latex','FontSize',16)
ylabel('${K}_{2}$', 'interpreter', 'latex','FontSize',16)
xlim([0 70])
set(gca,'XTick',0:10:70)
ylim([-20 0])
set(gca,'YTick',-20:5:0)
legend('Gain Scheduling Control','LQ Control');
legend('Location','SouthEast')
set(legend,'Fontname','arial','FontSize',16)

% ==================================================
% reference, disturbance
t_dis = 0;
r0 = 60*pi/180; k = 1;
% r0 = 45*pi/180; k = 6/8;
% r0 = 30*pi/180; k = 4/8;
d0 = 0;
% ----------------------------
% initial state
theta1_0 = 0;
theta2_0 = 0;
dtheta1_0 = 0;
dtheta2_0 = 0;
% ----------------------------
% J < gamma*x_0^T*x_0 (gamma <= gamma_obj)
gamma_obj
double(gamma)
% ----------------------------
% simulation
sim('adip_gs_servo_sim',12)
% ----------------------------
% plot
figure(1)
plot([0 6 6 12],r0*180/pi*[1 1 0 0],'g')
hold on
plot(t,theta1*180/pi,'r','LineWidth',2)
hold off
set(gca,'FontName','arial','FontSize',14)
xlabel('Time [s]','FontName','arial','FontSize',16)
ylabel('Arm Angle [deg]','FontName','arial','FontSize',16)
ylim([-20 80]*k)
set(gca,'YTick',[-20:20:80]*k)
% ---
figure(2)
plot(t,theta2*180/pi,'r','LineWidth',2)
set(gca,'FontName','arial','FontSize',14)
xlabel('Time [s]','FontName','arial','FontSize',16)
ylabel('Pendulum Angle [deg]','FontName','arial','FontSize',16)
ylim([-4 4]*k)
set(gca,'YTick',[-4:2:4]*k)
% ---
figure(3)
plot(t,rho_,'r','LineWidth',2)
hold on
plot([t(1) t(end)],[0 0],'k--',[t(1) t(end)],[rho_max rho_max],'k--')
hold off
set(gca,'FontName','arial','FontSize',14)
xlabel('Time [s]','FontName','arial','FontSize',16)
ylabel('Parameter','FontName','arial','FontSize',16)
ylim([-0.2 0.8])
% ---
figure(4)
plot(t,drho_,'r','LineWidth',2)
hold on
plot([t(1) t(end)],[-drho_max -drho_max],'k--',[t(1) t(end)],[drho_max drho_max],'k--')
hold off
set(gca,'FontName','arial','FontSize',14)
xlabel('Time [s]','FontName','arial','FontSize',16)
ylabel('Parameter Derivative','FontName','arial','FontSize',16)
ylim([-1 1])
% ---
figure(5)
plot(t,u,'r','LineWidth',2)
set(gca,'FontName','arial','FontSize',14)
xlabel('Time [s]','FontName','arial','FontSize',16)
ylabel('Voltage [V]','FontName','arial','FontSize',16)
ylim([-0.8 0.8]*k)
set(gca,'YTick',[-0.8:0.4:0.8]*k)

% ===============================================================
% ===============================================================
disp('----- シミュレーション結果をアニメーション表示する場合は 1 を入力 -----')
flag = input('input number: ');

if flag == 1
    % 表示のはやさは ip_toolbox_1.0.2/iptools/adip_anime.m 内の
    %   mabiki = 25; 
    % の数値を変更する
    adip_anime    % シミュレーション結果をアニメーション表示
end


