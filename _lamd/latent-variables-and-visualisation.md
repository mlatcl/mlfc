---
week: 4
session: 2
title: "Latent Variables and Visualisation"
featured_image: slides/diagrams/dimred/six_manifold_002.svg
layout: lecture
venue: Dedan Kimathi University of Technology, Nyeri, Kenya
time: "9:30"
date: 2025-09-23
abstract: |
  This lecture introduces different approaches to discovering latent structure in data. We begin by examining clustering as a discrete approach to finding latent structure, then explore why high dimensional data often has simpler underlying continuous representations. This motivates our introduction to Principal Component Analysis (PCA) as a fundamental approach to continuous latent variable modeling.
author:
- family: Lawrence
  given: Neil D.
  gscholar: r3SJcvoAAAAJ
  institute: University of Cambridge
  twitter: lawrennd
  url: http://inverseprobability.com
youtube: WelCunS9OaM
oldyoutube: 
- code: WelCunS9OaM
  year: 2024
- code: 0mtK2_rc0IY
  year: 2015
transition: None
ipynb: True
reveal: True
---

\notes{\include{_mlfc/includes/mlfc-notebook-setup.md}}

\include{_dimred/includes/high-dimensional-data.md}
\include{_dimred/includes/latent-variables.md}

\include{_dimred/includes/probabilistic-pca.md}
\include{_dimred/includes/probabilistic-pca-model.md}

\include{_dimred/includes/osu-run1-ppca.md}
\include{_dimred/includes/robot-wireless-ppca.md}

\section{Interpretations of Principal Component Analysis}

\include{_dimred/includes/principal-component-analysis.md}
\include{_dimred/includes/pca-and-matrix-factorisation.md}
\include{_dimred/includes/pca-and-model-algorithm-separation.md}
\include{_dimred/includes/pca-effectiveness.md}

\section{Derivation of PPCA}

\include{_dimred/includes/ppca-marginal-likelihood.md}
\include{_dimred/includes/ppca-reconstruction.md}


\include{_dimred/includes/dimensionality-reduction-failure-modes.md}
\include{_dimred/includes/visualisation-motivation.md}



\thanks

\references
