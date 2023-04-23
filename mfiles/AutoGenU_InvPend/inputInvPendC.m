(*-------- Define dimensions of x, u, C(x,u), and p(t). --------*)
dimx=4;
dimu=2;
dimc=1;
dimp=0;

(*-------- Do not touch the following difinition of vectors. --------*)
xv=Array[x,dimx];
lmdv=Array[lmd,dimx];
uv=Array[u,dimu];
muv=Array[u,dimc,dimu+1];
pv=Array[p,dimp];

(*-------- Define f(x,u,p), C(x,u,p), p(t), L(x,u,p) and phi(x,p). --------*)
fxu = {x[3], x[4], -As x[3] + Bs u[1], A52 Sin[x[2]] + C22 (x[3]-x[4]) + A32a x[3] Cos[x[1]-x[2]] + A32 x[3]^2 Sin[x[1]-x[2]] - A32b Cos[x[1]-x[2]] u[1]};
Cxu = {uv.uv/2 - u1max^2/2}; 
pt={};

qv = Array[q,dimx];
rv = Array[r,dimu];
sfv = Array[sf,dimx];
Q = DiagonalMatrix[qv];
Sf = DiagonalMatrix[sfv];

L = xv.Q.xv/2 + r[1]*u[1]^2/2 - r[2]*u[2]; 
phi = xv.Sf.xv/2;

(*-------- Define user's variables and arrays. --------*)
(*--- Numbers must be in Mathematica format. ---*)
MyVarNames={"As", "Bs", "A52", "C22", "A32a", "A32", "A32b", "u1max"};
MyVarValues={As, Bs, Alpha5/Alpha2, C2/Alpha2, As Alpha3/Alpha2, Alpha3/Alpha2, Bs Alpha3/Alpha2, 2.5} /. {As->6.25, Bs->15.6, Alpha2->0.004565, Alpha3->0.0041314, Alpha5-> 0.178542, C2->0.000186}; 
MyArrNames={"q", "r", "sf"};
MyArrDims={dimx, dimu, dimx};
MyArrValues={{1, 1, 0, 0}, {1, 0.1}, {3, 1, 0, 0}};

(*-------- Define simulation conditions. --------*)
(*--- Real Numbers ---*)
tsim0=0;
tsim=10;
tf=0.5;
ht=0.001;
alpha=0.5;
zeta=1000;
x0={N[Pi], N[Pi], 0, 0};
u0={0.00, 2.00, 0.01};
hdir=0.002;
rtol=10^(-6);
(*--- Integers ---*)
kmax = 5;
dv=25;
dstep=5;
(*--- Strings ---*)
outfn="aginvpendC";
fndat="aginvpendC04";

(*------------------------------------------------------------------ 
Define SimplifyLevel. 
If SimplifyLevel=0, then Simplify[] is not used. 
If SimplifyLevel>0, then Simplify[] is used. 
The larger SimplifyLevel is, the more expressions are simplified. 
------------------------------------------------------------------*)
SimplifyLevel=3;

(*------------------------------------------------------------------ 
Define Precondition.
If Precondition=0, no preconditioning for a linear equation in the algorithm.
If Precondition=1, preconditioning by the Hessian of the Hamiltonian. 
------------------------------------------------------------------*)
Precondition = 1;
