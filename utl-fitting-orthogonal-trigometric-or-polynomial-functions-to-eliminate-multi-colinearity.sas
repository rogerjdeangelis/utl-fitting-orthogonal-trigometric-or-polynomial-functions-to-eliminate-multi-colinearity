%let pgm=utl-fitting-orthogonal-trigometric-or-polynomial-functions-to-eliminate-multi-colinearity;

Fitting orthogonal trigometric or polynomial functions to eliminate multi colinearity and improve interpretation;

github
https://tinyurl.com/3fxt64fx
https://github.com/rogerjdeangelis/utl-fitting-orthogonal-trigometric-or-polynomial-functions-to-eliminate-multi-colinearity

   Two Solutions

          1 orthogonal trigometric functions
          2 orthogonal polynomial functions

    Not sure why orthogonality is not used more often

    Using orthogonal polynomials and trog functions in regression analysis offers several benefits:

    Avoids multicollinearity: Orthogonal polynomials are uncorrelated
    with each other, meaning they are linearly independent.

    This eliminates the problem of multicollinearity, which can cause instability
    and inaccuracy in the estimation of regression coefficients when using regular polynomials.

    Improves numerical stability: Orthogonal polynomials are constructed in a way that avoids the
    computational issues that can arise when using regular polynomials, such as round-off errors and
    overflow/underflow problems, especially for higher-order polynomials.

    Provides better interpretation: The coefficients of orthogonal polynomials have a more meaningful
    interpretation than those of regular polynomials. Each coefficient represents the contribution of
    a specific polynomial term to the overall fit, independent of the other terms.

    Enhances model fitting: Orthogonal polynomials can provide a better fit to the data, especially when
    modeling complex, non-linear relationships. They can capture intricate patterns and
    trends more effectively than regular polynomials.

    Computational efficiency: Calculating the orthogonal polynomial regression coefficients
    is computationally more efficient than inverting the matrix of regular polynomial terms,
    particularly for higher-order polynomials.

    Facilitates model selection: The orthogonality property makes it easier to assess the
    significance of individual polynomial terms and select the appropriate degree of the polynomial
    for the model.

    In summary, using orthogonal polynomials in regression analysis helps mitigate multicollinearity
    issues, improves numerical stability and interpretability, enhances model fitting capabilities,
    offers computational efficiency, and simplifies model selection, making them a valuable
    tool for modeling complex, non-linear relationships.


/*                   _
(_)_ __  _ __  _   _| |_
| | `_ \| `_ \| | | | __|
| | | | | |_) | |_| | |_
|_|_| |_| .__/ \__,_|\__|
        |_|
 */

Note Trig Functions


  x1=sine(x)
  x2-cosine(x)
  are othogonal and
  uncorrelated

  This is wht Fourier Series are so usefull
    Spectral analysis
    Signal Processing

Note othogonal polynomials
   X3 is othogonal to X4  Gram-Schmidt?
   only available in IML?

libname sd1 "d:/sd1";
options validvarname=upcase;
data sd1.have;
  do x=0 to 3.1416 by 0.00001 ;
    x1 = sin(x);
    x2 = cos(x);
    y   =(sin(x) + sqrt(sin(x)))/2 + rand('normal',0,1)/10;
    output;
  end;
run;quit;

/*----                                                                   ----*/
/*---- Drop down to R for othogonal polynomials                         ----*/
/*----                                                                   ----*/

%utl_rbegin;
parmcards4;
library(mctest)
library(haven)
library(polynom)
source("c:/temp/fn_tosas9.R")
have<-read_sas("d:/sd1/have.sas7bdat")
poly_terms <- poly(have$X, 2)
want<-cbind(have,poly_terms)
colnames(want)<-c("X","X1","X2","Y","X3","X4" )
str(want)
fn_tosas9(dataf=want)
;;;;
%utl_rend;

libname tmp "c:/temp";
proc print data=tmp.want(obs=10);
run;quit;

proc standard data=tmp.want mean=0 std=1 out=havstn;
  var y x1 x2 x3 x4;
run;quit;

 HAVSTN total obs=315

           Othogonal                othogonal
        Trig Functions             polynomial
        --------------           ================
   X     X1       X2       Y       X3       X4

 0.00 -2.05079 1.40937 -2.74540 -1.72382 2.21135
 0.01 -2.01849 1.40930 -2.63593 -1.71284 2.16910
 0.02 -1.98620 1.40909 -2.18544 -1.70186 2.12711
 0.03 -1.95391 1.40874 -1.43364 -1.69088 2.08540
 0.04 -1.92163 1.40825 -1.31917 -1.67990 2.04395
 ....
 3.10 -1.91649 -1.40958 -2.04031 1.67990 2.04395
 3.11 -1.94877 -1.41010 -1.46340 1.69088 2.08540
 3.12 -1.98106 -1.41047 -2.59041 1.70186 2.12711
 3.13 -2.01335 -1.41071 -2.15901 1.71284 2.16910
 3.14 -2.04565 -1.41080 -2.12344 1.72382 2.21135

