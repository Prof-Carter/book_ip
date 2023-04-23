function odqlab_interact(varargin)
% ODQLAB_INTERACT ODQLab with interaction mode
%       Help message is unavailable yet 


%  Initialization tasks
dtsize=get(0,'screensize');
odqnavi_window = figure('Visible','off','Name','ODQLab','MenuBar','none',...
    'NumberTitle','off','Position',[dtsize(3)/2-400,dtsize(4)/2-225,800,450]);

debugmode=0;

%%%%% Construct the components %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
workflow    =uipanel(odqnavi_window,'Units','pixels','Position',[10 40 100 400],...
    'BorderType','etchedin','UserData',0);
stintro     =uicontrol(workflow,'Style','text','String','Introduction',...
    'Units','pixel','Position',[10 370 80 20],'FontWeight','bold');
stsystem    =uicontrol(workflow,'Style','text','String','System type',...
    'Units','pixel','Position',[10 340 80 20],'FontWeight','normal');
stplant     =uicontrol(workflow,'Style','text','String','Plant',...
    'Units','pixel','Position',[10 310 80 20],'FontWeight','normal');
stcontroller=uicontrol(workflow,'Style','text','String','Controller',...
    'Units','pixel','Position',[10 280 80 20],'FontWeight','normal');
stquantizer =uicontrol(workflow,'Style','text','String',{'Quantizer','specification'},...
    'Units','pixel','Position',[10 245 80 30],'FontWeight','normal');
stsummary   =uicontrol(workflow,'Style','text','String','Design',...
    'Units','pixel','Position',[10 210 80 20],'FontWeight','normal');


buttonback=uicontrol(odqnavi_window,'Style','pushbutton','String','Back','Units','pixels',...
    'Position',[630 10 70 21],'Enable','off','Callback',@buttonback_callback);
buttonnext=uicontrol(odqnavi_window,'Style','pushbutton','String','Next','Units','pixels',...
    'Position',[710 10 70 21],'Enable','on','Callback',@buttonnext_callback);


intropanel=uipanel(odqnavi_window,'Units','pixels','Position',[110 40 680 400],...
    'BorderType','etchedin','Visible','on');
uicontrol(intropanel,'Style','text','String','ODQLab',...
    'Units','pixels','Position',[250 350 180 40],'FontWeight','bold','FontSize',18);
uicontrol(intropanel,'Style','text','String',...
    {'This Program guides to design','a dynamic quantizer for control.',...
    'It is not need advansed knowledge','for the quantized control.'},...
    'Units','pixels','Position',[10 220 250 80],'FontSize',12,...
    'HorizontalAlignment','left');
uicontrol(intropanel,'Style','text','String',...
    {'(C) 2011 Mechanical system control Lab,','Kyoto University',...
    'Gokasho, Uji, Kyoto 611-0011, Japan',...
    'http://www.robot.kuass.kyoto-u.ac.jp/'},...
    'Units','pixels','Position',[340 10 330 80],...
    'HorizontalAlignment','left');


systempanel=uipanel(odqnavi_window,'Units','pixels','Position',[110 40 680 400],...
    'BorderType','etchedin','Visible','off');
%%%%% Components of SystemPanel %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
uicontrol(systempanel,'Style','text','String',...
    'Select the type of the quantized system to be considered:',...
    'Units','pixels','Position',[10 330 500 30],'FontSize',12,...
    'HorizontalAlignment','left');
connection=uibuttongroup('Parent',systempanel,'Units','pixels','Position',[95 40 565 260],...
    'BorderType','none','SelectionChangeFcn',@connenction_selectionchangefcn);
axes('Parent',systempanel,'Units','pixels','Position',[95 180 245 120],...
    'XLim',[1 11],'YLim',[3 8],'Visible','off','CreateFcn',@axesff_createfcn);
axes('Parent',systempanel,'Units','pixels','Position',[380 180 280 120],...
    'XLim',[0 12],'YLim',[3 8],'Visible','off','CreateFcn',@axesfbiq_createfcn);
axes('Parent',systempanel,'Units','pixels','Position',[380 40 280 120],...
    'XLim',[0 12],'YLim',[3 8],'Visible','off','CreateFcn',@axesfboq_createfcn);
axes('Parent',systempanel,'Units','pixels','Position',[95 40 245 120],...
    'XLim',[1 11],'YLim',[3 8],'Visible','off','CreateFcn',@axeslft_createfcn);
uicontrol(connection,'Style','radiobutton',...
    'String','Feedforward connection','Tag','ff',...
    'Units','pixels','Position',[0 140 190 30]);
uicontrol(connection,'Style','radiobutton',...
    'String','Feedback connection with input quantizer','Tag','fbiq',...
    'Units','pixels','Position',[290 140 280 30]);
uicontrol(connection,'Style','radiobutton',...
    'String','Feedback connection with output quantizer','Tag','fboq',...
    'Units','pixels','Position',[290 0 280 30]);
uicontrol(connection,'Style','radiobutton',...
    'String','LFT connection','Tag','lft',...
    'Units','pixels','Position',[0 0 190 30]);
odqdata.connection='ff';
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


plantpanel=uipanel(odqnavi_window,'Units','pixels','Position',[110 40 680 400],...
    'BorderType','etchedin','Visible','off');
%%%%% Components of PlantPanel %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
uicontrol(plantpanel,'Style','text','String',...
    'Set the plant:',...
    'Units','pixels','Position',[10 330 500 30],'FontSize',12,...
    'HorizontalAlignment','left');
plantset=uibuttongroup('Parent',plantpanel,'Units','pixels','Position',[10 250 200 100],...
    'BorderType','none','SelectionChangeFcn',@plant_selectionchangefcn);
uicontrol(plantset,'Style','radiobutton',...
    'String','Transfer function','Tag','tf',...
    'Units','pixels','Position',[0 50 180 30]);
uicontrol(plantset,'Style','radiobutton',...
    'String','State space','Tag','ss',...
    'Units','pixels','Position',[0 20 180 30]);
%%%%% Transfer Function %%%%%
planttf=uipanel(plantpanel,'Units','pixels','Position',[340 10 330 380],...
    'BorderType','none','Visible','on');
uicontrol(planttf,'Style','text','Units','pixels','Position',[0 275 100 20],...
    'String','Numerator');
uicontrol(planttf,'Style','text','Units','pixels','Position',[0 225 100 20],...
    'String','Denominator');
editnumP=uicontrol(planttf,'Style','edit','Units','pixels','Position',[0 250 300 30],...
    'HorizontalAlignment','left','BackgroundColor',[1 1 1]);
editdenP=uicontrol(planttf,'Style','edit','Units','pixels','Position',[0 200 300 30],...
    'HorizontalAlignment','left','BackgroundColor',[1 1 1]);
%%%%% State Space %%%%%
plantss=uipanel(plantpanel,'Units','pixels','Position',[340 10 330 380],...
    'BorderType','none','Visible','off');
uicontrol(plantss,'Style','text','Units','pixels','Position',[10 300 150 60],...
    'String',{'x[k+1] = A*x[k] + B*v[k]',' z[k] = C1*x[k]',' y[k] = C2*x[k]'},...
    'HorizontalAlignment','left');
uicontrol(plantss,'Style','text','Units','pixels','Position',[0 275 30 20],...
    'String','A');
uicontrol(plantss,'Style','text','Units','pixels','Position',[0 225 30 20],...
    'String','B');
uicontrol(plantss,'Style','text','Units','pixels','Position',[0 175 30 20],...
    'String','C1');
uicontrol(plantss,'Style','text','Units','pixels','Position',[0 125 30 20],...
    'String','C2');
editAP=uicontrol(plantss,'Style','edit','Units','pixels','Position',[0 250 300 30],...
    'HorizontalAlignment','left','BackgroundColor',[1 1 1]);
editBP=uicontrol(plantss,'Style','edit','Units','pixels','Position',[0 200 300 30],...
    'HorizontalAlignment','left','BackgroundColor',[1 1 1]);
editC1P=uicontrol(plantss,'Style','edit','Units','pixels','Position',[0 150 300 30],...
    'HorizontalAlignment','left','BackgroundColor',[1 1 1]);
editC2P=uicontrol(plantss,'Style','edit','Units','pixels','Position',[0 100 300 30],...
    'HorizontalAlignment','left','BackgroundColor',[1 1 1]);
odqdata.Ptype='tf';
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


controlpanel=uipanel(odqnavi_window,'Units','pixels','Position',[110 40 680 400],...
    'BorderType','etchedin','Visible','off');
%%%%% Components of ControllerPanel %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
uicontrol(controlpanel,'Style','text','String',...
    'Set the controller:',...
    'Units','pixels','Position',[10 330 500 30],'FontSize',12,...
    'HorizontalAlignment','left');
controlset=uibuttongroup('Parent',controlpanel,'Units','pixels','Position',[10 250 200 100],...
    'BorderType','none','SelectionChangeFcn',@controller_selectionchangefcn);
uicontrol(controlset,'Style','radiobutton',...
    'String','Transfer function','Tag','tf',...
    'Units','pixels','Position',[0 50 180 30]);
uicontrol(controlset,'Style','radiobutton',...
    'String','State space','Tag','ss',...
    'Units','pixels','Position',[0 20 180 30]);
%%%%% Transfer Function %%%%%
controltf=uipanel(controlpanel,'Units','pixels','Position',[340 10 330 380],...
    'BorderType','none','Visible','on');
uicontrol(controltf,'Style','text','Units','pixels','Position',[0 275 100 20],...
    'String','Numerator');
uicontrol(controltf,'Style','text','Units','pixels','Position',[0 225 100 20],...
    'String','Denominator');
editnumK=uicontrol(controltf,'Style','edit','Units','pixels','Position',[0 250 300 30],...
    'HorizontalAlignment','left','BackgroundColor',[1 1 1]);
editdenK=uicontrol(controltf,'Style','edit','Units','pixels','Position',[0 200 300 30],...
    'HorizontalAlignment','left','BackgroundColor',[1 1 1]);
%%%%% State Space %%%%%
controlss=uipanel(controlpanel,'Units','pixels','Position',[340 10 330 380],...
    'BorderType','none','Visible','off');
uicontrol(controlss,'Style','text','Units','pixels','Position',[10 310 300 50],...
    'String',{'x[k+1] = A*x[k] + B1*r[k] + B2*y[k]',' u[k] = C*x[k] + D1*r[k] + D2*y[k]'},...
    'HorizontalAlignment','left');
uicontrol(controlss,'Style','text','Units','pixels','Position',[0 285 30 20],...
    'String','A');
uicontrol(controlss,'Style','text','Units','pixels','Position',[0 235 30 20],...
    'String','B1');
uicontrol(controlss,'Style','text','Units','pixels','Position',[0 185 30 20],...
    'String','B2');
uicontrol(controlss,'Style','text','Units','pixels','Position',[0 135 30 20],...
    'String','C');
uicontrol(controlss,'Style','text','Units','pixels','Position',[0 85 30 20],...
    'String','D1');
uicontrol(controlss,'Style','text','Units','pixels','Position',[0 35 30 20],...
    'String','D2');
editAK =uicontrol(controlss,'Style','edit','Units','pixels','Position',[0 260 300 30],...
    'HorizontalAlignment','left','BackgroundColor',[1 1 1]);
