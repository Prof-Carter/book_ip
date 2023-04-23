% ë‰é‘å^ì|óßêUéq
% Lagrange ñ@Ç…ÇÊÇÈâ^ìÆï˚íˆéÆÇÃì±èo

clear; format compact

syms m_c mu_c real
syms J_p m_p mu_p g l_p real
syms z th dz dth ddz ddth fc real

q   = [ z  th ]';
dq  = [ dz  dth ]';
ddq = [ ddz  ddth ]';
f   = [ fc  0 ]';
% ------------------------------------------
X2 = q(1) + l_p*sin(q(2));
Y2 =        l_p*cos(q(2)); 

dX2 = diff(X2,q(1))*dq(1) ...
    + diff(X2,q(2))*dq(2);
dY2 = diff(Y2,q(1))*dq(1) ...
    + diff(Y2,q(2))*dq(2);
% ------------------------------------------
W = (1/2)*m_c*dq(1)^2 ...
  + (1/2)*m_p*dX2^2 ...
  + (1/2)*m_p*dY2^2 ...
  + (1/2)*J_p*dq(2)^2;
U = m_p*g*Y2;
D = (1/2)*mu_c*dq(1)^2 ...
  + (1/2)*mu_p*dq(2)^2;

L = W - U;
% ------------------------------------------
N = length(q);
for i = 1:N
  dLq(i)  = diff(L,dq(i));

  temp = 0;
  for j = 1:N
    temp = temp + diff(dLq(i),dq(j))*ddq(j) ...
                + diff(dLq(i),q(j))*dq(j);
  end
  ddLq(i) = temp;

  eq(i) = ddLq(i) - diff(L,q(i)) ...
        + diff(D,dq(i)) - f(i);
end

eq = simplify(eq')
