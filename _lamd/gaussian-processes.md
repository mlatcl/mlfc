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
reveal: true
ipynb: true
---

\notes{\include{_mlfc/includes/mlfc-notebook-setup.md}}

\subsection{Review}

\slides{* Yesterday: Bayesian regression
* Today: 
    * Gaussian Processes: non parametric Bayesian modelling}


\notes{
\subsection{Generalised Linear Models}

\notes{Logistic regression is part of a wider class of models known as *generalised linear models*. In these models we determine that some characteristic of the model is speicified by a function that is liniear in the parameters. So we might suggest that}\slides{* Logistic regression is a *generalised linear model*
* Prediction function that is linear in parameters}
$$
\log \frac{p(\inputVector)}{1-p(\inputVector)} = \mappingFunction(\inputVector; \mappingVector)
$$
\notes{where $\mappingFunction(\inputVector; \mappingVector)$ is a linear-in-the-parameters function (here the
parameters are $\mappingVector$, which is generally non-linear in the inputs.}\slides{* Where $\mappingFunction(\cdot)$ is linear in parameters.}
\newslide{Basis Functions}

\notes{So far we have considered basis function models of the form}
\slides{* Linear models have the form}
$$
\mappingFunction(\inputVector) =
\mappingVector^\top \basisVector(\inputVector).
$$
\notes{When we form a Gaussian process we do something that is slightly more akin to the naive Bayes approach, but actually is closely related to the generalised linear model approach.}
\slides{* Gaussian processes are related to generalised linear models.}

\include{_gp/includes/gp-intro-lectures.md}
\include{_gp/includes/gptwopointpred.md}
\include{_gp/includes/gp-from-basis-functions.md}

\include{_gp/includes/non-degenerate-gps.md}
\include{_gp/includes/gp-function-space.md}
\include{_gp/includes/gp-covariance-function-importance.md}
\include{_gp/includes/gp-numerics-and-optimization.md}

\include{_gp/includes/gp-optimize.md}

\include{_kern/includes/eq-covariance.md}

\include{_gp/includes/olympic-marathon-gp.md}

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


