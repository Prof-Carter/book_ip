% ó· 7.3
% ïsâ¬åüèoÇ»ë‰é‘å^ì|óßêUéq

clear
format compact
% -----------------------------------
% syms Jp mp lp mup g real
syms a1 a2 a3 b1 real
syms ac bc real
syms l1 l2 l3 l4 real
syms s
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

L = [ l1
      l2
      l3
      l4 ];
% -----------------------------------
disp(' ')
disp('----- y(t) = x1(t) -----')

C = [ 1  0  0  0 ];
eq1 = det(s*eye(4) - (A + L*C));
%eq1 = collect(eq1,s);
eq1 = prod(factor(eq1))

% -----------------------------------
disp(' ')
disp('----- y(t) = x2(t) -----')

C = [ 0  1  0  0 ];
eq2 = det(s*eye(4) - (A + L*C));
%eq2 = collect(eq2,s);
eq2 = prod(factor(eq2))