options ls=64 ps=32;
proc plot data=havstn(
  rename=y=y12345678901234567890
  where=(uniform(12794)<.00025));
 plot y12345678901234567890*x1='*'/box haxis=-2.5 to 2.5 by 1;
run;quit;

      -2.5   -1.5   -0.5    0.5    1.5    2.5
     ---+------+------+------+------+------+---
     |                                        |
     |  Y vs X1 (X2 left off weak relation)   |
   2 +                                        +  2
     |  Standardized             **           |
     |   X1,X2  sin & cosine     **           |
     |   Y                  *** ***           |
  Y  |                    ***** ***           | Y
     |               *     * ***              |
   0 +                ******  *               +  0
     |             **    *                    |
     |          *   **                        |
     |             *                          |
     |       ** *                             |
     |       **                               |
  -2 +      ** *                              + -2
     |     **                                 |
     |                                        |
     |                                        |
     |                                        |
     |                                        |
  -4 +                                        + -4
     |                                        |
     ---+------+------+------+------+------+---
      -2.5   -1.5   -0.5    0.5    1.5    2.5
                Standardized X1

/*              _   _                   _        _         __                  _   _
/ |   ___  _ __| |_| |__   ___   __ _  | |_ _ __(_) __ _  / _|_   _ _ __   ___| |_(_) ___  _ __  ___
| |  / _ \| `__| __| `_ \ / _ \ / _` | | __| `__| |/ _` || |_| | | | `_ \ / __| __| |/ _ \| `_ \/ __|
| | | (_) | |  | |_| | | | (_) | (_| | | |_| |  | | (_| ||  _| |_| | | | | (__| |_| | (_) | | | \__ \
|_|  \___/|_|   \__|_| |_|\___/ \__, |  \__|_|  |_|\__, ||_|  \__,_|_| |_|\___|\__|_|\___/|_| |_|___/
                                |___/            _               _
 _ __  _ __ ___   ___ ___  ___ ___    ___  _   _| |_ _ __  _   _| |_
| `_ \| `__/ _ \ / __/ _ \/ __/ __|  / _ \| | | | __| `_ \| | | | __|
| |_) | | | (_) | (_|  __/\__ \__ \ | (_) | |_| | |_| |_) | |_| | |_
| .__/|_|  \___/ \___\___||___/___/  \___/ \__,_|\__| .__/ \__,_|\__|
|_|                                                 |_|
*/

proc corr data=sd1.have;
 var  x1;
 with x2;
run;quit;

Pearson Correlation Coefficients, N = 314160
         Prob > |r| under H0: Rho=0
              X1

X2      -0.00000   Uncorrelated
          0.9989


proc reg data=sd1.have;
 model y=x1 x2/ss1 ss2  vif;
 output out=fit pred=y_hat residual=resid;
run;quit;

VARIANCE INFLATION
==================
             Variance
 Variable   Inflation

 Intercept          0
 X1           1.00000  No muti-colinearity
 X2           1.00000

STANDARDIZED COEFICIENTS
========================

 X1           0.87425  We can compare the coef
 X2        0.00022388  because data has been standardized
                      independent of each other

options ls=255 ps=255;
proc glm data=tmp.want;
  model y = x1 x2 /ss1 ss2 ss3 ss4;
run;quit;


MUTUALLY EXCLUSIVE PARTITIONING OF
THE FOUR TYPES OF SUMS OF SQUARES
THE ORDER OF THE INDEPENENT VARIABLES DOES NOT MATTER
===========================================================

Source       DF       Type I SS

X1            1     22742.74572
X2            1         0.00787


Source       DF      Type II SS

X1            1     22742.74578
X2            1         0.00787


Source       DF     Type III SS

X1            1     22742.74578
X2            1         0.00787


Source       DF      Type IV SS

X1            1     22742.74578
X2            1         0.00787


