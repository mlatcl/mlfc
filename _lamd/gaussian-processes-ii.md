---
week: 3
session: 3
date: 2025-09-17
featured_image: slides/diagrams/gp/gp-optimise014.svg
title: "Gaussian Processes II"
layout: lecture
author:
- family: Lawrence
  given: Neil D.
time: "09:30"
abstract: In this session we build on previous session to understand how to fit Gaussian processes and to look at how to build covariance functions.
transition: None
venue: Dedan Kimathi University, Nyeri, Kenya
reveal: true
ipynb: true
---

\notes{\include{_mlfc/includes/mlfc-notebook-setup.md}
\installcode{GPy}}

\subsection{Review}

\slides{* Yesterday: Intro to Gaussian Processes
* Today: 
    * Gaussian Processes: optimising and covariance functions}


\include{_gp/includes/gp-from-basis-functions.md}

\include{_gp/includes/non-degenerate-gps.md}
\include{_gp/includes/gp-specify-covariance.md}
\include{_gp/includes/gp-intro-very-short.md}
\include{_gp/includes/gp-predictive.md}
\include{_gp/includes/gp-covariance-function-importance.md}

\section{Parameter Optimisation}

\include{_gp/includes/gp-numerics-and-optimization.md}
\include{_gp/includes/gp-optimize.md}

\include{_kern/includes/eq-covariance.md}

\include{_datasets/includes/olympic-marathon-data.md}
\include{_gp/includes/gp-fit.md}

\include{_gp/includes/della-gatta-gene-gp.md}
\include{_health/includes/malaria-gp.md}

\include{_kern/includes/add-covariance.md}
\include{_gp/includes/bda-forecasting.md}

\include{_kern/includes/basis-covariance.md}
\include{_kern/includes/brownian-covariance.md}
\include{_kern/includes/mlp-covariance.md}
\include{_kern/includes/relu-covariance.md}
\include{_kern/includes/sinc-covariance.md}
\include{_kern/includes/poly-covariance.md}
\include{_kern/includes/periodic-covariance.md}
\include{_kern/includes/lmc-covariance.md}
\include{_kern/includes/icm-covariance.md}

\include{_gp/includes/gp-summer-school.md}
\include{_software/includes/gpy-software.md}

\reading

\thanks

\references
