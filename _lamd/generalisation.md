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
\define{\designVector}{\boldsymbol{\phi}}
\define{designMatrix}{\basisMatrix}

\include{_mlfc/includes/mlfc-notebook-setup.md}


\include{_ml/includes/non-linear-regression-intro.md}
\include{_ml/includes/basis-functions.md}
\include{_ml/includes/basis-function-models.md}

\addreading{@Rogers:book11}{Section 1.4}
\addreading{@Bishop:book06}{Chapter 1, pg 1-6}
\addreading{@Bishop:book06}{Chapter 3, Section 3.1 up to pg 143}

\include{_ml/includes/nigeria-nmis-linear-regression.md}

\notes{\subsection{Aside}}

\notes{Just as a quick reminder, the approach used in software for fitting a linear model *should* be a QR decomposition. See \refnotes{the lecture on linear algebra and linear regression}{linear-algebra}.


\subsection{Basis Function Models}

\notes{We are reviewing models that are *linear* in the parameters. Very often we are interested in *non-linear* predictions. We can make models that are linear in the parameters and given non-linear predictions by introducing non-linear *basis functions*. A common example is the polynomial basis.}

\include{_ml/includes/polynomial-basis.md}

\notes{The predictions from this model,
$$
\mappingFunction(\inputScalar) = \mappingScalar_0 + \mappingScalar_1 \inputScalar} + \mappingScalar_2 \inputScalar^2 + \mappingScalar_3 \inputScalar^3 + \mappingScalar_4 \inputScalar^4
$$
are *linear* in the parameters, $\mappingVector$, but *non-linear* in the input $\inputScalar^3$. Here we are showing a polynomial basis for a 1-dimensional input, $\inputScalar$, but basis functions can also be constructed for multidimensional inputs, $\inputVector$.}

\notes{In the neural network models, the "RELU function" is normally used as a basis function, but for illustration we will continue with the polynomial basis for these linear models.}

\undef{olympicMarathonData}
\include{_ml/includes/olympic-marathon-polynomial.md}

\include{_ml/includes/the-bootstrap.md}

\include{_ml/includes/olympic-marathon-bootstrap-polynomial.md}

\define{biasVariancePlots}

\include{_ml/includes/bias-variance-dilemma.md}

\notes{Also related on generalisation error is the so called 'no free lunch theorem', which refers to our inability to decide what a better learning algorithm is without making assumptions about the data [@Wolpert:lack96] (see also @Wolpert-supervised02).}

\define{designVector}{\basisVector}
\define{designVariable}{Phi}
\define{designMatrix}{\basisMatrix}

\include{_ml/includes/linear-regression-regularisation.md}
\include{_ml/includes/training-with-noise-tikhonov-regularisation.md}

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


