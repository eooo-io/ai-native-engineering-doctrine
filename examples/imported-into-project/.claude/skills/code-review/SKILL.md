---
name: code-review
description: Review code for correctness, maintainability, security, performance, and test quality.
---

# Code Review

## Purpose

Review a code change and produce actionable feedback. The output is concrete enough that the author can fix issues without a follow-up conversation.

## Review dimensions

1. Correctness
2. Readability
3. Complexity
4. Security
5. Performance
6. Test quality
7. Architecture fit
8. Operational risk

## Output format

```md
## Summary

## Critical issues

## Suggested improvements

## Tests to add or update

## Questions or assumptions
```

## Rules

- Be specific. "Unclear" is not feedback; quote the line and explain why.
- Explain why each issue matters; consequences anchor priority.
- Prefer fix suggestions or small diffs when the change is mechanical.
- Do not invent project requirements.
- Mark uncertainty clearly. Reviewing is not bluffing.
