% 例 5.2：不可制御なシステムの可制御性行列
% ## Symbolic Math Toolbox が必要

clear
format compact

syms a real

A = [ a  0  0
      0  0  1
      0  0  0 ];
B = [ 0
      0
      1 ];

Mc = [ B  A*B  A^2*B ]

rank_Mc = rank(Mc)