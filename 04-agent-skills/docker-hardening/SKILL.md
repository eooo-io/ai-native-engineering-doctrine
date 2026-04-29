---
name: docker-hardening
description: Review Dockerfiles and Compose setups for security, reliability, image size, and developer ergonomics.
---

# Docker Hardening

## Purpose

Review a Dockerfile, Compose file, or build pipeline for the predictable failure modes: bloated images, leaked secrets, missing health checks, root-owned runtimes, and base images that haven't been updated since the previous coffee shortage.

## Review areas

- Base image choice and version pinning.
- Dependency installation order and cache usage.
- Layer caching effectiveness.
- Non-root user and filesystem permissions.
- Secret handling (environment, runtime injection, never bake-in).
- Health checks and readiness signals.
- Multi-stage builds and final image surface.
- Reproducibility (locked dependencies, deterministic build inputs).
- Image size and unused tooling left in the final stage.
- Local developer usability (build time, dev/prod parity, debug story).

## Output format

```md
## Summary

## Security findings

## Reliability findings

## Image size and build findings

## Developer-ergonomics findings

## Recommended changes
```

## Rules

- Never bake secrets into images. Use environment variables, secret stores, or runtime injection.
- Tie each finding to a concrete line or layer; "this image is too big" without a target is not a review.
- Prefer minimal, reproducible base images over whatever the README first suggested.
- Do not invent deployment-environment requirements; ask if they aren't stated.
