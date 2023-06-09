%%% adip_para.m
% ---------------------------
a1  = 6.20e+000;    % アーム駆動系のパラメータ
b1  = 1.58e+001;    % アーム駆動系のパラメータ
L1  = 2.27e-001;    % アームの全長
m2  = 9.60e-002;    % 振子の質量
l2  = 1.95e-001;    % 振子の軸から重心までの長さ
L2  = 3.00e-001;    % 振子の全長
J2  = 9.06e-004;    % 振子の重心まわりの慣性モーメント
mu2 = 1.01e-004;    % 振子の粘性摩擦係数
g   = 9.81e+000;    % 重力加速度
% ---------------------------
alpha2  = J2 + m2*l2^2;
alpha3  = m2*L1*l2;
alpha5  = m2*l2*g;
% ---------------------------
