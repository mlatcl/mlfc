---
layout: lecture
title: Convolutional Neural Networks
featured_image: slides/diagrams/deepnn/cnn-structure.svg
week: 5
session: 2
author:
- given: Neil D.
  family: Lawrence
abstract: >
  This lecture builds on deep neural networks to explore ...
talkscam:
youtube: 
oldyoutube: 
- code: 
  year: 2025
transition: None
time: "9:30"
date: 2025-09-30
---

\notes{\include{_mlfc/includes/mlfc-notebook-setup.md}}

\section{From Deep Networks to CNNs}

\notes{In our previous lectures, we explored how composing layers of basis functions creates deep neural networks, and we examined the chain rule and automatic differentiation that makes training these networks possible. We've seen how we can consider structured data through convolutional neural networks, graph neural networks, recurrent networks. Today we'll see how these foundations extend to one of the earliest architectural innovations in deep learning: the convolutional neural network.}

\slides{* **Review**: Deep networks, chain rule
* **Today**: How convolutional networks exploit these concepts
}

\include{_deepnn/includes/chain-rule-cnn-layered.md}
\include{_deepnn/includes/simple-cnn-implementation.md}

\reading
\thanks
\references
