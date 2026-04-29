# Stack Profile: Python FastAPI AI Services

One opinionated bundle, not a starting default. Pick, edit, replace, or delete based on your context.

## Use when

- The product surface includes inference, retrieval, or model orchestration.
- Async I/O dominates: long-running model calls, streaming responses, fan-out tool use.
- Python is a natural fit because the ML and AI ecosystem already lives there.
- A small, contract-first service surface fits the team better than a full framework's worth of conventions.

## Standards

- FastAPI for HTTP, Pydantic v2 for schema, Python 3.12+.
- ruff and mypy as the lint and type baseline; ruff-format or black for formatting (pick one, not both).
- pytest with httpx.AsyncClient for endpoint tests; mark slow or model-calling tests so CI can opt out.
- uv or pip-tools for reproducible installs; lockfile committed.
- Async route handlers; CPU-bound or sync work moved to threadpools or background tasks.
- Settings via pydantic-settings; never read environment variables ad hoc inside business code.
- Structured logging (structlog or orjson-based); request IDs and trace IDs propagated across model and tool calls.
- The OpenAPI surface is treated as a contract, not a side effect of FastAPI — review changes deliberately.
- Model-provider calls live behind a thin adapter; prompts and tool schemas are versioned alongside the code.
- Token budgets, retries, and timeouts are explicit per provider and per model — defaults are not a strategy.

## Agent instruction

When modifying a FastAPI AI service, preserve the async/sync boundary, keep model-provider calls behind the adapter layer, and treat the OpenAPI surface as a contract. Do not call providers directly from route handlers, and do not invent default token, retry, or timeout values — read them from configuration.
