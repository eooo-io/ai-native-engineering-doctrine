# Observability Standards

## Baseline

Systems should emit enough information to understand behavior, diagnose incidents, and evaluate performance.

## Required signals

- Structured logs
- Metrics for critical paths
- Traces for distributed flows where useful
- Correlation IDs across requests and jobs
- Error reporting
- Health checks

## Rules

- Logs must not expose secrets or sensitive data.
- Alerts should be actionable.
- Dashboards should reflect user-impacting behavior, not vanity telemetry.
