clear
format compact

A = [ -1    -1    -1    -1     0
       1    -1    -1     0    -1
       1     0     0    -1     0
       1    -1     1     0    -1
      -1     1    -1     1     0 ]

% ---------------------------------------------
% Q = Q' = I としたときの Lyapunou 方程式
%   P*A + A'*P = -Q
% の解 P = P' を求める
P = lyap(A',eye(5))

% ---------------------------------------------
% P が正定である場合，r = 0
% P が正定でない場合，r > 0
[R,r] = chol(P);
r

if r == 0
    disp(' ...... P is positive')
else
    disp(' ...... P is not positive')
end

% ---------------------------------------------
% P が正定である場合，固有値（実数）がすべて正
% P が正定でない場合，固有値（実数）に負のものが含まれる
eigen_P = eig(P)

if sign(eigen_P) > 0
    disp(' ...... P is positive')
else
    disp(' ...... P is not positive')
end

% ---------------------------------------------
% A の固有値（安定の場合，固有値の実部がすべて負）
eigen_A = eig(A)

if sign(real(eigen_A)) < 0
    disp(' ...... System is asymptotically stable')
else
    disp(' ...... System is not asymptotically stable')
end


