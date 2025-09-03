---
week: 1
session: 3
date: 2025-09-03
featured_image: slides/diagrams/ml/artificial-classification-example.png
title: "Objective Functions"
abstract: |
  In this session we introduce the notion of objective functions and show how they can be used in a simple recommender system based on *matrix factorisation*.
youtube: Gq6bjcm8AqQ
---

\define{ipynbpath}{_notebooks}

\notes{\include{_mlfc/includes/mlfc-notebook-setup.md}}

\newslide{Objective Function}
\slides{
- On Monday we introduced ML and motivated the importance of probability.
- Today we explore the idea of the 'objective function'.}

\notes{On Monday we introduce machine learning and motivate the importance of probability. We suggested that many machine learning algorithms can be motivated by considering a prediction funcation and an objective function. Together these form our mode that can be combined with data through computation and used to make predictions.}

\notes{We also motivated the importance of probability. We introduced Laplace's Gremlin and suggested that probability is a way of representing our ignorance. But objective functions are not always motivated by probability. Today we consider the optimisation of objective functions.}

\notes{But before we start specifically on objective functions we consider the oldest machine learning algorithm, the perceptron.} 

\include{_ml/includes/classification.md}

\include{_ml/includes/perceptron.md}
\include{_ml/includes/linear-regression-iterative.md}


\addreading{@Rogers:book11}{Section 1.1.3} for loss functions.

\reading


\thanks

\reading

\exercises

\references


