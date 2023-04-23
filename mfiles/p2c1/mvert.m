function vmat = mvert(m)
% mvert.m
%
% generate the matrix of vertices
%

range = [zeros(m,1) ones(m,1)];
vmat = []; ls = 1;
for bnds = range',
 vmat = [vmat vmat;bnds(1)*ones(1,ls) bnds(2)*ones(1,ls)];
 ls = size(vmat,2);
end
clear range bnds ls;

% EOF