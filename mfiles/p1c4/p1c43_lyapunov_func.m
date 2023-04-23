% Lyapunov ä÷êî
clear
format compact

% ---------------------------------------------
[x1,x2] = meshgrid(-5:0.1:5,-5:0.1:5);
V = x1.^2 + x2.^2;

% ---------------------------------------------
figure(1)
surfc(x1,x2,V)
shading interp

set(gca,'Fontname','arial','FontSize',14)
xlabel('x1','Fontname','arial','FontSize',16)
ylabel('x2','Fontname','arial','FontSize',16)
zlabel('V(x)','Fontname','arial','FontSize',16)


