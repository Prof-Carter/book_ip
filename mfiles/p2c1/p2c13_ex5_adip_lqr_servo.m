% 例 1.5
% アーム型倒立振子
% 最適レギュレータ（四つの端点に対する非線形シミュレーション）

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
      A21         A22   ];
B = [ zeros(2,1)
      B2         ];
C = [ 1  0  0  0 ];
% ----------------------------
At_nominal = [ A  zeros(4,1)
              -C  0 ];
Bt_nominal = [ B
               0 ];
% ----------------------------
Q  = diag([0.1 1 0.001 0.001 4]);
R  = 1;
% ----------------------------
Kt_LQ = - lqr(At_nominal,Bt_nominal,Q,R)

% =================================================================================
% =================================================================================
a1_nominal = a1;
b1_nominal = b1;

rho1_range = a1_nominal*[0.55 1.45];
rho2_range = b1_nominal*[0.55 1.45];

nop = 2;
ve = mvert(nop)
vertex(1,:) = rho1_range(1)*ones(size(ve(1,:))) + diff(rho1_range)*ve(1,:);
vertex(2,:) = rho2_range(1)*ones(size(ve(2,:))) + diff(rho2_range)*ve(2,:);
vertex
% ----------------------------
K1 = Kt_LQ(1:4)
K2 = Kt_LQ(5)

t_end = 6;
t_dis = 0;

r0 = 30*pi/180;
d0 = 0;

theta1_0 = 0;  dtheta1_0 = 0;
theta2_0 = 0;  dtheta2_0 = 0;

for i = 1:2^nop
    a1 = vertex(1,i);
    b1 = vertex(2,i);
    sim('adip_servo_sim')

    switch i
        case 1; symb = 'r';  t_case1 = t; theta1_case1 = theta1; theta2_case1 = theta2; u_case1 = u; 
        case 2; symb = 'g';  t_case2 = t; theta1_case2 = theta1; theta2_case2 = theta2; u_case2 = u; 
        case 3; symb = 'b';  t_case3 = t; theta1_case3 = theta1; theta2_case3 = theta2; u_case3 = u; 
        case 4; symb = 'm';  t_case4 = t; theta1_case4 = theta1; theta2_case4 = theta2; u_case4 = u; 
    end

    figure(2); plot(t,theta1*180/pi,symb,'LineWidth',2)
    hold on
    figure(3); plot(t,theta2*180/pi,symb,'LineWidth',2)
    hold on
    figure(4); plot(t,u,symb,'LineWidth',2)
    hold on
end

% ---------------------------------------------
figure(2); hold off
set(gca,'FontName','arial','FontSize',14)
xlabel('Time [s]','FontName','arial','FontSize',16)
ylabel('Arm Angle [deg]','FontName','arial','FontSize',16)
xlim([0 6])
ylim([-10 40])
set(gca,'ytick',-10:10:40)
legend('$\rho = [\underline{\rho}{}_{1}\ \ \overline{\rho}{}_{2}]^{\top}$',...
       '$\rho = [\overline{\rho}{}_{1}\ \ \underline{\rho}{}_{2}]^{\top}$',...
       '$\rho = [\underline{\rho}{}_{1}\ \ \overline{\rho}{}_{2}]^{\top}$',...
       '$\rho = [\overline{\rho}{}_{1}\ \ \overline{\rho}{}_{2}]^{\top}$')
legend('Location','SouthEast')
set(legend,'interpreter','latex')
set(legend,'FontSize',16)

% -----
figure(3); hold off
set(gca,'FontName','arial','FontSize',14)
xlabel('Time [s]','FontName','arial','FontSize',16)
ylabel('Pendulum Angle [deg]','FontName','arial','FontSize',16)
xlim([0 6])
ylim([-3 3])
set(gca,'ytick',-3:1.5:3)
legend('$\rho = [\underline{\rho}{}_{1}\ \ \overline{\rho}{}_{2}]^{\top}$',...
       '$\rho = [\overline{\rho}{}_{1}\ \ \underline{\rho}{}_{2}]^{\top}$',...
       '$\rho = [\underline{\rho}{}_{1}\ \ \overline{\rho}{}_{2}]^{\top}$',...
       '$\rho = [\overline{\rho}{}_{1}\ \ \overline{\rho}{}_{2}]^{\top}$')
legend('Location','SouthEast')
set(legend,'interpreter','latex')
set(legend,'FontSize',16)

% -----
figure(4); hold off
set(gca,'FontName','arial','FontSize',14)
xlabel('Time [s]','FontName','arial','FontSize',16)
ylabel('Voltage [V]','FontName','arial','FontSize',16)
xlim([0 6])
ylim([-0.5 1.5])
set(gca,'ytick',-2:0.5:2)
legend('$\rho = [\underline{\rho}{}_{1}\ \ \overline{\rho}{}_{2}]^{\top}$',...
       '$\rho = [\overline{\rho}{}_{1}\ \ \underline{\rho}{}_{2}]^{\top}$',...
       '$\rho = [\underline{\rho}{}_{1}\ \ \overline{\rho}{}_{2}]^{\top}$',...
       '$\rho = [\overline{\rho}{}_{1}\ \ \overline{\rho}{}_{2}]^{\top}$')
legend('Location','NorthEast')
set(legend,'interpreter','latex')
set(legend,'FontSize',16)

% =================================================================================
% =================================================================================
disp('----- シミュレーション結果のアニメーション表示 -----')
disp('　　　 　　アニメーション表示しない ===> 0 を入力 ')
disp('　　　 　　rho1: min, rho2 : min ===> 1 を入力 ')
disp('　　　 　　rho1: max, rho2 : min ===> 2 を入力 ')
disp('　　　 　　rho1: min, rho2 : max ===> 3 を入力 ')
disp('　　　 　　rho1: max, rho2 : max ===> 4 を入力 ')
flag = input('input number: ');

% 表示のはやさは ip_toolbox_1.0.1/iptools/adip_anime.m 内の
%   mabiki = 25; 
% の数値を変更する
switch flag 
    case 1
        theta1 = theta1_case1;
        theta2 = theta2_case1;
        adip_anime    % シミュレーション結果をアニメーション表示
    case 2
        theta1 = theta1_case2;
        theta2 = theta2_case2;
        adip_anime    % シミュレーション結果をアニメーション表示
    case 3
        theta1 = theta1_case3;
        theta2 = theta2_case3;
        adip_anime    % シミュレーション結果をアニメーション表示
    case 4
        theta1 = theta1_case4;
        theta2 = theta2_case4;
        adip_anime    % シミュレーション結果をアニメーション表示
end
