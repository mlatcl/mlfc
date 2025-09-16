---
layout: lecture
title: Deep Architectures
week: 4
session: 3
featured_image: slides/diagrams/deepnn/deep-neural-network.svg
author:
- given: Neil
  family: Lawrence
abstract: >
  This lecture will explore what happens when we compose layers of basis functions together to form deep neural networks.
talkscam:
venue: Dedan Kimathi University of Technology, Nyeri, Kenya
youtube: -9O5obQZUn0
oldyoutube: 
- code: m3KZLPed7aM
  year: 2021
time: "9:30"
date: 2025-09-24
---


\include{_mlfc/includes/mlfc-notebook-setup.md}

\section{Neural Networks}



\subsection{Shallow and Deep Learning}

\notes{So far, we have been talking about *linear models* or *shallow learning* as we might think of it. Let's pause for a moment and consider a *fully connected* deep neural network model to relate the two ideas.}

\include{_ml/includes/basis-to-neural-networks.md}

\addreading{Bishop-deeplearning24}{Chapter 8}
\define{\hiddenVector}{\mappingFunctionVector}
\define{\hiddenScalar}{\mappingFunction}

\include{_deepnn/includes/deep-neural-network.md}

\newslide{Neural Network Prediction Function}

\notes{Under our basis function perspective, we can see that our deep neural network is mathematical composition of basis function models. Each layer contains a separate basis function set, so
$$
 \mappingFunction(\inputVector; \mappingMatrix)  =  \mappingVector_4 ^\top\basisFunction\left(\mappingMatrix_3 \basisFunction\left(\mappingMatrix_2\basisFunction\left(\mappingMatrix_1 \inputVector\right)\right)\right).
$$}

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
\include{_deepnn/includes/from-shallow-to-deep.md}
\include{_deepnn/includes/generalisation-in-deep-networks.md}
\include{_deepnn/includes/double-descent.md}
\include{_deepnn/includes/neural-tangent-kernel.md}
\include{_deepnn/includes/regularisation-in-optimisation.md}



\include{_ml/includes/chain-rule-and-back-propagation.md}


\include{_ml/includes/automatic-differentiation.md}

\subsection{Practical Optimisation Notes}

\slides{* Initialisation: variance-preserving (He, Xavier); scale affects signal propagation
* Optimisers: SGD(+momentum), Adam/AdamW; decoupled weight decay often preferable
* Learning rate schedules: cosine, step, warmup; LR is the most sensitive hyperparameter
* Batch size: affects gradient noise and implicit regularisation; tune with LR
* Normalisation: BatchNorm/LayerNorm stabilise optimisation
* Regularisation: data augmentation, dropout, weight decay; early stopping}

\subsection{Timing Guidance (for 2 hours)}

\notes{15 min recap; 30 min depth/width and representation; 25 min generalisation phenomena; 30 min autodiff/backprop with small live demos; 15 min practical optimisation; 5 min Q\&A.}

\subsection{Further Reading}

\slides{* Baydin et al. (2018) Automatic differentiation in ML (JMLR)
* Jacot, Gabriel, Hongler (2018) Neural Tangent Kernel
* Arora et al. (2019) On exact dynamics of deep linear networks
* Keskar et al. (2017) Large-batch training and sharp minima
* Novak et al. (2018) Sensitivity and generalisation in neural networks
* [JAX Autodiff Cookbook](https://docs.jax.dev/en/latest/notebooks/autodiff_cookbook.html) (JVPs/VJPs, `jacfwd`/`jacrev`)
* PyTorch Autograd Docs (computational graph, `grad_fn`, backward)}

\subsection{Example: calculating a Hessian}

$$
H(\mathbb{w}) = \frac{\partial^2}{\partial\mathbf{w}\partial\mathbf{w}^\top} L(\mathbf{w})
:= \frac{\partial}{\partial\mathbf{w}} \mathbf{g}(\mathbf{w})
$$

\notes{Efficient strategy: compute $\mathbf{g}(\mathbf{w})$ with reverse-mode, then apply forward-mode to obtain Hessian columns or HVPs (reverse-over-forward). Framework helpers: JAX `jax.jacfwd(jax.jacrev(f))`, PyTorch `autograd.functional.hessian` (memory heavy for large models).}

\subsection{Example: Hessian-vector product}

$$
\mathbf{v}^\top H(\mathbf{w}) = \frac{\partial}{\partial\mathbf{w}} \left( \mathbf{v}^\top \mathbf{g}(\mathbf{w}) \right)
$$

\notes{Live-coding HVP in PyTorch (mixed-mode via backward-over-backward or autograd.functional). Using a quadratic ensures a non-zero Hessian (2I):}

\code{import torch as th
def f(w):
    return (w**2).sum()  # toy scalar loss; Hessian = 2I
w = th.randn(5, requires_grad=True)
g, = th.autograd.grad(f(w), w, create_graph=True)  # gradient with graph
v = th.randn_like(w)
hv, = th.autograd.grad(g, w, grad_outputs=v)  # Hessian-vector product = 2*v
hv}


\subsection{Learning Objectives}

\slides{* Understand basis functions and shallow models as a foundation
* Explain deep architectures: composition, depth vs width
* Describe generalisation in deep nets vs classical view
* Apply automatic differentiation: chain rule, forward vs reverse, backprop
* Interpret computational graphs and PyTorch autodiff
* Recognize practical optimisation choices that affect generalisation}

\subsection{Agenda}

\slides{1. Recap: Basis functions and shallow models (15 min)
2. Deep architectures and representational power (30 min)
3. Generalisation: classical vs deep, double descent, NTK (25 min)
4. Automatic differentiation: from chain rule to backprop (30 min)
5. Practical optimisation and implementation notes (15 min)
6. Q&A (5 min)}






David Hogg's lecture <https://speakerdeck.com/dwhgg/linear-regression-with-huge-numbers-of-parameters>



The Deep Bootstrap <https://twitter.com/PreetumNakkiran/status/1318007088321335297?s=20>

Aki Vehtari on Leave One Out Uncertainty: <https://arxiv.org/abs/2008.10296> (check for his references).

<!-- Material from Ferenc's DeepNN lecture on generalisation -->
\slides{
\subsection{Approximation}

\subsubsection{Basic Multilayer Perceptron}

\begin{align}
f_l(x) &= \phi(W_l f_{l-1}(x) + b_l)\\
f_0(x) &= x
\end{align}

\subsubsection{Basic Multilayer Perceptron}

$$
\small
f_L(x) = \phi\left(b_L + W_L \phi\left(b_{L-1} + W_{L-1} \phi\left( \cdots \phi\left(b_1 + W_1 x\right) \cdots \right)\right)\right)
$$

\subsubsection{Rectified Linear Unit}

$$
\phi(x) = \left\{\matrix{0&\text{when }x\leq 0\\x&\text{when }x>0}\right.
$$

![](https://i.imgur.com/SxKdrzb.png)


\subsubsection{What can these networks represent?}


$$
\operatorname{ReLU}(\mathbf{w}_1x - \mathbf{b}_1)
$$

![](https://i.imgur.com/rN5wRVJ.png)

\subsubsection{What can these networks represent?}

$$
f(x) = \mathbf{w}^T_2 \operatorname{ReLU}(\mathbf{w}_1x - \mathbf{b}_1)
$$

![](https://i.imgur.com/kX3nuYg.png)

\subsubsection{Single hidden layer}

number of kinks $\approx O($ width of network $)$

\subsubsection{Example: "sawtooth" network}


\begin{align}
f_l(x) &= 2\vert f_{l-1}(x)\vert - 2 \\
f_0(x) &= x
\end{align}

\subsubsection{Sawtooth network}

\begin{align}
f_l(x) &= 2 \operatorname{ReLU}(f_{l-1}(x)) + 2 \operatorname{ReLU}(-f_{l-1}(x)) - 2\\
f_0(x) &= x
\end{align}

\subsubsection{$0$-layer network}

![](https://i.imgur.com/pucqIVN.png)

\subsubsection{$1$-layer network}

![](https://i.imgur.com/YOTtTY7.png)

\subsubsection{$2$-layer network}

![](https://i.imgur.com/reii7O5.png)

\subsubsection{$3$-layer network}

![](https://i.imgur.com/J6KiUHI.png)

\subsubsection{$4$-layer network}

![](https://i.imgur.com/fHTZhU0.png)

\subsubsection{$5$-layer network}

![](https://i.imgur.com/ni4QV2b.png)

\subsubsection{Deep ReLU networks}

number of kinks $\approx O(2^\text{depth of network})$

\subsubsection{In higher dimensions}

![](https://i.imgur.com/0NVHFEN.png)

\subsubsection{In higher dimensions}

![](https://i.imgur.com/DJtv5Yj.jpg)

\subsubsection{Approximation: summary}

* depth increases model complexity more than width
* model clas defined by deep networks is VERY LARGE
* both an advantage, but and cause for concern
* "complex models don't generalize"

\subsection{Generalization}

\subsection{Generalization}

![](https://i.imgur.com/Tu5SHpr.png)

\subsection{Generalization}

![](https://i.imgur.com/8bkhxAv.png)

\subsection{Generalization}

![](https://i.imgur.com/YHedAr6.png)

\subsection{Generalization: deep nets}

![](https://i.imgur.com/bfyRBsx.png)

\subsection{Generalization: deep nets}
![](https://i.imgur.com/fzLYvHe.png)

\subsection{Generalization: summary}

* **classical view:** generalization is property of model class and loss function
* **new view:** it is also a property of the optimization algorithm

\subsection{Generalization}

* optimization is core to deep learning
* new tools and insights:
    * infinite width neural networks
    * neural tangent kernel [(Jacot et al, 2018)](https://arxiv.org/abs/1806.07572)
    * deep linear models ([e.g. Arora et al, 2019](https://arxiv.org/abs/1905.13655))
    * importance of initialization
    * effect of gradient noise





\reading
\thanks
\references