editB1K=uicontrol(controlss,'Style','edit','Units','pixels','Position',[0 210 300 30],...
    'HorizontalAlignment','left','BackgroundColor',[1 1 1]);
editB2K=uicontrol(controlss,'Style','edit','Units','pixels','Position',[0 160 300 30],...
    'HorizontalAlignment','left','BackgroundColor',[1 1 1]);
editCK =uicontrol(controlss,'Style','edit','Units','pixels','Position',[0 110 300 30],...
    'HorizontalAlignment','left','BackgroundColor',[1 1 1]);
editD1K=uicontrol(controlss,'Style','edit','Units','pixels','Position',[0 60 300 30],...
    'HorizontalAlignment','left','BackgroundColor',[1 1 1]);
editD2K=uicontrol(controlss,'Style','edit','Units','pixels','Position',[0 10 300 30],...
    'HorizontalAlignment','left','BackgroundColor',[1 1 1]);
odqdata.Ktype='tf';
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


lftpanel=uipanel(odqnavi_window,'Units','pixels','Position',[110 40 680 400],...
    'BorderType','etchedin','Visible','off');
%%%%% Components of lftPanel %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
uicontrol(lftpanel,'Style','text','String',...
    'Set the LFT system:',...
    'Units','pixels','Position',[10 330 500 30],'FontSize',12,...
    'HorizontalAlignment','left');
lftset=uibuttongroup('Parent',lftpanel,'Units','pixels','Position',[10 250 200 100],...
    'BorderType','none','SelectionChangeFcn',@lft_selectionchangefcn);
uicontrol(lftset,'Style','radiobutton',...
    'String','Transfer function','Tag','tf',...
    'Units','pixels','Position',[0 50 180 30],'Enable','off','Value',0);
uicontrol(lftset,'Style','radiobutton',...
    'String','State space','Tag','ss',...
    'Units','pixels','Position',[0 20 180 30],'Value',1);
%%%%% Transfer Function %%%%%
% lfttf=uipanel(lftpanel,'Units','pixels','Position',[340 10 330 380],...
%     'BorderType','none','Visible','on');
% uicontrol(planttf,'Style','text','Units','pixels','Position',[0 275 100 20],...
%     'String','Numerator');
% uicontrol(planttf,'Style','text','Units','pixels','Position',[0 225 100 20],...
%     'String','Denominator');
% editnumG=uicontrol(lfttf,'Style','edit','Units','pixels','Position',[0 250 300 30],...
%     'HorizontalAlignment','left','BackgroundColor',[1 1 1]);
% editdenG=uicontrol(lfttf,'Style','edit','Units','pixels','Position',[0 200 300 30],...
%     'HorizontalAlignment','left','BackgroundColor',[1 1 1]);
%%%%% State Space %%%%%
lftss=uipanel(lftpanel,'Units','pixels','Position',[340 10 330 380],...
    'BorderType','none','Visible','on');
uicontrol(lftss,'Style','text','Units','pixels','Position',[10 300 200 60],...
    'String',{'x[k+1] = A*x[k] + B1*r[k] + B2*u[k]',...
             ' z[k] = C1*x[k] +D1*r[k]',...
             ' v[k] = C2*x[k] +D2*r[k]'},...
             'HorizontalAlignment','left');
uicontrol(lftss,'Style','text','Units','pixels','Position',[0 250 30 20],...
    'String','A');
uicontrol(lftss,'Style','text','Units','pixels','Position',[0 210 30 20],...
    'String','B1');
uicontrol(lftss,'Style','text','Units','pixels','Position',[0 170 30 20],...
    'String','B2');
uicontrol(lftss,'Style','text','Units','pixels','Position',[0 130 30 20],...
    'String','C1');
uicontrol(lftss,'Style','text','Units','pixels','Position',[0 90 30 20],...
    'String','C2');
uicontrol(lftss,'Style','text','Units','pixels','Position',[0 50 30 20],...
    'String','D1');
uicontrol(lftss,'Style','text','Units','pixels','Position',[0 10 30 20],...
    'String','D2');
editAG=uicontrol(lftss,'Style','edit','Units','pixels','Position',[30 250 270 30],...
    'HorizontalAlignment','left','BackgroundColor',[1 1 1]);
editB1G=uicontrol(lftss,'Style','edit','Units','pixels','Position',[30 210 270 30],...
    'HorizontalAlignment','left','BackgroundColor',[1 1 1]);
editB2G=uicontrol(lftss,'Style','edit','Units','pixels','Position',[30 170 270 30],...
    'HorizontalAlignment','left','BackgroundColor',[1 1 1]);
editC1G=uicontrol(lftss,'Style','edit','Units','pixels','Position',[30 130 270 30],...
    'HorizontalAlignment','left','BackgroundColor',[1 1 1]);
editC2G=uicontrol(lftss,'Style','edit','Units','pixels','Position',[30 90 270 30],...
    'HorizontalAlignment','left','BackgroundColor',[1 1 1]);
editD1G=uicontrol(lftss,'Style','edit','Units','pixels','Position',[30 50 270 30],...
    'HorizontalAlignment','left','BackgroundColor',[1 1 1]);
editD2G=uicontrol(lftss,'Style','edit','Units','pixels','Position',[30 10 270 30],...
    'HorizontalAlignment','left','BackgroundColor',[1 1 1]);
odqdata.Gtype='ss';
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


quantizerpanel1=uipanel(odqnavi_window,'Units','pixels','Position',[110 40 680 400],...
    'BorderType','etchedin','Visible','off');
%%%%% Components of QuantizerPanel 1 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
uicontrol(quantizerpanel1,'Style','text','String',...
    {'Set the quantization interval:'},...
    'Units','pixels','Position',[10 310 500 50],'FontSize',12,...
    'HorizontalAlignment','left');
axes('Parent',quantizerpanel1,'Units','pixels','Position',[50 50 240 240],...
    'Visible','on','Box','on','XLim',[0 8],'YLim',[0 8],'XTick',0:1:8,'YTick',0:1:8,...
    'XTickLabel',[],'YTickLabel',[],'XGrid','on','YGrid','on',...
    'CreateFcn',@axesinterval_createfcn);
uicontrol(quantizerpanel1,'Style','text','String','Quantization interval',...
    'Units','pixels','Position',[300 200 120 20],'HorizontalAlignment','left');
editd=uicontrol(quantizerpanel1,'Style','edit','String','1',...
    'Units','pixels','Position',[300 175 50 30],'HorizontalAlignment','left',...
    'BackgroundColor',[1 1 1]);

quantizerpanel2=uipanel(odqnavi_window,'Units','pixels','Position',[110 40 680 400],...
    'BorderType','etchedin','Visible','off');
%%%%% Components of QuantizerPanel 2 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
uicontrol(quantizerpanel2,'Style','text','String',...
    'Set the Evaluation time:',...
    'Units','pixels','Position',[10 330 500 30],'FontSize',12,...
    'HorizontalAlignment','left');
axes('Parent',quantizerpanel2,'Units','pixels','Position',[50 100 580 200],...
    'Visible','on','Box','on','CreateFcn',@axesE_createfcn);
uicontrol(quantizerpanel2,'Style','text','String','Evaluation time',...
    'Units','pixels','Position',[240 60 100 25],'HorizontalAlignment','left');
editT=uicontrol(quantizerpanel2,'Style','edit','String','Inf',...
    'Units','pixels','Position',[340 60 50 30],'HorizontalAlignment','left',...
    'BackgroundColor',[1 1 1]);

quantizerpanel3=uipanel(odqnavi_window,'Units','pixels','Position',[110 40 680 400],...
    'BorderType','etchedin','Visible','off');
%%%%% Components of QuantizerPanel 3 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
uicontrol(quantizerpanel3,'Style','text','String',...
    'Set the upper bounds of quantizer gains:',...
    'Units','pixels','Position',[10 330 500 30],'FontSize',12,...
    'HorizontalAlignment','left');
uicontrol(quantizerpanel3,'Style','text','String','Quantizer gain (u -> v)',...
    'Units','pixels','Position',[380 265 150 20],'HorizontalAlignment','left');
uicontrol(quantizerpanel3,'Style','text','String','Quantizer gain (w -> v)',...
    'Units','pixels','Position',[380 105 150 20],'HorizontalAlignment','left');
edituv=uicontrol(quantizerpanel3,'Style','edit','String','Inf',...
    'Units','pixels','Position',[380 230 50 30],'HorizontalAlignment','left',...
    'BackgroundColor',[1 1 1]);
editwv=uicontrol(quantizerpanel3,'Style','edit','String','Inf',...
    'Units','pixels','Position',[380 70 50 30],'HorizontalAlignment','left',...
    'BackgroundColor',[1 1 1]);
axes('Parent',quantizerpanel3,'Units','pixels','Position',[50 170 300 150],...
    'Visible','off','CreateFcn',@axesuv_createfcn);
axes('Parent',quantizerpanel3,'Units','pixels','Position',[50 10 300 150],...
    'Visible','off','CreateFcn',@axeswv_createfcn);

quantizerpanel4=uipanel(odqnavi_window,'Units','pixels','Position',[110 40 680 400],...
    'BorderType','etchedin','Visible','off');
%%%%% Components of QuantizerPanel 4 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
uicontrol(quantizerpanel4,'Style','text','String',...
    'Select a linear programing solver:',...
    'Units','pixels','Position',[10 330 500 30],'FontSize',12,...
    'HorizontalAlignment','left');
lpsolver=uibuttongroup('Parent',quantizerpanel4,'Units','pixels','Position',[100 150 200 170],...
    'BorderType','none','SelectionChangeFcn',@lpsolver_selectionchangefcn);
uicontrol(lpsolver,'Style','radiobutton',...
    'String','linprog','Tag','linprog',...
    'Units','pixels','Position',[10 120 180 30]);
uicontrol(lpsolver,'Style','radiobutton',...
    'String','CPLEX','Tag','cplex',...
    'Units','pixels','Position',[10 90 180 30]);
uicontrol(lpsolver,'Style','radiobutton',...
    'String','SDPT3','Tag','sdpt3',...
    'Units','pixels','Position',[10 60 180 30]);
uicontrol(lpsolver,'Style','radiobutton',...
    'String','SeDuMi','Tag','sedumi',...
    'Units','pixels','Position',[10 30 180 30]);
uicontrol(lpsolver,'Style','radiobutton',...
    'String','SDPA','Tag','sdpa',...
    'Units','pixels','Position',[10 0 180 30],'Visible','off');
odqdata.solver='linprog';
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


summarypanel=uipanel(odqnavi_window,'Units','pixels','Position',[110 40 680 400],...
    'BorderType','etchedin','Visible','off');
%%%%% Components of SummaryPanel %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
summaryPtype=uicontrol(summarypanel,'Style','text','String','P:',...
    'Units','pixels','Position',[10 350 290 30],'HorizontalAlignment','left');
summaryPdata=uicontrol(summarypanel,'Style','text','String','Undefined',...
    'Units','pixels','Position',[10 200 290 150],'fontname','monospased');
summaryKtype=uicontrol(summarypanel,'Style','text','String','K:',...
    'Units','pixels','Position',[10 170 290 30],'HorizontalAlignment','left');
