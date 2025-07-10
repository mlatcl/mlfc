---
id: "2025-07-10_lecture-content-restructuring"
title: "Restructure Lecture Content Based on Feedback"
status: "Proposed"
priority: "High"
created: "2025-07-10"
last_updated: "2025-07-10"
owner: "Neil Lawrence"
github_issue: "N/A"
dependencies: "2025-07-10_pods-package-python312-compatibility"
tags:
- backlog
- features
- lectures
- pedagogy
---

# Task: Restructure Lecture Content Based on Feedback

## Description
Restructure lecture content to address feedback from Fred Lawrence and Radzim Sendyka regarding flow, clarity, and missing content.

**Feedback Source:** Fred Lawrence, Radzim Sendyka

### Key Issues to Address

#### Lecture 1 - Foundations
- [ ] Add proper introduction to linear models before overdetermined systems
- [ ] Create separate practical session for GitHub setup
- [ ] Fix missing plot references ("scatter plot of deaths vs year")
- [ ] Clarify exercise expectations (essay vs. raise hand questions)
- [ ] Fix book page rendering issues
- [ ] Remove oversized quotes (Nigeria MDG part)
- [ ] Clarify Bishop exercise expectations
- [ ] Add ML AI Notebook setup instructions

#### Lecture 2 - Linear Algebra
- [ ] Remove repetitive content from Lecture 1 (Laplace story, Nigeria NMIS quote)
- [ ] Add link to Tecator dataset
- [ ] Move Olympic data sections to practical sessions
- [ ] Replace Kiptorich photo with Kenyan marathoner (e.g., Kipchoge)
- [ ] Make "Sum of Squares Error" section more general
- [ ] Add proper derivation of maximum likelihood for σ²
- [ ] Remove references to concepts not covered (perceptron, movie recommender)
- [ ] Fix "lab from last week" 404 error
- [ ] Remove extra parentheses in SGD equation
- [ ] Add 2D visualization examples
- [ ] Add QR decomposition example

#### Lecture 3 - Basis Functions
- [ ] Add gradual introduction to differentiation (currently 0 to 100 too quickly)
- [ ] Fix formatting issues in QR decomposition (\designMatrix)
- [ ] Add tool for exploring polynomial basis
- [ ] Remove repeated Olympic Marathon Data sections
- [ ] Introduce likelihood and log-likelihood concepts early
- [ ] Show working for solving σ² from derivative

#### Lecture 4 - Bayesian Regression
- [ ] Remove content that belongs in Lecture 3
- [ ] Remove duplicate Olympic runner paragraph
- [ ] Fix formatting: "\(\boldsymbol{ \Phi}= \mathbf{Q}{\mathbf{R}\)"
- [ ] Remove repetitions from previous lectures
- [ ] Reference previous material instead of repeating

#### Lecture 5 - Gaussian Processes
- [ ] Create content (currently missing)

#### Lecture 6 - Advanced Topics
- [ ] Move prior/posterior distribution explanation before Bayesian approach
- [ ] Add more applied examples throughout
- [ ] Consider if multivariate calculus is too advanced for this level
- [ ] Remove repeated runner paragraph

## Acceptance Criteria
- [ ] All lectures have clear, logical flow
- [ ] No broken references or missing content
- [ ] Exercises and expectations are clearly defined
- [ ] Content is appropriate for target audience (undergrads, masters, PhDs)
- [ ] Practical sessions are properly separated from lectures
- [ ] All formatting issues are resolved

## Implementation Notes
- **Pedagogical Approach**: Change from "Math first" to "Applied examples first, then code, then math theory"
- **Target Audience**: Mixed levels (UG, Masters, PhD) - consider "extended" questions for different levels
- **Workload**: Students have 25% effort available, not working evenings/weekends
- **Motivation**: Make course application-based to motivate students

### Recommended Structure
1. **Start with applied example** (e.g., marathon data)
2. **Show the code** that solves the problem
3. **Explain the math theory** behind it
4. **Provide exercises** appropriate for different levels

## Related
- Feedback Source: Fred Lawrence, Radzim Sendyka
- Course Timeline: 5 weeks, starting 1st September 2025
- Target Audience: DSAIL team, 20-30 students (11 UG, 13 Masters, 4 PhD)

## Progress Updates

### 2025-07-10
Task created with Proposed status. Comprehensive feedback analysis completed. 