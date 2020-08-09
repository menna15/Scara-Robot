function varargout = untitled3(varargin)
%************
% UNTITLED3 MATLAB code for untitled3.fig
%      UNTITLED3, by itself, creates a new UNTITLED3 or raises the existing
%      singleton*.
%
%      H = UNTITLED3 returns the handle to a new UNTITLED3 or the handle to
%      the existing singleton*.
%
%      UNTITLED3('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in UNTITLED3.M with the given input arguments.
%
%      UNTITLED3('Property','Value',...) creates a new UNTITLED3 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before untitled3_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to untitled3_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help untitled3

% Last Modified by GUIDE v2.5 11-May-2020 00:15:54

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @untitled3_OpeningFcn, ...
                   'gui_OutputFcn',  @untitled3_OutputFcn, ...
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


% --- Executes just before untitled3 is made visible.
function untitled3_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to untitled3 (see VARARGIN)

% Choose default command line output for untitled3
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes untitled3 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = untitled3_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
q1=0;
q2=0;
d3=0; 
q4=0;
%should be changed due to the specification of the robot
l1=0.394;
l2=0.450;
l3=0.350;
l4=0.16;
%Definition of the robot using DH (th,d,a,alfa,P/R)
L(1)=Link([q1, l1, l2,0, 0]);
L(2)=Link([q2, 0, l3,0, 0]);
L(3)=Link([0, d3, 0,pi, 1]);
L(3).qlim=[0 0.01];
L(4)=Link([q4, l4, 0, 0, 0]);
% Robot creation

scara = SerialLink(L, 'name', 'scara') 
figure(1)
%***********************
scara.plot([0 0 0 0]);
%scara.plot([pi -pi/2 0.5 pi]);
hold on
H1=transl(0,0,0.394);
trplot(H1,'frame', '1','color','r','arrow');
H2=transl(0.450,0,0.394);
trplot(H2,'frame', '2','color','m','arrow');
H3=transl(0.45,-0.35,0.394)*trotx(-pi)*troty(0)*trotx(0);
trplot(H3,'frame', '3','color','g','arrow');
% H4=transl(0.45,-0.35,0.169);
%  trplot(H4,'frame', '4','color','y','arrow'); %already drawn with no index x,y,z
hold off

% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)

%***********************
q1=0;
q2=0;
d3=0; 
q4=0;
%should be changed due to the specification of the robot
l1=0.394;
l2=0.450;
l3=0.350;
l4=0.16;
%Definition of the robot using DH (th,d,a,alfa,P/R)
L(1)=Link([q1, l1, l2,0, 0]);
L(2)=Link([q2, 0, l3, pi, 0]);
L(3)=Link([0, d3, 0, 0, 1]);
L(3).qlim=[0 0.16];
L(4)=Link([q4, l4, 0, 0, 0]);
%********************
%q1 , q2 ,d3,q4
%values to test robot arm movements 
q0=[0 0 0 0];
q1=[0 pi/2 0.6 pi/2];% the range of d3 till 0.2 we used out of range num just to be clearly shown.
q2=[pi/3 pi/2 0.2 0];
q3=[pi/3 0 0.50 -2*pi/3];
q4=[2*pi/3 0 0.7 0];
%*****************************
scara=SerialLink(L,'name','ScaraRobot')
To=scara.fkine(q0);
T1=scara.fkine(q1);
T2=scara.fkine(q2);
T3=scara.fkine(q3);
T4=scara.fkine(q4);
figure(2)
%********************
tempo=0:2:10;
q=jtraj(q0,q1,tempo);
scara.plot(q)
pause(1)
q=jtraj(q1,q2,tempo);
scara.plot(q)
pause(1)
q=jtraj(q2,q3,tempo);
scara.plot(q)
pause(1)
q=jtraj(q3,q4,tempo);
scara.plot(q)

% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
figure(3)
%*******************
l1=0.394;
l2=4;% lenght shlould be 0.450 we put 4 just to be clear in Workspace diagram
l3=3;% lenght shlould be 0.350 we put 3 just to be clear in Workspace diagram
l4=0.16;
t1=linspace(0,105)*pi/180;
t2=linspace(0,157.5)*pi/180;
d3=linspace(0,210);
t4=linspace(0,360)*pi/180;
[q1,q2,q4]=ndgrid(t1,t2,t4);  %Creates the matrices for each variable 
xM = l2 * cos(q1) + l3 * cos(q2+q1 );
yM = l2 * sin(q1) + l3 * sin(q2+q1);
plot(xM(:),yM(:))

xL = xlim; %all values of x 
yL = ylim; % all values of y 
line(xL, [0 0],'color','b','linewidth',1) %Draw x-axis
line([0 0], yL,'color','b','linewidth',1) %Draw y-axis
pause(1)
figure(4)
q1=0;
k=1;
for q2=0:157.5
    xa=l2*cosd(q1);
    ya=l2*sind(q1);
    xb=xa+l3*cosd(q1+q2);
    yb=ya+l3*sind(q1+q2);
    plot([0 xa],[0 ya],xb,yb,[0 xa xb],[0 ya yb],'linewidth',4)
    axis([ -(l2+l3+1) (l2+l3+1) -(l2+l3+1) (l2+l3+1)])
    grid on
    hold on
   getframe();
   k=k+1;
    
