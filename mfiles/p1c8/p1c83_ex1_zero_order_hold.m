% 例 8.1
% 0 次ホールドによる離散化

%% 連続時間コントローラ C = 1/(s^2 + s + 1)
s = tf('s');
C = 1/(s^2 + s + 1);

%% 0 次ホールドによる離散化 K
ts = 1;         % <-- サンプリング周期
K = c2d(C, ts)  % <-- 零次ホールドによる離散化
