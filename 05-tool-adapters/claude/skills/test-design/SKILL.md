---
name: test-design
description: Design practical tests for business logic, integrations, APIs, and regression protection.
---

# Test Design

## Purpose

Produce a lean, useful test plan for a change or component — enough coverage to catch the failures that matter, not enough to drown the change under fixture maintenance.

## Test types

- **Unit tests** for pure logic and small functions.
- **Component tests** for module-level behavior with realistic dependencies.
- **Integration tests** for database, queue, API, or external boundaries.
- **Acceptance-style tests** for user-visible behavior or contract surfaces.

## Output format

```md
## Scope

## Test plan

### Unit
### Component
### Integration
### Acceptance

## Edge and failure cases

## Tests intentionally not included
```

## Rules

- Prefer meaningful coverage over coverage theater.
- Tests must be runnable by the project's existing tooling.
- Include edge cases and failure cases — happy-path-only suites lie about quality.
- Avoid brittle tests that assert implementation details without protecting behavior.
- If a test type is intentionally skipped, name it in "Tests intentionally not included" and say why.