summaryKdata=uicontrol(summarypanel,'Style','text','String','Undefined',...
    'Units','pixels','Position',[10 70 290 100],'fontname','monospased');
uicontrol(summarypanel,'Style','text','String','Quantization inteval',...
    'Units','pixels','Position',[300 350 250 30],'HorizontalAlignment','left');
uicontrol(summarypanel,'Style','text','String','Evaluation period',...
    'Units','pixels','Position',[300 280 250 30],'HorizontalAlignment','left');
uicontrol(summarypanel,'Style','text','String','Quantizer gain',...
    'Units','pixels','Position',[300 210 250 30],'HorizontalAlignment','left');
uicontrol(summarypanel,'Style','text','String','LP solver',...
    'Units','pixels','Position',[300 140 250 30],'HorizontalAlignment','left');
summaryddata=uicontrol(summarypanel,'Style','text','String','Undefined',...
    'Units','pixels','Position',[300 320 250 30],'fontname','monospased');
summaryTdata=uicontrol(summarypanel,'Style','text','String','Undefined',...
    'Units','pixels','Position',[300 250 250 30],'fontname','monospased');
summaryuvdata=uicontrol(summarypanel,'Style','text','String','Undefined',...
    'Units','pixels','Position',[300 180 100 30],'fontname','monospased');
summarywvdata=uicontrol(summarypanel,'Style','text','String','Undefined',...
    'Units','pixels','Position',[400 180 100 30],'fontname','monospased');
summarylpdata=uicontrol(summarypanel,'Style','text','String','Undefined',...
    'Units','pixels','Position',[300 110 250 30]);


resultpanel=uipanel(odqnavi_window,'Units','pixels','Position',[110 40 680 400],...
    'BorderType','etchedin','Visible','off');
%%%%% Components of ResultPanel %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
uicontrol(resultpanel,'Style','text','String','Quantizer gain (u->v)',...
    'Units','pixels','Position',[10 300 100 30],'HorizontalAlignment','left');
uicontrol(resultpanel,'Style','text','String','Quantizer gain (u->w)',...
    'Units','pixels','Position',[10 270 100 30],'HorizontalAlignment','left');
uicontrol(resultpanel,'Style','text','String','Dimension',...
    'Units','pixels','Position',[10 240 100 30],'HorizontalAlignment','left');
uicontrol(resultpanel,'Style','text','String','E(T,Q)',...
    'Units','pixels','Position',[10 210 100 30],'HorizontalAlignment','left');
uicontrol(resultpanel,'Style','text','String','E(Inf,Q)',...
    'Units','pixels','Position',[10 180 100 30],'HorizontalAlignment','left');
uicontrol(resultpanel,'Style','text','String',{'Lower bound','of E(Inf,Q)'}',...
    'Units','pixels','Position',[10 150 100 30],'HorizontalAlignment','left');
uicontrol(resultpanel,'Style','text','String',{'Upper bound','of E(Inf,Q)'}',...
    'Units','pixels','Position',[10 120 100 30],'HorizontalAlignment','left');
resultuv    =uicontrol(resultpanel,'Style','text','String','Undefined',...
    'Units','pixels','Position',[120 300 150 30]);
resultwv    =uicontrol(resultpanel,'Style','text','String','Undefined',...
    'Units','pixels','Position',[120 270 150 30]);
resultdim   =uicontrol(resultpanel,'Style','text','String','Undefined',...
    'Units','pixels','Position',[120 240 150 30]);
resultET    =uicontrol(resultpanel,'Style','text','String','Undefined',...
    'Units','pixels','Position',[120 210 150 30]);
resultEinf  =uicontrol(resultpanel,'Style','text','String','Undefined',...
    'Units','pixels','Position',[120 180 150 30]);
resultLEinf =uicontrol(resultpanel,'Style','text','String','Undefined',...
    'Units','pixels','Position',[120 150 150 30]);
resultUEinf =uicontrol(resultpanel,'Style','text','String','Undefined',...
    'Units','pixels','Position',[120 120 150 30]);
uicontrol(resultpanel,'Style','text','String','Singular value distribution',...
    'Units','pixels','Position',[350 300 250 30]);
axeshnkl=axes('Parent',resultpanel,'Units','pixels','Position',[350 100 250 200],...
    'Visible','on','Box','on');
uicontrol(resultpanel,'Style','text','String','Quantizer reduction',...
    'Units','pixels','position',[350 50 250 20],'Horizontalalignment','left');
setdim=uicontrol(resultpanel,'Style','popupmenu','String','none','Value',1,...
    'Units','pixels','Position',[400 20 100 30],'Callback',@setdim_callback,'BackgroundColor',[1 1 1]);
setdimcustom=uicontrol(resultpanel,'Style','edit','Visible','off',...
    'Units','pixels','Position',[500 20 60 30],'BackgroundColor',[1 1 1],...
    'HorizontalAlignment','left');


savepanel=uipanel(odqnavi_window,'Units','pixels','Position',[110 40 680 400],...
    'BorderType','etchedin','Visible','off');
%%%%% Components of SavelPanel %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
uicontrol(savepanel,'Style','text','String',...
    'What will you do next?',...
    'Units','pixels','Position',[10 330 500 30],'FontSize',12,...
    'HorizontalAlignment','left');
uicontrol(savepanel,'Style','pushbutton','String','Save to Workspace',...
    'Units','pixels','Position',[100 250 140 21],'Callback',@savews_callback);
uicontrol(savepanel,'Style','pushbutton','String','Save to MAT-file',...
    'Units','pixels','Position',[250 250 140 21],'Callback',@savefile_callback);
uicontrol(savepanel,'Style','pushbutton','String','Numerical simuration',...
    'Units','pixels','Position',[150 200 140 21],'Callback',@numsim_callback);
uicontrol(savepanel,'Style','pushbutton','String','Experiment',...
    'Units','pixels','Position',[150 150 140 21],'Callback',@exp_callback);

    
setsimpanel=uipanel(odqnavi_window,'Units','pixels','Position',[110 40 680 400],...
    'BorderType','etchedin','Visible','off');
%%%%% Components of SetsimPanel %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
uicontrol(setsimpanel,'Style','text','String',...
    'Set the simulation conditions:',...
    'Units','pixels','Position',[10 330 500 30],'FontSize',12,...
    'HorizontalAlignment','left');
simblock=axes('parent',setsimpanel,'units','pixels','position',[200 150 280 120],...
    'XLim',[0 12],'YLim',[3 8],'Visible','off');
steditR=uicontrol(setsimpanel,'style','text','string','Reference input',...
    'unit','pixels','position',[80 260 100 20]);
editR=uicontrol(setsimpanel,'style','edit','String','0',...
    'Units','pixels','Position',[130 240 50 20],'HorizontalAlignment','left',...
    'BackgroundColor',[1 1 1]);
steditxP0=uicontrol(setsimpanel,'style','text','string','Initial value (P)',...
    'unit','pixels','position',[360 290 100 20]);
editxP0=uicontrol(setsimpanel,'style','edit','String','[0;0;0;0]',...
    'Units','pixels','Position',[385 270 50 20],'HorizontalAlignment','left',...
    'BackgroundColor',[1 1 1]);
steditxK0=uicontrol(setsimpanel,'style','text','string','Initial value (K)',...
    'unit','pixels','position',[210 290 100 20]);
editxK0=uicontrol(setsimpanel,'style','edit','String','0',...
    'Units','pixels','Position',[245 270 50 20],'HorizontalAlignment','left',...
    'BackgroundColor',[1 1 1]);
uicontrol(setsimpanel,'style','text','string','Simulation time',...
    'unit','pixels','position',[280 150 100 20]);
editfinaltime=uicontrol(setsimpanel,'style','edit','String','100',...
    'Units','pixels','Position',[300 130 50 20],'HorizontalAlignment','left',...
    'BackgroundColor',[1 1 1]);

simulationpanel=uipanel(odqnavi_window,'Units','pixels','Position',[110 40 680 400],...
    'BorderType','etchedin','Visible','off');
%%%%% Components of SimulationPanel %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axesu   =axes('Parent',simulationpanel,'Units','pixels','Position',[ 50 260 250 130],...
    'Box','on','XGrid','on','Ygrid','on');
axesv   =axes('Parent',simulationpanel,'Units','pixels','Position',[ 50  50 250 130],...
    'Box','on','XGrid','on','Ygrid','on');
axesz   =axes('Parent',simulationpanel,'Units','pixels','Position',[420 260 250 130],...
    'Box','on','XGrid','on','Ygrid','on');
axesdiff=axes('Parent',simulationpanel,'Units','pixels','Position',[420  50 250 130],...
    'Box','on','XGrid','on','Ygrid','on');
ylabel(axesu   ,'Quantizer input'  )
ylabel(axesv   ,'Quantizer output' )
ylabel(axesz   ,'Output')
ylabel(axesdiff,'Output difference')


if debugmode==1
    uicontrol(odqnavi_window,'Style','text','String','debug',...
        'Units','pixels','Position',[0 0 50 20]);
    set(odqnavi_window,'MenuBar','figure','ToolBar','figure');
    [Pdebug Kdebug Gdebug Qdebug]=debugdata;
    stprocess=uicontrol(odqnavi_window,'Style','text','String',0,...
        'Units','pixels','Position',[50 0 20 20]);
    set(editAP ,'String',Pdebug.a );
    set(editBP ,'String',Pdebug.b );
    set(editC1P,'String',Pdebug.c1);
    set(editC2P,'String',Pdebug.c2);
    set(editAK ,'String',Kdebug.a );
    set(editB1K,'String',Kdebug.b1);
    set(editB2K,'String',Kdebug.b2);
    set(editCK ,'String',Kdebug.c );
    set(editD1K,'String',Kdebug.d1);
    set(editD2K,'String',Kdebug.d2);
    set(editAG ,'String',Gdebug.a );
    set(editB1G,'String',Gdebug.b1);
    set(editB2G,'String',Gdebug.b2);
    set(editC1G,'String',Gdebug.c1);
    set(editC2G,'String',Gdebug.c2);
    set(editD1G,'String',Gdebug.d1);
    set(editD2G,'String',Gdebug.d2);
%     set(editnumP ,'String',Pdebug.num );
%     set(editdenP ,'String',Pdebug.den );
%     set(editnumK,'String',Kdebug.num);
%     set(editdenK,'String',Kdebug.den);
    set(editd  ,'String',Qdebug.d );
    set(editT  ,'String',Qdebug.T );
    set(edituv ,'String',Qdebug.gamma.uv);
    set(editwv ,'String',Qdebug.gamma.wv);
end

set(odqnavi_window,'UserData',odqdata);
set(odqnavi_window,'Visible','on');


