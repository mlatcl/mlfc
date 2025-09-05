---
week: 4
session: 3
date: 2025-09-24
time: "9:30"
featured_image: 
title: Transformers
author:
- given: Neil D.
  family: Lawrence
- given: Nic
  family: Lane
abstract: |
  In this session we introduce the transformer, the architecture ...
youtube: Ab1cbUdL50A  
googleslides: https://docs.google.com/presentation/d/1VAkvBT2kDKb3ekQgDSA2vD4MUUHAzlnDTAiB0o89ApY/edit?usp=sharing
---


\define{ipynbpath}{_notebooks}

\notes{\include{_mlfc/includes/mlfc-notebook-setup.md}}

\notes{We will introduce attention as a mechanism, build to transformers, and show practical examples (e.g., MiniGPT). This lecture is initially based on a lecture by Nic Lane for the 2022 edition of the Deep Neural Networks course in Cambridge. You can view hi slides below}
<iframe src="https://docs.google.com/presentation/d/e/2PACX-1vT5yXJwQSBU3DoB9zL6lUlpOsdmy8-3Cw9nHv3Q7PiJYHgTDTxNlIUYQF7bMAlQ9Sgpd_jP8wqThc3L/embed?start=false&loop=false&delayms=3000" frameborder="0" width="960" height="569" allowfullscreen="true" mozallowfullscreen="true" webkitallowfullscreen="true"></iframe>

\subsection{Plan}

\slides{* Attention, Attention!
* Transformers: “Attention Is All You Need”
* Extensions: Reformer, Linformer, Switch Transformers
* Beyond NLP: ViT, TNT, AlphaFold 2}
\notes{Focus first on the attention operator, then architectures, then applications and variants.}

\subsection{Traditional Sequence Modelling}
\slides{* Encoder compresses inputs into a state vector (context)
* Decoder generates outputs from context
* Bottlenecks: fixed-length context; gradient stability}
\notes{Seq2seq compresses an entire sequence into a single context vector, limiting capacity for long/complex inputs.}
\figure{\includesvg{}{70%}}{Traditional encoder–decoder with fixed context.}{seq2seq-context}

\subsection{The Innovation: Attention}
\slides{* Replace fixed context with per-step, input-dependent context
* Learn attention weights over encoder states; softmax normalisation}
\notes{Each output step computes a context as a weighted sum over encoder states, with weights learned from the decoder state and encoder states.}
\figure{\includesvg{}{70%}}{Attention mechanism with learned alignment.}{attention-mechanism}

\subsection{First Use of Attention}

\slides{* Bahdanau et al., 2015 (soft-)search the source sentence for segments that are rlevant to predicting a target word.}
* The Method
  * **Encoder**: bi-directional RNN; 
  * **Decoder**: gated RNN
  * **Innovation**: each time-step gets its own separate set of weights used to generate its part of the context vector

  \begin{aligned} \alpha_{t, j} & =\frac{\exp \left(e_{t, j}\right)}{\sum_{k=1}^T \exp\left(e_{t, k}\right) \\ e_{t, j} & =f\left(s_{t-1}, h_j\right)\end{aligned}


\notes{A small MLP computes unnormalised scores from decoder and encoder states; softmax yields alignment.}

\figure{\includediagram{\diagramsDir/ml/attention-diagram}{50%}}{Alignment-based attention in encoder–decoder RNNs.}{attention-diagram}
\figure{\includesvg{}{70%}}{Attention heatmap for translation (alignment matrix).}{attention-heatmap}



\subsection{Vision Transformers (ViT)}
\slides{* Split image into patches; embed + positions
* Transformer encoder over patch sequence
* Strong vision results}
\notes{Patch tokenisation with positional encodings enables global interactions without convolutions.}
\figure{\includesvg{}{70%}}{ViT architecture.}{vit-architecture}
\figure{\includesvg{}{70%}}{ViT attention visualisations.}{vit-attn}

\subsection{Transformer in Transformer (TNT)}
\slides{* Nested tokens: inner (patch) + outer (image)
* Attention at multiple granularities}
\notes{TNT improves fine-grained modelling within patches while maintaining global context.}
\figure{\includesvg{}{70%}}{TNT nested token structure.}{tnt-architecture}

\subsection{AlphaFold 2}
\slides{* Attention-centric modules for structure prediction
* Transformers superseded CNNs in later versions}
\notes{Attention enables modelling of long-range residue interactions; key to breakthrough accuracy.}
\figure{\includesvg{}{70%}}{Attention modules in AlphaFold-style models.}{alphafold}

\subsection{Summary}
\slides{* Attention replaces fixed context with learned focus
* Transformers scale via multi-head attention and stacking
* Variants address quadratic cost; broad applications}
\notes{From alignment to scaled dot-product attention; from RNNs to attention-only models; from NLP to vision/biology.}


\subsection{Scaled Dot-Product Attention}
\slides{* Project inputs to Q, K, V (trainable projections)
* Attention(Q,K,V) = softmax(QK^T/\sqrt{d_k}) V}
\notes{Q, K, V are computed from inputs via learned linear maps; the scale factor stabilises gradients.}
\figure{\includesvg{}{70%}}{Scaled dot-product attention.}{scaled-dot-attention}

\subsection{Multi-head Attention}
\slides{* Multiple heads learn diverse relations
* Concatenate heads and project}
\notes{Parallel heads allow capturing short- and long-range patterns concurrently.}
\figure{\includesvg{}{70%}}{Multi-head attention block.}{multihead-attn}

\subsection{Material}
\notes{Reference slides and practical tutorials.}

* [Vision Transformer Tutorial](https://colab.research.google.com/github/hirotomusiker/schwert_colab_data_storage/blob/master/notebook/Vision_Transformer_Tutorial.ipynb)
* [Transformer model for language understanding](https://colab.research.google.com/github/tensorflow/text/blob/master/docs/tutorials/transformer.ipynb#scrollTo=s_qNSzzyaCbD)
* [Transformers and Multihead Attention](https://colab.research.google.com/github/PytorchLightning/lightning-tutorials/blob/publication/.notebooks/course_UvA-DL/05-transformers-and-MH-attention.ipynb#scrollTo=70711ff5)

\subsection{The Transformer}
\slides{* Stacks of (MH-Attn + FFN + Norm)
* Encoder–decoder entirely attention-based
* Positional encodings provide order}
\notes{Residual connections and normalisation stabilise deep stacks; position is injected additively/multiplicatively.}
\figure{\includesvg{}{70%}}{Transformer encoder–decoder overview.}{transformer-overview}

\subsection{Variants for Scaling}
\slides{* Reformer: LSH attention; local buckets
* Linformer: low-rank projections of K/V
* Switch Transformer: MoE in FFNs}
\notes{All aim to reduce the O(T^2) cost of attention or increase capacity/throughput efficiently.}
\figure{\includesvg{}{70%}}{Reformer LSH attention.}{reformer-lsh}
\figure{\includesvg{}{70%}}{Linformer low-rank projections.}{linformer}
\figure{\includesvg{}{70%}}{Switch Transformer expert routing.}{switch-transformer}

\thanks

\reading

\references
