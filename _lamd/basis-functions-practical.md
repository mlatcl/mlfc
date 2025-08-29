---
title: "Practical 4:  Basis Functions"
practical: 4
featured_image: assets/images/practical-four.png
abstract:  >
  In this lab session we will review basis functions.
layout: practical
venue: 
author:
- family: Lawrence
  given: Neil D.
  gscholar: r3SJcvoAAAAJ
  institute: University of Cambridge
  twitter: lawrennd
  url: http://inverseprobability.com
date: 2025-09-08
transition: None
reveal: false
ipynb: true
postsdir: ../_practicals/ # Where compiled lecture HTML files go
---

\subsection{Objective Functions}

\include{_mlfc/includes/mlfc-notebook-setup.md}

\include{_ml/includes/non-linear-regression-intro.md}

\include{_ml/includes/basis-functions.md}
\include{_ml/includes/basis-function-models.md}

\addreading{@Rogers:book11}{Section 1.4}
\addreading{@Bishop:book06}{Chapter 1, pg 1-6}
\addreading{@Bishop:book06}{Chapter 3, Section 3.1 up to pg 143}

\subsection{Lecture on Basis Functions from GPRS Uganda}

\figure{\includeyoutube{PoNbOnUnOao}{600}{450}}{Lecture on Basis functions from GPRS in Uganda in 2013.}{basis-functions-gprs-uganda}

\subsection{Use of QR Decomposition for Numerical Stability}

\notes{In the last session we showed how rather than computing $\inputMatrix^\top\inputMatrix$ as an intermediate step to our solution, we could compute the solution to the regressiond directly through [QR-decomposition](http://en.wikipedia.org/wiki/QR_decomposition). Now we will consider an example with non linear basis functions where such computation is critical for forming the right answer.}

*TODO* example with polynomials.

\setupcode{import numpy as np}

\code{x = np.random.normal(size=(10, 1))}

\code{Phi = mlai.fourier(x, 5)}

\code{(np.dot(Phi.T,Phi))}

\code{Phi*Phi}

\thanks

\reading

\exercises

\references
