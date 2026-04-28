# Python Standards

## Baseline

- Follow PEP 8.
- Prefer type hints for public functions and core domain logic.
- Use `pytest` for tests.
- Use `black` or `ruff format` for formatting.
- Use `ruff`, `mypy`, or equivalent checks where practical.
- Prefer dataclasses, pydantic models, or typed dictionaries for structured data.
- Keep side effects at the edges.

## Agent instruction

When generating Python code, include clear function boundaries, types where useful, and tests for non-trivial logic. Do not swallow exceptions silently.
