# Example: Harness Imported Into a Project

This directory shows the *shape* of a project after the harness has been adopted. Nothing here is meant to be run; it is doctrine-only, like the rest of the repo. The point is legibility: what files land where, what the filled-in versions look like, what changes from the adapter baseline.

## The fictional project

Everything below is filled in for **`audra-chat`**, a fictional FastAPI service. The shape:

- Streaming chat endpoint (`/chat`) that orchestrates calls to model providers (Anthropic primary, OpenAI fallback).
- Retrieval over a Postgres + pgvector store.
- Alembic-managed schema, uv-managed environment, ruff/mypy/pytest for tooling.

`audra-chat` is not a real project. It is concrete enough to make the example sentences sound like sentences, generic enough that the choices are transferable.

## File map

```
.
├── README.md                                 # this file
├── CLAUDE.md                                 # project-root memory for Claude Code
├── AGENTS.md                                 # generic agent memory (mirror of CLAUDE.md content)
├── .cursor/
│   └── rules/
│       └── engineering.mdc                   # Cursor project rules
└── .claude/
    ├── settings.json                         # tightened from the adapter baseline
    ├── skills/
    │   └── code-review/
    │       └── SKILL.md                      # one routable skill, copied from the canon
    └── hooks/
        └── post-tool-use-secrets-flag.sh     # text-only, mode 644 (chmod +x in your project)
```

## How to read this

- **Comparing each file to its adapter source.** `CLAUDE.md` here vs. `05-tool-adapters/claude/CLAUDE.md` shows what filled-in content looks like next to the template. Same for `settings.json` (tightened) and `engineering.mdc` (filled in from the Cursor sketch adapter).
- **What changes after adoption.** The adapter files are seeds. The example shows how those seeds shape into project-specific content: real commands, named conventions, real "ask before" cases, real boundaries.
- **What stays the same.** The hook script and the code-review skill are essentially unchanged from the canon — they're project-agnostic. The memory files and `settings.json` are project-specific.

## What this example is not

- Not a runnable project. There is no `pyproject.toml`, no source code, no migrations.
- Not a recommendation that your project should look exactly like this. `audra-chat` is one shape; yours will differ.
- Not a substitute for reading the harness's doctrine. This is the *what*; the *why* lives in `01-engineering-canon/` and the rest of the numbered directories.
