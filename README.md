# ML Foundations Course


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
