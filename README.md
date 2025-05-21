# ML Foundations Course

## Topics and Resources

### Fundamental Topics

- Probability and probability distributions
- Linear algebra and linear regression - appropriate factorisations with examples
- Generalisation and double descent
- Latent variables - representation learning

#### Advanced Topics

- Bayesian regression
- Uncertainty quantification
- Gaussian processes
- Bayesian optimisation
- Reinforcement learning
- Data oriented architectures
- Data & machine learning systems

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

## Team

- Cedric Kiplimo 
- Austin Kaburia 
- Fred Lawrence
- Neil Lawrence @lawrennd
- Ciira Maina
- Radzim Sendyka

## Repository Structure

```
lecture-course/
├── _config.yml           # Jekyll configuration
├── _lamd/                # LaMD files containing lecture sources
│   └── _lamd.yml         # LaMD configuration (author, output formats, paths)
├── _lectures/            # Compiled Lecture html files
├── _notebooks/           # Compiled Jupyter notebooks
├── _practicals/          # Compiled Practical exercises
├── assets/               # Static assets (images, js, css)
├── index.md              # Home page
└── slides/               # Compiled reveal.js presentation slides
```

## Usage

Lectures are compiled using the `maketalk` command:

```bash
cd _lamd
maketalk 01-introduction.md 
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