end
q1=105;
k=1;
for q2=0:157.5
    xa=l2*cosd(q1);
    ya=l2*sind(q1);
    xb=xa+l3*cosd(q1+q2);
    yb=ya+l3*sind(q1+q2);
    plot([0 xa],[0 ya],xb,yb,[0 xa xb],[0 ya yb],'linewidth',1)
    axis([ -(l2+l3+1) (l2+l3+1) -(l2+l3+1) (l2+l3+1)])
    grid on
    hold on
   getframe();
   k=k+1;
    
end
q2=0;
k=1;
for q1=0:105
    xa=l2*cosd(q1);
    ya=l2*sind(q1);
    xb=xa+l3*cosd(q1+q2);
    yb=ya+l3*sind(q1+q2);
    plot([0 xa],[0 ya],xb,yb,[0 xa xb],[0 ya yb],'linewidth',1)
    axis([ -(l2+l3+1) (l2+l3+1) -(l2+l3+1) (l2+l3+1)])
    grid on
    hold on
   getframe();
   k=k+1;
    
end
q2=157.5;
k=1;
for q1=0:105
    xa=l2*cosd(q1);
    ya=l2*sind(q1);
    xb=xa+l3*cosd(q1+q2);
    yb=ya+l3*sind(q1+q2);
    plot([0 xa],[0 ya],xb,yb,[0 xa xb],[0 ya yb],'linewidth',1)
    axis([ -(l2+l3+1) (l2+l3+1) -(l2+l3+1) (l2+l3+1)])
    grid on
    hold on
   getframe();
   k=k+1;
    
end
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function edit1_Callback(hObject, eventdata, handles)

% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
figure(5)
theta1=30;%% input from Dr.(######)
theta2=60;%% input from Dr.(######)
d3=50;%% input from Dr.(######)
theta4=110;%% input from Dr.(######)
x6 = str2double(char(get(handles.edit1,'String')));
x7 = str2double(char(get(handles.edit4,'String')));
x8 = str2double(char(get(handles.edit5,'String')));
x9 = str2double(char(get(handles.edit6,'String')));
theta1=x6;
theta2=x7;
d3=x8;
theta4=x9;

X=0.450*cosd(theta1+theta2)+0.350*cosd(theta1);
Y= 0.450*sind(theta1+theta2)+0.350*sind(theta1);
Z=0.394-d3; % that the distance between the base and the first joint is 300 mm
% and the distance the 3rd link has moved is d3 so the eqution is z=d1-d3

% the orientation of the EE is actually represented by a 3*3 matrix(rotation matrix) but we will
% ouput the matrix in a form of 3 vectors to serve the simulation of the robot arm

% the vectors are n,o,a (the matrix is [n o a] )
n=[-cosd(theta1+theta2-theta4) -sind(theta1+theta2-theta4) 0]';
o=[-sind(theta1+theta2-theta4) cosd(theta1+theta2-theta4) 0]';
a=[0 0 -1]';
pos=[X;Y; Z];
%%Concatenation of Bassant's code to facilitate comparing, to draw
%%turn 3x1 vectors into 4x1 as last row is 0
%n=[n;0];
%o=[o;0];
%a=[a;0];
%f=e2h([X;Y;Z]);
%j=[n o a f];
%display(j);
orientation=[n o a]';
H30=transl(X,Y,Z)*trotz((theta1+theta2-theta4)*pi/180)*trotx(pi)*trotz(pi);
%we must put them in output text(######)
%display(H30);%orientation matrix (rotation and traansformation)
%display([n o a]);%rotaion only
%display([X;Y;Z]);%transformation only
%double2str(char(set(handles.edit2,'double')));
set(handles.uitable1, 'Data', H30);
set(handles.uitable2, 'Data', pos);
set(handles.uitable3, 'Data', orientation);
trplot(H30,'frame','axis_3','color','r','arrow');
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes when entered data in editable cell(s) in uitable1.
function uitable1_CellEditCallback(hObject, eventdata, handles)
% hObject    handle to uitable1 (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.TABLE)
%	Indices: row and column indices of the cell(s) edited
%	PreviousData: previous data for the cell(s) edited
%	EditData: string(s) entered by the user
%	NewData: EditData or its converted form set on the Data property. Empty if Data was not changed
%	Error: error string when failed to convert EditData to appropriate value for Data
% handles    structure with handles and user data (see GUIDATA)



function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double


% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit5_Callback(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit5 as text
%        str2double(get(hObject,'String')) returns contents of edit5 as a double


% --- Executes during object creation, after setting all properties.
function edit5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit6_Callback(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit6 as text
%        str2double(get(hObject,'String')) returns contents of edit6 as a double


% --- Executes during object creation, after setting all properties.
function edit6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function uitable3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to uitable3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
