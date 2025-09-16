---
week: 3
session: 2
date: 2025-09-16
featured_image: slides/diagrams/gp/two_point_sample001.svg
title: "Gaussian Processes"
layout: lecture
author:
- family: Lawrence
  given: Neil D.
time: "09:30"
abstract: Gaussian processes are non parameteric Bayesian models that extend the idea of Bayesian linear models to infinite basis functions.
youtube: B2XhFoCehy8
transition: None
venue: Dedan Kimathi University, Nyeri, Kenya
reveal: true
ipynb: true
---

\notes{\include{_mlfc/includes/mlfc-notebook-setup.md}}

\subsection{Review}

\slides{* Yesterday: Bayesian regression
* Today: 
    * Gaussian Processes: non parametric Bayesian modelling}


\newslide{Multivariate Gaussian Properties}

\include{_ml/includes/multivariate-gaussian-properties-summary.md}

\slides{
\newslide{Linear Gaussian Models}
}\notes{Gaussian processes are initially of interest because}

1. linear Gaussian models are easier to deal with 
2. Even the parameters *within* the process can be handled, by considering a particular limit.

\include{_ml/includes/linear-model-overview.md}

\include{_gp/includes/gp-intro-lectures.md}
\include{_gp/includes/gptwopointpred.md}
\include{_kern/includes/computing-rbf-covariance.md}
\include{_gp/includes/gp-from-basis-functions.md}

\include{_gp/includes/non-degenerate-gps.md}
\include{_gp/includes/gp-function-space.md}
\include{_gp/includes/gp-covariance-function-importance.md}


\reading

\thanks

\references


