% 例 5.7
% アーム型倒立振子
% 極配置法によるコントローラ設計

clear
format compact

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
s = [-2 -2.5 -3 -3.5];
K = - place(A,B,s)