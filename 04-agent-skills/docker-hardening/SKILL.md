---
name: docker-hardening
description: Review Dockerfiles and Compose setups for security, reliability, image size, and developer ergonomics.
---

# Docker Hardening Skill

## Review areas

- Base image choice
- Dependency installation
- Layer caching
- Non-root user
- Secret handling
- Health checks
- Multi-stage builds
- Reproducibility
- Image size
- Local developer usability

## Rule

Never bake secrets into images. Use environment variables, secret stores, or runtime injection.
