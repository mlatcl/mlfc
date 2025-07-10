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