options ls=64 ps=32 ;
options nolabel;
proc plot data=fit(
    where=(uniform(12794)<.00025)
    rename=(
       y=y12345678901234567890
       y_hat=y_hat12345678901234567890
       resid=resid12345678901234567890
   ));
   plot y_hat12345678901234567890*x='o'
        y12345678901234567890*x='p' /overlay  box;
   plot y_hat12345678901234567890*
     y12345678901234567890='*' / box;
   plot y_hat12345678901234567890*x1='p'
        y12345678901234567890*x1='o' / overlay box;
   plot resid12345678901234567890*
    y12345678901234567890='*' / box;
run;quit;

FIT
===                     X1
      0.0              0.5              1.0
      -+----------------+----------------+--
      |                                    |
   .5 + This is what was fitted            +
      | X1 is a trig sine function and     |
      | is much stronger then X2           |
      |                                  o |
      | P=0.1433+0.87425*T1+0.00022*T2   o |
      |                                  o |
   .0 + X1 is sine(X)           ooo o   pp +
      |  standardized        o ooo oppppoo |
      |                       oopppp    o  |
      |               o    oooppp    o     |
      |                o oppppo    o       |
      |           oo o p p o               |
   .5 +       o     ppp                    +
      |           pp                       |
      |   o opp                            |
      |   ppp o                            |
      |pppoooo                             |
      |   o                                |
   .0 +oo                                  +
      -+----------------+----------------+--
      0.0              0.5              1.0
                        X1


RESIDUALS
=========
      0.0        0.5  Y      1.0        1.5
     --+----------+----------+----------+--
 0.3 +                                    + 0.3
     |  RESIDUAL vs Y (observed)          |
     |                                    |
     |                  *                 |
 0.2 +                     * *    *       + 0.2
     |                     *              |
 890 |           *  *      * *            | 890
     |                *   * *   *         |
 0.1 +              *     ** *  *         + 0.1
     |        *       **    *             |
     |        *       ****    **          |
     |            **  **     **           |
 0.0 +               **  * **             + 0.0
     |     * *           * **             |
     |    **    *     *     *             |
     |     *        *   *  **             |
 0.1 +   *                 *              + 0.1
     |   **                *              |
     | **               * *               |
     |                                    |
 0.2 +                *                   + 0.2
     --+----------+----------+----------+--
      0.0        0.5        1.0        1.5
                      Y


       0       1       2       3
    +--+-------+-------+-------+------+
    |  Observed vs Pedicted           |
    |                                 |
    |  O=(sin(x) + sqrt(sin(x)))/2    |
  5 +  P=0.1433+0.87425*T1+0.00022*T2 + 5
    |  T1 & T2 are orthog trig funcs  |
    |             p                   |
 Ys |              p                  | s
    |            p p p                |
  0 +         p  oooooo pp            + 0
    |        p po  ppppooppp          |
    |        poo     p  oop           |
    |      ppo          p o           |
    |       oo p           op         |
    |                      pop        |
  5 +    poo                 o        + 5
    |        o-observed      o        |
    |   po   p-prodicted       o      |
    |   op                     o      |
    |  op                      po     |
    |   p                             |
  0 +  p                        p     + 0
    ---+-------+-------+-------+------
       0       1       2       3
           Observation(original x)

/*___               _   _                               _                             _       _
|___ \    ___  _ __| |_| |__   ___   __ _   _ __   ___ | |_   _ _ __   ___  _ __ ___ (_) __ _| |___
  __) |  / _ \| `__| __| `_ \ / _ \ / _` | | `_ \ / _ \| | | | | `_ \ / _ \| `_ ` _ \| |/ _` | / __|
 / __/  | (_) | |  | |_| | | | (_) | (_| | | |_) | (_) | | |_| | | | | (_) | | | | | | | (_| | \__ \
|_____|  \___/|_|   \__|_| |_|\___/ \__, | | .__/ \___/|_|\__, |_| |_|\___/|_| |_| |_|_|\__,_|_|___/
                                    |___/  |_|   _        |___/  _
 _ __  _ __ ___   ___ ___  ___ ___    ___  _   _| |_ _ __  _   _| |_
| `_ \| `__/ _ \ / __/ _ \/ __/ __|  / _ \| | | | __| `_ \| | | | __|
| |_) | | | (_) | (_|  __/\__ \__ \ | (_) | |_| | |_| |_) | |_| | |_
| .__/|_|  \___/ \___\___||___/___/  \___/ \__,_|\__| .__/ \__,_|\__|
|_|                                                 |_|
*/

proc corr data=tmp.want;
 var  x3;
 with x4;
run;quit;

Pearson Correlation Coefficients, N = 314160
         Prob > |r| under H0: Rho=0

              X3

X4       0.00000  Uncorrelated
          1.0000


