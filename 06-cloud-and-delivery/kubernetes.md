# Kubernetes Standards

## Baseline

- Use namespaces deliberately.
- Define resource requests and limits.
- Use readiness and liveness probes.
- Keep secrets out of manifests.
- Prefer ConfigMaps for non-secret configuration.
- Use least-privilege RBAC.
- Avoid privileged containers unless justified.
- Use labels and annotations consistently.
- Plan rolling updates and rollback.

## Agent instruction

When editing Kubernetes manifests, check securityContext, probes, resources, config, secrets, and rollout behavior.
