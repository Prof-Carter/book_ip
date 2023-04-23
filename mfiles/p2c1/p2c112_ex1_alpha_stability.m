% —á 1.1FLMI ‰Â‰ð–â‘è

clear;  format compact
% ------------------------
A = [  0      1
      -2.25  -2.25 ];
n     = length(A);
alpha = 1;
ep    = 1e-6;
% ------------------------
xi1 = sdpvar(1);  xi2 = sdpvar(1);
P = [ xi1  xi2
      xi2  1 ];
% P = sdpvar(n,n,'sy');
% ------------------------
LMI = [ P >= ep*eye(n) ];
LMI = LMI + [ A'*P + P*A + 2*alpha*P <= - ep*eye(n) ];
% ------------------------
solvesdp(LMI)
% ------------------------
P = double(P)

