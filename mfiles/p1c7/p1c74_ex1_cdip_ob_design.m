% �� 7.1
% ��Ԍ^�|���U�q
% �ɔz�u�@�ɂ��I�u�U�[�o�݌v

clear
format compact
close all

% ----------------------------------------------------------------
format short e
% -----------------------------------
cdip_para
% -----------------------------------
J  = Jp + mp*lp^2;
a1 =  mp*g*lp/J;  a2 =  ac*mp*lp/J;
a3 =     -mup/J;  b1 = -bc*mp*lp/J;
% -----------------------------------
A = [ 0   0   1   0
      0   0   0   1
      0   0  -ac  0
      0   a1  a2  a3 ];
B = [ 0
      0
      bc
      b1 ];
C = [ 1   0   0   0
      0   1   0   0 ];
D = [ 0
      0 ];
% -----------------------------------
Mc = ctrb(A,B);
rank_Mc = rank(Mc)
pc = [ -6.5+1.5j
       -6.5-1.5j
       -4
       -2.5 ];
K = - place(A,B,pc)
% -----------------------------------
Mo = obsv(A,C);
rank_Mo = rank(Mo)
po = 4*pc;
L = - (place(A',C',po))'
% -----------------------------------
Ac = A + B*K + L*C + L*D*K
Bc = - L
Cc = K
% -----------------------------------
format short