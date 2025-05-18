# LaMD Lecture System

[![Tests](https://github.com/lawrennd/lamd-lecture/actions/workflows/tests.yml/badge.svg)](https://github.com/lawrennd/lamd-lecture/actions/workflows/tests.yml)
[![codecov](https://codecov.io/gh/lawrennd/lamd-lecture/branch/gh-pages/graph/badge.svg)](https://codecov.io/gh/lawrennd/lamd-lecture)

A template repository for creating academic lecture courses using Jekyll and LaMD (Literate Academic Markdown).

## Quick Install

```bash
# Clone the template
git clone https://github.com/lawrennd/lamd-lecture.git my-course
cd my-course

# Run the installation script
./install.sh
```

The installer will:
1. Ask for your course details
2. Set up the directory structure
3. Configure the templates
4. Initialize git repository
5. Optionally create a GitHub repository

## Overview

lamd-lecture provides a skeleton structure for building lecture courses with the following features:
- Multiple output formats (slides, notes, web pages) from a single markdown source
- Jekyll-based website generation for course materials
- LaMD macros for consistent content rendering

## Getting Started

1. Use this repository as a template
2. Configure `_config.yml` with your course details
3. Update `_lamd/_lamd.yml` with your personal information and output preferences
4. Add lecture content to the `_lamd` directory
5. Compile lectures with `maketalk` command

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
