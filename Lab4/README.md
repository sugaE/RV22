
<link type="text/css" rel="stylesheet" href="https://github.com/sugaE/sugaE.github.io/blob/master/uob/md.css">

# Robot Vision - Lab 4 - Hough Transformation
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


![](images/cfp3.png)
![](images/cfp6.png)

## Question 2:
How would you evaluate the accuracy of your registration?

## Question 3:
Other than Affine, what are the other options and which one do you think works best?

(Some options has minimal points requirement.)

![](images/cfp6affine.png =49%x)
![](images/cfp6lwm.png =49%x)
*affine / lwm(6)*

![](images/cfp6nonreflectivesimilarity.png =49%x)
![](images/cfp6polynomial.png =49%x)
*nonreflectivesimilarity / polynomial(2)*

![](images/cfp6projective.png =49%x)
![](images/cfp6pwl.png =49%x)
*projective / pwl*

<script type="text/javascript" src="https://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML"></script>
<script type="text/x-mathjax-config">
    MathJax.Hub.Config({ tex2jax: {inlineMath: [['$', '$']]}, messageStyle: "none" });
</script>
