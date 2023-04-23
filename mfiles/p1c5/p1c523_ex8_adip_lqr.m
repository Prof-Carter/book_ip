% 例 5.8
% アーム型倒立振子
% 最適レギュレータによるコントローラ設計

clear
format compact
close all

% ----------------------------------------------------------------
adip_para
theta1e = pi/4;
A = [ 0  0  1  0 
      0  0  0  1
      0  0 -a1 0
      0  alpha5/alpha2  (mu2+a1*alpha3*cos(theta1e))/alpha2  -mu2/alpha2 ];
B = [ 0
      0
      b1
     -b1*alpha3*cos(theta1e)/alpha2 ];
Q = diag([10 10 1 1]);
R = 1;
K = - lqr(A,B,Q,R)

% ===============================================================
% ===============================================================
% 以下は追加

disp('----- シミュレーション結果をアニメーション表示する場合は 1 を入力 -----')
flag = input('input number: ');

if flag == 1

     theta1_0 = 0;
     theta2_0 = 0;
    dtheta1_0 = 0;
    dtheta2_0 = 0;

    % D/A 変換，エンコーダの分解能を考慮しないシミュレーション
    sim('adip_lqr_sim',3)

    % D/A 変換，エンコーダの分解能を考慮したシミュレーション
    % sim('adip_lqr2_sim',3)

    % 表示のはやさは ip_toolbox_1.0.2/iptools/adip_anime.m 内の
    %   mabiki = 25; 
    % の数値を変更する
    adip_anime    % シミュレーション結果をアニメーション表示
end
