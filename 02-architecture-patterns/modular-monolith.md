# Modular Monolith

## Intent

Use a single deployable application with strong internal module boundaries. One process, one deploy pipeline, multiple bounded modules.

## Use when

- The team is small to medium-sized and operational simplicity has real value.
- Domain boundaries are still being learned; you want low cost to redraw them.
- Independent deployment is not yet worth the operational and observability tax.
- You want to defer the distributed-systems decision until evidence justifies it.

## When not to use

- Modules need to scale, deploy, or fail independently in ways a single process cannot accommodate.
- Compliance, tenancy, or fault-isolation requirements demand separate deployment surfaces.
- Different modules have fundamentally different runtime characteristics (long-running ML inference vs. sub-100ms request handling) that one process degrades.
- Team topology is already split such that a shared codebase creates more coordination cost than the deployment simplicity is worth.

## Guardrails

- Organize modules by business capability, not by technical layer.
- Avoid shared mutable domain state across modules.
- Communicate between modules through explicit services, events, or interfaces — never via reaching into another module's models or tables.
- Keep module-specific migrations, tests, and policies close to the module.
- Document intentional coupling. Undocumented coupling is just future debt with confidence.

## Anti-patterns

- A modular monolith in name only: shared database tables, cross-module imports, and a single god service that pretends boundaries exist.
- Treating the monolith as permanent. The pattern is a starting point for some teams; revisit the choice when constraints change.
- Letting framework-shaped code (controllers, ORM models, observers) become the de facto module boundary.

## Agent instruction

When modifying a modular monolith, preserve module boundaries. Do not introduce direct cross-module model access, database coupling, or service leakage unless the change includes a written rationale.
