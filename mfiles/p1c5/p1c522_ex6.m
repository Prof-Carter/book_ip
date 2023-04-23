% �� 5.6�F����ȃV�X�e���̋ɔz�u

clear
format compact

syms lambda s1 s2
syms k1 k2 real

A = [ 1  0
      1  1 ];
B = [ 1
      1 ];
K = [ k1  k2 ];

eq1 = det(lambda*eye(2) - (A + B*K));   % |lambda*I - (A + B*K)|
eq1 = collect(eq1,lambda)   % ���������~�ׂ��̏��ŕ\��
coe1 = coeffs(eq1,lambda)   % �������̌W�������ׂ��̏��ŕ\��

eq2 = (lambda - s1)*(lambda - s2);
eq2 = collect(eq2,lambda)   % ���������~�ׂ��̏��ŕ\��
coe2 = coeffs(eq2,lambda)   % �������̌W�������ׂ��̏��ŕ\��

v = ver('MATLAB');
ver_MATLAB = str2num(v.Version(1:3))

if ver_MATLAB < 8.4 % R2014a �܂�
    [k1 k2] = solve(coe1(2)-coe2(2),coe1(1)-coe2(1),'k1,k2')
else
    [k1 k2] = solve([coe1(2)-coe2(2)==0,coe1(1)-coe2(1)==0],[k1,k2])  % �ŋ߂̃o�[�W���� (R2014b�ȍ~)
end

