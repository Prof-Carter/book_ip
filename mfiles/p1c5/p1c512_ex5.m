% —á 5.5F‰Â§Œä³€Œ`‚Ö‚Ì•ÏŠ·

clear
format compact

A = [ 1  0
      1  1 ];
B = [ 1
      1 ];

Mc = ctrb(A,B)

poly_A = poly(A)

U = [ poly_A(2) 1
      1         0 ]

T = inv(Mc*U)

Ahat = T*A*inv(T)
Bhat = T*B