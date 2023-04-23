「倒立振子で学ぶ制御工学」3.3節「モデル予測制御」
アーム型倒立振子の振り上げ制御シミュレーションプログラム


※内容についての動作保証およびテクニカルサポート，発生した損害に対する
責任は負いません．


---------- ファイル構成 ----------

AutoGenU_InvPend.zip は以下のファイルを含みます．

【Cプログラム関係】
aginvpendC.c : 振り上げ制御シミュレーションの C ソースファイル
rhfuncu.c : C ソースファイル（汎用関数）
rhmainu.c : C ソースファイル（メイン関数）
plotsim.m : シミュレーション結果のグラフを表示する Matlab M ファイル
animInvPend.m : シミュレーション結果のアニメーションを作成する Matlab 
M ファイル

【自動生成関係】
AutoGenU.nb : C ソースファイルを自動生成する Mathematica ノートブック
AutoGenU.mc : C ソースファイルのテンプレートファイル
inputInvPendC.m : AutGenU.nb が読み込む問題設定ファイル
Format2.m : AutoGenU.nb が使用するパッケージ（Mathematica Ver. 4～8用）
Format3.m : AutoGenU.nb が使用するパッケージ（Mathematica Ver. 9用）
Optimize2.m : AutoGenU.nb が使用するパッケージ

【説明】
ReadmeInvPend.txt : このファイル


---------- 使い方（C プログラム） ----------

（１）rhfuncu.c, rhmainu.c, aginvpendC.c を同じディレクトリに置いて，
aginvpendC.c 「だけ」をコンパイルすれば，rhfuncu.c, rhmainu.c も
インクルードされて，実行ファイルが作られます．標準的なCコンパイラなら
使えるはずです．
（２）シミュレーション結果は複数の Matlab M ファイル（拡張子m）として
保存されます．Matlab で plotsim.m を実行するとグラフが描かれます．
（３）plotsim.m を実行した後で animInvPend.m を実行すると，AVI形式の
アニメーションが保存されます．

計算条件や重み等は aginvpendC.c の最初の方で定義されており，変更が可能
です．

plotsim.m と animInvPend.m は Matlab 基本モジュールだけで実行できる
はずです．


---------- 使い方（自動生成システム） ----------

AutoGenU 自体の詳細は，下記URLで公開されている AutoGenU.zip の中の 
Readme.txt（英文） を参考にしてください．
http://www.ids.sys.i.kyoto-u.ac.jp/~ohtsuka/code/index_j.htm

Cプログラムと Matlab M ファイルだけを使うのであれば自動生成は不要です．

自動生成を行う場合，AutoGenU.nb, AutoGenU.mc, inputInvPend.m, 
Format3.m（または Format2.m）, Optimize2.m を同じディレクトリに置いて，
Mathematica で AutoGenU.nb を実行すると，aginvpendC.c が生成されます．
その際，AutoGenU.nb の中でディレクトリを正しく指定してください．
Mathematica Ver. 4~8 の場合，AutoGenU.nb の Generate C Code セクション
冒頭で読み込んでいる Format3 を Format2 に変更してください．


---------- 参考文献 ----------

T. Ohtsuka, and A. Kodama: Automatic Code Generation System for 
Nonlinear Receding Horizon Control, 計測自動制御学会論文集, Vol. 38, 
No. 7, pp. 617-623, 2002. 
http://joi.jlc.jst.go.jp/JST.Journalarchive/sicetr1965/38.617
（扱っているアルゴリズムは異なりますが，自動コード生成について述べています．）

T. Ohtsuka: A Continuation/GMRES Method for Fast Computation of 
Nonlinear Receding Horizon Control, Automatica, Vol. 40, No. 4, 
pp. 563-574, 2004. 
http://dx.doi.org/10.1016/j.automatica.2003.11.005
（AutoGenUが使っているアルゴリズムC/GMRESに関する詳細です．）

大塚敏之: 非線形Receding Horizon制御の計算方法について, 計測と制御, 
Vol. 41, No. 5, pp. 366-371, 2002. 
http://joi.jlc.jst.go.jp/JST.Journalarchive/sicejl1962/41.366
（C/GMRESと自動生成に関する解説です．）

大塚敏之: 非線形最適制御入門, コロナ社, 2011. 
（最適制御全般とモデル予測制御についてC/GMRESも含めてまとめた書籍です．）

大塚敏之 編著, 浜松正典, 永塚満, 川邊武俊, 向井正和, M. A. S. Kamal, 
西羅光, 山北昌毅, 李俊黙, 橋本智昭 共著, 実時間最適化による制御の実応用, 
コロナ社, 2015. 
（モデル予測制御の応用事例のほか自動コード生成の使い方も解説しています．）


------------------------------
京都大学大学院情報学研究科
システム科学専攻
大塚敏之