%%%%% Callbacks for Panel Change %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    function buttonnext_callback(hObject,eventdata,handles)
        odqdata=get(odqnavi_window,'UserData');
        process=get(workflow,'UserData');
        switch process
            case 0
                set(intropanel ,'Visible','off');
                set(systempanel,'Visible','on');
                set(buttonback,'Enable','on');
                set(stintro ,'FontWeight','normal')
                set(stsystem,'FontWeight','bold')
                process=1;
                
            case 1
                set(stsystem,'FontWeight','normal')
                set(stplant ,'FontWeight','bold')
                set(systempanel,'Visible','off');
                if strcmp(odqdata.connection,'lft')
                    set(lftpanel,'Visible','on');
                    set(stcontroller,'FontWeight','bold')
                    process=2.5;
                else
                    set(plantpanel ,'Visible','on');
                    process=2;
                end
            case 2
                switch odqdata.Ptype
                    case 'tf'
                        tmp_P.num=get(editnumP,'String');
                        tmp_P.den=get(editdenP,'String');
                        P.num =evalin('base',tmp_P.num);
                        P.den =evalin('base',tmp_P.den);
                        
                    case 'ss'
                        tmp_P.a =get(editAP ,'String');
                        tmp_P.b =get(editBP ,'String');
                        tmp_P.c1=get(editC1P,'String');
                        tmp_P.c2=get(editC2P,'String');
                        P.a =evalin('base',tmp_P.a);
                        P.b =evalin('base',tmp_P.b);
                        P.c1=evalin('base',tmp_P.c1);
                        P.c2=evalin('base',tmp_P.c2);
                end
                odqdata.P=P;
                set(odqnavi_window,'UserData',odqdata)
  
                set(plantpanel  ,'Visible','off');
                set(stplant     ,'FontWeight','normal')
                if strcmp(odqdata.connection,'ff')
                    set(quantizerpanel1,'Visible','on');
                    set(stquantizer ,'FontWeight','bold')
                    process=4;
                else
                    set(controlpanel,'Visible','on');
                    set(stcontroller,'FontWeight','bold')
                    process=3;
                end
            case 3
                switch odqdata.Ktype
                    case 'tf'
                        tmp_K.num=get(editnumK,'String');
                        tmp_K.den=get(editdenK,'String');
                        K.num =evalin('base',tmp_K.num);
                        K.den =evalin('base',tmp_K.den);
                    case 'ss'
                        tmp_K.a =get(editAK ,'String');
                        tmp_K.b1=get(editB1K,'String');
                        tmp_K.b2=get(editB2K,'String');
                        tmp_K.c =get(editCK,'String');
                        tmp_K.d1=get(editD1K,'String');
                        tmp_K.d2=get(editD2K,'String');
                        K.a =evalin('base',tmp_K.a);
                        K.b1=evalin('base',tmp_K.b1);
                        K.b2=evalin('base',tmp_K.b2);
                        K.c =evalin('base',tmp_K.c);
                        K.d1=evalin('base',tmp_K.d1);
                        K.d2=evalin('base',tmp_K.d2);
                end
                odqdata.K=K;
                set(odqnavi_window,'UserData',odqdata)
                
                set(controlpanel   ,'Visible','off');
                set(quantizerpanel1,'Visible','on');
                set(stcontroller,'FontWeight','normal')
                set(stquantizer ,'FontWeight','bold')
                process=4;
            case 2.5
                switch odqdata.Gtype
                    case 'tf'
                        tmp_G.num=get(editnumG,'String');
                        tmp_G.den=get(editdenG,'String');
                        G.num =evalin('base',tmp_G.num);
                        G.den =evalin('base',tmp_G.den);
                    case 'ss'
                        tmp_G.a =get(editAG ,'String');
                        tmp_G.b1=get(editB1G,'String');
                        tmp_G.b2=get(editB2G,'String');
                        tmp_G.c1=get(editC1G,'String');
                        tmp_G.c2=get(editC2G,'String');
                        tmp_G.d1=get(editD1G,'String');
                        tmp_G.d2=get(editD2G,'String');
                        G.a =evalin('base',tmp_G.a);
                        G.b1=evalin('base',tmp_G.b1);
                        G.b2=evalin('base',tmp_G.b2);
                        G.c1=evalin('base',tmp_G.c1);
                        G.c2=evalin('base',tmp_G.c2);
                        G.d1=evalin('base',tmp_G.d1);
                        G.d2=evalin('base',tmp_G.d2);
                end
                odqdata.G=G;
                set(odqnavi_window,'UserData',odqdata)
                
                set(lftpanel   ,'Visible','off');
                set(quantizerpanel1,'Visible','on');
                set(stcontroller,'FontWeight','normal')
                set(stplant,'FontWeight','normal')
                set(stquantizer ,'FontWeight','bold')
                process=4;
            case 4
                odqdata.d=str2double(get(editd,'String'));
                set(odqnavi_window,'UserData',odqdata);
                
                set(quantizerpanel1,'Visible','off');
                set(quantizerpanel2,'Visible','on');
                process=4.2;
            case 4.2
                odqdata.T=str2double(get(editT,'String'));
                set(odqnavi_window,'UserData',odqdata);
                
                set(quantizerpanel2,'Visible','off');
                set(quantizerpanel3,'Visible','on');
                process=4.3;
            case 4.3
                odqdata.gamma.uv=str2double(get(edituv,'String'));
                odqdata.gamma.wv=str2double(get(editwv,'String'));
                set(odqnavi_window,'UserData',odqdata);
                
                set(quantizerpanel3,'Visible','off');
                set(quantizerpanel4,'Visible','on');
                set(buttonnext,'string','Design');
                process=4.4;
            case 4.4
                odqdata.T=str2double(get(editT,'String'));
                set(odqnavi_window,'UserData',odqdata);
                setsummary
                if ~strcmp(odqdata.connection,'lft') && strcmp(odqdata.Ptype,'tf')
                    [P.a P.b P.c1 P.d]=tf2ss(odqdata.P.num,odqdata.P.den);
                    P.c2=P.c1;
                    odqdata.P=P;
                end                    
                if strncmp(odqdata.connection,'fb',2) && strcmp(odqdata.Ktype,'tf')
                    [K.a K.b2 K.c K.d2]=tf2ss(odqdata.K.num,odqdata.K.den);
                    K.b1=K.b2;
                    K.d1=K.d2;
                    odqdata.K=K;
                end
                
                set(quantizerpanel4,'Visible','off');
                set(summarypanel,'Visible','on');
                set(stquantizer,'FontWeight','normal');
                set(stsummary,  'FontWeight','bold');
                process=5;
            case 5
                con=odqdata.connection;
                if strcmp(con,'lft')
                    G=odqdata.G;
                else
                    P=odqdata.P;
                    if strcmp(con,'ff')
                        K=[];
                    else
                        K=odqdata.K;
                    end
                    G=compg(P,K,con);
                end
                T=odqdata.T;
                d=odqdata.d;
                gamma=odqdata.gamma;
                solver=odqdata.solver;
                 [Q E Hk gain]=odq(G,T,d,gamma,[],solver);
                if ~strcmp(con,'lft')
                    odqdata.P=P;
                    odqdata.K=K;
                end
                odqdata.G=G;
                odqdata.connection=con;
                odqdata.Q=Q;
                odqdata.E=E;
                odqdata.Hk=Hk;
                odqdata.gain=gain;
                set(odqnavi_window,'UserData',odqdata)
                setresult
                set(summarypanel,'Visible','off');
                set(resultpanel ,'Visible','on');
                set(hObject,'String','Next');
                set(stsummary,'FontWeight','normal')
%                set(stsummary,'FontWeight','bold')
                process=6;
            case 6
                if get(setdim,'Value')==1
                    set(resultpanel  ,'Visible','off');
                    set(savepanel,'Visible','on');
%                set(stsummary,'FontWeight','normal')
%                set(stsummary,'FontWeight','bold')
                    set(buttonnext,'Enable','off')
                    process=7;
                else
                    G =odqdata.G;
                    Hk=odqdata.Hk;
                    T =odqdata.T;
                    d =odqdata.d;
                    dimchoice=get(setdim,'Value');
                    dimcandidate=get(setdim,'String');
                    customdim=size(dimcandidate,1);
                    if dimchoice==customdim
                        dim=str2double(get(setdimcustom,'String'));
                    else
                        dim=str2double(dimcandidate(dimchoice));
                    end
                    [Q Hk] = odqreal(G,Hk,dim);
                    E = odqcost(G,Q,d,T);
                    gain = odqgain(Q,T);
                    odqdata.Q=Q;
                    odqdata.E=E;
                    odqdata.Hk=Hk;
                    odqdata.gain=gain;
                    set(odqnavi_window,'UserData',odqdata)
                    setresult
                    set(setdim,'Value',1);
                    set(buttonnext,'String','Next')
                end
            case 7
                set(savepanel  ,'Visible','off');
                set(setsimpanel,'Visible','on');
%                set(stquantizer,'FontWeight','normal')
%                set(stsummary,'FontWeight','bold')
                process=8;
            case 8
                set(setsimpanel  ,'Visible','off');
                set(simulationpanel,'Visible','on');
                set(buttonnext,'String','Start');
                process=9;
            case 9
                startsim;
                process=10;
        end
        set(workflow      ,'UserData',process);
        set(odqnavi_window,'UserData',odqdata);
        if debugmode==1
            set(stprocess,'String',process);
            val=whos;
            for k=1:length(val)
                if exist(val(k).name,'var')
                    assignin('base',val(k).name,eval(val(k).name))
                end
            end
        end
    end
                
    function buttonback_callback(hObject,eventdata,handles)
        process=get(workflow,'UserData');
        switch process
            case 10
                process=9;
            case 9
                set(simulationpanel,'Visible','off');
                set(setsimpanel  ,'Visible','on');
%                set(stsummary,'FontWeight','normal')
%                set(stsummary,'FontWeight','bold')
                process=8;
            case 8
                set(setsimpanel,'Visible','off');
                set(savepanel  ,'Visible','on');
%                set(stsummary,'FontWeight','normal')
%                set(stsummary,'FontWeight','bold')
                set(buttonnext ,'Enable','off');
                process=7;
            case 7
                set(savepanel,'Visible','off');
                set(resultpanel  ,'Visible','on');
%                set(stsummary,'FontWeight','normal')
%                set(stsummary,'FontWeight','bold')
                set(buttonnext,'Enable','on')
                process=6;
            case 6
                set(resultpanel ,'Visible','off');
                set(summarypanel,'Visible','on');
                set(buttonnext,'String','Design');
