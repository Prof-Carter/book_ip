IP Toolbox Ver.1.0.2	(08/09/2016)

## MATLAB R2013a-R2016a for Windows (64bit) �œ���m�F��



---- Step1 ---------------------------------------

zip �t�@�C�����𓀂��Ă��������D
���ɁCC:\hoge\ip_toolbox_1.0.2 ���������ꂽ�Ƃ��āC�������܂��D

---- Step2 ---------------------------------------

MATLAB �R�}���h�E�B���h��

>> addpath(genpath('C:\hoge\ip_toolbox_1.0.2\iptools'))

�̂悤�Ƀp�X��ʂ��Ă��������D

���̂Ƃ��C

>> ip_model

�Ɠ��͂���΁C�|���U�q�̔���`�V�~�����[�^�iSimulink ���f���j���N�����܂��D

�����p�����[�^��

C:\hoge\ip_toolbox_1.0.2\iptools\cdip_para.m		... ��Ԍ^�|���U�q
C:\hoge\ip_toolbox_1.0.2\iptools\adip_para.m		... �A�[���^�|���U�q

�ɂ���܂��D

---- Step3 ---------------------------------------

�T���v���t�@�C���́C

C:\hoge\ip_toolbox_1.0.2\sample_cdip	... ��Ԍ^�|���U�q
C:\hoge\ip_toolbox_1.0.2\sample_adip	... �A�[���^�|���U�q

�ɓ����Ă��܂��D

=============================================
��Ԍ^�|���U�q
=============================================
>> cd C:\hoge\ip_toolbox_1.0.2\sample_cdip

% P-D ����
>> cdip_pdcont_sim
>> cdip_anime

% �œK���M�����[�^
>> cdip_lqr_sim
>> cdip_anime

% �T�[�{����
>> cdip_lqr_servo_sim
>> cdip_anime


=============================================
�A�[���^�|���U�q
=============================================
>> cd C:\hoge\ip_toolbox_1.0.2\sample_adip

% P-D ����
>> adip_pdcont_sim
>> adip_anime

% �œK���M�����[�^
>> adip_lqr_sim
>> adip_anime

% �T�[�{����
>> adip_lqr_servo_sim
>> adip_anime


