%
% 2.1.3 PID���� (�} 2.10)
%

clear
close all
format compact

%% ��Ԃ̃p�����[�^ %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%���f�� G = b/(s(s+a))
cdip_para
a  = ac;    % ��ԋ쓮�n�̃p�����[�^
b  = bc;    % ��ԋ쓮�n�̃p�����[�^

sysP = tf([0 b],[1 a 0]); % ����Ώ� (2.8)��

%% �����̃p�����[�^ %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% PID�Q�C��
kP = 10;
kD = 0.8;
kI = 5;

% �ϕ����ԁC��������
TI = kP/kI;
TD = kD/kP;

sysK = tf([kP*TI*TD kP*TI kP],[TI 0]); % ����� (2.4)��


%% Bode���} %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% PID����
figure(1); % �����̎��g������
bode(sysK);
hold on;

figure(2); % �J���[�v�`�B�֐��̎��g������
bode(sysP*sysK);
hold on;

figure(2); % ����Ώۂ̎��g������
bode(sysP);
hold on;


% PD����iTI->�� = kI->���j�@
TI = kP/kI*10000;
TD = kD/kP;

sysK = tf([kP*TI*TD kP*TI kP],[TI 0]);
figure(1);
bode(sysK);
hold on;

figure(2);
bode(sysP*sysK);
hold on;


% PI����iTD->�� = kD->���j
TI = kP/kI;
TD = kD/kP*0.0001;
sysK = tf([kP*TI*TD kP*TI kP],[TI 0]);

figure(1);
bode(sysK);
hold on;

figure(2);
bode(sysP*sysK);
hold on;


