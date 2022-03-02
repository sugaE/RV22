
<link type="text/css" rel="stylesheet" href="https://github.com/sugaE/sugaE.github.io/blob/master/uob/md.css">

# Robot Vision - Lab 4 - Registration
> Yanrong~Wang, 2257486, Robot Vision[06-25024], 2022. [Code is here](https://github.com/sugaE/RV22/tree/main/Lab4).

<!-- ## STEP 1:
• Download the zip file and extract the .m script file and the data files (.jpg) for Lab from CANVAS and save them in your working directory
• Use the matlab script Lab3.m, which has all the steps needed for line detection. -->
## Question 1:
> What is the effect of increasing/decreasing the number of chosen control points in registration accuracy?

The more *correct* paired points, the more accurate the transform gets. Also if points are in positions where there are distrinct(good) features (eg. corners), the more accurate the transform gets and less points needed.


| num of control points| time |
|-|-|
|3| 0.210487 s |
|6| 0.083026 s |


![](figures/cfp3.png)
![](figures/cfp6.png)

## Question 2:
How would you evaluate the accuracy of your registration?

## Question 3:
Other than Affine, what are the other options and which one do you think works best?

(Some options has minimal points requirement.)

<img src="figures/cfp6affine.png" width="49%" />
<img src="figures/cfp6lwm.png" width="49%" />
*affine / lwm(6)*

<img src="figures/cfp6nonreflectivesimilarity.png" width="49%" />
<img src="figures/cfp6polynomial.png" width="49%" />
*nonreflectivesimilarity / polynomial(2)*

<img src="figures/cfp6projective.png" width="49%" />
<img src="figures/cfp6pwl.png" width="49%" />
*projective / pwl*

TODO
use Q2 to determine which is best.

<script type="text/javascript" src="https://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML"></script>
<script type="text/x-mathjax-config">
    MathJax.Hub.Config({ tex2jax: {inlineMath: [['$', '$']]}, messageStyle: "none" });
</script>
