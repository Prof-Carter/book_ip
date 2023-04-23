function [ dy, K, T ] = cartident( t, y, ref, ts, tend )

datasize = int32(tend/ts);        % 32 ビット符号付き整数への変換

dy = zeros(size(y,1),1);
for i = 2:1:size(y,1)-1
    dy(i,1) = (y(i+1)-y(i-1))/2/ts;
end
dy(1,1) = (-3*y(1)+4*y(2)-y(3))/2/ts;
dy(size(y,1),1) = (y(size(y,1)-2) - 4*y(size(y,1)-1) + 3*y(size(y,1)))/2/ts;
% dy(size(y,1)-1,1) = dy(size(y,1)-2,1);
% dy(size(y,1),1) = dy(size(y,1)-1,1);

init_data = int32(1.4/ts);         % 32 ビット符号付き整数への変換
K = mean(dy(init_data:datasize));  % 1.4 sec - 1.5 sec の平均値

for i=1:datasize
  if dy(i) < 0.632*K & dy(i+1) > 0.632*K
     k = i;
     break;
  end
end
% 
T = t(k);

K = K/ref;

end

