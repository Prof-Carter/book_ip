% ‘äÔŒ^“|—§Uq
% 2 Ÿ’x‚êŒn‚Ì“Á«‚É’–Ú‚µ‚½Uq‚Ìƒpƒ‰ƒ[ƒ^“¯’è

clear
format compact
close all

load cdip_pend_data    % Uq‚Ì©—RU“®‚ÌÀŒ±ƒf[ƒ^‚Ì“Ç‚İ‚İ

% ---------------------------------------------------------
t_data   = t;
phi_data = theta;

clear t theta

% ---------------------------------------------------------
% t = 35 ‚©‚ç t = 51 ‚Ìƒf[ƒ^‚Åƒpƒ‰ƒ[ƒ^“¯’è‚Ìˆ—‚ğs‚¤
tmin = 35;
tmax = 51;

k = 0;
for i = 1:length(t_data)
    if t_data(i) >= tmin & t_data(i) <= tmax
        k = k + 1;

        t(k)   = t_data(i) - tmin;
        phi(k) = phi_data(i);
    end
end

% ---------------------------------------------------------
figure(1)
stairs(t,phi*180/pi,'r','LineWidth',2);
hold on

% ---------------------------------------------------------
k = 0;
flag = 0;
for i = 1:length(t)-1
    if phi(i) > 0 
        flag = 1;
    end
    if flag == 1 & phi(i) < 0
        k = k + 1;
        num(k) = i;
        T0(k)  = t(i);
        A0(k)  = phi(i);
        flag   = 0;
    end
end

figure(1)
plot(T0,A0*180/pi,'bx','MarkerSize',8,'LineWidth',2);

if phi(1) < 0
    num = [1 num];
end


% ---------------------------------------------------------
for j = 1:length(num)-1   

    [Amax(j) imax(j)] = max(phi(num(j):num(j+1)));
    imax(j) = imax(j) + num(j);

    imax_last(j) = imax(j);
    for i = imax(j):num(j+1)
        if phi(i) == Amax(j)
            imax_last(j) = i;
        end
        if phi(i) < Amax(j)
            break
        end
    end

    tmax(j) = (t(imax(j)) + t(imax_last(j)))/2;
end

figure(1)
plot(tmax,Amax*180/pi,'bo','MarkerSize',8,'LineWidth',2)
hold off

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
mp = 1.07e-001;
lp = 2.30e-001;
Lp = 3.80e-001;

g  = 9.81e+000;

gamma = (1/T_average)*log(1/lambda_average);
delta = 2*pi/T_average;

omega_n = sqrt(gamma^2 + delta^2);
zeta    = gamma/omega_n;

Jp  = mp*g*lp/omega_n^2 - mp*lp^2;
mup = 2*zeta*omega_n*(Jp + mp*lp^2);

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
fprintf('gamma_p  = %5.2e\n',gamma)
fprintf('delta_p  = %5.2e\n',delta)
fprintf('omega_np = %5.2e\n',omega_n)
fprintf('zeta_p   = %5.2e\n',zeta)
fprintf('mp  = %5.2e\n',mp)
fprintf('lp  = %5.2e\n',lp)
fprintf('g   = %5.2e\n',g)
fprintf('Jp  = %5.2e\n',Jp)
fprintf('mup = %5.2e\n',mup)
fprintf(' ****************************** \n')


% ---------------------------------------------------------
omega_d = omega_n*sqrt(1 - zeta^2);
phi0 = Amax(1);

t_sim = 0:0.001:max(t);
phi_sim = exp(-zeta*omega_n*t_sim).*(cos(omega_d*t_sim) + zeta/sqrt(1 - zeta^2)*sin(omega_d*t_sim))*phi0;

figure(4);
plot(t,phi*180/pi,'r','LineWidth',2)
hold on
plot(t_sim+tmax(1),phi_sim*180/pi,'b--','LineWidth',2)
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

