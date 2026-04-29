---
name: architecture-review
description: Review architecture decisions, boundaries, trade-offs, scalability, and operational risk.
---

# Architecture Review

## Purpose

Evaluate whether a proposed or existing design fits the problem, the constraints, the team, and the operational environment. The output is structured feedback a designer can act on, not a verdict.

## Checklist

- Problem statement is clear.
- Main constraints are explicit.
- Boundaries are defined.
- Data ownership is clear.
- Failure modes are considered.
- Security and authorization are addressed.
- Observability is included.
- Deployment and rollback are realistic.
- Alternatives were considered.

## Output format

```md
## Architecture summary

## Strengths

## Risks

## Trade-offs

## Missing decisions

## Recommended next step
```

## Rules

- Tie each risk and trade-off to a constraint, not to taste.
- Mark uncertainty explicitly; don't smuggle assumptions past the reader.
- Prefer "missing decision" over "wrong decision" when the design hasn't named the trade-off yet.
- Do not invent product or business requirements.
