# Delivery Principles

## Delivery philosophy

Ship small, verified increments. Prefer visible progress with safety rails over heroic rewrites performed without a rollback path.

## Rules

- Slice work into independently reviewable units.
- Define acceptance criteria before implementation where practical.
- Keep CI fast enough that developers actually use it.
- Automate linting, tests, dependency checks, and build verification.
- Avoid long-lived branches unless the project has a deliberate release model.
- Maintain rollback and recovery paths for production systems.
- Do not merge changes that cannot be built, tested, or explained.
