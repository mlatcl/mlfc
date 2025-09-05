---
week: 3
session: 3
date: 2025-09-17
featured_image: slides/diagrams/dimred/dem_manifold_print002.png
title: "Dimensionality Reduction: Latent Variable Modelling"
abstract: "In this lecture we turn to *unsupervised learning*. Specifically, we introduce the idea of a latent variable model. Latent variable models are a probabilistic perspective on unsupervised learning which lead to dimensionality reduction algorithms. "
youtube: 0mtK2_rc0IY
---

\include{_mlfc/includes/mlfc-notebook-setup.md}

\subsection{Review}

\notes{So far in our classes we have focussed mainly on regression
problems, which are examples of supervised learning. We have considered the
relationship between the likelihood and the objective function and we have shown
how we can find paramters by maximizing the likelihood (equivalent to minimizing
the objective function) in this session we look at latent variables.}


\include{_ml/includes/clustering.md}
\include{_dimred/includes/high-dimensional-data.md}
\include{_dimred/includes/high-dimensional-effects.md}
\include{_dimred/includes/latent-variable-motivation.md}
\include{_dimred/includes/practical-dimensionality-reduction.md}
\include{_dimred/includes/dimensionality-reduction-failure-modes.md}
\include{_dimred/includes/high-dimensional-data-real.md}
\include{_dimred/includes/latent-variables.md}
\include{_dimred/includes/principal-component-analysis.md}

\include{_dimred/includes/probabilistic-pca.md}

\include{_dimred/includes/mocap-ppca.md}
\include{_dimred/includes/robot-wireless-ppca.md}
\include{_dimred/includes/ppca-interpretations.md}
\include{_dimred/includes/pca-in-practice.md}
\include{_dimred/includes/ppca-marginal-likelihood.md}
\include{_dimred/includes/ppca-reconstruction.md}
\include{_dimred/includes/mds-derivation.md}
\include{_dimred/includes/mds-pca-equivalence.md}

\include{_dimred/includes/iterative-dimensionality-reduction.md}
\include{_dimred/includes/local-vs-global-preservation.md}

\include{_dimred/includes/t-sne-intro.md}
\include{_dimred/includes/umap-intro.md}

\include{_dimred/includes/dimensionality-reduction-comparison.md}

\subsection{Summary and Key Points}

\notes{We've covered several key ideas about dimensionality reduction:

1. High-dimensional spaces have counter-intuitive properties:
   - The curse of dimensionality
   - Concentration of distances
   
2. Real data doesn't behave like random high-dimensional data because:
   - It lies near lower-dimensional manifolds
   - It has structure imposed by physics, biology, or other constraints
   
3. This structure makes dimensionality reduction possible:
   - PCA finds linear manifolds
   - More sophisticated methods can find nonlinear manifolds
   
4. The probabilistic perspective helps us:
   - Understand when methods will work
   - Quantify uncertainty in our reduced representations
   - Connect dimensionality reduction to other machine learning approaches}

\reading

\thanks

\references
