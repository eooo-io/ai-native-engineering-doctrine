# CI/CD Standards

## Pipeline gates

- Format check
- Static analysis or linting
- Unit tests
- Integration tests where feasible
- Build verification
- Dependency vulnerability scan
- Secret scan
- Artifact publishing only after checks pass

## Rules

- CI should be boring, fast, and trusted.
- Failed checks should block merges unless explicitly overridden.
- Deployment jobs should be auditable.
- Production deploys need rollback or recovery instructions.
