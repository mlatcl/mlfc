---
title: "Practical 4: Collaborative Filtering with Matrix Factorisation"
practical: 4
layout: practical
featured_image: slides/diagrams/mlai/carthaginian-empire.png
author:
- family: Lawrence
  given: Neil D.
- family: Sendyka
  given: Radzim
date: 2025-09-09
abstract: |
  In this session we use our understanding of objective functions to build a  simple recommender system based on *matrix factorisation*.
youtube: Gq6bjcm8AqQ
reveal: false
---

\include{_mlfc/includes/mlfc-notebook-setup.md}

\newslide{Objective Function}

\notes{Across the first week we motivated the importance of probability, but also stressed that machine learning builds on 'objective functions'. In this practical you will take the ideas you've learnt and apply them to the domain of *collaborative filtering*. Specifically you will create a *matrix factorisation* algorithm.} 

\notes{In the last few practicals we saw how
we could load in a data set to pandas and use it for some simple data
processing. We computed variaous probabilities on the data and I encouraged you
to think about what sort of probabilities you need for prediction. This week we
are going to take a slightly different tack.}

\notes{Broadly speaking there are two dominating approaches to machine learning problems. We started to consider both approaches last week: firstly we can construct models based on defining the relationship between variables using probabilities. In this practical we will consider the second approach: which involves defining an *objective function* and optimising it.}

\notes{What do we mean by an objective function? An objective function could be an *error function* a *cost function* or a *benefit* function. In evolutionary computing they are called *fitness* functions. But the idea is always the same. We write down a mathematical equation which is then optimized to do the learning. The equation should be a function of the *data* and our model *parameters*. We have a choice when optimizing, either minimize or maximize. To avoid confusion, in the optimization field, we always choose to minimize the function. If we have function that we would like to maximize, we simply choose to minimize the negative of that function.}

\notes{So for this lab session, we are going to ignore probabilities, but don't worry, they will return!}

\notes{This week we are going to try and build a simple movie recommender system using an objective function. To do this, the first thing I'd like you to do is to install some software we've written for sharing information across google documents.}

\include{_datasets/includes/movie-body-count-data.md}
\include{_data-science/includes/movie-body-count-visualise.md}

\writeassignment{Data ethics. If you find data available on the
internet, can you simply use it without consequence? If you are given data by a
fellow researcher can you publish that data on line?}{1}{10}

\include{_ml/includes/recommender-systems.md}
\include{_ml/includes/recommender-data.md}
\include{_ml/includes/matrix-factorization.md}

\notes{End of Practical 4
```
 _______  __   __  _______  __    _  ___   _  _______  __
|       ||  | |  ||   _   ||  |  | ||   | | ||       ||  |
|_     _||  |_|  ||  |_|  ||   |_| ||   |_| ||  _____||  |
  |   |  |       ||       ||       ||      _|| |_____ |  |
  |   |  |       ||       ||  _    ||     |_ |_____  ||__|
  |   |  |   _   ||   _   || | |   ||    _  | _____| | __
  |___|  |__| |__||__| |__||_|  |__||___| |_||_______||__|
```}


\thanks

\reading

\exercises

\references


