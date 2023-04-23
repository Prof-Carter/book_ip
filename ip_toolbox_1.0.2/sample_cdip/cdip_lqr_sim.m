clear
format compact
close all

cdip_para

% ---------------------------
Ap21 = [ 0  0
         0  mp*g*lp/(Jp+mp*lp^2) ];
Ap22 = [ -ac                      0
          ac*mp*lp/(Jp+mp*lp^2)  -mup/(Jp+mp*lp^2) ];
Bp2  = [  bc
         -bc*mp*lp/(Jp+mp*lp^2) ];
% ---------------------------
A = [ zeros(2,2)  eye(2)
      Ap21        Ap22   ];

B = [ zeros(2,1)
      Bp2        ];
% ---------------------------
     z_0 = 0;
 theta_0 = 15*pi/180;
    dz_0 = 0;
dtheta_0 = 0;

% ---------------------------
for i=1:3
    R = 1;

    if i==1
        aa = [ 1  0  0 ];
        Q = diag([10 10 0 0]);        
    elseif i == 2
        aa = [ 0  1  0 ];
        Q = diag([10 50 0 0]);     
    elseif i == 3
        aa = [ 0  0  1 ];
        Q = diag([10 100 0 0]);     
    end

    K = - lqr(A,B,Q,R)

    sim('cdip_lqr')

    figure(1); plot(t,z,'linewidth',2,'color',aa); hold on
    figure(2); plot(t,theta*180/pi,'linewidth',2,'color',aa); hold on
    figure(3); plot(t,u,'linewidth',2,'color',aa); hold on
end

% ---------------------------------
figure(1); hold off
set(gca,'fontname','arial','fontsize',14)
xlabel('Time [s]','FontName','arial','FontSize',16)
ylabel('Cart [m]','FontName','arial','FontSize',16)

figure(2); hold off
set(gca,'fontname','arial','fontsize',14)
xlabel('Time [s]','FontName','arial','FontSize',16)
ylabel('Pendulum [deg]','FontName','arial','FontSize',16)

figure(3); hold off
set(gca,'fontname','arial','fontsize',14)
xlabel('Time [s]','FontName','arial','FontSize',16)
ylabel('Voltage [V]','FontName','arial','FontSize',16)

figure(1)
legend('q_2 = 10','q_2 = 50','q_2 = 100')
set(legend,'fontname','arial','fontsize',16)

