% 例 2.1
% 台車型倒立振子の量子化入力制御
% （グラフの描画をカスタマイズ）

clear
format compact
format short e
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
A   = [ zeros(2,2)  eye(2)
        Ap21        Ap22   ];
B   = [ zeros(2,1)
        Bp2        ];
Cd1 = [ eye(2)  zeros(2,2) ];
Cd2 =   eye(4);
% -------------------------------------
Q = diag([10 10 0 0]);
R = 1;
K = - lqr(A,B,Q,R); 
% -------------------------------------
ts = 0.01; 
[Ad Bd] = c2d(A,B,ts); 
Sigma_Pd.a  = Ad;
Sigma_Pd.b  = Bd;
Sigma_Pd.c1 = Cd1;
Sigma_Pd.c2 = Cd2;
% -------------------------------------
Sigma_K.a  = zeros(4,4);
Sigma_K.b1 = zeros(4,1);
Sigma_K.b2 = zeros(4,4);
Sigma_K.c  = zeros(1,4);
Sigma_K.d1 = 0;
Sigma_K.d2 = K;
% -------------------------------------
Sigma_G = compg(Sigma_Pd,Sigma_K,'fbiq')
% -------------------------------------
d = 2;
T = 300;
% gamma.vu = 1;
% gamma.wu = 3.35;
gamma.uv = 1;
gamma.wv = 3.35;
dim = 2;
% -------------------------------------
[Sigma_Q E H] = odq(Sigma_G,T,d,gamma,dim,'sedumi')
% -------------------------------------
z_0  = 0;  theta_0  = pi/18;   % <---- 10 [deg]
dz_0 = 0;  dtheta_0 = 0;
t_end = 5;
% -------------------------------------
sim('cdip_odq_sim')
% -------------------------------------
figure(1)
plot(t,z_d,'r',t,z_c,'g','LineWidth',2)
set(gca,'FontName','arial','FontSize',14)
xlabel('Time [s]','FontName','arial','FontSize',16);
ylabel('Cart [m]','FontName','arial','FontSize',16)
ylim([-0.05 0.15])

figure(2)
plot(t,theta_d*180/pi,'r',t,theta_c*180/pi,'g','LineWidth',2)
set(gca,'FontName','arial','FontSize',14)
xlabel('Time [s]','FontName','arial','FontSize',16);
ylabel('Pendulum [deg]','FontName','arial','FontSize',16)
ylim([-5 15])

figure(3)
plot(t,u_d,'r',t,u_c,'g','LineWidth',2)
hold on
plot([0 5], 2.5*[1 1],'k--')
hold off
set(gca,'FontName','arial','FontSize',14)
xlabel('Time [s]','FontName','arial','FontSize',16);
ylabel('Voltage [V]','FontName','arial','FontSize',16)
ylim([-2.5 4.5])
set(gca,'YTick',-2:2:4)


% ===============================================================
% ===============================================================
% 以下は追加

disp(' ')
disp('----- シミュレーション結果のアニメーション表示 -----')
disp('　　　 　　アニメーション表示しない ===> 0 を入力 ')
disp('　　　 　　量子化入力制御　 ===> 1 を入力 ')
disp('　　　 　　最適レギュレータ ===> 2 を入力 ')
flag = input('input number: ');

% 表示のはやさは ip_toolbox_1.0.2/iptools/cdip_anime.m 内の
%   mabiki = 25; 
% の数値を変更する
switch flag 
    case 1
        z = z_d;
        theta = theta_d;
        cdip_anime    % シミュレーション結果をアニメーション表示
    case 2
        z = z_c;
        theta = theta_c;
        cdip_anime    % シミュレーション結果をアニメーション表示
end
