function varargout = odqloadplant(varargin)
% ODQLOADPLANT M-file for odqloadplant.fig
%      ODQLOADPLANT, by itself, creates a new ODQLOADPLANT or raises the existing
%      singleton*.
%
%      H = ODQLOADPLANT returns the handle to a new ODQLOADPLANT or the handle to
%      the existing singleton*.
%
%      ODQLOADPLANT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ODQLOADPLANT.M with the given input arguments.
%
%      ODQLOADPLANT('Property','Value',...) creates a new ODQLOADPLANT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before odqloadplant_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to odqloadplant_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help odqloadplant

% Last Modified by GUIDE v2.5 27-Dec-2009 11:59:09

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @odqloadplant_OpeningFcn, ...
                   'gui_OutputFcn',  @odqloadplant_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before odqloadplant is made visible.
function odqloadplant_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to odqloadplant (see VARARGIN)

% Choose default command line output for odqloadplant
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes odqloadplant wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = odqloadplant_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
%varargout{2} = get(handles.loadbutton,'UserData');

function vars_struct=update_listbox
j=0;
vars = evalin('base','whos');
vars_struct=cell(0);
for i=1:length(vars)
    if strcmp(vars(i).class,'struct')==1
        j=j+1;
        vars_struct(j)={vars(i).name};
    end
end


% --- Executes on selection change in listbox1.
function listbox1_Callback(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% ヒント: contents = cellstr(get(hObject,'String')) はセル配列として listbox1 の内容を返します。
%        contents{get(hObject,'Value')} は listbox1 から選択した項目を返します。


% --- Executes during object creation, after setting all properties.
function listbox1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
vars_struct=update_listbox;
set(hObject,'String',vars_struct)


% --- Executes on button press in loadbutton.
function loadbutton_Callback(hObject, eventdata, handles)
% hObject    handle to loadbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global odq_plant
list_entries = get(handles.listbox1,'String');
index_selected = get(handles.listbox1,'Value');
var1 = list_entries{index_selected(1)};
odq_plant=evalin('base',var1);
disp(odq_plant)
%set(hObject,'UserData',odq_plant)
%uiresume(f)
close


% --- Executes on button press in cancelbutton.
function cancelbutton_Callback(hObject, eventdata, handles)
% hObject    handle to cancelbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global odq_plant
odq_plant='canceled';
close


% --- Executes on button press in refreshbutton.
function refreshbutton_Callback(hObject, eventdata, handles)
% hObject    handle to refreshbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
vars_struct=update_listbox;
set(handles.listbox1,'String',vars_struct)
