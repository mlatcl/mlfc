---
title: "Practical 2: Dataset Joining and Access-Assess-Address Framework"
practical: 2
featured_image: assets/images/practical-two.png
abstract: >
  In this lab session we will explore dataset joining techniques, implement 
  the Access-Assess-Address framework in practice, work with camera trap data,
  and build predictive models for animal sightings.
layout: practical
venue: 
author:
- family: Sendyka
  given: Radzim
- family: Lawrence
  given: Neil D.
  gscholar: r3SJcvoAAAAJ
  institute: University of Cambridge
  twitter: lawrennd
  url: http://inverseprobability.com
time: "15:00"
date: 2025-09-02
published: 2025-08-29
transition: None
reveal: false
ipynb: true
postsdir: ../_practicals/ # Where compiled lecture HTML files go
---

\subsection{Code Reuse and Dataset Integration}

\include{_mlfc/includes/mlfc-notebook-setup.md}

\include{_ml/includes/code-reuse-fynesse.md}

\writeassignment{Install your Fynesse library from Practical 1, and demonstrate that it works by plotting a city map.}{10}

\subsection{DSAIL-Porini Camera Trap Dataset}

\include{_datasets/includes/dsail-porini-data.md}

\include{_ml/includes/geospatial-data-joining.md}

\writeassignment{Find the coordinate information in the dataset, deduplicate the coordinates, and plot them on top of an OSM map.}{15}

\subsection{Access-Assess-Address Framework Implementation}

\include{_ml/includes/access-assess-address-framework.md}

\subsection{Data Assessment and Preprocessing}

\include{_ml/includes/camera-trap-data-preprocessing.md}

\writeassignment{Clean the dataset by handling multi-species sightings, removing invalid entries, and converting to binary sighting data.}{20}

\subsection{Statistical Analysis and Pattern Detection}

\include{_ml/includes/sighting-probability-analysis.md}

\writeassignment{Calculate and plot average probabilities for dates, species, and cameras. Determine which relationships are statistically significant.}{20}

\subsection{Naive Bayesian Prediction Models}

\include{_ml/includes/naive-bayes-sighting-prediction.md}

\subsection{Advanced Analysis and Model Improvement}

\include{_ml/includes/correlation-analysis-improvements.md}

\writeassignment{Analyze the data to find the strongest relationships for improving predictions. Compare improved model against the baseline.}{15}

\subsection{Database Integration}

\include{_datasets/includes/sqlite-database-creation.md}

\writeassignment{Create a SQLite database with animal sighting and camera coordinate tables. Set appropriate indices and demonstrate with SQL queries.}{20}

\subsection{Extended Analysis}

\include{_ml/includes/burst-detection-analysis.md}

\thanks

\reading

\exercises

\references
