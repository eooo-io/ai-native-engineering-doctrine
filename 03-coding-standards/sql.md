# SQL and Persistence Standards

## Baseline

- Design schema around domain facts and access patterns.
- Use migrations, not manual production changes.
- Use indexes intentionally and verify query plans for hot paths.
- Avoid N+1 query patterns.
- Treat transactions as explicit business consistency boundaries.
- Do not store secrets unless encrypted and justified.

## Agent instruction

When changing persistence logic, identify migration impact, rollback concerns, indexes, data integrity rules, and tests.
