---
title: "Practical 1: Nyeri to Cambridge - Geospatial Data and Reusability"
practical: 1
featured_image: assets/images/practical-one.png
abstract: >
  In this lab session we will explore geospatial data using OpenStreetMap, 
  create reusable code for data science pipelines, and apply machine learning 
  to classify locations based on geographic features.
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
- family: Cabrera
  given: Christian
time: "15:00"
date: 2025-09-01
published: 2025-08-29
transition: None
reveal: false
ipynb: true
postsdir: ../_practicals/ # Where compiled lecture HTML files go
---

\subsection{Geospatial Data and Machine Learning}

\include{_mlfc/includes/mlfc-notebook-setup.md}

\include{_ml/includes/geospatial-data-intro.md}

\include{_software/includes/osmnx-setup.md}

\include{_datasets/includes/openstreetmap-data.md}

\subsection{Downloading and Visualizing Geospatial Data}

\include{_ml/includes/poi-extraction-osm.md}

\include{_ml/includes/city-map-visualization.md}

\subsection{Reusability and Function Design}

\writeassignment{Use the code above to write a function that given a set of coordinates and a placename (eg. `Nyeri, Kenya`), outputs a visualisation of the area, with optional highlighted features.}{15}

\include{_ml/includes/reusable-map-function.md}

\subsection{Feature Extraction for Machine Learning}

\include{_ml/includes/osm-feature-extraction.md}

\include{_ml/includes/ml-dataset-construction.md}

\subsection{Classification and Analysis}

\include{_ml/includes/city-classification.md}

\include{_ml/includes/dataset-representativeness.md}

\subsection{Access, Assess, Address Framework}

\include{_ml/includes/access-assess-address.md}

\writeassignment{Using the Access-Assess-Address framework, identify generalisable functionality in your code and organize it into appropriate modules.}{20}

\thanks

\reading

\exercises

\references
