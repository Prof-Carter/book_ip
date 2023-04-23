n = length(theta1);

x1 = theta1;
x2 = theta2;

figure(10); clf;

mabiki = 25;    % �A�j���[�V�����\�����x���ꍇ�� mabiki ��傫�Ȓl�ɕύX���Ă�������
                % �A�j���[�V�����\������������ꍇ�� mabiki �������Ȓl�ɕύX���Ă�������

for i = 1:mabiki:n
    figure(10); clf;
    axis off
    set(gcf,'Color','w')

    axis('square')
    axis([-0.55 0.55 -0.55 0.55]);
    set(gca,'fontsize',12,'fontname','arial')
    set(gca,'xtick',[])        % �����̖ڐ�
	set(gca,'xticklabel',[])   % �����̖ڐ��̃��x��
	set(gca,'ytick',[])        % �c���̖ڐ�
	set(gca,'yticklabel',[])   % �c���̖ڐ��̃��x��

    % �A�[�����t����
    xaxis = [-0.05 -0.05 0.05 0.05 -0.05];
    yaxis = [-0.05 0.05 0.05 -0.05 -0.05]; 
    patch(xaxis,yaxis,[0.6 0.6 0.6])

    % ��
    xaxis = [-0.13 -0.13 -0.12 -0.12 -0.13];
    yaxis = [-0.1 -0.015 -0.015 -0.1 -0.1]; 
    patch(xaxis,yaxis,'k')

    xaxis = [0.13 0.13 0.12 0.12 0.13];
    yaxis = [-0.1 -0.015 -0.015 -0.1 -0.1]; 
    patch(xaxis,yaxis,'k')

    xaxis = [-0.15 -0.15 -0.1 -0.1 -0.15];
    yaxis = [-0.09 -0.1 -0.1 -0.09 -0.09]; 
    patch(xaxis,yaxis,'k')

    xaxis = [0.15 0.15 0.1 0.1 0.15];
    yaxis = [-0.09 -0.1 -0.1 -0.09 -0.09]; 
    patch(xaxis,yaxis,'k')

    % ��
    xaxis = [-0.175 -0.175 0.175 0.175 -0.175];
    yaxis = [-0.07 -0.05 -0.05 -0.07 -0.07]; 
    patch(xaxis,yaxis,[0.6 0.6 0.6])

    % �n��
    xaxis = [-0.35 -0.35 0.35 0.35 -0.35];
    yaxis = [-0.1 -0.5 -0.5 -0.1 -0.1]; 
    patch(xaxis,yaxis,[0.8 0.8 0.8])

    % �A�[��
    line([0 L1*sin(x1(i))],[0 L1*cos(x1(i))],'color',[0 0 1],'linewidth',12.5);

    % �A�[����
    m = linspace(-pi,pi,100);
    rc11 = 0.02;
    xc11 = rc11*cos(m);
    yc11 = rc11*sin(m);
    patch(xc11,yc11,[1 1 1])

    rc12 = 0.01;
    xc12 = rc12*cos(m);
    yc12 = rc12*sin(m);
    patch(xc12,yc12,[1 1 1])


    % �U�q
    line([L1*sin(x1(i)) L1*sin(x1(i))+L2*sin(x2(i))],[L1*cos(x1(i)) L1*cos(x1(i))+L2*cos(x2(i))],'color',[1 0 0],'linewidth',5);    

    % �U�q��
    rc21 = 0.02;
    xc21 = L1*sin(x1(i)) + rc21*cos(m);
    yc21 = L1*cos(x1(i)) + rc21*sin(m);
    patch(xc21,yc21,[1 1 1])
    
    rc22 = 0.01;
    xc22 = L1*sin(x1(i)) + rc22*cos(m);
    yc22 = L1*cos(x1(i)) + rc22*sin(m);
    patch(xc22,yc22,[1 1 1])

    text(0.475,0.5,num2str(ceil(10*t(i))/10),'fontsize',12,'fontname','arial')
    text(0.6,0.5,'[s]','fontsize',12,'fontname','arial')
    % ----------------------------------------------------
    % ----------------------------------------------------
    drawnow;

end

