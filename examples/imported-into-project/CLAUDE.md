# CLAUDE.md

## Project

`audra-chat` is a FastAPI service that exposes a streaming `/chat` endpoint. It orchestrates calls to model providers (Anthropic as the primary, OpenAI as the fallback) and grounds responses against a retrieval layer backed by Postgres with pgvector. It is not a frontend, not a general-purpose API gateway, and not the place to put unrelated experiments.

## Commands

- Run tests: `uv run pytest`
- Type check: `uv run mypy`
- Lint: `uv run ruff check`
- Format: `uv run ruff format`
- Local server: `uv run uvicorn app.main:app --reload`
- Migrations (apply): `uv run alembic upgrade head`
- Migrations (autogenerate): `uv run alembic revision --autogenerate -m "<message>"` — review the generated diff before committing

## Code style

- Python 3.12+, type hints required for public functions, Pydantic v2 for all schema.
- Async route handlers; CPU-bound or sync work moves to threadpools or background tasks.
- Settings via `pydantic-settings`; never read `os.environ` ad hoc inside business code.
- Ruff is the lint baseline (`tool.ruff` in `pyproject.toml` is canonical); mypy strict on `app/`.
- Test files mirror module structure under `tests/`. Slow or model-calling tests are marked `@pytest.mark.slow` so CI can opt out.

## Ask before

- Modifying anything under `alembic/versions/`. Migrations are immutable once merged.
- Adding new dependencies. Justify the new package; prefer the standard library or what's already pinned.
- Touching `infra/` or any deployment manifest.
- Force-pushing to any branch.
- Changing the model-provider adapter interface in `app/providers/base.py`. That contract is shared.

## Never do

- Direct database modifications outside of an Alembic migration.
- Production deploys (handled by the deploy pipeline; never triggered locally).
- Force-pushes to `main` or `release/*`.
- Calling a model provider from a route handler — providers must go through `app/providers/`.
- Reading or logging the contents of a request `Authorization` header.

## Conventions worth knowing

- **Provider adapter.** All model calls go through `app/providers/`. Adding a new provider means a new adapter implementing `BaseProvider`, registered in `app/providers/__init__.py`. Routes never call providers directly.
- **Streaming.** The `/chat` endpoint streams via FastAPI's `StreamingResponse`. The streaming pattern is implemented once in `app/routes/chat.py`; reuse it rather than reimplementing.
- **Retrieval.** Embedding generation is provider-aware (different models, different dimensions). The `app/retrieval/` module owns the dimension/model bookkeeping; consumers never hard-code a dimension.
- **Token budgets, retries, timeouts.** Per-provider, per-model, set in configuration. Defaults are not a strategy.
- **Test fixtures live in `tests/fixtures/`.** Do not duplicate fixtures inline.

---

<!--
This `CLAUDE.md` is part of the example end-state in
`examples/imported-into-project/` of the AI-Native Engineering Doctrine.
The repo itself contains the doctrine that informs each section
(see `01-engineering-canon/`, `03-coding-standards/python.md`,
`07-security-and-secrets/`).

In a real downstream project, this file lives at the project root
and stands alone — there is no runtime dependency on the doctrine repo.
-->
