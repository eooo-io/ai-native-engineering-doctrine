# API-First Design

## Intent

Design contracts deliberately before binding clients and services to accidental implementation details.

## Rules

- Define resource boundaries and contracts clearly.
- Use consistent error formats.
- Version APIs when compatibility matters.
- Document authentication and authorization requirements.
- Include pagination, filtering, sorting, and rate-limit behavior where relevant.
- Add contract tests for important integrations.

## Agent instruction

When changing an API, identify affected clients, compatibility risks, error behavior, and tests. Do not silently change response shapes.
