#include "rhfuncu.c"

/*#define HDIR_EQ_HT */ 
/*#define RESET_DU */ 
/*#define ADAMS */
/*#define TRACE_ON */


/*-------------- Dimensions -------------- */
#define DIMX   4
#define DIMUC  3
#define DIMP   0

/*-------------- Global Variagles -------------- */
double tsim0 = 0;
double tsim = 10;
double tf = 0.5;
double ht = 0.001;
double alpha = 0.5;
double zeta = 1000; 
double x0[DIMX] = {3.141592653589793, 3.141592653589793, 0, 0};
double u0[DIMUC] = {0., 2., 0.01};
double hdir = 0.002;
double rtol = 1.e-6;
int kmax = 5;
int dv = 25;
int dstep =   5;
#define FNMHD  "aginvpendC04"

/*-------------- Global Variables Defined by User -------------- */
double  As = 6.25;
double  Bs = 15.6;
double  A52 = 39.1111;
double  C22 = 0.0407448;
double  A32a = 5.65635;
double  A32 = 0.905016;
double  A32b = 14.1183;
double  u1max = 2.5;

double  q[4] = {1, 1, 0, 0};
double  r[2] = {1, 0.1};
double  sf[4] = {3, 1, 0, 0};


/*------------------------------------------------------------*/



/*-------------- dPhi/dx -------------- */
void phix(double t, double x[], double phx1[])
{

    phx1[0] = sf[0]*x[0];
    phx1[1] = sf[1]*x[1];
    phx1[2] = sf[2]*x[2];
    phx1[3] = sf[3]*x[3]; 
}

/*-------------- State Equation -------------- */
void xpfunc(double t, double x[], double u[], double xprime[])
{
    double o[3];

    o[0] = -1.*x[1];
    o[1] = o[0] + x[0];
    o[2] = cos(o[1]);
    xprime[0] = x[2];
    xprime[1] = x[3];
    xprime[2] = Bs*u[0] - 1.*As*x[2];
    xprime[3] = A32*pow(x[2],2.)*sin(o[1]) + A52*sin(x[1]) -\
 
  1.*A32b*o[2]*u[0] + A32a*o[2]*x[2] + C22*(x[2] - 1.*x[3]);
}

/*-------------- Costate Equation -------------- */
void lpfunc(double t, double lmd[], double linp[], double lprime[])
{
    double x[DIMX], u[DIMUC];
    double o[7];

    mmov(1,DIMX, linp, x);
    mmov(1,DIMUC, linp+DIMX, u);
    o[0] = -1.*x[1];
    o[1] = o[0] + x[0];
    o[2] = cos(o[1]);
    o[3] = pow(x[2],2.);
    o[4] = sin(o[1]);
    o[5] = A32b*u[0];
    o[6] = A32a*x[2];
    lprime[0] = -1.*A32*lmd[3]*o[2]*o[3] - 1.*lmd[3]*o[4]*(o[5] - 1.*o[6]) -\
 
  1.*q[0]*x[0];
    lprime[1] = -1.*lmd[3]*(A52*cos(x[1]) - 1.*A32*o[2]*o[3] + o[4]*(-1.*o[5]\
 
  + o[6])) - 1.*q[1]*x[1];
    lprime[2] = -1.*lmd[0] + As*lmd[2] - 1.*q[2]*x[2] - 1.*lmd[3]*(C22 +\
 
  A32a*o[2] + 2.*A32*o[4]*x[2]);
    lprime[3] = -1.*lmd[1] + C22*lmd[3] - 1.*q[3]*x[3];
}

/*-------------- Error in Optimality Condition, Hu -------------- */
void hufunc(double t, double x[], double lmd[], double u[], double hui[])
{
    double o[13];

    o[0] = pow(u[1],2.);
    o[1] = -1.*x[1];
    o[2] = o[1] + x[0];
    o[3] = cos(o[2]);
    o[4] = pow(u1max,2.);
    o[5] = o[0]*r[0];
    o[6] = pow(u[0],2.);
    o[7] = o[0] + o[6];
    o[8] = o[7]*u[2];
    o[9] = o[5] + o[8];
    o[10] = 1/o[9];
    o[11] = o[6]*u[2];
    o[12] = r[0] + u[2];
    hui[0] = 0.5*o[10]*(2.*Bs*lmd[2]*o[0] - 2.*A32b*lmd[3]*o[0]*o[3] +\
 
  2.*o[0]*r[0]*u[0] + 2.*r[1]*u[0]*u[1] + pow(u[0],3.)*u[2] + o[0]*u[0]*u[2]\
 
  - 1.*o[4]*u[0]*u[2]);
    hui[1] = 0.5*o[10]*(-2.*o[6]*r[1] + 2.*A32b*lmd[3]*o[3]*u[0]*u[1] +\
 
  u[1]*(o[5] + o[11] - 1.*o[4]*o[12] - 1.*o[6]*r[0] - 2.*Bs*lmd[2]*u[0] +\
 
  o[0]*u[2]));
    hui[2] = ((-0.5*(o[0] - 1.*o[4] + o[6])*o[12] + u[0]*(Bs*lmd[2] -\
 
  1.*A32b*lmd[3]*o[3] + o[12]*u[0]))*u[2] + o[12]*u[1]*(-1.*r[1] +\
 
  u[1]*u[2]))/(o[11] + o[0]*o[12]);
}

/*-------------- Save Simulation Conditions -------------- */
void final(FILE *fp, float t_cpu, float t_s2e)
{
    int i;
    fprintf(fp, "%% Simulation Result by aginvpendC.c \n");
    fprintf(fp, "Precondition = 1 \n");
    fprintf(fp, "tsim = %g\n", tsim);
    fprintf(fp, "ht = %g, dstep = %d\n", ht, dstep);
    fprintf(fp, "tf = %g, dv = %d, alpha = %g, zeta = %g \n", (float)tf, dv, (float)alpha, (float)zeta);
    fprintf(fp, "hdir = %g, rtol = %g, kmax = %d \n", (float)hdir, (float)rtol, kmax);
    fprintf(fp, "u0 = [%g", (float)u0[0] );
    for(i=1; i<DIMUC; i++)
        fprintf(fp, ",%g", (float)u0[i] );
    fprintf(fp, "]\n" );
    fprintf(fp, "t_cpu = %g, t_s2e = %g  %% [sec] \n", t_cpu, t_s2e);

    fprintf(fp, "As = %g \n", (float)As );
    fprintf(fp, "Bs = %g \n", (float)Bs );
    fprintf(fp, "A52 = %g \n", (float)A52 );
    fprintf(fp, "C22 = %g \n", (float)C22 );
    fprintf(fp, "A32a = %g \n", (float)A32a );
    fprintf(fp, "A32 = %g \n", (float)A32 );
    fprintf(fp, "A32b = %g \n", (float)A32b );
    fprintf(fp, "u1max = %g \n", (float)u1max );


    fprintf(fp, "q = [%g", (float)q[0] );
    for(i=1; i<4; i++)
        fprintf(fp, ",%g", (float)q[i] );
    fprintf(fp, "]\n" );

    fprintf(fp, "r = [%g", (float)r[0] );
    for(i=1; i<2; i++)
        fprintf(fp, ",%g", (float)r[i] );
    fprintf(fp, "]\n" );

    fprintf(fp, "sf = [%g", (float)sf[0] );
    for(i=1; i<4; i++)
        fprintf(fp, ",%g", (float)sf[i] );
    fprintf(fp, "]\n" );

}

#include "rhmainu.c"