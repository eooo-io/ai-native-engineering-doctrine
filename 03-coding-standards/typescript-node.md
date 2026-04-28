# TypeScript and Node Standards

## Baseline

- Use TypeScript strict mode.
- Use ESLint and Prettier or equivalent formatting rules.
- Prefer explicit domain types over unstructured objects.
- Avoid `any` unless documented and contained.
- Validate external input at system boundaries.
- Use Vitest or Jest for tests.
- Use Supertest or equivalent for HTTP endpoint testing.

## Agent instruction

Generated TypeScript must compile under strict mode unless the project explicitly opts out. Avoid broad `any`, hidden globals, and untyped API contracts.