%                set(stsummary,'FontWeight','normal')
                set(stsummary,'FontWeight','bold')
                process=5;
            case 5
                set(summarypanel  ,'Visible','off');
                set(quantizerpanel4,'Visible','on');
                set(buttonnext,'String','Next');
                set(stsummary  ,'FontWeight','normal')
                set(stquantizer,'FontWeight','bold')
                process=4.4;
            case 4.4
                set(quantizerpanel4,'Visible','off');
                set(quantizerpanel3,'Visible','on');
                process=4.3;
            case 4.3
                set(quantizerpanel3,'Visible','off');
                set(quantizerpanel2,'Visible','on');
                process=4.2;
            case 4.2
                set(quantizerpanel2,'Visible','off');
                set(quantizerpanel1,'Visible','on');
                process=4;
            case 4
                set(quantizerpanel1,'Visible','off');
                set(stquantizer ,'FontWeight','normal');
                set(stcontroller,'FontWeight','bold');
                if strcmp(odqdata.connection,'lft')
                    set(stplant,'FontWeight','bold');
                    set(lftpanel,'Visible','on');
                    process=2.5;
                else
                    set(controlpanel  ,'Visible','on');
                    process=3;
                end
            case 2.5
                set(lftpanel,'Visible','off');
                set(systempanel  ,'Visible','on');
                set(stcontroller,'FontWeight','normal')
                set(stplant,'FontWeight','normal')
                set(stsystem     ,'FontWeight','bold')
                process=2;
            case 3
                set(controlpanel,'Visible','off');
                set(plantpanel  ,'Visible','on');
                set(stcontroller,'FontWeight','normal')
                set(stplant     ,'FontWeight','bold')
                process=2;
            case 2
                set(plantpanel ,'Visible','off');
                set(systempanel,'Visible','on');
                set(stplant ,'FontWeight','normal')
                set(stsystem,'FontWeight','bold')
                process=1;
            case 1
                set(systempanel,'Visible','off');
                set(intropanel ,'Visible','on');
                set(hObject,'Enable','off');
                set(stsystem,'FontWeight','normal')
                set(stintro ,'FontWeight','bold')
                process=0;
        end
        set(workflow,'UserData',process);
        set(odqnavi_window,'UserData',odqdata);
        if debugmode==1
            set(stprocess,'String',process);
            val=whos;
            for k=1:length(val)
                if exist(val(k).name,'var')
                    assignin('base',val(k).name,eval(val(k).name))
                end
            end
        end
    end


%%%%% Callbacks for SystemPanel %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    function axesff_createfcn(hObject,eventdata,handles)
        block=create_ff_block(hObject);
        set(hObject,'UserData',block)
    end
    function axesfbiq_createfcn(hObject,eventdata,handles)
        block=create_fbiq_block(hObject);
        set(hObject,'UserData',block)
    end
    function axesfboq_createfcn(hObject,eventdata,handles)
        block=create_fboq_block(hObject);
        set(hObject,'UserData',block)
    end
    function axeslft_createfcn(hObject,eventdata,handles)
        block=create_GQ_block(hObject);
        set(hObject,'UserData',block)
    end
    function connenction_selectionchangefcn(hObject,eventdata,handles)
        odqdata=get(odqnavi_window,'UserData');
        odqdata.connection=get(eventdata.NewValue,'Tag');
        set(odqnavi_window,'UserData',odqdata)
    end


%%%%% Callbacks for PlantPanel %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    function plant_selectionchangefcn(hObject,eventdata,handles)
        odqdata=get(odqnavi_window,'UserData');
        odqdata.Ptype=get(eventdata.NewValue,'Tag');
        switch odqdata.Ptype
            case 'tf'
                set(planttf,'Visible','on');
                set(plantss,'Visible','off');
            case 'ss'
                set(planttf,'Visible','off');
                set(plantss,'Visible','on');
        end
        set(odqnavi_window,'Userdata',odqdata);
    end

%%%%% Callbacks for ControllerPanel %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    function controller_selectionchangefcn(hObject,eventdata,handles)
        odqdata=get(odqnavi_window,'UserData');
        odqdata.Ktype=get(eventdata.NewValue,'Tag');
        switch odqdata.Ktype
            case 'tf'
                set(controltf,'Visible','on');
                set(controlss,'Visible','off');
            case 'ss'
                set(controltf,'Visible','off');
                set(controlss,'Visible','on');
        end                
        set(odqnavi_window,'Userdata',odqdata);
    end


%%%%% Callbacks for QuantizerPanel %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    function axesinterval_createfcn(hObject,eventdata,handles)
        line([0 8 NaN 7.8 8 7.8 NaN 4 4 NaN 3.9 4 4.1],...
             [4 4 NaN 4.1 4 3.9 NaN 0 8 NaN 7.8 8 7.8],...
             'LineWidth',2,'Color',[0 0 0]);
        line([0 0.5 0.5 1.5 1.5 2.5 2.5 3.5 3.5 4.5 4.5 5.5 5.5 6.5 6.5 7.5 7.5 8],...
             [0 0   1   1   2   2   3   3   4   4   5   5   6   6   7   7   8   8],...
             'LineWidth',2,'Color',[1 0 0]);
        line([5.4 5.4 NaN 5.3 5.4 5.5 NaN 5.3 5.4 5.5],...
             [4.1 4.9 NaN 4.7 4.9 4.7 NaN 4.3 4.1 4.3],...
             'LineWidth',2,'Color',[0 0 0]);
        text(5.8,4.5,'$d$','FontSize',16,'Interpreter','latex','Color',[0 0 0]);
         
    end
    function axesE_createfcn(hObject,eventdata,handles)
        plot(0:0.1:10,2*sin(2.*(0:0.1:10)),...
            'LineWidth',2,'Color',[0 0 1],'Parent',hObject);
        hold on
        stairs(-0.1:0.2:10.1,2*sin(2.*(0:0.2:10.2)),...
            'LineWidth',2,'Color',[1 0 0],'Parent',hObject);
        hold off
        set(hObject,'XLim',[0 10],'YLim',[-4 4],'XTick',0:1:10,'YTick',-4:1:4,...
            'XTickLabel',[],'YTickLabel',[],'XGrid','on','YGrid','on');
%         line([0  1  1  2  2  3  3  4  5  5  6  6  7  7  8  8  9  9 10],...
%              [3  3  0  0 -3 -3  3  3  3 -3 -3  0  0  3  3 -3 -3  0  0],...
%              'LineWidth',2,'Color',[1 0 0],'Parent',hObject);
        line([ 0    8   NaN 0.25  0   0.25  NaN 7.75  8   7.75],...
             [-2.5 -2.5 NaN -2.3 -2.5 -2.7  NaN -2.3 -2.5 -2.7],...
             'LineWidth',2,'Color',[0 0 0]);
        text(4,-3,'$T$','FontSize',16,'Interpreter','latex','Color',[0 0 0]);
    end
    function axesuv_createfcn(hObject,eventdata,handles)
        plot(1:0.1:3,sin(6.5*(0:0.1:2))+4,'LineWidth',2,'Color',[0 0 1],...
            'Parent',hObject);
        hold on
        plot(7:0.1:9,1.5*sin(6.5*(0:0.1:2))+4,'LineWidth',2,'Color',[1 0 0],...
            'Parent',hObject);
        hold off
        set(hObject,'XLim',[0 10],'YLim',[0 8],'Visible','off');
        line([1 3 NaN 1 3 NaN 7.0 9.0 NaN 7.0 9.0],...
             [3 3 NaN 5 5 NaN 5.5 5.5 NaN 2.5 2.5],...
             'LineWidth',2,'color',[0 0 0]);
        line([2.0 2.0 NaN 1.8 2.0 2.2 NaN 2.0 2.0 NaN 1.8 2.0 2.2 NaN ...
              8.0 8.0 NaN 7.8 8.0 8.2 NaN 8.0 8.0 NaN 7.8 8.0 8.2],...
             [1.0 3.0 NaN 2.0 3.0 2.0 NaN 7.0 5.0 NaN 6.0 5.0 6.0 NaN ...
              0.0 2.5 NaN 1.5 2.5 1.5 NaN 8.0 5.5 NaN 6.5 5.5 6.5],...
             'LineWidth',2,'Color',[0 0 0]);
        line([3 7 NaN 3 7],[5 5.5 NaN 3 2.5],...
             'LineWidth',1,'LineStyle',':','Color',[0 0 0]);
        line([3.00 4.00 NaN 3.50 4.00 3.50],...
             [4.00 4.00 NaN 3.75 4.00 4.25],...
             'LineWidth',2,'Color',[0 0 1],'Parent',hObject);
        line([6.00 7.00 NaN 6.50 7.00 6.50],...
             [4.00 4.00 NaN 3.75 4.00 4.25],...
             'LineWidth',2,'Color',[1 0 0],'Parent',hObject);
        rectangle('Position',[4 3 2 2],'FaceColor',[1.0 1.0 0.0]);
        text(4.75,4,'$Q$','FontSize',16,'Interpreter','latex',...
            'Parent',hObject,'Color',[0 0 0]);
        text(0.2,4,'$u$','FontSize',16,'Interpreter','latex',...
            'Parent',hObject,'Color',[0 0 0]);
        text(9.5,4,'$v$','FontSize',16,'Interpreter','latex',...
            'Parent',hObject,'Color',[0 0 0]);
    end
    function axeswv_createfcn(hObject,eventdata,handles)
        plot(1:0.1:3,sin(6.5*(0:0.1:2))+4,'LineWidth',2,'Color',[0 0 1],...
            'Parent',hObject);
        hold on
        plot(7:0.1:9,1.5*sin(6.5*(0:0.1:2))+4,'LineWidth',2,'Color',[1 0 0],...
            'Parent',hObject);
        hold off
        set(hObject,'XLim',[0 10],'YLim',[0 8],'Visible','off');
        line([1 3 NaN 1 3 NaN 7.0 9.0 NaN 7.0 9.0],...
             [3 3 NaN 5 5 NaN 5.5 5.5 NaN 2.5 2.5],...
             'LineWidth',2,'color',[0 0 0]);
        line([2.0 2.0 NaN 1.8 2.0 2.2 NaN 2.0 2.0 NaN 1.8 2.0 2.2 NaN ...
              8.0 8.0 NaN 7.8 8.0 8.2 NaN 8.0 8.0 NaN 7.8 8.0 8.2],...
             [1.0 3.0 NaN 2.0 3.0 2.0 NaN 7.0 5.0 NaN 6.0 5.0 6.0 NaN ...
              0.0 2.5 NaN 1.5 2.5 1.5 NaN 8.0 5.5 NaN 6.5 5.5 6.5],...
             'LineWidth',2,'Color',[0 0 0]);
        line([3 7 NaN 3 7],[5 5.5 NaN 3 2.5],...
             'LineWidth',1,'LineStyle',':','Color',[0 0 0]);
        line([3.00 4.00 NaN 3.50 4.00 3.50],...
             [4.00 4.00 NaN 3.75 4.00 4.25],...
             'LineWidth',2,'Color',[0 0 1],'Parent',hObject);
        line([6.00 7.00 NaN 6.50 7.00 6.50],...
             [4.00 4.00 NaN 3.75 4.00 4.25],...
             'LineWidth',2,'Color',[1 0 0],'Parent',hObject);
        rectangle('Position',[4 3 2 2],'FaceColor',[1.0 1.0 0.0]);
        text(4.75,4,'$Q$','FontSize',16,'Interpreter','latex',...
            'Parent',hObject,'Color',[0 0 0]);
        text(0.2,4,'$w$','FontSize',16,'Interpreter','latex',...
            'Parent',hObject,'Color',[0 0 0]);
        text(9.5,4,'$v$','FontSize',16,'Interpreter','latex',...
            'Parent',hObject,'Color',[0 0 0]);
    end
    function lpsolver_selectionchangefcn(hObject,eventdata,handles)
        odqdata=get(odqnavi_window,'UserData');
        odqdata.solver=get(eventdata.NewValue,'Tag');
        set(odqnavi_window,'UserData',odqdata);
    end
        
