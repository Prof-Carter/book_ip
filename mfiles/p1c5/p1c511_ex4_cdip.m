% �� 5.4�F��Ԍ^�����d�|���U�q�̉��䐫�s��
% ## Symbolic Math Toolbox ���K�v

clear
format compact

syms g real
syms ac bc real
syms alpha1 alpha2 beta1 beta2

% --------------------------------------------------------
E = [ 1 0 0 0 0      0
      0 1 0 0 0      0
      0 0 1 0 0      0 
      0 0 0 1 0      0
      0 0 0 1 alpha1 0
      0 0 0 1 0      alpha2 ];

F = [ 0 0 0  1   0      0
      0 0 0  0   1      0
      0 0 0  0   0      1
      0 0 0 -ac  0      0 
      0 g 0  0  -beta1  0
      0 0 g  0   0     -beta2 ];
     
G = [ 0
      0
      0
      bc
      0
      0 ];

A = inv(E)*F;
B = inv(E)*G;

% --------------------------------------------------------
Mc = [ B A*B A^2*B A^3*B A^4*B A^5*B ];

disp(' ----- ���䐫�s�� Mc ----- ')
det_Mc = simplify(det(Mc))

disp(' ----- �����U�q�̏ꍇ�̉��䐫�s�� Mc ----- ')
det_Mc_same = subs(det_Mc,{alpha2,beta2},{alpha1,beta1})


% =======================================================
% =======================================================
ac  = 6.25e+000;    % ��ԋ쓮�n�̃p�����[�^
bc  = 4.36e+000;    % ��ԋ쓮�n�̃p�����[�^

mp1  = 1.07e-001;    % �U�q1�̎���
lp1  = 2.30e-001;    % �U�q1�̎�����d�S�܂ł̒���
Lp1  = 3.80e-001;    % �U�q1�̑S��
Jp1  = 1.59e-003;    % �U�q1�̏d�S�܂��̊������[�����g
mup1 = 2.35e-004;    % �U�q1�̔S�����C�W��

mp2  = 1.2*mp1;    % �U�q2�̎���
lp2  = 1.2*lp1;    % �U�q2�̎�����d�S�܂ł̒���
Lp2  = 1.2*Lp1;    % �U�q2�̑S��
Jp2  = 1.2^3*Jp1;  % �U�q2�̏d�S�܂��̊������[�����g
mup2 = mup1;       % �U�q2�̔S�����C�W��

g    = 9.81e+000;    % �d�͉����x

% --------------------------------------------------------
alpha1 = (Jp1 + mp1*lp1^2)/(mp1*lp1);
beta1  = mup1/(mp1*lp1);
alpha2 = (Jp2 + mp2*lp2^2)/(mp2*lp2);
beta2  = mup2/(mp2*lp2);

% --------------------------------------------------------
E = [ 1 0 0 0 0      0
      0 1 0 0 0      0
      0 0 1 0 0      0 
      0 0 0 1 0      0
      0 0 0 1 alpha1 0
      0 0 0 1 0      alpha2 ];

F = [ 0 0 0  1   0      0
      0 0 0  0   1      0
      0 0 0  0   0      1
      0 0 0 -ac  0      0 
      0 g 0  0  -beta1  0
      0 0 g  0   0     -beta2 ];
     
G = [ 0
      0
      0
      bc
      0
      0 ];

A = inv(E)*F;
B = inv(E)*G;

% --------------------------------------------------------
Mcn = ctrb(A,B);

disp(' ----- �U�q 2 ���U�q 1 �� 1.2 �{�̂Ƃ��̉��䐫�s�� Mc ----- ')
det_Mcn = det(Mcn)







