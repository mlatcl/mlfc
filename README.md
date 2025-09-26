# ML Foundations Course

An introduction to machine learning foundations, designed as a 4-week course with 3 sessions per week. The course will be first run starting *1st September 2025*.

## Course Structure

*Duration*: 4 weeks  
*Sessions*: 3 sessions per week  
*Start Date*: 1st September 2025

## Topics and Resources

### Week 1: Foundations
- *Session 1*: Probability and an Introduction to Jupyter, Python and Pandas
- *Session 2*: Objective Functions: A Simple Example with Matrix Factorisation
- *Session 3*: Linear Algebra and Linear Regression

### Week 2: Basis Functions and Generalisation
- *Session 1*: Linear Algebra (continued)
- *Session 2*: Basis Functions

### Week 3: Neural Networks
- *Session 1*: Generalisation and Neural Networks

### Week 4: Advanced Topics
- *Session 1*: Bayesian Regression
- *Session 2*: Gaussian Processes

### Week 5: Applications and Systems
- *Session 1*: Latent Variable Modelling

### Core Topics Covered

- Probability and probability distributions
- Linear algebra and linear regression with appropriate factorisations
- Basis functions and feature engineering
- Generalisation and double descent
- Bayesian regression 
- Gaussian processes
- Latent variable modelling and representation learning

## Lecture Materials

All lecture materials are available in multiple formats:

- *Web Lectures*: [View lectures online](https://mlatcl.github.io/mlfc/lectures/)
- *Slides*: [Download presentation slides](https://mlatcl.github.io/mlfc/slides/)
- *Jupyter Notebooks*: [Interactive notebooks](https://mlatcl.github.io/mlfc/notebooks/)
- *Practical Exercises*: [Hands-on exercises](https://mlatcl.github.io/mlfc/practicals/)

### Available Lectures

1. *01-01-probability*: Probability and an Introduction to Jupyter, Python and Pandas
2. *01-02-matrix-factorization*: Objective Functions: A Simple Example with Matrix Factorisation
3. *02-01-linear-algebra*: Linear Algebra and Linear Regression
4. *02-02-basis-functions*: Basis Functions
5. *03-01-generalisation-and-neural-networks*: Generalisation and Neural Networks
6. *04-01-bayesian-regression*: Bayesian Regression
7. *04-02-gaussian-processes*: Gaussian Processes
8. *05-01-latent-variable-modelling*: Latent Variable Modelling

### Datasets
- River water level (time series)
- Weather (TAHMO, time series) - [TAHMO](https://tahmo.org/)
- DSAIL porini (images of wild animals) - [DSAIL Porini](https://www.sciencedirect.com/science/article/pii/S2352340922010666)
- Kieni forest (terrestrial and aerial images)
- Sensor placement problem
- UK census data
- Kenya census data - [Kenya Census 2019](https://www.knbs.or.ke/reports/kenya-census-2019/)

### Dissemination Ideas
- Video recordings of lectures
- Dedicated web pages with lecture materials on the DSAIL website
- Paper on teaching methods and outcome

## Course Delivery

The course is designed to be delivered in a hybrid format:
- *In-person lectures* with interactive demonstrations
- *Online materials* for self-paced learning
- *Practical sessions* with hands-on coding exercises
- *Assessment* through practical assignments and final project

## Prerequisites

- Basic programming experience (Python preferred)
- Familiarity with high school mathematics (calculus, linear algebra)
- No prior machine learning experience required

## Team

- Cedric Kiplimo 
- Austin Kaburia 
- Fred Lawrence
- Neil Lawrence @lawrennd
- Ciira Maina
- Radzim Sendyka

## Repository Structure

```
mlfc/
├── _config.yml           # Jekyll configuration
├── _lamd/                # LaMD files containing lecture sources
│   └── _lamd.yml         # LaMD configuration (author, output formats, paths)
├── _lectures/            # Compiled Lecture html files
├── _notebooks/           # Compiled Jupyter notebooks
├── _practicals/          # Compiled Practical exercises
├── assets/               # Static assets (images, js, css)
├── index.md              # Home page
├── lectures.html         # Lectures index page
├── slides/               # Compiled reveal.js presentation slides
├── backlog/              # Project backlog and task tracking
├── cip/                  # Code Improvement Plans
└── docs/                 # Additional documentation
```

## Usage

Lectures are compiled using the `maketalk` command:

```bash
cd _lamd
maketalk probability.md 
```

## Configuration

The `_lamd/_lamd.yml` file controls how your lectures are processed and where outputs are stored. Key settings include:

- `author`: Your personal information
- `postsdir`, `slidesdir`, etc.: Output directories for different formats
- `posts`, `docx`, `pptx`, etc.: Enable/disable different output formats
- `baseurl`, `url`: Website configuration for GitHub Pages

See the repositories at [mlphysical](https://github.com/mlatcl/mlphysical) or [advds](https://github.com/mlatcl/advds) for examples of complete lecture courses using the LaMD system.

## Learn More

For more information about LaMD, see [the LaMD documentation](https://inverseprobability.com/lamd).
