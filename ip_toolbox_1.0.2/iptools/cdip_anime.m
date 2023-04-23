n = length(z);

zlx = 0.08;
zly = 0.04;

figure(10); clf;

mabiki = 25;    % アニメーション表示が遅い場合は mabiki を大きな値に変更してください
                % アニメーション表示が速すぎる場合は mabiki を小さな値に変更してください

for i = 1:mabiki:n
    figure(10); clf;
    set(gcf,'position',[50 50 1068 432])
    grid

    axis([-1.5 1.5 -0.6 0.6]);
    set(gca,'fontsize',10,'fontname','arial')
    set(gca,'xtick',[-2:0.1:2])
    set(gca,'ytick',[-1:0.1:1])

    % レール
    line([-1.5 1.5],[0 0],'color',[0.65 0.65 0.65],'linewidth',5);  

    % 台車
    xaxis = [z(i)-zlx z(i)+zlx z(i)+zlx z(i)-zlx z(i)-zlx];
    yaxis = [    -zly     -zly      zly      zly     -zly]; 
    patch(xaxis,yaxis,[0 0 1])

    % 振子
    line([z(i) z(i)+Lp*sin(theta(i))],[0 Lp*cos(theta(i))],'color',[1 0 0],'linewidth',5);   

    % 振子軸
    m = linspace(-pi,pi,100);

    rc1 = 0.03;
    xc1 = z(i) + rc1*cos(m);
    yc1 =        rc1*sin(m);
    patch(xc1,yc1,[1 1 1])
    
    rc2 = 0.015;
    xc2 = z(i) + rc2*cos(m);
    yc2 =        rc2*sin(m);
    patch(xc2,yc2,[1 1 1])

    % ----------------------------------------------------
    % ----------------------------------------------------
%    pause

    patch([1.15 1.45 1.45 1.15 1.15],[0.4 0.4 0.5 0.5 0.4],[1 1 1])
    text(1.2,0.45,num2str(floor(10*t(i))/10),'fontsize',12,'fontname','arial')
    text(1.35,0.45,'[s]','fontsize',12,'fontname','arial')

    drawnow;
end

