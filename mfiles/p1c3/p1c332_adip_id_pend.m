clear
format compact

load adip_pend_data

% ---------------------------------------------------------
t_data   = t;
phi2_data = theta2;

clear t phi2

% ---------------------------------------------------------
tmin = 50;
tmax = tmin + 16;
k = 0;
for i = 1:length(t_data)
    if t_data(i) >= tmin & t_data(i) <= tmax
        k = k + 1;

        t(k)    = t_data(i) - tmin;
        phi2(k) = phi2_data(i);
    end
end

% ---------------------------------------------------------
figure(1)
stairs(t,phi2*180/pi,'r','LineWidth',2);
hold on

% ---------------------------------------------------------
k = 0;
flag = 0;
for i = 1:length(t)-1
    if phi2(i) > 0 
        flag = 1;
    end
    if flag == 1 & phi2(i) < 0
        k = k + 1;
        num(k) = i;
        T0(k)  = t(i);
        A0(k)  = phi2(i);
        flag   = 0;
    end
end

figure(1)
plot(T0,A0*180/pi,'bx','MarkerSize',8,'LineWidth',2);

if phi2(1) < 0
    num = [1 num];
end

% ---------------------------------------------------------
for j = 1:length(num)-1   

    [Amax(j) imax(j)] = max(phi2(num(j):num(j+1)));
    imax(j) = imax(j) + num(j);

    imax_last(j) = imax(j);
    for i = imax(j):num(j+1)
        if phi2(i) == Amax(j)
            imax_last(j) = i;
        end
        if phi2(i) < Amax(j)
            break
        end
    end

    tmax(j) = (t(imax(j)) + t(imax_last(j)))/2;
end

figure(1)
plot(tmax,Amax*180/pi,'bo','MarkerSize',8,'LineWidth',2)
hold off

xlim([0 max(t)])

set(gcf,'Position',[25 25 1120 420])

xlim([0 max(t)])
set(gca,'xtick',0:2:16)
ylim([-45 45])
set(gca,'Ytick',-45:22.5:45)
set(gca,'FontName','arial','FontSize',14)
xlabel('Time [s]','FontName','arial','FontSize',16)
ylabel('Pendulum angle [deg]','FontName','arial','FontSize',16)

% ---------------------------------------------------------
for i = 1:length(tmax)-1
    T(i)      = tmax(i+1) - tmax(i);
    lambda(i) = Amax(i+1)/Amax(i);
end

T_average      = mean(T)
lambda_average = mean(lambda)

% -----
figure(2)
plot(1:length(T),T,'bo','MarkerSize',8,'LineWidth',2)
hold on
plot([1 length(T)],T_average*[1 1],'r')
hold off
ylim([0 1.5])

xlim([1 length(T)])
set(gca,'Xtick',[1:length(T)])
set(gca,'FontName','arial','FontSize',14)
xlabel('i','FontName','arial','FontSize',16)
ylabel('T [s]','FontName','arial','FontSize',16)

% -----
figure(3)
plot(1:length(lambda),lambda,'bo','MarkerSize',8,'LineWidth',2)
hold on
plot([1 length(lambda)],lambda_average*[1 1],'r')
hold off
ylim([0 1.5])

xlim([1 length(lambda)])
set(gca,'Xtick',[1:length(lambda)])
set(gca,'FontName','arial','FontSize',14)
xlabel('i','FontName','arial','FontSize',16)
ylabel('\lambda','FontName','arial','FontSize',16)


% ---------------------------------------------------------
m2 = 9.60e-002;
l2 = 1.95e-001;
L2 = 3.00e-001;

g  = 9.81e+000;

gamma = (1/T_average)*log(1/lambda_average);
delta = 2*pi/T_average;

omega_n = sqrt(gamma^2 + delta^2);
zeta    = gamma/omega_n;

J2  = m2*g*l2/omega_n^2 - m2*l2^2;
mu2 = 2*zeta*omega_n*(J2 + m2*l2^2);

% -----------------------
fprintf(' ****************************** \n')
for i = 1:length(T)
    fprintf('T%2d = %5.3e\t',i,T(i))
    fprintf('lambda%2d = %5.3e\n',i,lambda(i))
end
fprintf(' ----------------------------- \n')
fprintf('T = %5.2e\t',T_average)
fprintf('lambda = %5.2e\n',lambda_average)
fprintf('\n')
fprintf('gamma_2  = %5.2e\n',gamma)
fprintf('delta_2  = %5.2e\n',delta)
fprintf('zeta_2   = %5.2e\n',zeta)
fprintf('omega_n2 = %5.2e\n',omega_n)
fprintf('m2  = %5.2e\n',m2)
fprintf('l2  = %5.2e\n',l2)
fprintf('g   = %5.2e\n',g)
fprintf('J2  = %5.2e\n',J2)
fprintf('mu2 = %5.2e\n',mu2)
fprintf(' ****************************** \n')


% ---------------------------------------------------------
omega_d = omega_n*sqrt(1 - zeta^2);
phi20 = Amax(1);

t_sim = 0:0.001:max(t);
phi2_sim = exp(-zeta*omega_n*t_sim).*(cos(omega_d*t_sim) + zeta/sqrt(1 - zeta^2)*sin(omega_d*t_sim))*phi20;

figure(4);
plot(t,phi2*180/pi,'r','LineWidth',2)
hold on
plot(t_sim+tmax(1),phi2_sim*180/pi,'b--','LineWidth',2)
hold off

set(gcf,'Position',[50 50 1120 420])

xlim([0 max(t)])
set(gca,'Xtick',0:2:16)
ylim([-45 45])
set(gca,'Ytick',-45:22.5:45)
set(gca,'FontName','arial','FontSize',14)
xlabel('Time [s]','FontName','arial','FontSize',16)
ylabel('Pendulum angle [deg]','FontName','arial','FontSize',16)
legend('Experiment','Simulation')
set(legend,'FontName','arial','FontSize',16)

% plot(t,phi2,'b',t_sim+tmax(1),phi2_sim,'g')
% 
% xlim([0 max(t)])
% set(gca,'xtick',0:2:max(t))
% 
% ylim([-pi/4 pi/4])
% set(gca,'ytick',-pi/4:pi/8:pi/4)
% set(gca,'fontname','symbol','yticklabel',{'-p/4','-p/8','0','p/8','p/4'})
% set(gcf,'position',[420 278 1120 420])

