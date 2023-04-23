% ‘äŽÔŒ^“|—§UŽq
% 2 ŽŸ’x‚êŒn‚Ì“Á«‚É’–Ú‚µ‚½‘äŽÔ‚Ìƒpƒ‰ƒ[ƒ^“¯’è

clear
format compact
close all

load cdip_cart_pcont_data_kP_100_ref_02    % ‘äŽÔ‚Ì P §Œä‚ÌŽÀŒ±ƒf[ƒ^‚Ì“Ç‚Ýž‚Ý
kP = 10;

zc = 0.2;

t_data = t;
z_data = z;

clear t z

k = 1;
for i = 1:length(t_data)
    if t_data(i) >= 1
        t(k) = t_data(i) - 1;
        z(k) = z_data(i);
        k = k + 1;
    end
end

% --------------------------------------------------------
[zmax imax] = max(z);

for i = imax:length(t)
    if z(i) == zmax
        imax_last = i;
    end
    if z(i) < zmax
        break
    end
end

Tp = (t(imax) + t(imax_last))/2;

% --------------------------------------------------------
figure(1)
stairs(t,z,'r','LineWidth',2);
hold on

% --------------------------------------------------------
Amax = zmax - zc;

gamma = - (1/Tp)*log(Amax/zc);
delta = pi/Tp;

omega_n = sqrt(gamma^2 + delta^2);
zeta    = gamma/omega_n;

ac = 2*zeta*omega_n;
bc = omega_n^2/kP;

% --------------------------------------------------------
fprintf(' ****************************** \n')
fprintf('Tp   = %5.2e\n',Tp)
fprintf('Amax = %5.2e\n',Amax)
fprintf('gamma_c  = %5.2e\n',gamma)
fprintf('delta_c  = %5.2e\n',delta)
fprintf('omega_nc = %5.2e\n',omega_n)
fprintf('zeta_c   = %5.2e\n',zeta)
fprintf('ac  = %5.2e\n',ac)
fprintf('bc  = %5.2e\n',bc)
fprintf(' ****************************** \n')

% --------------------------------------------------------
sysGyr = tf(omega_n^2,[1 2*zeta*omega_n omega_n^2])
z_sim = zc*step(sysGyr,t);

% --------------------------------------------------------
figure(1)
plot(t,z_sim,'b--','LineWidth',2);

plot(Tp*[0 1],zmax*[1 1],'k')
plot(Tp*[1 1],zmax*[0 1],'k')
hold off

% --------------------------------------------------------
xlim([0 2]);   set(gca,'Xtick',0:0.5:2)
ylim([0 0.3]); set(gca,'Ytick',0:0.1:0.3)

% --------------------------------------------------------
set(gca,'FontName','arial','FontSize',14)
xlabel('Time [s]','FontName','arial','FontSize',16)
ylabel('Cart position [m]','FontName','arial','FontSize',16)
legend('Experiment','Simulation')
set(legend,'FontName','arial','FontSize',16)



