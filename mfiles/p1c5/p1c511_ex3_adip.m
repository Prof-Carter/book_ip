% 例 5.3：アーム型倒立振子の可制御性行列
% ## Symbolic Math Toolbox が必要

clear
format compact

syms theta1e real
syms a1 b1 real
syms alpha2 real     % alpha2  = J2 + m2*l2^2
syms alpha3 real     % alpha3  = m2*L1*l2
syms alpha5 real     % alpha5  = m2*l2*g
syms alpha3t real    % alpha3t = alpha3*cos(theta1e)
syms mu2 real

A = [ 0  0  1  0 
      0  0  0  1
      0  0 -a1 0
      0  alpha5/alpha2  (mu2+a1*alpha3t)/alpha2  -mu2/alpha2 ];
B = [ 0
      0
      b1
     -b1*alpha3t/alpha2 ];

Mc = [ B  A*B  A^2*B  A^3*B ];

disp(' ----- 可制御性行列 Mc ----- ')
det_Mc = simplify(det(Mc))

disp(' ----- 振子の粘性摩擦を考慮しない (mu2 = 0) ときの可制御性行列 Mc ----- ')
det_Mc_0 = subs(det_Mc,mu2,0)