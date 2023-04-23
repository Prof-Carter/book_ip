n = 4;
% ---------------------------
Ap21 = [ 0  0
         0  mp*g*lp/(Jp+mp*lp^2) ];
Ap22 = [ -ac                      0
          ac*mp*lp/(Jp+mp*lp^2)  -mup/(Jp+mp*lp^2) ];
Bp2  = [  bc
         -bc*mp*lp/(Jp+mp*lp^2) ];
% ---------------------------
A = [ zeros(2,2)  eye(2)
      Ap21        Ap22   ];
B = [ zeros(2,1)
      Bp2        ];
% ---------------------------
B1 = B(1:n-1);
B2 = B(n);
T = [ eye(n-1)      -B1/B2
      zeros(1,n-1)   1     ];
Ab = T*A*inv(T);
Bb = T*B;
Ab11 = Ab(1:n-1,1:n-1);
Ab12 = Ab(1:n-1,n);
Ab21 = Ab(n,1:n-1);
Ab22 = Ab(n,n);
% ---------------------------
Q = diag([10 100 1 1]);
Qb = inv(T)'*Q*inv(T);
Qb11 = Qb(1:n-1,1:n-1);
Qb12 = Qb(1:n-1,n);
Qb21 = Qb(n,1:n-1);
Qb22 = Qb(n,n);
% ---------------------------
At11 = Ab11 - Ab12*Qb12'/Qb22;
P = care(At11,Ab12,Qb11,Qb22);
S = ( [Ab12'*P+Qb12'  Qb22]*T )'

