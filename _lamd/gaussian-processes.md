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

\include{_gp/includes/gp-intro-lectures.md}
\include{_gp/includes/gptwopointpred.md}
\include{_gp/includes/gp-from-basis-functions.md}

\include{_gp/includes/non-degenerate-gps.md}
\include{_gp/includes/gp-function-space.md}
\include{_gp/includes/gp-covariance-function-importance.md}
\include{_gp/includes/gp-numerics-and-optimization.md}

\include{_gp/includes/gp-optimize.md}

\include{_kern/includes/eq-covariance.md}

\include{_datasets/includes/olympic-marathon-data.md}
\include{_ml/includes/alan-turing-marathon.md}
\include{_gp/includes/gp-fit.md}

\include{_gp/includes/della-gatta-gene-gp.md}
\include{_health/includes/malaria-gp.md}

\include{_kern/includes/add-covariance.md}
\include{_gp/includes/bda-forecasting.md}

\include{_kern/includes/basis-covariance.md}
\include{_kern/includes/brownian-covariance.md}
\include{_kern/includes/mlp-covariance.md}

\include{_gp/includes/gp-summer-school.md}
\include{_software/includes/gpy-software.md}

\thanks

\references


