---
layout: lecture
featured_image: slides/diagrams/ml/olympic_LM_polynomial_number026.svg
title: Generalisation
week: 2
session: 2
date: 2025-09-09
abstract: >
  This lecture will cover generalisation in machine learning.
youtube: WaauyjcSNhc
oldyoutube: 
- code: tk9qM00Bs_o
  year: 2021
---

\define{\errorFunction}{L}
\define{designVector}{\basisVector}
\define{designMatrix}{\basisMatrix}
\define{designVariable}{Phi}

\include{_mlfc/includes/mlfc-notebook-setup.md}

\section{Nonlinear Regression with Linear Models}

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
\notes{\include{_ml/includes/basis-functions-student-fitting-exercise.md}}

\include{_ml/includes/olympic-marathon-polynomial.md}
\include{_ml/includes/expected-loss.md}
\include{_ml/includes/empirical-risk-minimization.md}
\include{_ml/includes/validation-short-intro.md}
\include{_ml/includes/olympic-marathon-validation-fit.md}
\include{_ml/includes/olympic-marathon-hold-out-validation.md}
\include{_ml/includes/olympic-marathon-loo-validation.md}
\include{_ml/includes/olympic-marathon-k-fold-validation.md}

\include{_ml/includes/the-bootstrap.md}

\include{_ml/includes/olympic-marathon-bootstrap-polynomial.md}

\define{biasVariancePlots}

\include{_ml/includes/bias-variance-dilemma.md}
\include{_ml/includes/no-free-lunch-theorem.md}

\include{_ml/includes/linear-regression-regularisation.md}
\include{_ml/includes/training-with-noise-tikhonov-regularisation.md}


\reading

\thanks

\references


