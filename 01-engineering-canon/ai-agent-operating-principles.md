# AI Agent Operating Principles

## Role of agents

Agents are force multipliers, not owners. Humans remain responsible for intent, correctness, architecture, security, and final acceptance.

## Rules

- Give agents bounded tasks with clear acceptance criteria.
- Provide project-specific context instead of dumping the entire universe into the prompt.
- Require tests for logic-heavy changes.
- Require review of security-sensitive changes.
- Require explicit assumptions for architecture or design recommendations.
- Prefer small, reviewable changes over sprawling autonomous edits.
- Do not allow agents to invent facts, APIs, library behavior, or business requirements.
- Treat generated code as untrusted until reviewed and tested.
- Bound agent permissions deliberately; see `permission-boundaries.md`.

## Useful agent roles

- Implementer
- Code reviewer
- Test engineer
- Architecture reviewer
- Security reviewer
- DevOps reviewer
- Documentation editor
