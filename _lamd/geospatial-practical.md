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
  institute: University of Cambridge
- family: Lawrence
  given: Neil D.
  institute: University of Cambridge
  url: http://inverseprobability.com
- family: Cabrera
  given: Christian
  institute: University of Cambridge
time: "15:00"
date: 2025-09-01
published: 2025-08-29
transition: None
reveal: false
ipynb: true
---

\section{Geospatial Data and Machine Learning}

\include{_software/includes/osmnx-setup.md}

\include{_datasets/includes/osm-cities-data-intro.md}

\include{_datasets/includes/openstreetmap-data.md}

\subsection{Reusability and Function Design}

\codeassignment{Use the code above to write a function that given a set of coordinates and a placename (eg. `Nyeri, Kenya`), outputs a visualisation of the area, with optional highlighted features.}{import osmnx as ox
import matplotlib.pyplot as plt
import math

def plot_city_map(place_name, latitude, longitude, box_size_km=2, poi_tags=None):
    """
    Plot a simple city map with area boundary, buildings, roads, nodes, and optional POIs.

    Parameters
    ----------
    place_name : str
        Name of the place (used for boundary + plot title).
    latitude, longitude : float
        Central coordinates.
    box_size_km : float
        Size of the bounding box in kilometers (default 2 km).
    poi_tags : dict, optional
        Tags dict for POIs (e.g. {"amenity": ["school", "restaurant"]}).
    """
    return NotImplementedError("not implemented yet")}{15}

\code{plot_city_map('Nyeri, Kenya', -0.4371, 36.9580, 5, poi_tags=tags)}

\codeassignment{Plot the area around one of these English cities, and compare it with Nyeri. What do you notice? What assumptions did you make in your code that are now not holding? Go back to the relevant part of the code and fix it.}{plot_city_map('Cambridge, England', 52.205, 0.1218, 5, poi_tags=tags)}{15}

\include{_datasets/includes/osm-feature-extraction.md}

\include{_datasets/includes/osm-ml-dataset-construction.md}

\include{_ml/includes/osm-city-classification.md}

\include{_data-science/includes/osm-dataset-representativeness.md}

\subsection{Access, Assess, Address Framework}

\include{_data-science/includes/osm-access-assess-address.md}

\writeassignment{Using the Access-Assess-Address framework, identify generalisable functionality in your code and organize it into appropriate modules.}{20}


\notes{End of Practical 1A
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
