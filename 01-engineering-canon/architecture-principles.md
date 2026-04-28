# Architecture Principles

## Preferred default

Start with a modular monolith unless there is a concrete reason to distribute the system.

A modular monolith preserves deployment simplicity while enforcing internal boundaries. Move toward microservices only when team topology, scaling needs, operational independence, fault isolation, or compliance constraints justify the distributed-systems tax.

## Durable rules

- Define module boundaries around business capabilities.
- Keep domain logic out of controllers and framework glue.
- Use APIs and events intentionally, not as architecture confetti.
- Design for observability early: logs, metrics, traces, and correlation IDs.
- Plan authentication, authorization, and tenant boundaries early.
- Make persistence choices explicit.
- Prefer explicit contracts between components.
- Avoid cross-module database coupling unless documented and justified.

## Architecture decision records

Use ADRs for decisions that affect system structure, operational behavior, security posture, or long-term maintainability.
