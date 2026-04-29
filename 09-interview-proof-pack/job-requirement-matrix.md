# Job Requirement Matrix

Map common job-description requirements to the harness artifacts that back them, with a one-line interview talking point per row. Every artifact cited below exists in this repo.

| Job requirement | Harness artifact | Interview talking point |
|---|---|---|
| Backend systems | `03-coding-standards/` (PHP/Laravel, Python, TypeScript/Node, SQL); `02-architecture-patterns/api-first.md` | I define clear service boundaries, contracts, and operational expectations. |
| Solution architecture | `01-engineering-canon/architecture-principles.md`; `02-architecture-patterns/`; `08-review-rubrics/architecture-review-rubric.md` | I document trade-offs and choose architecture against constraints, not by trend. |
| Agile development | `01-engineering-canon/delivery-principles.md`; `06-cloud-and-delivery/ci-cd.md` | I slice work into reviewable increments with acceptance criteria. |
| AI engineering | `01-engineering-canon/ai-agent-operating-principles.md`; `04-agent-skills/`; `05-tool-adapters/` | I use AI as governed engineering acceleration, not ad hoc prompting. |
| System design | `02-architecture-patterns/`; `06-cloud-and-delivery/observability.md` | I reason about data, failure modes, scale, and operational cost. |
| Application design | `03-coding-standards/`; `01-engineering-canon/architecture-principles.md` | I keep domain behavior out of framework glue. |
| Web applications | `03-coding-standards/typescript-node.md`; `02-architecture-patterns/api-first.md` | I design contracts between frontend, backend, and infrastructure. |
| Cloud-native design | `06-cloud-and-delivery/docker.md`, `kubernetes.md`, `ci-cd.md` | I build deployable systems with health checks, config, and rollback paths. |
| Distributed systems | `02-architecture-patterns/event-driven.md`; `06-cloud-and-delivery/observability.md` | I account for retries, idempotency, ordering, and partial failure. |
| Continuous integration | `06-cloud-and-delivery/ci-cd.md`; `01-engineering-canon/delivery-principles.md` | I use CI to enforce quality, not merely decorate pull requests. |
| Security posture | `07-security-and-secrets/secrets-policy.md`, `supply-chain-policy.md` | I treat secrets, dependencies, and the supply chain as part of the design. |
| Code review | `08-review-rubrics/code-review-rubric.md`; `04-agent-skills/code-review/SKILL.md` | I bring a written review rubric, not just opinions. |

## Known gaps

These are concerns the harness will need real artifacts for, but doesn't yet. They are intentionally absent from the table above rather than linked as broken references.

- **Scalability playbook** — adjacent concerns are covered by the system-design and distributed-systems rows; a dedicated playbook is not yet written.
- **Auth standards** — no dedicated file. Likely lands either per-language inside `03-coding-standards/` or as a future page under `07-security-and-secrets/`.
- **Persistence patterns** — partially covered in `03-coding-standards/sql.md` and architecture rules; no dedicated catalog yet.
- **ADR template** — referenced from `architecture-principles.md`; the template itself lands in phase 4 of the harness build-out.