%%%%% Callbacks for ResultPanel %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    function setdim_callback(hObject,eventdata,handles)
        dimchoice=get(hObject,'Value');
        customdim=size(get(hObject,'String'),1);
        if dimchoice==customdim
            set(setdimcustom,'Visible','on');
        else
            set(setdimcustom,'Visible','off');            
        end
        if dimchoice==1
            set(buttonnext,'String','Next')
        else
            set(buttonnext,'String','Reduce');
        end
    end


%%%%% Callbacks for SavePanel %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    function savews_callback(hObject,eventdata,handles)
        odqdata=get(odqnavi_window,'UserData');
        save_flag=savedata_selection('ODQ_Designer',odqnavi_window);
        if strcmp(save_flag,'Qonly')
            val_name=inputdlg('Variable name in workspace');
            if ~isempty(val_name{1})
                assignin('base',val_name{1},odqdata.Q)
                fprintf('Quantizer exported in Workspace!\n');
            end
        end
        if strcmp(save_flag,'AllData')
            odqdata_ex=data_export(odqdata);
            val_name=inputdlg('Variable name in workspace');
            if ~isempty(val_name{1})
                assignin('base',val_name{1},odqdata_ex)
                fprintf('Quantizer exported in Workspace!\n');
            end
        end
    end

    function savefile_callback(hObject,eventdata,handles)
        odqdata=get(odqnavi_window,'UserData');
        save_flag=savedata_selection('ODQ_Designer',odqnavi_window);
        if strcmp(save_flag,'Qonly')
            val_name=inputdlg('Variable name in workspace');
            odqsave.name='Quantizer';
            if ~isempty(val_name{1})
                eval(['odqsave.' val_name{1} '=' 'odqdata.Q']);
                [filename pathname]=uiputfile('*.mat','Save quantizer to MAT-file','quantizer.mat');
                if filename~=0
                    save([pathname filename],'-struct','odqsave',val_name{1})
                end
            end
        end
        if strcmp(save_flag,'AllData')
            odqdata_ex=data_export(odqdata);
            val_name=inputdlg('Variable name in workspace');
            odqsave.name='ODQ_DATA';
            if ~isempty(val_name{1})
                eval(['odqsave.' val_name{1} '=' 'odqdata_ex']);
                [filename pathname]=uiputfile('*.mat','Save quantizer to MAT-file','quantizer.mat');
                if filename~=0
                    save([pathname filename],'-struct','odqsave',val_name{1})
                end
            end
        end
    end

    function numsim_callback(hObject,eventdata,handles)
        odqdata=get(odqnavi_window,'Userdata');
        set(savepanel,'Visible','off');
        set(setsimpanel,'Visible','on');
        process=8;
        set(workflow,'UserData',process);
        if debugmode==1
            set(stprocess,'String',process);
            val=whos;
            for k=1:length(val)
                if exist(val(k).name,'var')
                    assignin('base',val(k).name,eval(val(k).name))
                end
            end
        end
        switch odqdata.connection
            case 'ff'
                create_ff_block(simblock);
                set(steditR,'Position',[125 225 100 20]);
                set(editR,'Position',[150 205 50 20]);
                set(steditxP0,'Position',[340 265 100 20]);
                set(editxP0,'Position',[365 245 50 20]);
                set(steditxK0,'Visible','off');
                set(editxK0,'Visible','off');
            case 'fbiq'
                create_fbiq_block(simblock);
            case 'fboq'
                create_fboq_block(simblock);
            case 'lft'
                create_GQ_block(simblock);
                set(steditxP0,'String','Initial value (G)','Position',[290 290 100 20]);
                set(editxP0,'Position',[315 270 50 20]);
                set(steditxK0,'Visible','off');
                set(editxK0,'Visible','off');
        end
        set(buttonnext,'Enable','on')
    end

    function exp_callback(hObject,eventdata,handles)
        odqdata=get(odqnavi_window,'Userdata');
        if ispc
            xpcexplr
            xpclib
        end
        switch odqdata.connection
            case 'ff'
                open odqexp_ff.mdl;
                set_param('odqexp_ff/ODQ','A' ,mat2str(odqdata.Q.a));
                set_param('odqexp_ff/ODQ','B1',mat2str(odqdata.Q.b1));
                set_param('odqexp_ff/ODQ','B2',mat2str(odqdata.Q.b2));
                set_param('odqexp_ff/ODQ','C' ,mat2str(odqdata.Q.c));
                save_system('odqexp_ff',[currentfolder '/odqexp_ff'],'BreakAllLinks','true');
            case 'fbiq'
                open odqexp_fbiq.mdl;
                set_param('odqexp_fbiq/ODQ','A',mat2str(odqdata.Q.a));
                set_param('odqexp_fbiq/ODQ','B1',mat2str(odqdata.Q.b1));
                set_param('odqexp_fbiq/ODQ','B2',mat2str(odqdata.Q.b2));
                set_param('odqexp_fbiq/ODQ','C',mat2str(odqdata.Q.c));
                set_param('odqexp_fbiq/K'  ,'A' ,mat2str(odqdata.K.a ));
                set_param('odqexp_fbiq/K'  ,'B1',mat2str(odqdata.K.b1));
                set_param('odqexp_fbiq/K'  ,'B2',mat2str(odqdata.K.b2));
                set_param('odqexp_fbiq/K'  ,'C' ,mat2str(odqdata.K.c ));
                set_param('odqexp_fbiq/K'  ,'D1',mat2str(odqdata.K.d1));
                set_param('odqexp_fbiq/K'  ,'D2',mat2str(odqdata.K.d2));
                save_system('odqexp_fbiq',[currentfolder '/odqexp_fbiq'],'BreakAllLinks','true');
            case 'fboq'
                open odqexp_fboq.mdl;
                set_param('odqexp_fboq/ODQ','A',mat2str(odqdata.Q.a));
                set_param('odqexp_fboq/ODQ','B1',mat2str(odqdata.Q.b1));
                set_param('odqexp_fboq/ODQ','B2',mat2str(odqdata.Q.b2));
                set_param('odqexp_fboq/ODQ','C',mat2str(odqdata.Q.c));
                set_param('odqexp_fboq/K','A' ,mat2str(odqdata.K.a));
                set_param('odqexp_fboq/K','B1',mat2str(odqdata.K.b1));
                set_param('odqexp_fboq/K','B2',mat2str(odqdata.K.b2));
                set_param('odqexp_fboq/K','C' ,mat2str(odqdata.K.c));
                set_param('odqexp_fboq/K','D1',mat2str(odqdata.K.d1));
                set_param('odqexp_fboq/K','D2',mat2str(odqdata.K.d2));
                save_system('odqexp_fboq',[currentfolder '/odqexp_fboq'],'BreakAllLinks','true');
            case 'lft'
                open odqexp_lft.mdl;
                set_param('odqexp_lft/ODQ','A',mat2str(odqdata.Q.a));
                set_param('odqexp_lft/ODQ','B1',mat2str(odqdata.Q.b1));
                set_param('odqexp_lft/ODQ','B2',mat2str(odqdata.Q.b2));
                set_param('odqexp_lft/ODQ','C',mat2str(odqdata.Q.c));
                set_param('odqexp_lft/K','A' ,mat2str(odqdata.K.a));
                set_param('odqexp_lft/K','B1',mat2str(odqdata.K.b1));
                set_param('odqexp_lft/K','B2',mat2str(odqdata.K.b2));
                set_param('odqexp_lft/K','C' ,mat2str(odqdata.K.c));
                set_param('odqexp_lft/K','D1',mat2str(odqdata.K.d1));
                set_param('odqexp_lft/K','D2',mat2str(odqdata.K.d2));
                save_system('odqexp_lft',[currentfolder '/odqexp_lft'],'BreakAllLinks','true');
        end        
    end

