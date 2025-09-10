---
week: 2
session: 3
featured_image: assets/images/generalised-linear-models.png 
title: "From Generalised Linear Models to Neural Networks"
abstract:  >
layout: lecture
author:
- family: Lawrence
  given: Neil D.
  gscholar: r3SJcvoAAAAJ
  institute: University of Cambridge
  twitter: lawrennd
  url: http://inverseprobability.com
time: "09:30"
date: 2025-09-10
youtube: 1IM_t8miX6s
oldyoutube: 
- code: 1IM_t8miX6s
  year: 2024
- code: DgaZQcNp9fU
  year: 2022
- code: VQvYg3jin-k
  year: 2021
transition: None
reveal: true
ipynb: true
---


\include{_mlfc/includes/mlfc-notebook-setup.md}


\subsection{Review}

\notes{We introduced machine learning as a way to extract knowledge from data to make predictions through a prediction function and an objective function. We looked at a simple example of predicting whether someone would buy a jumper based on their age and latitude, *using logistic regression* to model the log-odds of purchase. This highlighted how machine learning can codify predictions through mathematical functions. This is an example of a broader approach known as *generalised linear models*.

When taking a probabilistic approach to supervised learning we're interested in predicting a class label, $\dataScalar_i$, given an input, $\inputVector_i$. That's represented probabilisticially as $p(\dataScalar_i|\inputVector_i)$. We can derive this conditional distribution through either (1) modelling the joint distribution, $p(\dataVector, \inputMatrix)$ and then dividing by the marginal distribution of the inputs, $p(\inputMatrix)$  , or (2) focusing specifically on modeling the conditional density, $p(\dataVector|\inputMatrix)$, that directly answers our prediction question. In the *generalised linear model* we choose the second approach. 

As we move to generalised linear models like logistic regression, we'll see how directly modeling the conditional density $p(\dataVector|\inputMatrix)$ can provide more flexibility in our modeling assumptions, while still allowing us to make the specific predictions we need.}

\include{_ml/includes/logistic-regression-intro.md}
\include{_ml/includes/sigmoid-function.md}
\include{_ml/includes/logistic-regression-prediction-function.md}
\include{_ml/includes/logistic-regression-maximum-likelihood.md}
\include{_datasets/includes/classification-toy-data.md}

\notes{Now from the toy data we create design matrices with a leading column of ones (an Eins column)}

\setupcode{import numpy as np}
\code{phi_plus = np.hstack([np.ones((x_plus.shape[0], 1)), x_plus])
phi_minus = np.hstack([np.ones((x_minus.shape[0], 1)), x_minus])}

\include{_ml/includes/logistic-regression-perceptron.md}
\include{_ml/includes/nigeria-nmis-data-logistic.md}


\installcode{statsmodels}

\include{_ml/includes/linear-regression-statsmodels.md}
\include{_ml/includes/logistic-regression-statsmodels.md}
\include{_ml/includes/other-glms-statsmodels.md}



\subsection{Other GLMs}

\slides{
* Logistic regression is part of a family known as *generalised linear models*
* They all take the form 
  $$g^{-1}(\mappingFunction_i(x)) = \mappingVector^\top \basisVector(\inputVector_i)$$
* Other examples include *Poisson regression*.}

\notes{We've introduced the formalism for generalised linear models. Have a think about how you might model count data using the [Poisson distribution](http://en.wikipedia.org/wiki/Poisson_distribution) and a log link function for the rate, $\lambda(\inputVector)$. If you want a data set you can try the `pods.datasets.google_trends()` for some count data.}

\include{_ml/includes/poisson-regression.md}
\include{_ml/includes/glm-practical-tips.md}

\section{Neural Networks}

\include{_ml/includes/basis-to-neural-networks.md}




\reading

\thanks

\references


