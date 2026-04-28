# Modular Monolith

## Intent

Use a single deployable application with strong internal module boundaries.

## Use when

- The team is small to medium-sized.
- Domain boundaries are still evolving.
- Operational simplicity matters.
- Independent deployment is not yet worth the cost.

## Rules

- Organize modules by business capability.
- Avoid shared mutable domain state across modules.
- Communicate between modules through explicit services, events, or interfaces.
- Keep module-specific migrations, tests, and policies close to the module.
- Document intentional coupling.

## Agent instruction

When modifying a modular monolith, preserve module boundaries. Do not introduce direct cross-module model access, database coupling, or service leakage unless the change includes a written rationale.