%%%%% Other functions %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    function block=create_ff_block(parent)
        block.u=line([1.00 3.00 NaN 2.50 3.00 2.50],...
                     [5.75 5.75 NaN 6.00 5.75 5.50],...
                     'LineWidth',2,'Color',[0 0 1],'Parent',parent);
        block.v=line([5.00 7.00 NaN 6.50 7.00 6.50],...
                     [5.75 5.75 NaN 6.00 5.75 5.50],...
                     'LineWidth',2,'Color',[1 0 0],'Parent',parent);
        block.z=line([9.00 11.0 NaN 10.5 11.0 10.5],...
                     [5.75 5.75 NaN 6.00 5.75 5.50],...
                     'LineWidth',2,'Color',[0 0 0],'Parent',parent);
        block.P=rectangle('Position',[7 5 2 1.5],'FaceColor',[0.7 0.3 1.0],...
            'Parent',parent);
        block.Q=rectangle('Position',[3 5 2 1.5],'FaceColor',[1.0 1.0 0.0],...
            'Parent',parent);
        block.textP=text(7.6,5.75,'$P$','FontSize',16,'Interpreter','latex',...
            'Parent',parent,'Color',[1 1 1]);
        block.textQ=text(3.6,5.75,'$Q$','FontSize',16,'Interpreter','latex',...
            'Parent',parent,'Color',[0 0 0]);
    end
    function block=create_fbiq_block(parent)
        block.r=line([ 0.00  2.00 NaN  1.50  2.00  1.50],...
                     [ 7.00  7.00 NaN  7.25  7.00  6.75],...
                     'LineWidth',2,'Color',[0 0 0],'Parent',parent);
        block.u=line([ 4.00  5.00 NaN  4.50  5.00  4.50],...
                     [ 6.75  6.75 NaN  7.00  6.75  6.50],...
                     'LineWidth',2,'Color',[0 0 1],'Parent',parent);
        block.v=line([ 7.00  8.00 NaN  7.50  8.00  7.50],...
                     [ 6.75  6.75 NaN  7.00  6.75  6.50],...
                     'LineWidth',2,'Color',[1 0 0],'Parent',parent);
        block.z=line([10.00 12.00 NaN 11.50 12.00 11.50],...
                     [ 7.00  7.00 NaN  7.25  7.00  6.75],...
                     'LineWidth',2,'Color',[0 0 0],'Parent',parent);
        block.y=line([10.00 10.50 10.50 1.25 1.25 2.00 NaN 1.50 2.00 1.50],...
                     [ 6.50  6.50  5.00 5.00 6.50 6.50 NaN 6.75 6.50 6.25],...
                     'LineWidth',2,'Color',[0 0 0],'Parent',parent);
        block.P=rectangle('Position',[8 6 2 1.5],'FaceColor',[0.7 0.3 1.0],...
            'Parent',parent);
        block.K=rectangle('Position',[2 6 2 1.5],'FaceColor',[1.0 0.7 0.0],...
            'Parent',parent);
        block.Q=rectangle('Position',[5 6 2 1.5],'FaceColor',[1.0 1.0 0.0],...
            'Parent',parent);
        block.textP=text(8.6,6.75,'$P$','FontSize',16,'Interpreter','latex',...
            'Parent',parent,'Color',[1 1 1]);
        block.textK=text(2.6,6.75,'$K$','FontSize',16,'Interpreter','latex',...
            'Parent',parent,'Color',[1 1 1]);
        block.textQ=text(5.6,6.75,'$Q$','FontSize',16,'Interpreter','latex',...
            'Parent',parent,'Color',[0 0 0]);
    end
    function block=create_fboq_block(parent)
        block.r=line([ 0.00  2.00 NaN  1.50  2.00  1.50],...
                     [ 7.00  7.00 NaN  7.25  7.00  6.75],...
                     'LineWidth',2,'Color',[0 0 0],'Parent',parent);
        block.u=line([10.00 10.50 10.50  7.00 NaN 7.50 7.00 7.50],...
                     [ 6.50  6.50  5.00  5.00 NaN 5.25 5.00 4.75],...
                     'LineWidth',2,'Color',[0 0 1],'Parent',parent);
        block.v=line([ 5.00  1.25  1.25  2.00 NaN 1.50 2.00 1.50],...
                     [ 5.00  5.00  6.50  6.50 NaN 6.75 6.50 6.25],...
                     'LineWidth',2,'Color',[1 0 0],'Parent',parent);
        block.z=line([10.00 12.00 NaN 11.50 12.00 11.50],...
                     [ 7.00  7.00 NaN  7.25  7.00  6.75],...
                     'LineWidth',2,'Color',[0 0 0],'Parent',parent);
        block.w=line([ 4.00  8.00 NaN  7.50  8.00  7.50],...
                     [ 6.75  6.75 NaN  7.00  6.75  6.50],...
                     'LineWidth',2,'Color',[0 0 0],'Parent',parent);
        block.P=rectangle('Position',[8 6 2 1.5],'FaceColor',[0.7 0.3 1.0],...
            'Parent',parent);
        block.K=rectangle('Position',[2 6 2 1.5],'FaceColor',[1.0 0.7 0.0],...
            'Parent',parent);
        block.Q=rectangle('Position',[5 4.25 2 1.5],'FaceColor',[1.0 1.0 0.0],...
            'Parent',parent);
        block.textP=text(8.6,6.75,'$P$','FontSize',16,'Interpreter','latex',...
            'Parent',parent,'Color',[1 1 1]);
        block.textK=text(2.6,6.75,'$K$','FontSize',16,'Interpreter','latex',...
            'Parent',parent,'Color',[1 1 1]);
        block.textQ=text(5.6,5.00,'$Q$','FontSize',16,'Interpreter','latex',...
            'Parent',parent,'Color',[0 0 0]);
    end
    function block=create_GQ_block(parent)
        block.r=line([1.00 5.00 NaN  4.50  5.00  4.50],...
                     [7.00 7.00 NaN  7.25  7.00  6.75],...
                     'LineWidth',2,'Color',[0 0 0],'Parent',parent);
        block.u=line([7.00 9.00 9.00 7.00 NaN 7.50 7.00 7.50],...
                     [6.50 6.50 5.00 5.00 NaN 5.25 5.00 4.75],...
                     'LineWidth',2,'Color',[0 0 1],'Parent',parent);
        block.v=line([5.00 3.00 3.00 5.00 NaN 4.50 5.00 4.50],...
                     [5.00 5.00 6.50 6.50 NaN 6.75 6.50 6.25],...
                     'LineWidth',2,'Color',[1 0 0],'Parent',parent);
        block.z=line([7.00 11.00 NaN 10.50 11.00 10.50],...
                     [7.00  7.00 NaN  7.25  7.00  6.75],...
                     'LineWidth',2,'Color',[0 0 0],'Parent',parent);
        block.G=rectangle('Position',[5 6 2 1.5],'FaceColor',[0.0 0.7 0.3],...
            'Parent',parent);
        block.Q=rectangle('Position',[5 4.25 2 1.5],'FaceColor',[1.0 1.0 0.0],...
            'Parent',parent);
        block.textG=text(5.6,6.75,'$G$','FontSize',16,'Interpreter','latex',...
            'Parent',parent,'Color',[1 1 1]);
        block.textQ=text(5.6,5.00,'$Q$','FontSize',16,'Interpreter','latex',...
            'Parent',parent,'Color',[0 0 0]);
    end


    function setsummary
        odqdata=get(odqnavi_window,'UserData');
        if strcmp(odqdata.connection,'lft')
            Gtype=odqdata.Gtype;
            Gtmp=odqdata.G;
            switch Gtype
                case 'tf'
                    Gstnum='';
                    for k=1:length(Gtmp.num)
                        if Gtmp.num(k)~=0
                            if Gtmp.num(k)==1 && k~=length(Gtmp.num)
                                Gsttmp='';
                            elseif Gtmp.num(k)==-1 && k~=length(Gtmp.num)
                                Gsttmp='-';
                            else
                                Gsttmp=num2str(Gtmp.num(k));
                            end
                            if k~=1 && Gtmp.num(k)>=0
                                Gstnum=strcat(Gstnum,sprintf('%s','+'));
                            end
                            if (length(Gtmp.num)-k)==0
                                Gstnum=strcat(Gstnum,sprintf('%s',Gsttmp));
                            elseif (length(Gtmp.num)-k)==1
                                Gstnum=strcat(Gstnum,sprintf('%s%s',Gsttmp,'s'));
                            else
                                Gstnum=strcat(Gstnum,sprintf('%s%s%d',Gsttmp,'s^',length(Gtmp.num)-k));
                            end
                        end
                    end
                    Gstden='';
                    for k=1:length(Gtmp.den)
                        if Gtmp.den(k)~=0
                            if Gtmp.den(k)==1 && k~=length(Gtmp.den)
                                Gsttmp='';
                            elseif Gtmp.den(k)==-1 && k~=length(Gtmp.den)
                                Gsttmp='-';
                            else
                                Gsttmp=num2str(Gtmp.den(k));
                            end
                            if k~=1 && Gtmp.den(k)>=0
                                Gstden=strcat(Gstden,sprintf('%s','+'));
                            end
                            if (length(Gtmp.den)-k)==0
                                Gstden=strcat(Gstden,sprintf('%s',Gsttmp));
                            elseif (length(Gtmp.den)-k)==1
                                Gstden=strcat(Gstden,sprintf('%s%s',Gsttmp,'s'));
                            else
                                Gstden=strcat(Gstden,sprintf('%s%s%d',Gsttmp,'s^',length(Gtmp.den)-k));
                            end
                        end
                    end
                    
                    Gstbar=char('-'*ones(max(size(Gstnum),size(Gstden))));
                    set(summaryPtype,'String','G: Transfer function');
                    set(summaryPdata,'String',{Gstnum,Gstbar,Gstden});
                case 'ss'
                    Gsta =sprintf('%s%d%s%d%s','A: ' ,size(Gtmp.a,1) ,'x',size(Gtmp.a,2) ,' matrix');
                    Gstb1=sprintf('%s%d%s%d%s','B1: ',size(Gtmp.b1,1),'x',size(Gtmp.b1,2),' matrix');
                    Gstb2=sprintf('%s%d%s%d%s','B1: ',size(Gtmp.b2,1),'x',size(Gtmp.b2,2),' matrix');
                    Gstc1=sprintf('%s%d%s%d%s','C1: ',size(Gtmp.c1,1),'x',size(Gtmp.c1,2),' matrix');
                    Gstc2=sprintf('%s%d%s%d%s','C2: ',size(Gtmp.c2,1),'x',size(Gtmp.c2,2),' matrix');
                    Gstd1=sprintf('%s%d%s%d%s','C1: ',size(Gtmp.d1,1),'x',size(Gtmp.d1,2),' matrix');
                    Gstd2=sprintf('%s%d%s%d%s','C2: ',size(Gtmp.d2,1),'x',size(Gtmp.d2,2),' matrix');
                    set(summaryPtype,'String','G: State space');
                    set(summaryPdata,'String',{Gsta,Gstb1,Gstb2,Gstc1,Gstc2,Gstd1,Gstd2});
                    set(summaryKtype,'Visible','off');
                    set(summaryKdata,'Visible','off');
            end
        else
            Ptype=odqdata.Ptype;
            Ptmp=odqdata.P;
            switch Ptype
                case 'tf'
                    Pstnum='';
                    for k=1:length(Ptmp.num)
                        if Ptmp.num(k)~=0
                            if Ptmp.num(k)==1 && k~=length(Ptmp.num)
                                Psttmp='';
                            elseif Ptmp.num(k)==-1 && k~=length(Ptmp.num)
                                Psttmp='-';
                            else
                                Psttmp=num2str(Ptmp.num(k));
                            end
                            if k~=1 && Ptmp.num(k)>=0
                                Pstnum=strcat(Pstnum,sprintf('%s','+'));
                            end
                            if (length(Ptmp.num)-k)==0
                                Pstnum=strcat(Pstnum,sprintf('%s',Psttmp));
                            elseif (length(Ptmp.num)-k)==1
                                Pstnum=strcat(Pstnum,sprintf('%s%s',Psttmp,'s'));
                            else
                                Pstnum=strcat(Pstnum,sprintf('%s%s%d',Psttmp,'s^',length(Ptmp.num)-k));
                            end
                        end
                    end
                    Pstden='';
                    for k=1:length(Ptmp.den)
                        if Ptmp.den(k)~=0
                            if Ptmp.den(k)==1 && k~=length(Ptmp.den)
                                Psttmp='';
                            elseif Ptmp.den(k)==-1 && k~=length(Ptmp.den)
                                Psttmp='-';
                            else
                                Psttmp=num2str(Ptmp.den(k));
                            end
                            if k~=1 && Ptmp.den(k)>=0
                                Pstden=strcat(Pstden,sprintf('%s','+'));
                            end
                            if (length(Ptmp.den)-k)==0
                                Pstden=strcat(Pstden,sprintf('%s',Psttmp));
                            elseif (length(Ptmp.den)-k)==1
                                Pstden=strcat(Pstden,sprintf('%s%s',Psttmp,'s'));
                            else
                                Pstden=strcat(Pstden,sprintf('%s%s%d',Psttmp,'s^',length(Ptmp.den)-k));
                            end
                        end
                    end
                    
                    Pstbar=char('-'*ones(max(size(Pstnum),size(Pstden))));
                    set(summaryPtype,'String','P: Transfer function');
                    set(summaryPdata,'String',{Pstnum,Pstbar,Pstden});
                case 'ss'
                    Psta =sprintf('%s%d%s%d%s','A: ' ,size(Ptmp.a,1) ,'x',size(Ptmp.a,2) ,' matrix');
                    Pstb =sprintf('%s%d%s%d%s','B: ' ,size(Ptmp.b,1) ,'x',size(Ptmp.b,2) ,' matrix');
                    Pstc1=sprintf('%s%d%s%d%s','C1: ',size(Ptmp.c1,1),'x',size(Ptmp.c1,2),' matrix');
                    Pstc2=sprintf('%s%d%s%d%s','C2: ',size(Ptmp.c2,1),'x',size(Ptmp.c2,2),' matrix');
                    set(summaryPtype,'String','P: State space');
                    set(summaryPdata,'String',{Psta,Pstb,Pstc1,Pstc2});
            end
            if strncmp(odqdata.connection,'fb',2)
                Ktype=odqdata.Ktype;
                Ktmp=odqdata.K;
                switch Ktype
                    case 'tf'
                        Kstnum='';
                        for k=1:length(Ktmp.num)
                            if Ktmp.num(k)~=0
                                if Ktmp.num(k)==1 && k~=length(Ktmp.num)
                                    Ksttmp='';
                                elseif Ktmp.num(k)==-1 && k~=length(Ktmp.num)
                                    Ksttmp='-';
                                else
                                    Ksttmp=num2str(Ktmp.num(k));
                                end
                                if k~=1 && Ktmp.num(k)>=0
                                    Kstnum=strcat(Kstnum,sprintf('%s','+'));
                                end
                                if (length(Ktmp.num)-k)==0
                                    Kstnum=strcat(Kstnum,sprintf('%s',Ksttmp));
                                elseif (length(Ktmp.num)-k)==1
                                    Kstnum=strcat(Kstnum,sprintf('%s%s',Ksttmp,'z'));
                                else
                                    Kstnum=strcat(Kstnum,sprintf('%s%s%d',Ksttmp,'z^',length(Ktmp.num)-k));
                                end
                            end
                        end
                        Kstden='';
                        for k=1:length(Ktmp.den)
                            if Ktmp.den(k)~=0
                                if Ktmp.den(k)==1 && k~=length(Ktmp.den)
                                    Ksttmp='';
                                elseif Ktmp.den(k)==-1 && k~=length(Ktmp.den)
                                    Ksttmp='-';
                                else
                                    Ksttmp=num2str(Ktmp.den(k));
                                end
                                if k~=1 && Ktmp.den(k)>=0
                                    Kstden=strcat(Kstden,sprintf('%s','+'));
                                end
                                if (length(Ktmp.den)-k)==0
                                    Kstden=strcat(Kstden,sprintf('%s',Ksttmp));
                                elseif (length(Ktmp.den)-k)==1
                                    Kstden=strcat(Kstden,sprintf('%s%s',Ksttmp,'z'));
                                else
                                    Kstden=strcat(Kstden,sprintf('%s%s%d',Ksttmp,'z^',length(Ktmp.den)-k));
                                end
                            end
                        end
                        
                        Kstbar=char('-'*ones(max(size(Kstnum),size(Kstden))));
                        set(summaryKtype,'String','K: Transfer function');
                        set(summaryKdata,'String',{Kstnum,Kstbar,Kstden});
                    case 'ss'
                        Ksta =sprintf('%s%d%s%d%s','A: ' ,size(Ktmp.a,1) ,'x',size(Ktmp.a,2) ,' matrix');
                        Kstb1=sprintf('%s%d%s%d%s','B1: ',size(Ktmp.b1,1),'x',size(Ktmp.b1,2),' matrix');
                        Kstb2=sprintf('%s%d%s%d%s','B2: ',size(Ktmp.b2,1),'x',size(Ktmp.b2,2),' matrix');
                        Kstc =sprintf('%s%d%s%d%s','C: ' ,size(Ktmp.c,1) ,'x',size(Ktmp.c,2) ,' matrix');
                        Kstd1=sprintf('%s%d%s%d%s','D1: ',size(Ktmp.d1,1),'x',size(Ktmp.d1,2),' matrix');
                        Kstd2=sprintf('%s%d%s%d%s','D2: ',size(Ktmp.d2,1),'x',size(Ktmp.d2,2),' matrix');
                        set(summaryKtype,'String','K: State space');
                        set(summaryKdata,'String',{Ksta,Kstb1,Kstb2,Kstc,Kstd1,Kstd2});
                end
            end
        end
        d =get(editd ,'String');
        T =get(editT ,'String');
        uv=get(edituv,'String');
        wv=get(editwv,'String');
        lp=odqdata.solver;
        set(summaryddata,'String',d)
        set(summaryTdata,'String',T)
        set(summaryuvdata,'String',uv)
        set(summarywvdata,'String',wv)
        set(summarylpdata,'String',lp)
    end


    function setresult
        odqdata=get(odqnavi_window,'UserData');
        G    = odqdata.G;
        Q    = odqdata.Q;
        d    = odqdata.d;
        gain = odqdata.gain;
        E    = odqdata.E;
        Hk   = odqdata.Hk;

        if size(Q.a,1)>1000
            Einf='skipped';
        else
            Einf = odqcost(G,Q,d,inf);
        end
        staticQ.a  = 0;
        staticQ.b1 = zeros(1,size(G.c2,1));
        staticQ.b2 = zeros(1,size(G.c2,1));
        staticQ.c  = zeros(size(G.c2,1),1);
        E_upper = odqcost(G,staticQ,d,inf);
        E_low   = norm(G.c1*G.b2,inf)*d/2;
        
        
        set(resultwv   ,'String',gain.wv)
        set(resultuv   ,'String',1)
        set(resultdim  ,'String',size(Q.a,1));
        set(resultET   ,'String',E);
        set(resultEinf ,'String',Einf);
        set(resultLEinf,'String',E_low);
        set(resultUEinf,'String',E_upper)
        singular_xrange=0:size(Hk.S,1)-1;
        stairs(axeshnkl,singular_xrange,diag(Hk.S),'LineWidth',2);
        set(axeshnkl,'YScale','log','YGrid','on');
        redline=zeros(1,size(Hk.S,1));
        for k=1:size(Hk.S,1)-1
            if Hk.S(k+1,k+1)/Hk.S(k,k)<0.1
                redline(k)=1;
            end
        end
        if max(redline)==1
            singular_yrange=get(axeshnkl,'YLim');
            xredline=find(redline);
            for k=1:length(xredline)
                line([xredline(k) xredline(k)],singular_yrange,'Color',[1 0 0],...
                    'Parent',axeshnkl);
            end
            set(axeshnkl,'XTick',xredline,'XTickLabel',xredline);
            set(setdim,'String',['None',num2cell(xredline),'Other']);
        end
        odqdata.E_inf=Einf;
        odqdata.E_lower=E_low;
        odqdata.E_upper=E_upper;
        set(odqnavi_window,'UserData',odqdata)
    end
    function startsim
        odqdata = get(odqnavi_window,'UserData');
        G = odqdata.G;
        Q = odqdata.Q;
        d = odqdata.d;
        
        Rt=get(editR,'String');
        x0_P=get(editxP0,'string');
        x0_K=get(editxK0,'string');
        kFinal=str2double(get(editfinaltime,'string'));
        x  = zeros( size(G.a ,1) , kFinal+1 );
        xQ = zeros( size(G.a ,1) , kFinal+1 );
        z  = zeros( size(G.c1,1) , kFinal+1 );
        zQ = zeros( size(G.c1,1) , kFinal+1 );
        u  = zeros( size(G.c2,1) , kFinal+1 );
        uQ = zeros( size(G.c2,1) , kFinal+1 );
        xi = zeros( size(Q.a ,1) , kFinal+1 );
        v  = zeros( size(Q.c ,1) , kFinal+1 );

        k = 0:kFinal;
        flg.r_work  = 0;
        flg.x0_P_work = 0;
        flg.x0_K_work = 0;
        work_val = evalin('base','who');
        for i = 1:size(work_val)
            if strcmp(work_val(i,:),Rt)==1
                r=evalin('base',Rt);
                flg.r_work=1;
            end
            if strcmp(work_val(i,:),x0_P)==1
                x0_P=evalin('base',x0_K);
                flg.x0_P_work=1;
            end
            if strcmp(work_val(i,:),x0_K)==1
                x0_K=evalin('base',x0_K);
                flg.x0_K_work=1;
            end
        end
        if flg.r_work==0
            r = eval(Rt);
        end
        if isscalar(r)==1
            r = r*ones(1,kFinal+1);
        end
        if flg.x0_P_work==1;
            x0_P2 = x0_P;
        else
            x0_P2 = eval(x0_P);
        end
        if flg.x0_K_work==1;
            x0_K2 = x0_K;
        else
            x0_K2 = eval(x0_K);
        end
        if strcmp(odqdata.connection,'ff') || strcmp(odqdata.connection,'lft')
            x(:,1)  = x0_P2;
            xQ(:,1) = x0_P2;
        else
            x(:,1)  = [x0_P2;x0_K2];
            xQ(:,1) = [x0_P2;x0_K2];
        end
        %%% start simulation %%%
        for i=1:kFinal+1
            z(:,i)  = G.c1*x(:,i)  + G.d1*r(:,i);
            zQ(:,i) = G.c1*xQ(:,i) + G.d1*r(:,i);
            u(:,i)  = G.c2*x(:,i)  + G.d2*r(:,i);
