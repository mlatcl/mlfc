---
week: 2
session: 1
date: 2025-09-08
featured_image: slides/diagrams/ml/regression_contour_fit028.svg
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
\include{_ml/includes/laplace-latent-variable-solution.md}

\include{_datasets/includes/olympic-100m-data.md}
\include{_ml/includes/sum-of-squares-error.md}
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

\addreading{@Rogers:book11}{Section 1.3 for Matrix & Vector Review}


\thanks

\exercises

\reading

\references
