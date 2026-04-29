# Stack Profile: Laravel Modular Monolith

One opinionated bundle, not a starting default. Pick, edit, replace, or delete based on your context.

## Use when

- The product needs fast iteration.
- Domain boundaries matter.
- Deployment simplicity matters.
- The team benefits from a single codebase with strong module separation.

## Standards

- Laravel conventions
- PSR-12
- nWidart module structure where applicable
- Pest or PHPUnit
- Thin controllers
- Explicit services/actions
- Module-local migrations and tests
- Queue jobs for async work
- Policies/gates for authorization

## Agent instruction

Preserve module boundaries and Laravel conventions. Do not create cross-module shortcuts without a rationale.
