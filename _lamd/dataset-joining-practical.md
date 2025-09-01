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

\include{_data-science/includes/osm-code-reuse-fynesse.md}

\include{_datasets/includes/dsail-porini-data.md}

\include{_data-science/includes/dsail-porini-data-joining.md}

<!-- Dsail Porini Address -->
\include{_data-science/includes/dsail-porini-data-preprocessing.md}

\include{_data-science/includes/dsail-porini-probability-analysis.md}

\include{_ml/includes/dsail-porini-naive-bayes.md}


\include{_ml/includes/dsail-porini-correlation-analysis-improvements.md}

\writeassignment{Analyze the data to find the strongest relationships for improving predictions. Compare improved model against the baseline.}{15}

\include{_datasets/includes/dsail-porini-sqlite-database-creation.md}

\writeassignment{Create a SQLite database with animal sighting and camera coordinate tables. Set appropriate indices and demonstrate with SQL queries.}{20}


\include{_ml/includes/dsail-porini-burst-detection-analysis.md}


\reading

\exercises

\references


