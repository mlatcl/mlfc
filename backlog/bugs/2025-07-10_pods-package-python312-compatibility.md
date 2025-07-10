---
id: "2025-07-10_pods-package-python312-compatibility"
title: "Fix Pods Package Python 3.12 Compatibility"
status: "Proposed"
priority: "High"
created: "2025-07-10"
last_updated: "2025-07-10"
owner: "Neil Lawrence"
github_issue: "N/A"
dependencies: "N/A"
tags:
- backlog
- bugs
- packages
- compatibility
---

# Task: Fix Pods Package Python 3.12 Compatibility

## Description
The `pods` package is incompatible with Python 3.12, causing runtime errors that prevent students from following the course materials. This is a critical blocker for the course.

**Feedback Source:** Fred Lawrence, Radzim Sendyka

### Current Issues
1. `FileNotFoundError: [Errno 2] No such file or directory: 'C:\\tmp\\sods.log'`
2. `AttributeError: 'ConfigParser' object has no attribute 'readfp'. Did you mean: 'read'?`

### Impact
- Students cannot run code examples in lectures
- Practical sessions fail immediately
- Course materials are unusable with modern Python versions

## Acceptance Criteria
- [ ] Pods package works on Python 3.12 without errors
- [ ] All dataset loading functions work correctly
- [ ] Students can run all lecture examples
- [ ] Documentation updated with Python version requirements

## Implementation Notes
- **Option 1**: Fix pods package compatibility issues
- **Option 2**: Replace pods datasets with local alternatives
- **Option 3**: Downgrade to Python 3.10 (as suggested by Radzim)
- **Option 4**: Create wrapper functions that handle compatibility

### Recommended Approach
1. Test pods package on Python 3.10 first
2. If 3.10 works, document this as the required version
3. If 3.10 doesn't work, create local dataset alternatives
4. Update all lecture materials to use compatible data loading

## Related
- Feedback Source: Fred Lawrence, Radzim Sendyka
- Affected Lectures: All lectures using pods datasets
- Priority: Critical - blocks course delivery

## Progress Updates

### 2025-07-10
Task created with Proposed status. Critical issue identified that prevents course from running. 