proc reg data=tmp.want;
 model y=x3 x4/ss1 ss2  vif;
 output out=fit pred=y_hat residual=resid;
run;quit;

VARIANCE INFLATION
==================
             Variance
 Variable   Inflation

 Intercept          0
 X3           1.00000  No muti-colinearity
 X4           1.00000

STANDARDIZED COEFICIENTS
========================

 X3         -0.09765   We can compare the coef
 X4       -151.21117   because data has been standardized
                      independent of each other

options ls=255 ps=255;
proc glm data=tmp.want;
  model y = x3 x4 /ss1 ss2 ss3 ss4;
run;quit;


MUTUALLY EXCLUSIVE PARTITIONING OF
THE FOUR TYPES OF SUMS OF SQUARES
THE ORDER OF THE INDEPENENT VARIABLES DOES NOT MATTER
===========================================================

 Source                      DF       Type I SS

 X3                           1         0.00953
 X4                           1     22864.81708


 Source                      DF      Type II SS

 X3                           1         0.00953
 X4                           1     22864.81708


 Source                      DF     Type III SS

 X3                           1         0.00953
 X4                           1     22864.81708


 Source                      DF      Type IV SS

 X3                           1         0.00953
 X4                           1     22864.81708


options ls=64 ps=32 ;
options nolabel;
proc plot data=fit(
    where=(uniform(12794)<.00025)
    rename=(
       y=y12345678901234567890
       y_hat=y_hat12345678901234567890
       resid=resid12345678901234567890
   ));
   plot y_hat12345678901234567890*x='o'
        y12345678901234567890*x='p' /overlay  box;
   plot y_hat12345678901234567890*
          y12345678901234567890='*' / box;
   plot y_hat12345678901234567890*x4='p'
        y12345678901234567890*x4='o' / overlay box;
   plot resid12345678901234567890*
      y12345678901234567890='*' / box;
run;quit;

FIT
===   -0.002      0.000  X4  0.002      0.004
       --+----------+----------+----------+--
       |                                    |
   1.5 + Predicted vs X4                    + 1.5
       | Standardized coef indicate X3 weak |
       |                                    |
 Pred  |  o                                 |
       | o                                  |
       | o                                  |
   1.0 + pp  oooo                           + 1.0
       | oopppoo ooo                        |
       |  o   ppp o                         |
       |    o    pppoo   o                  |
       |      o   o pppoo                   |
       |            o  pppo  o              |
   0.5 +                  p pp    o         + 0.5
       |                    op              |
       |                          p  oo     |
       |                          opppp     |
       |                           oooppp   |
       |                              oo  p |
   0.0 +                                o o + 0.0
       --+----------+----------+----------+--
      -0.002      0.000      0.002      0.004

                         X4


RESIDUALS
=========

      --+----------+----------+----------+--
      |                                    |
  0.4 +  RESIDUALS vs OBSERVED             +  0.4
      |                                    |
      |                                    |
      |                                    |
      |                                    |
      |                            *       |
  0.2 +                  *                 +  0.2
      |                     * *            |
      |           *  *     ***   *         |
      |        *       *   ** *            |
      |        *     * **    * **          |
      |            *   ****   **           |
  0.0 +    **       *  ** * **             +  0.0
      |     * *       **  * **             |
      |   * *    *     * *  **             |
      | ***          *      *              |
      |    *             * *               |
      |                                    |
 -0.2 +                *                   + -0.2
      |                                    |
      --+----------+----------+----------+--
       0.0        0.5        1.0        1.5
                      Y


       0       1       2       3
    +--+-------+-------+-------+------+
    |  Observed vs Pedicted           |
    |                                 |
    |  O=(sin(x) + sqrt(sin(x)))/2    |
  5 +  P=.69985-0.09765*P1-151.2112*P2+ 5
    |  P1 & P2 are orthog polynomial  |
    |             p                   |
 Ys |              p                  | s
    |            p p p                |
  0 +         p  oooooo pp            + 0
    |        p po  ppppooppp          |
    |        poo     p  oop           |
    |      ppo          p o           |
    |       oo p           op         |
    |                      pop        |
  5 +    poo                 o        + 5
    |        o-observed      o        |
    |   po   p-prodicted       o      |
    |   op                     o      |
    |  op                      po     |
    |   p                             |
  0 +  p                        p     + 0
    ---+-------+-------+-------+------
       0       1       2       3
             Observation

/*              _
  ___ _ __   __| |
 / _ \ `_ \ / _` |
|  __/ | | | (_| |
 \___|_| |_|\__,_|

*/