%             if u(:,i)>60
%                 u(:,i)=60;
%             elseif u(:,i)<-60
%                 u(:,i)=-60;
%             end
            uQ(:,i) = G.c2*xQ(:,i) + G.d2*r(:,i);
%             if uQ(:,i)>60
%                 uQ(:,i)=60;
%             elseif uQ(:,i)<-60
%                 uQ(:,i)=-60;
%             end
            v(:,i)  = d*round( ( Q.c*xi(:,i) + uQ(:,i) )/d );
            if v(:,i)>60;
                v(:,i)=60;
            elseif v(:,i)<-60
                v(:,i)=-60;
            end
            xi(:,i+1) = Q.a*xi(:,i) + Q.b1*uQ(:,i) + Q.b2*v(:,i);
            x(:,i+1)  = G.a*x(:,i)  + G.b1*r(:,i) + G.b2*u(:,i);
            xQ(:,i+1) = G.a*xQ(:,i) + G.b1*r(:,i) + G.b2*v(:,i);
             if uQ(:,i)>60
                uQ(:,i)=60;
            elseif uQ(:,i)<-60
                uQ(:,i)=-60;
            end
           
        end
        stairs(axesu   ,k,uQ'    );
        %axis(axes_u,[0 kFinal min(u) max(u)])
        stairs(axesv   ,k,v'    );
        stairs(axesz   ,k,zQ'   );
        stairs(axesdiff,k,zQ'-z');
        ylabel(axesu   ,'Quantizer input'  ,'FontSize',10)
        ylabel(axesv   ,'Quantizer output' ,'FontSize',10)
        ylabel(axesz   ,'Output'           ,'FontSize',10)
        ylabel(axesdiff,'Output difference','FontSize',10)
        set(axesu   ,'XGrid','on','YGrid','on')
        set(axesv   ,'XGrid','on','YGrid','on')
        set(axesz   ,'XGrid','on','YGrid','on')
        set(axesdiff,'XGrid','on','YGrid','on')
    end

    function odqdata_ex=data_export(odqdata)
        if ~strcmp(odqdata.connection,'lft')
            odqdata_ex.P          = odqdata.P;
            if ~strcmp(odqdata.connection,'ff')
                odqdata_ex.K          = odqdata.K;
            end
        end
        odqdata_ex.G          = odqdata.G;
        odqdata_ex.Q          = odqdata.Q;
        odqdata_ex.Hk         = odqdata.Hk;
        odqdata_ex.gamma      = odqdata.gamma;
        odqdata_ex.gain       = odqdata.gain;
        odqdata_ex.connection = odqdata.connection;
        odqdata_ex.d          = odqdata.d;
        odqdata_ex.T          = odqdata.T;
        odqdata_ex.solver     = odqdata.solver;
        odqdata_ex.dim        = size(odqdata.Q.a,1);
        odqdata_ex.E          = odqdata.E;
        odqdata_ex.E_inf      = odqdata.E_inf;
        odqdata_ex.E_lower    = odqdata.E_lower;
        odqdata_ex.E_upper    = odqdata.E_upper;
    end

end


