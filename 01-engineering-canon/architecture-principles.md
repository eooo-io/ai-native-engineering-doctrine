# Architecture Principles

## Default stance

Architecture choices are constraint-driven. The doctrine does not pick a default pattern; team size, latency budgets, deployment surface, compliance posture, and the team's operational maturity are what decide.

The job of these principles is to hold across patterns. Whether the system ends up a modular monolith, a set of services, an event-driven backbone, or some unholy hybrid, the same checks apply.

## Durable rules

- **Boundaries.** Define module or service boundaries around business capabilities, not technical layers.
- **Contracts.** Prefer explicit contracts (typed APIs, event schemas) between components over implicit shared state.
- **Ownership.** Each component has a clear owner, accountable for its behavior, on-call posture, and evolution.
- **Observability.** Logs, metrics, traces, and correlation IDs are design requirements, not afterthoughts.
- **Authorization.** Plan authentication, authorization, and tenant boundaries early; retrofitting them is where the bodies are.
- **Persistence.** Make persistence choices explicit. Avoid cross-boundary database coupling unless documented and justified.
- **Failure modes.** Design for partial failure, retries, idempotency, and recovery — not just the happy path.
- **Evolvability.** Optimize for the change you don't yet know about: avoid premature commitments, keep abstractions earned.

## Choosing a pattern

Patterns live in `02-architecture-patterns/`, presented as peer options. Compare them against the rules above; the right choice is the one whose trade-offs match your constraints, not the one that's currently fashionable.

## Architecture decision records

Use ADRs for decisions that affect system structure, operational behavior, security posture, or long-term maintainability. The constraint that drove the decision is the part that matters in two years; record it. A starting template lives at `templates/adr-template.md`.
