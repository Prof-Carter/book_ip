% ó· 7.2
% ïsâ¬äœë™Ç»ë‰é‘å^ì|óßêUéq
% ## Symbolic Math Toolbox Ç™ïKóv

clear
format compact
% -----------------------------------
% syms Jp mp lp mup g real
syms a1 a2 a3 b1 real
syms ac bc real
% -----------------------------------
% J  = Jp + mp*lp^2;
% a1 =  mp*g*lp/J;  a2 =  ac*mp*lp/J;
% a3 =     -mup/J;  b1 = -bc*mp*lp/J;
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
disp(' ')
disp('----- y(t) = x1(t) -----')

C = [ 1  0  0  0 ];

Mo = [ C
       C*A
       C*A^2
       C*A^3 ]

det_Mo  = det(Mo)
rank_Mo = rank(Mo)
% -----------------------------------
disp(' ')
disp('----- y(t) = x2(t) -----')

C = [ 0  1  0  0 ];

Mo = [ C
       C*A
       C*A^2
       C*A^3 ]

det_Mo  = det(Mo)
rank_Mo = rank(Mo)

