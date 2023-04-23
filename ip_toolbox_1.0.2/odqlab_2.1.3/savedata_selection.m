function save_flag=savedata_selection(varargin)

datasel=figure('units','pixels',...
    'Visible','off','windowstyle','normal','Userdata','Qonly',...
    'DeleteFcn',@datasel_deletefcn);
%handles.output = hObject;

odqgui_input = find(strcmp(varargin, 'ODQ_Designer'));
if ~isempty(odqgui_input)
    odq_verify = varargin{odqgui_input+1};
end


selpanel=uibuttongroup(datasel,'BorderType','none','units','pixels',...
    'position',[10 50 280 60],'SelectionChangeFcn',@savedata_WS_changefcn);
uicontrol(selpanel,'Style','radiobutton','Tag','Qonly','Units','pixels',...
    'Position',[0 30 100 30],'String','Quantizer only')
uicontrol(selpanel,'Style','radiobutton','Tag','AllData','Units','pixels',...
    'Position',[0 0 200 30],'String','All Data (stored in structure array)')
savedata_OK=uicontrol(datasel,'Style','pushbutton','String','OK','Position',[120 10 80 30],...
    'Callback',@savedata_OK_callback,'UserData','NG');
uicontrol(datasel,'Style','pushbutton','String','CANCEL','Position',[210 10 80 30],...
    'Callback',@savedata_NG_callback)

DQpos=get(odq_verify,'position');
set(datasel,'position',[DQpos(1)+200 DQpos(2)+100 300 120],'visible','on')
uiwait(datasel)



function savedata_WS_changefcn(hObject, eventdata, handles)
    switch get(eventdata.NewValue,'Tag')
        case 'Qonly'
            set(datasel,'UserData','Qonly');
        case 'AllData'
            set(datasel,'UserData','AllData');
    end
end


function savedata_OK_callback(hObject, eventdata, handles)
    save_flag=get(datasel,'UserData');
    set(hObject,'UserData','OK');
    close
end

function savedata_NG_callback(hObject, eventdata, handles)
%    save_flag='NG';
    close
end

function datasel_deletefcn(hObject,eventdata,handles)
    OK_flag=get(savedata_OK,'UserData');
    if ~strcmp(OK_flag,'OK')
        save_flag='NG';
    end
end

end