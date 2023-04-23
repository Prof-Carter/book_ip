% 例 5.1：可制御なシステムの可制御性行列

clear
format compact

A = [ 1  0
      1  1 ];
B = [ 1
      1 ];

Mc = ctrb(A,B)

rank_Mc = rank(Mc)