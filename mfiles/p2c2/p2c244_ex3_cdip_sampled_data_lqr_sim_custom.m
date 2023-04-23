% 例 2.3
% 台車型倒立振子のサンプル値最適レギュレータ
% 　赤：サンプル値最適レギュレータ (ts = 100 [ms])
% 　青：連続時間最適レギュレータ (ts = 100 [ms])
% 　緑：連続時間最適レギュレータ
% （グラフの描画をカスタマイズ）

clear
format compact
close all

cdip_para
% -------------------------------------
Ap21 = [ 0  0
         0  mp*g*lp/(Jp+mp*lp^2) ];
Ap22 = [ -ac                      0
          ac*mp*lp/(Jp+mp*lp^2)  -mup/(Jp+mp*lp^2) ];
Bp2  = [  bc
         -bc*mp*lp/(Jp+mp*lp^2) ];
% -------------------------------------
A = [ zeros(2,2)  eye(2)
      Ap21        Ap22   ];
B = [ zeros(2,1)
      Bp2        ];
% -------------------------------------
Q = diag([10 10 0 0]);  R = 1;
K = - lqr(A,B,Q,R)
% -------------------------------------
ts = 0.1; % サンプリング周期
[Ad Bd] = c2d(A,B,ts);
% -------------------------------------
[n,m] = size(B);
W  = [ Q           zeros(n,m)
       zeros(m,n)  R          ];
M  = [ A           B
       zeros(m,n)  zeros(m,m) ];
MM = [-M'              W
       zeros(n+m,n+m)  M ];
expMM = expm(MM*ts);
N12 = expMM(1:n+m,n+m+1:2*(n+m));
N22 = expMM(n+m+1:2*(n+m),n+m+1:2*(n+m));
Wd = N22'*N12;
Qd = Wd(1:n,1:n); Rd = Wd(n+1:n+m,n+1:n+m);
Sd = Wd(1:n,n+1:n+m);
Kd = - dlqr(Ad,Bd,Qd,Rd,Sd)
% -------------------------------------
z_0  = 0;  theta_0 = pi/12;
dz_0 = 0; dtheta_0 = 0;
t_end = 4;
sim('cdip_sampled_value_lqr_sim')
% -------------------------------------
figure(1)
plot(t,z_d,'Color',[114 189 255]/255,'LineWidth',2); hold on
plot(t,z_cd,'Color',[217 83 25]/255,'LineWidth',2)
plot(t,z_c,'Color',[237 177 32]/255,'LineWidth',2); hold off
set(gca,'FontName','arial','FontSize',14)
xlabel('Time [s]','FontName','arial','FontSize',16)
ylabel('Cart [m]','FontName','arial','FontSize',16)
legend('Sampled-data LQ (100 ms)','Continuous time LQ (100 ms)','Continuous time LQ')
set(legend,'FontName','arial','FontSize',16)

figure(2)
plot(t,theta_d,'Color',[114 189 255]/255,'LineWidth',2); hold on
plot(t,theta_cd,'Color',[217 83 25]/255,'LineWidth',2)
plot(t,theta_c,'Color',[237 177 32]/255,'LineWidth',2); hold off
set(gca,'FontName','arial','FontSize',14)
xlabel('Time [s]','FontName','arial','FontSize',16)
ylabel('Pendulum [deg]','FontName','arial','FontSize',16)
legend('Sampled-data LQ (100 ms)','Continuous time LQ (100 ms)','Continuous time LQ')
set(legend,'FontName','arial','FontSize',16)

figure(3)
plot(t,u_d,'Color',[114 189 255]/255,'LineWidth',2); hold on
plot(t,u_cd,'Color',[217 83 25]/255,'LineWidth',2)
plot(t,u_c,'Color',[237 177 32]/255,'LineWidth',2); hold off
set(gca,'FontName','arial','FontSize',14)
xlabel('Time [s]','FontName','arial','FontSize',16)
ylabel('Voltage [V]','FontName','arial','FontSize',16)
legend('Sampled-data LQ (100 ms)','Continuous time LQ (100 ms)','Continuous time LQ')
set(legend,'FontName','arial','FontSize',16)

