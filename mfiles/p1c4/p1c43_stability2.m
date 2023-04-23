clear
format compact

A = [ -1    -1    -1    -1     0
       1    -1    -1     0    -1
       1     0     0    -1     0
       1    -1     1     0    -1
      -1     1    -1     1     0 ]

% ---------------------------------------------
% Q = Q' = I �Ƃ����Ƃ��� Lyapunou ������
%   P*A + A'*P = -Q
% �̉� P = P' �����߂�
P = lyap(A',eye(5))

% ---------------------------------------------
% P ������ł���ꍇ�Cr = 0
% P ������łȂ��ꍇ�Cr > 0
[R,r] = chol(P);
r

if r == 0
    disp(' ...... P is positive')
else
    disp(' ...... P is not positive')
end

% ---------------------------------------------
% P ������ł���ꍇ�C�ŗL�l�i�����j�����ׂĐ�
% P ������łȂ��ꍇ�C�ŗL�l�i�����j�ɕ��̂��̂��܂܂��
eigen_P = eig(P)

if sign(eigen_P) > 0
    disp(' ...... P is positive')
else
    disp(' ...... P is not positive')
end

% ---------------------------------------------
% A �̌ŗL�l�i����̏ꍇ�C�ŗL�l�̎��������ׂĕ��j
eigen_A = eig(A)

if sign(real(eigen_A)) < 0
    disp(' ...... System is asymptotically stable')
else
    disp(' ...... System is not asymptotically stable')
end


