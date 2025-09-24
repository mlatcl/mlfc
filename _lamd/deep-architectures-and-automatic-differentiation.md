---
layout: lecture
title: Deep Architectures
featured_image: slides/diagrams/deepnn/relu-network-2d.svg
week: 4
session: 3
author:
- given: Neil
  family: Lawrence
abstract: >
  This lecture will explore what happens when we compose layers of basis functions together to form deep neural networks.. 
talkscam:
venue: Dedan Kimathi University of Technology, Nyeri, Kenya
youtube: -9O5obQZUn0
oldyoutube: 
- code: m3KZLPed7aM
  year: 2021
transition: None
time: "9:30"
date: 2025-09-24
---


\notes{\include{_mlfc/includes/mlfc-notebook-setup.md}}

\section{Review}

\notes{By this point in the course we have covered the foundations sufficiently for you to look at three Cambridge courses.}

* [Advanced Data Science](https://mlatcl.github.io/advds/)
* [ML and the Physical World](https://mlatcl.github.io/mlphysical/)
* [Deep Neural Networks](https://mlatcl.github.io/deepnn/)

\notes{Today we will give some insight into the third of those courses, deep neural networks.}

\section{Basis Functions to Neural Networks}

\include{_ml/includes/basis-to-neural-networks.md}
\include{_deepnn/includes/deep-neural-network.md}
\include{_deepnn/includes/from-shallow-to-deep.md}
\include{_ml/includes/chain-rule-and-back-propagation.md}
\include{_ml/includes/automatic-differentiation.md}

\subsection{Overparameterised Systems}

\slides{* Neural networks are highly overparameterised.
* If we *could* examine their Hessian at "optimum"
  * Very low (or negative) eigenvalues.
  * Error function is not sensitive to changes in parameters.
  * Implies parmeters are *badly determined*}
  
\notes{If we could examine the Hessian of a neural network at its
minimum, we can speculate about what we would find. In particular, we
would find that it would have very many low (or negative) eigenvalues
in many directions. This is indicative of the parameters being *badly
determined* because of the neural network model being heavily
*overparameterised*. So how does it generalise?}

\newslide{Whence Generalisation?}

\slides{* Not enough regularisation in our objective functions to explain.
* Neural network models are *not* using traditional generalisation approaches.
* The ability of these models to generalise *must* be coming somehow from the algorithm*
* How to explain it and control it is perhaps the most interesting theoretical question for neural networks.}

\notes{Simply put, there is not enough regularisation encoded in the
objective function of the neural network models we are using to
explain the generalisation performance. There must be something in the
algorithms we are using that causes these highly overparameterised
models to generalise well.}

\include{_deepnn/includes/double-descent.md}
\include{_deepnn/includes/neural-tangent-kernel.md}
\include{_deepnn/includes/regularisation-in-optimisation.md}

\subsection{Practical Optimisation Notes}

\slides{* Initialisation: variance-preserving (He, Xavier); scale affects signal propagation
* Optimisers: SGD(+momentum), Adam/AdamW; decoupled weight decay often preferable
* Learning rate schedules: cosine, step, warmup; LR is the most sensitive hyperparameter
* Batch size: affects gradient noise and implicit regularisation; tune with LR
* Normalisation: BatchNorm/LayerNorm stabilise optimisation
* Regularisation: data augmentation, dropout, weight decay; early stopping}

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
H(\mathbb{w}) = \frac{\text{d}^2}{\text{d}\weightVector\text{d}\weightVector^\top} L(\weightVector)
:= \frac{\text{d}}{\text{d}\weightVector} \mathbf{g}(\weightVector)
$$

\notes{Efficient strategy: compute $\mathbf{g}(\weightVector)$ with reverse-mode, then apply forward-mode to obtain Hessian columns or HVPs (reverse-over-forward). Framework helpers: JAX `jax.jacfwd(jax.jacrev(f))`, PyTorch `autograd.functional.hessian` (memory heavy for large models).}

\subsection{Example: Hessian-vector product}

$$
\mathbf{v}^\top H(\weightVector) = \frac{\text{d}}{\text{d}\weightVector} \left( \mathbf{v}^\top \mathbf{g}(\weightVector) \right)
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


\reading
\thanks
\references


