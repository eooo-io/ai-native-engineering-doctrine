# Docker Standards

## Dockerfile rules

- Use official or trusted base images.
- Prefer small, reproducible images.
- Use multi-stage builds where useful.
- Run as a non-root user where practical.
- Do not bake secrets into images.
- Pin versions where reproducibility matters.
- Add health checks for long-running services when appropriate.
- Keep build and runtime dependencies separate.

## Docker Compose rules

- Use Compose for local development orchestration.
- Keep environment values in `.env.example`, not real `.env` files.
- Use named volumes intentionally.
- Avoid exposing internal services unnecessarily.
