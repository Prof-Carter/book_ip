clear
format compact

A = [ 0    -1     0     0    -1
      1     0     0     1     0
      1     1     1     0     1
      0     1    -1     1     0
      1     1     1     1    -1 ]

% ---------------------------------------------
% A の固有値（安定の場合，固有値の実部がすべて負）
eigen_A = eig(A)

if sign(real(eigen_A)) < 0
    disp(' ...... System is asymptotically stable')
else
    disp(' ...... System is not asymptotically stable')
end


