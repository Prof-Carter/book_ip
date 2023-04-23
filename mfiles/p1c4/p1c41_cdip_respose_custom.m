% �O���t�̕`����J�X�^�}�C�Y

cdip_para;
% -------------------------
kP = 1;
% -------------------------
A = [ 0      1
     -bc*kP -ac ];
B = [ 0
      1 ];
C = [ bc*kP  0 ];
D = 0;
G = ss(A,B,C,D);
% -------------------------
t = 0:0.01:10;
% -------------------------
x0 = [ 1;  1 ];
y1 = initial(G,x0,t);
y2 = lsim(G,2*sin(t),t,[0; 0]);
y3 = lsim(G,2*sin(t),t,x0);
% -------------------------
figure(1);
plot(t,y1,'r--',t,y2,'g:',t,y3,'b','LineWidth',2)
set(gca,'FontName','arial','FontSize',14)
xlabel('Time [s]','FontName','arial','FontSize',16); 
ylabel('Position [m]','FontName','arial','FontSize',16)

legend('y1(t)','y2(t)','y3(t)')
set(legend,'FontName','arial','FontSize',16)

ylim([-2 6])
set(gca,'Ytick',-2:2:6)

