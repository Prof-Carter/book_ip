%
% 2.1.3 PID制御 (図 2.10)
%

clear
close all
format compact

%% 台車のパラメータ %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%モデル G = b/(s(s+a))
cdip_para
a  = ac;    % 台車駆動系のパラメータ
b  = bc;    % 台車駆動系のパラメータ

sysP = tf([0 b],[1 a 0]); % 制御対象 (2.8)式

%% 制御器のパラメータ %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% PIDゲイン
kP = 10;
kD = 0.8;
kI = 5;

% 積分時間，微分時間
TI = kP/kI;
TD = kD/kP;

sysK = tf([kP*TI*TD kP*TI kP],[TI 0]); % 制御器 (2.4)式


%% Bode線図 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% PID制御
figure(1); % 制御器の周波数特性
bode(sysK);
hold on;

figure(2); % 開ループ伝達関数の周波数特性
bode(sysP*sysK);
hold on;

figure(2); % 制御対象の周波数特性
bode(sysP);
hold on;


% PD制御（TI->大 = kI->小）　
TI = kP/kI*10000;
TD = kD/kP;

sysK = tf([kP*TI*TD kP*TI kP],[TI 0]);
figure(1);
bode(sysK);
hold on;

figure(2);
bode(sysP*sysK);
hold on;


% PI制御（TD->小 = kD->小）
TI = kP/kI;
TD = kD/kP*0.0001;
sysK = tf([kP*TI*TD kP*TI kP],[TI 0]);

figure(1);
bode(sysK);
hold on;

figure(2);
bode(sysP*sysK);
hold on;


