# PHP and Laravel Standards

## Baseline

- Follow PSR-12.
- Use strict types where practical.
- Prefer Laravel conventions unless there is a documented reason not to.
- Keep controllers thin.
- Put domain behavior in services, actions, domain models, or module-specific application layers.
- Prefer explicit validation through Form Requests or dedicated validators.
- Use migrations for schema changes.
- Use Pest or PHPUnit for tests.

## Laravel modules

When using `nWidart/laravel-modules`, follow module conventions:

```text
Modules/<ModuleName>/
  Entities/
  Http/Controllers/
  Services/
  Providers/
  Database/Migrations/
  Tests/
```

## Agent instruction

Do not place substantial business logic in controllers. Do not bypass module boundaries. Include tests for logic-heavy behavior.
