clear
format compact
close all

adip_para

% ---------------------------
Ap21 = [ 0  0
         0  alpha5/alpha2 ];
Ap22 = [ -a1                      0
         (a1*alpha3+mu2)/alpha2  -mu2/alpha2 ];
Bp2  = [  b1
         -b1*alpha3/alpha2 ];
% ---------------------------
A = [ zeros(2,2)  eye(2)
      Ap21        Ap22   ];

B = [ zeros(2,1)
      Bp2        ];
% ---------------------------
 theta1_0 = 30*pi/180;

 theta2_0 = 0;
dtheta1_0 = 0;
dtheta2_0 = 0;

for i=1:3
    R = 1;

    if i==1
        flag = [ 1  0  0 ];
        Q = diag([ 1 10 0.1 0.1]);        
    elseif i == 2
        flag = [ 0  1  0 ];
        Q = diag([ 5 10 0.1 0.1]);     
    elseif i == 3
        flag = [ 0  0  1 ];
        Q = diag([20 10 0.1 0.1]);     
    end

    K = - lqr(A,B,Q,R)

    sim('adip_lqr')

    figure(1); plot(t,theta1*180/pi,'LineWidth',2,'Color',flag); hold on
    figure(2); plot(t,theta2*180/pi,'LineWidth',2,'Color',flag); hold on
    figure(3); plot(t,u,'LineWidth',2,'Color',flag); hold on
end

% ---------------------------
figure(1); hold off
set(gca,'FontName','arial','FontSize',14)
set(gca,'xtick',[0:0.5:2])
xlabel('Time [s]','FontName','arial','FontSize',16)
ylabel('Arm [deg]','FontName','arial','FontSize',16)

figure(2); hold off
set(gca,'FontName','arial','FontSize',14)
set(gca,'xtick',[0:0.5:2])
xlabel('Time [s]','FontName','arial','FontSize',16)
ylabel('Pendulum [deg]','FontName','arial','FontSize',16)

figure(3); hold off
set(gca,'FontName','arial','FontSize',14)
set(gca,'xtick',[0:0.5:2])
xlabel('Time [s]','FontName','arial','FontSize',16)
ylabel('Voltage [V]','FontName','arial','FontSize',16)

figure(1)
legend('q_1 = 1','q_1 = 5','q_1 = 20')
set(legend,'FontName','arial','FontSize',16)

