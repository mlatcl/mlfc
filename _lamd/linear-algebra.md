---
week: 2
session: 1
date: 2025-09-08
featured_image: slides/diagrams/turing-run.jpg
title: Linear Algebra and Linear Regression
abstract: |
  In this session we combine the objective function perspective and the probabilistic perspective on *linear regression*. We motivate the importance of *linear algebra* by showing how much faster we can complete a linear regression using linear algebra.
transition: None
time: 9:30
ipynb: true
---


\subsection{Review}

* Last time: Reviewed Objective Functions and gradient descent. 

\define{ipynbpath}{_notebooks}

\notes{\include{_mlfc/includes/mlfc-notebook-setup.md}}

\include{_ml/includes/regression-examples.md}
\notes{In the [lecture on probability](https://mlatcl.github.io/mlfc/lectures/01-01-probability.html) we explored how Laplace proposed that we should introduce a latent slack variable for dealing with model mismatch.}
\include{_ml/includes/laplace-latent-variable-solution.md}
\notes{As we saw, Gauss used his understanding to predict where the dwarf planet Ceres could be recovered. We've already used the least squares algorithm to fit linear regressions. Today we're going to motivate least squares through the probabilistic framework we introduced in Lecture 1.}

\notes{First though, we'll introduce a data set. Since our presentation mirrors that of Rogers and Girolami, we'll follow them in looking at Olympic sprinting data.}

\include{_datasets/includes/olympic-100m-data.md}

\subsection{Sum of Squares Error}

\section{Sum of Squares Error}

\notes{Last week we considered a cost function for minimization of the error. We minimised an objective that assumed used the quadratic error function,
$$
\errorFunction(\mappingVector) = \sum_{i=1}^n \left(\dataScalar_i - \inputVector_i^\top \mappingVector\right)^2.
$$
}

\notes{This week we will reinterpret the error as a *probabilistic model*. As Laplace suggests, we will consider the difference between our data and our model to have come from unconsidered factors which exhibit as a probability density. This leads to a more principled definition of least squares error due to [Carl Friederich Gauss](https://en.wikipedia.org/wiki/Carl_Friedrich_Gauss), but inspired by [Pierre-Simon Laplace](https://en.wikipedia.org/wiki/Pierre-Simon_Laplace).}

\include{_ml/includes/univariate-gaussian.md}
\include{_ml/includes/univariate-gaussian-properties.md}
\include{_ml/includes/linear-regression-log-likelihood.md}
\include{_ml/includes/sum-of-squares-log-likelihood.md}
\include{_datasets/includes/olympic-marathon-data.md}
\include{_ml/includes/alan-turing-marathon.md}
\include{_ml/includes/olympic-marathon-linear-regression.md}
\include{_ml/includes/linear-regression-coordinate-ascent.md}

\subsection{Important Concepts Not Covered}

* Other optimization methods:
    * Second order methods, conjugate gradient, quasi-Newton and Newton.
* Effective heuristics such as momentum.
* Local vs global solutions.

\addreading{@Rogers:book11}{For fitting linear models: Section 1.1-1.2}
\addreading{@Bishop:book06}{Section 1.2.5 up to equation 1.65}

\newslide{Multi-dimensional Inputs}
\slides{
* Multivariate functions involve more than one input.
* Height might be a function of weight and gender.
* There could be other contributory factors.
* Place these factors in a feature vector $\inputVector_i$.
* Linear function is now defined as
  $$\mappingFunction(\inputVector_i) = \sum_{j=1}^p w_j \inputScalar_{i, j} + c$$
}

\newslide{Vector Notation}
\slides{

* Write in vector notation,
  $$\mappingFunction(\inputVector_i) = \mappingVector^\top \inputVector_i + c$$
* Can absorb $c$ into $\mappingVector$ by assuming extra input $\inputScalar_0$ which is always 1.
  $$\mappingFunction(\inputVector_i) = \mappingVector^\top \inputVector_i$$
}

\include{_ml/includes/linear-regression-multivariate-log-likelihood.md}
\include{_ml/includes/linear-regression-direct-solution.md}

\include{_ml/includes/linear-regression-objective-optimisation.md}
\include{_ml/includes/movie-body-count-linear-regression.md}

\notes{
\figure{\includeyoutube{ui-uNlFHoms}{600}{450}}{MLAI Lecture 15 from 2014 on Multivariate Regression.}{mlai-15-multivariate-regression}

\figure{\includeyoutube{78YNphT90-k}{600}{450}}{MLAI Lecture 3 from 2012 on Maximum Likelihood}{mlai-3-maximum-likelihood}
}

\include{_ml/includes/qr-decomposition-regression.md}

\writeassignment{Ca you see any difference between the values for the coefficients you got using QR decomposition than for the system where you computed $\designMatrix^\top \designMatrix$? Why is this?}{20}

\addreading{@Rogers:book11}{Section 1.3 for Matrix & Vector Review}


\include{_ml/includes/non-linear-regression-intro.md}

\section{Basis Functions}

\include{_ml/includes/basis-functions-intro.md}
\include{_ml/includes/quadratic-basis.md}
\include{_ml/includes/basis-functions-different-bases.md}
\include{_ml/includes/radial-basis.md}
\include{_ml/includes/relu-basis.md}
\include{_ml/includes/hyperbolic-tangent-basis.md}
\include{_ml/includes/fourier-basis.md}

\section{Fitting Basis Function Models}

\include{_ml/includes/basis-functions-fitting-to-data.md}
\include{_ml/includes/basis-functions-log-likelihood.md}
\include{_ml/includes/basis-functions-optimisation.md}
\include{_ml/includes/olympic-marathon-all-polynomial.md}
\include{_ml/includes/non-linear-but-linear-in-parameters.md}
\include{_ml/includes/basis-functions-student-fitting-exercise.md}

\thanks

\exercises

\reading

\references
