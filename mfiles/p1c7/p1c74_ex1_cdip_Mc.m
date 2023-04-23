% ó· 7.1
% ë‰é‘å^ì|óßêUéqÇÃâ¬êßå‰ê´
% ## Symbolic Math Toolbox Ç™ïKóv

clear
format compact
% -----------------------------------
syms Jp mp lp mup g real
syms ac bc real
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
% -----------------------------------
Mc = [B A*B A^2*B A^3*B]
det_Mc  = det(Mc)
rank_Mc = rank(Mc)