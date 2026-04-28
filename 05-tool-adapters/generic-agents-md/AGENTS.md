# AGENTS.md

## Project operating rules

This project follows the AI-Native Engineering Harness.

## General instructions

- Preserve existing architecture unless explicitly asked to refactor.
- Keep changes small and reviewable.
- Add or update tests for logic-heavy changes.
- Do not hard-code secrets.
- Do not introduce new dependencies without explaining why.
- Prefer simple, maintainable code over cleverness.
- Document meaningful trade-offs.

## Code style

Follow the project language standards. If no local standard exists, use the relevant standard from `03-coding-standards`.

## Testing

Before finalizing work, identify the tests that should be run. If tests cannot be run, explain why.

## Architecture

Prefer modular boundaries, explicit contracts, observable behavior, and secure defaults.
