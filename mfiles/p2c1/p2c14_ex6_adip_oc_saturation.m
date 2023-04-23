% 例 1.6
% 入力飽和を有するアーム型倒立振子の制御

clear
format compact
close all

% ---------------------------
adip_para

% ---------------------------
A21 = [ 0  0
        0  alpha5/alpha2 ];
A22 = [ -a1                      0
        (a1*alpha3+mu2)/alpha2  -mu2/alpha2 ];
B2  = [  b1
        -b1*alpha3/alpha2 ];
% ---------------------------
A = [ zeros(2,2)  eye(2)
      A21        A22   ];
B = [ zeros(2,1)
      B2        ];
% ---------------------------------
n = length(A);

% ---------------------------------
% optimal control
Q = diag([20 10 0.1 0.1]);
Q = diag([20 10 0.1 0.1]);
R = 1;
% ---------------------------------
% X, L, V
X  = sdpvar(n,n,'sy');
L  = sdpvar(1,n);
V1 = sdpvar(n,1);
V  = V1';   % V = [V1 ... Vm]', Vi' = [Vi1 ... Vim] 
% ---------------------------------
% saturation (square)
sigma2 = 0.1^2;
% ---------------------------------
% initial state
theta1_0 = 10*pi/180;
theta2_0 = 0*pi/180;
dtheta1_0 = 0;
dtheta2_0 = 0;
% ---------------------------------
% initial state
x0 = [theta1_0 theta2_0 dtheta1_0 dtheta2_0]';
% ---------------------------------
% constraints
ep = 1e-6;
OC1 = [ (A*X+B*L)'+(A*X+B*L)  X*sqrtm(Q)   L'*sqrtm(R);
        sqrtm(Q)*X           -eye(n)       zeros(n,1);
        sqrtm(R)*L            zeros(1,n)  -1 ];
OC2 = [ (A*X+B*V)'+(A*X+B*V)  X*sqrtm(Q)   V'*sqrtm(R);
        sqrtm(Q)*X           -eye(n)       zeros(n,1);
        sqrtm(R)*V            zeros(1,n)  -1 ];
MH  = [ X    V1
        V1'  sigma2 ];
INI = [ X   x0
        x0' 1 ];
% ---------------------------------
CON = [X >= ep*eye(n)]
CON = CON + [ OC1 <= -ep*eye(length(OC1)) ];
CON = CON + [ OC2 <= -ep*eye(length(OC2)) ];
CON = CON + [ MH  >= 0 ];
CON = CON + [ INI >= 0 ];
% ---------------------------------
OBV = - trace(X);
% ---------------------------------
% call solver
solinfo = solvesdp(CON,OBV)

double(OBV)

% ==========================================================
CON = CON + [CON, trace(X) <= - double(OBV) ];
solinfo = solvesdp(CON)
% ---------------------------------
% solution
X = double(X)
L = double(L);
V = double(V);
K = L*inv(X)
H = V*inv(X)
% ---------------------------------
% poles
eig(A+B*K)
% ---------------------------------
% V < trace(inv(X))*trace(x_0*x_0^T)
trace_invX = trace(inv(X))
trace_X    = trace(X)
% ---------------------------------
% simulation
sat = sqrt(sigma2);
% sim('adip_saturation_sim',10)  % D/A 変換，エンコーダの分解能を考慮しないシミュレーション
sim('adip_saturation2_sim',10)  % D/A 変換，エンコーダの分解能を考慮したシミュレーション
% ---------------------------------
% plot
xlim_upper = 10;

% -----
figure(1)
plot(t,theta1*180/pi,'r-','linewidth',2)
set(gca,'FontName','arial','FontSize',14)
xlabel('Time [s]','FontName','arial','FontSize',16)
ylabel('Arm Angle [deg]','FontName','arial','FontSize',16)
xlim([0 xlim_upper])
ylim([-5 15])

% -----
figure(2)
plot(t,theta2*180/pi,'r-','linewidth',2)
set(gca,'FontName','arial','FontSize',14)
xlabel('Time [s]','FontName','arial','FontSize',16)
ylabel('Pendulum Angle [deg]','FontName','arial','FontSize',16)
xlim([0 xlim_upper])
ylim([-0.4 0.4])
set(gca,'ytick',-0.4:0.2:0.4)

% -----
figure(3)
plot(t,v,'r-','linewidth',2)
set(gca,'FontName','arial','FontSize',14)
xlabel('Time [s]','FontName','arial','FontSize',16)
ylabel('Voltage [V]','FontName','arial','FontSize',16)
xlim([0 xlim_upper])
ylim([-0.2 0.2])
set(gca,'ytick',-0.2:0.1:0.2)

% -----
figure(4)
plot(t,u,'r-','linewidth',2)
set(gca,'FontName','arial','FontSize',14)
xlabel('Time [s]','FontName','arial','FontSize',16)
ylabel('Voltage [V]','FontName','arial','FontSize',16)
xlim([0 xlim_upper])
ylim([-2 2])
set(gca,'ytick',-2:1:2)

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


