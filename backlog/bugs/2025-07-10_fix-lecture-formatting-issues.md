---
id: "2025-07-10_fix-lecture-formatting-issues"
title: "Fix Lecture Formatting and Content Issues"
status: "Proposed"
priority: "Medium"
created: "2025-07-10"
last_updated: "2025-07-10"
owner: "Neil Lawrence"
github_issue: "N/A"
dependencies: "N/A"
tags:
- backlog
- bugs
- formatting
- lectures
---

# Task: Fix Lecture Formatting and Content Issues

## Description
Fix specific formatting, content, and reference issues identified in the lecture feedback.

**Feedback Source:** Fred Lawrence, Radzim Sendyka

### Specific Issues to Fix

#### Formatting Issues
- [ ] Fix LaTeX formatting: `\(\boldsymbol{ \Phi}= \mathbf{Q}{\mathbf{R}\)` → `\(\boldsymbol{ \Phi}= \mathbf{Q}\mathbf{R}\)`
- [ ] Fix QR decomposition formatting: `\designMatrix` issues
- [ ] Remove extra parentheses in SGD equation
- [ ] Fix book page rendering that breaks flow
- [ ] Reduce oversized quotes (Nigeria MDG part)

#### Content Issues
- [ ] Remove missing plot reference: "scatter plot of deaths vs year"
- [ ] Fix "lab from last week" 404 error
- [ ] Remove repetitive content between lectures
- [ ] Remove references to concepts not covered (perceptron, movie recommender)
- [ ] Remove duplicate Olympic runner paragraphs
- [ ] Remove repeated Olympic Marathon Data sections

#### Reference Issues
- [ ] Add link to Tecator dataset
- [ ] Replace Kiptorich photo with Kenyan marathoner (e.g., Kipchoge)
- [ ] Fix broken references to previous material
- [ ] Add proper cross-references between lectures

#### Exercise Issues
- [ ] Clarify exercise expectations (essay vs. raise hand questions)
- [ ] Clarify Bishop exercise expectations and submission
- [ ] Add missing exercises where referenced
- [ ] Fix "If you are unfamiliar with probabilities you should complete the following exercises: (nothing)"

## Acceptance Criteria
- [ ] All LaTeX formatting is correct and renders properly
- [ ] No broken references or missing content
- [ ] No repetitive content between lectures
- [ ] All exercises have clear expectations
- [ ] All external links work correctly
- [ ] Content flows logically without interruptions

## Per-lecture feedback

### Week 1 (Probability)
- [ ] Define/introduce linear model before using "overdetermined system" example
- [ ] Clarify whether "overdetermined system" is just linear model explanation
- [ ] Add half-practical setup: simple linear regression + GitHub workflow
- [ ] pods package breaks on Python 3.12: downgrade to 3.10 (done?)
- [ ] Decouple Nigeria NMIS Data section into separate lab with own dataset
- [ ] Remove reference to missing scatter plot of deaths vs year
- [ ] Clarify if Exercise 1 is essay or raise hand question
- [ ] Clarify Bishop exercise expectations and submission
- [ ] Fix "If you are unfamiliar with probabilities you should complete the following exercises: (nothing)"
- [ ] Clarify whether book pages are required reading or just illustrations
- [ ] Reduce overly large quotes (eg Nigeria MDG part)
- [ ] Clarify whether students are expected to watch MLAI Lecture 2 (2012)
- [ ] Add ML AI Notebook setup at the start of each lecture (if not intentional omission)

### Week 1 (Objective Functions)
- [ ] TODO

### Week 2 (LinAlg LinReg)
- [ ] Remove repetition of Laplace story and Nigeria NMIS quote from Lecture 1
- [ ] Add link to Tecator dataset
- [ ] Move Olympic 100m & Marathon Data sections to lab
- [ ] Replace Kiptorich photo with Kenyan marathoner (eg Kipchoge)
- [ ] Generalise Sum of Squares Error section to align with Lecture 1
- [ ] Remove repetition of "Overdetermined System" to "A Probabilistic Process" content from Lecture 1
- [ ] Introduce "Maximum Likelihood" in Sum of Squares Error section
- [ ] Remove references to tasks not done (eg movie recommender, perceptron)
- [ ] Derive maximum likelihood solution for σ2 (as done for c* and m*)
- [ ] Remove "lab from last week" broken reference (404 error)
- [ ] Remove extra parentheses in expanded SGD equation
- [ ] Briefly introduce maximum likelihood and log likelihood
- [ ] Add 2D linear algebra example solving system
- [ ] Add short example on QR decomposition and solving lower triangular system
- [ ] Confirm dataset choice (no change needed, per Austin’s feedback)

### Week 2 (Basis Functions)
- [ ] Smooth transition into differentiating objective function (currently abrupt)
- [ ] Fix formatting issue in QR decomposition (\designMatrix)
- [ ] Add missing tool for exploring polynomial basis
- [ ] Remove repeated Olympic Marathon Data section
- [ ] Introduce likelihood and log likelihood concepts/equations earlier
- [ ] Show working for solving σ2 by setting derivative to 0

### Week 3 (Generalisation and NNs)
- [ ] Move Lecture 3 content that appears in Lecture 4 back to correct place
- [ ] Remove duplicate Olympic runner paragraph
- [ ] Fix formatting: "and we substitute \(\boldsymbol{ \Phi}= \mathbf{Q}{\mathbf{R}\) so we have"
- [ ] Remove repetitions from Lectures 1, 2, and 3 (reference instead of duplicating)
- [ ] Add suggested reading for Regularisation section (linear algebra prep)

### Week 4 (Dimensionality Reduction)
- [ ] TODO

### Week 4 (Gaussian Processes)
- [ ] TODO
- [ ] Simplify lab workload (currently 3 labs worth)
- [ ] Ensure consistent notebook format (part is written differently)
- [ ] Resolve missing module (GPy)

### Week 5 (Bayesian Regression)
- [ ] Move prior/posterior explanation before Bayesian approach paragraph
- [ ] Add more applied examples (eg marathon data) throughout lecture
- [ ] Fix broken multivariate regression link (should likely link to this lecture)
- [ ] Introduce likelihood concept and distinction from probability earlier
- [ ] Simplify posterior distribution derivation (too heavy on multivariate calculus)
- [ ] TODO: more


## Implementation Notes
- *Priority*: Fix critical rendering issues first (LaTeX, 404s)
- *Approach*: Systematic review of each lecture file
- *Testing*: Verify all links and references work
- *Consistency*: Ensure formatting is consistent across all lectures

## Related
- Feedback Source: Fred Lawrence, Radzim Sendyka
- Affected Files: All lecture HTML files in `_lectures/`
- Dependencies: N/A

## Progress Updates

### 2025-07-10
Task created with Proposed status. Specific formatting and content issues identified. 
