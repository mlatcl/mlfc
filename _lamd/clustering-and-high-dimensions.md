---
week: 4
session: 1
date: 2025-09-22
featured_image: slides/diagrams/dimred/dem_manifold_print002.png
title: "Clustering and High Dimensions"
layout: lecture
author:
- family: Lawrence
  given: Neil D.
time: "09:30"
abstract: "In this lecture we turn to *unsupervised learning*. We look at clustering models and consider how data behaves in high dimensions."
transition: None
venue: Dedan Kimathi University, Nyeri, Kenya
youtube: 0mtK2_rc0IY
---

\notes{\include{_mlfc/includes/mlfc-notebook-setup.md}}

\subsection{Review}

\notes{So far in our classes we have focussed on regression 
problems and generalised linear models. These are examples of supervised learning. We have considered the
relationship between the likelihood and the objective function and we have shown
how we can find paramters by maximizing the likelihood (equivalent to minimizing
the objective function) in this session we look at latent variables.}


\include{_ml/includes/clustering-intro.md}
\include{_ml/includes/k-means-clustering.md}
\include{_ml/includes/hierarchical-clustering.md}

\include{_dimred/includes/thinking-in-high-dimensions.md}
\include{_datasets/includes/dimred-example-datasets.md}
\include{_dimred/includes/high-dimensional-data.md}

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
