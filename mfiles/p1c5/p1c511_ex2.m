% �� 5.2�F�s����ȃV�X�e���̉��䐫�s��
% ## Symbolic Math Toolbox ���K�v

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