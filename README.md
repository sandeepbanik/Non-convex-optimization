# Non-convex optimization
This repository contains matlab interface to use proximal algorithms and different variants for composite funtions containing convex and non-convex functions.

## Description
Non convex and non smooth probelms have been observed widely in the field of signal processing and machine learning. Solving non convex non smooth problems is a big challenge involving saddle point localization, non differentialibilty, escape from saddle point and others. Proximal algorithms and its variants provides a good framework for non convex problems.Here a non convex for proximal algorithms have been built. 

Given a composite function

![](http://latex.codecogs.com/gif.latex?min_%7Bx%5Cin%20%5Cmathbb%7BR%7D%5E%7Bn%7D%7D%20%5C%20F%28x%29%20%3D%20f%28x%29%20&plus;%20g%28x%29)

![](http://latex.codecogs.com/gif.latex?where)

![](http://latex.codecogs.com/gif.latex?f%28x%29%20-%20convex%20%5C%20function)
![](http://latex.codecogs.com/gif.latex?g%28x%29%20-%20nonconvex%20%5C%20function)

The non convex class tries to solve the optimization probelm given the proximal operator and the gradient of the convex function.

The algorithms present are:
  - Proximal gradient method
  - Accelerated proximal gradient method
  - Monotonic accelerated proximal gradient method
  - Monotonic non convex proximal gradient method
  - Nonmonotonic non convex proximal gradient method

The references for the algorithms stated above are provided in the reference below

## Getting Started

Clone or download the repository. Various inputs are needed to the non convex class which are explained as follows.
f - convex function

g - non-convex function

grad_f - gradient of convex function

prox - proximal operator

init_x - initialization

A constructor is also present for the class and the cronological order is as mentioned above.

### Prerequisites

Matlab 2010 or higher


## Running the tests

The test_non_APG.m contains a random system. With the objective of a lasso with l1 regularization.

## Authors

* **Sandeep Banik** -  [Projects](https://github.com/sandeepbanik)

## Reference 

**[Proximal algorithm]** by Neal Parikh and Stephen Boyd

**[Fast Gradient-Based Algorithms for Constrained Total Variation Image Denoising and Deblurring Problems]** by Amir Beck and Marc Teboulle

**[Accelerated Proximal Gradient Methods for Nonconvex Programming]** by Huan Li and Zhouchen Lin

[Proximal algorithm]:<https://web.stanford.edu/~boyd/papers/pdf/prox_algs.pdf>
[Fast Gradient-Based Algorithms for Constrained Total Variation Image Denoising and Deblurring Problems]:<http://www.math.tau.ac.il/~teboulle/papers/tlv.pdf>
[Accelerated Proximal Gradient Methods for Nonconvex Programming]:<https://papers.nips.cc/paper/5728-accelerated-proximal-gradient-methods-for-nonconvex-programming.pdf>
