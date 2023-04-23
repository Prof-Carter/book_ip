% Animation of an Inverted Pendulum
%  '11/09/28, '16/07/14 (replacement of avifile by VideoWriter) 
%  T. Ohtsuka
%
% **** Run this file after plotsim.m. ****
%
L1 = 2.27e-001;
l2 = 1.75e-001;
L2 = 2 * l2; 

clf;
XYmax = 1.1 * ceil(10*(L1+L2))/10;
axis([-XYmax XYmax -XYmax XYmax]); 
set(gca,'xtick',[]);        
set(gca,'xticklabel',[]);   
set(gca,'ytick',[]);        
set(gca,'yticklabel',[]);   
box on;
pause on;

fstep=10;
finterval=fstep*dstep*ht
% mov = avifile('InvPendNMPC.avi','fps',ceil(1/finterval)); % obsolete
mov = VideoWriter('InvPendNMPC.avi');
mov.FrameRate = ceil(1/finterval);
open(mov);

j=1;
for i=1:fstep:ns
   cla;
    X1 = L1 * sin(xs(i,1));
    Y1 = L1 * cos(xs(i,1));
    X2 = X1 + L2 * sin(xs(i,2));
    Y2 = Y1 + L2 * cos(xs(i,2));
    line([0],[0],'LineWidth',2,'MarkerSize',24,...
        'Marker','o','MarkerFaceColor','w','MarkerEdgeColor','k');
    line([0 X1],[0 Y1],'LineWidth',14,...
        'Marker','none','MarkerFaceColor','r','MarkerEdgeColor','r');
    line([0],[0],'LineWidth',6,'MarkerSize',10,...
        'Marker','o','MarkerFaceColor','w','MarkerEdgeColor','b');
    line([X1 X2],[Y1 Y2],'LineWidth',5,'Color','r',...
        'Marker','none','MarkerFaceColor','k','MarkerEdgeColor','k');
    line([X1],[Y1],'LineWidth',1,'Color','r','MarkerSize',4,...
        'Marker','o','MarkerFaceColor','w','MarkerEdgeColor','k');
%    title(['NMPC by C/GMRES, |u| \leq ' num2str(u1max)],'FontSize',14);
    title(['NMPC with |u| \leq ' num2str(u1max)],'FontSize',14);
    text(XYmax-0.30,XYmax-0.07, [sprintf('    %4.1f',ts(i)) ' sec'],'FontSize',14);
    text(XYmax-0.18,-XYmax-0.05, 'T. Ohtsuka','FontSize',8);
    if mod(i-1,fstep)==0,
        F = getframe(gcf);
        % mov = addframe(mov,F); % obsolete
        writeVideo(mov,F);
        j=j+1;
    end
    pause(fstep*dstep*ht);
end

% mov = close(mov); % obsolete
close(mov);

