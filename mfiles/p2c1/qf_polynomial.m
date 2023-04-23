% qf_polynomial.m
function S = qf_polynomial(z,dim)

% 2011/01/25   H. Ichihara

if nargin == 1
 dim = 1;
end

R = sdpvar(length(z)*dim);
S = kron(eye(dim),z)'*R*kron(eye(dim),z);

% EOF