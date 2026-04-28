# Supply Chain Policy

## Rules

- Prefer well-maintained dependencies.
- Avoid unnecessary packages.
- Pin versions where reproducibility matters.
- Run dependency vulnerability scanning in CI.
- Generate SBOMs for production artifacts where practical.
- Review transitive dependency risk for security-sensitive systems.

## Agent instruction

Do not add dependencies just to save a few lines of code. Explain why a new dependency is justified.
