# CLAUDE.md

<!--
Template for the project-root `CLAUDE.md` Claude Code reads on every turn.

Keep this file short. Long memory files burn tokens, dilute attention, and
become a graveyard for stale rules. If you need depth, link to it instead of
inlining it.

Replace the example bullets in each section with project-specific content.
Delete sections that don't apply. Comments below this line should be removed
once you've filled the file in.
-->

## Project

<!-- One paragraph: what this project is, what it isn't.
Example:
A FastAPI service that orchestrates calls to model providers and serves a
streaming chat endpoint. It is not a frontend, not a general-purpose API
gateway, and not the place to put unrelated experiments. -->

## Commands

<!-- The handful of commands the agent should know.
Example:
- Run tests: `uv run pytest`
- Type check: `uv run mypy`
- Lint: `uv run ruff check`
- Format: `uv run ruff format`
- Local server: `uv run uvicorn app.main:app --reload`
-->

## Code style

<!-- Pointers, not full rewrites. Refer to canonical sources where possible.
Example:
- Python: type hints required for public functions; docstrings only when behavior is non-obvious.
- See `docs/STYLE.md` for the full doctrine.
-->

## Ask before

<!-- Operations the agent must surface for confirmation.
Example:
- Modifying database migrations.
- Adding new dependencies.
- Touching `infra/` or `.github/workflows/`.
- Force-pushing to any branch.
-->

## Never do

<!-- Operations that should never run automatically, regardless of permission.
Example:
- Direct database modifications outside of migrations.
- Production deploys.
- Force-pushes to `main` or `develop`.
- Creating PRs from forks without review.
-->

## Conventions worth knowing

<!-- Non-obvious things a fresh reader couldn't infer in 60 seconds.
Example:
- All async I/O is `asyncio`-based; avoid `trio` patterns even when they would be more elegant.
- Test fixtures live in `tests/fixtures/`; do not duplicate inline.
- Migrations are managed by Alembic; never hand-edit `versions/`.
-->

---

<!--
This template is part of the AI-Native Engineering Doctrine:
https://github.com/eooo-io/ai-native-engineering-doctrine

The repo contains the engineering doctrine that informs these sections.
Once you've filled in this `CLAUDE.md`, it stands alone — your project does
not need access to the doctrine repo at runtime, and downstream forks
shouldn't assume it.
-->
