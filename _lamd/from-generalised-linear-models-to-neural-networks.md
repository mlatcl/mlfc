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

\section{Logistic Regression}

\include{_ml/includes/logistic-regression.md}
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

\subsection{Shallow and Deep Learning}

\notes{So far, we have been talking about *linear models* or *shallow learning* as we might think of it. Let's pause for a moment and consider a *fully connected* deep neural network model to relate the two ideas.}

\include{_deepnn/includes/deep-neural-network.md}

\newslide{Neural Network Prediction Function}

\notes{Under our basis function perspective, we can see that our deep neural network is mathematical composition of basis function models. Each layer contains a separate basis function set, so}
$$
 \mappingFunction(\inputVector; \mappingMatrix)  =  \mappingVector_4 ^\top\basisFunction\left(\mappingMatrix_3 \basisFunction\left(\mappingMatrix_2\basisFunction\left(\mappingMatrix_1 \inputVector\right)\right)\right).
$$

\notes{In this course there are two reasons for looking at the shallow model. Firstly, it is easier to introduce the concepts of regularisation in the linear model regime. Secondly, the matrix forms we see, e.g., expressions like $\basisMatrix^\top \basisMatrix$, appear in both models.}

\notes{For deep learning, we can no longer optimise the parameters of the model through solving a linear system[^quadratic]. Instead, we need to turn to non-linear optimisation algorithms. For deep learning, that's typically stochastic gradient descent.

[^quadratic]: Apart from the last layer of parmeters in models with quadratic loss functions.}

\notes{While it's possible to compute the Hessian in a neural network, @Bishop-exact92, we also find that it varies across the parameter space and will not normally be positive definite. In practice, the number of parameters is normally so large that storing the Hessian is impossible (it has quadratic cost in the number of weights/parameters) due to memory constraints.}

\notes{This means that while the theory of minima in optimisation is well understood, empirical experiments with large neural networks are hard and the lessons of small models do not all translate to the very large systems.}

\notes{We can stay within the framework of linear models but take a step closer to neural network models by introducing functions that are non-linear in the inputs, $\inputVector$, known as *basis functions*.}


\subsection{Overparameterised Systems}

\slides{* Neural networks are highly overparameterised.
* If we *could* examine their Hessian at "optimum"
  * Very low (or negative) eigenvalues.
  * Error function is not sensitive to changes in parameters.
  * Implies parmeters are *badly determined*}
  

\notes{If we could examine the Hessian of a neural network at its minimum, we can speculate about what we would find. In particular, we would find that it would have very many low (or negative) eigenvalues in many directions. This is indicative of the parameters being *badly determined* because of the neural network model being heavily *overparameterised*. So how does it generalise?}

\newslide{Whence Generalisation?}

\slides{* Not enough regularisation in our objective functions to explain.
* Neural network models are *not* using traditional generalisation approaches.
* The ability of these models to generalise *must* be coming somehow from the algorithm*
* How to explain it and control it is perhaps the most interesting theoretical question for neural networks.}

\notes{Simply put, there is not enough regularisation encoded in the objective function of the neural network models we are using to explain the generalisation performance. There must be something in the algorithms we are using that causes these highly overparameterised models to generalise well.}

\include{_ml/includes/generalisation-and-overfitting.md}

\include{_deepnn/includes/double-descent.md}
\include{_deepnn/includes/neural-tangent-kernel.md}

\include{_deepnn/includes/regularisation-in-optimisation.md}



\reading

\thanks

\references


