---
week: 1
session: 3
date: 2025-09-03
featured_image: slides/diagrams/ml/regression_contour_fit028.svg
title: "Objective Functions and Gradient Descent"
author:
  - given: Neil
    family: Lawrence
abstract: |
  In this session we introduce the notion of objective functions and show how they can be used in a simple optimisation systems based on gradients.
venue: Dedan Kimathi University, Nyeri, Kenya
transition: None
time: 9:30
ipynb: true
---

\define{ipynbpath}{_notebooks}

\notes{\include{_mlfc/includes/mlfc-notebook-setup.md}}

\notes{\subsection{Learning Objectives}

* Explain the role of objective functions in ML and their relationship to prediction functions.
* Implement gradient descent for a simple regression objective; interpret learning curves.
* Derive and use stochastic gradient descent; contrast with batch GD.
* Understand step size (learning rate) effects and basic convergence intuition.
* Connect classification via the perceptron to optimisation of a margin-based objective.
* Visualise loss landscapes and trajectories (contours) for intuition.
* Recognise practical considerations: feature scaling, initialisation, stopping criteria.
* Situate GD within the broader optimisation toolbox (momentum, second-order methods) at a high level.

\subsection{Lecture Timing}

* Framing and objectives — 5 min
* Perceptron and classification setup — 10 min
* Toy data and hyperplane intuition — 8 min
* Regression objective and contour visualisation — 12 min
* Gradient descent derivation and demo — 15 min
* Stochastic gradient descent (SGD) — 15 min
* Practicalities: scaling, step size, stopping — 15 min
* Wrap-up & Q&A — 10 min}

\newslide{Objective Function}
\slides{
- On Monday we introduced ML and motivated the importance of probability.
- Today we explore the idea of the 'objective function'.}

\notes{On Monday we introduce machine learning and motivate the importance of probability. We suggested that many machine learning algorithms can be motivated by considering a prediction funcation and an objective function. Together these form our mode that can be combined with data through computation and used to make predictions.}

\notes{We also motivated the importance of probability. We introduced Laplace's Gremlin and suggested that probability is a way of representing our ignorance. But objective functions are not always motivated by probability. Today we consider the optimisation of objective functions.}

\notes{But before we start specifically on objective functions we consider the oldest machine learning algorithm, the perceptron.} 

\include{_ml/includes/classification-intro.md}
\include{_ml/includes/classification-examples.md}
\include{_ml/includes/classification-hyperplane.md}
\include{_datasets/includes/classification-toy-data.md}
\include{_ml/includes/perceptron.md}

\section{Regression}

\include{_ml/includes/regression.md}
\include{_ml/includes/regression-contour-plot.md}
\include{_ml/includes/regression-gradient-descent.md}
\include{_ml/includes/regression-stochastic-gradient-descent.md}
\include{_ml/includes/regression-reflection.md}

\addreading{@Rogers:book11}{Section 1.1.3} for loss functions.
\addreading{@Bishop-deeplearning24}{Section 8.1} for gradient descent.
\thanks

\reading

\exercises

\references


