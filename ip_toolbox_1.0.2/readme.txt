IP Toolbox Ver.1.0.2	(08/09/2016)

## MATLAB R2013a-R2016a for Windows (64bit) で動作確認済



---- Step1 ---------------------------------------

zip ファイルを解凍してください．
仮に，C:\hoge\ip_toolbox_1.0.2 が生成されたとして，説明します．

---- Step2 ---------------------------------------

MATLAB コマンドウィンドで

>> addpath(genpath('C:\hoge\ip_toolbox_1.0.2\iptools'))

のようにパスを通してください．

このとき，

>> ip_model

と入力すれば，倒立振子の非線形シミュレータ（Simulink モデル）が起動します．

物理パラメータは

C:\hoge\ip_toolbox_1.0.2\iptools\cdip_para.m		... 台車型倒立振子
C:\hoge\ip_toolbox_1.0.2\iptools\adip_para.m		... アーム型倒立振子

にあります．

---- Step3 ---------------------------------------

サンプルファイルは，

C:\hoge\ip_toolbox_1.0.2\sample_cdip	... 台車型倒立振子
C:\hoge\ip_toolbox_1.0.2\sample_adip	... アーム型倒立振子

に入っています．

=============================================
台車型倒立振子
=============================================
>> cd C:\hoge\ip_toolbox_1.0.2\sample_cdip

% P-D 制御
>> cdip_pdcont_sim
>> cdip_anime

% 最適レギュレータ
>> cdip_lqr_sim
>> cdip_anime

% サーボ制御
>> cdip_lqr_servo_sim
>> cdip_anime


=============================================
アーム型倒立振子
=============================================
>> cd C:\hoge\ip_toolbox_1.0.2\sample_adip

% P-D 制御
>> adip_pdcont_sim
>> adip_anime

% 最適レギュレータ
>> adip_lqr_sim
>> adip_anime

% サーボ制御
>> adip_lqr_servo_sim
>> adip_anime


