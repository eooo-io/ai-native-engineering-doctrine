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

## Maintenance posture: `CLAUDE.md` vs. `AGENTS.md`

The example carries both `CLAUDE.md` and `AGENTS.md` because real projects often run multiple coding agents — Claude Code reads `CLAUDE.md`, generic-agent tooling reads `AGENTS.md`. The two files cover overlapping ground (project description, code style, security, operating posture) but at different fidelities: `CLAUDE.md` is project-specific and tuned for Claude Code's memory-file conventions; `AGENTS.md` is the broader baseline that any agent landing in the repo can read.

Pick a sync stance and write it down:

- **Single source.** Treat one file as canonical (usually `AGENTS.md` for the operating-rules baseline) and copy the relevant sections into the other when you change them. Annotate the derived file at the top: "sections N–M mirror AGENTS.md; edit there first."
- **Independent.** Treat them as deliberately separate files, where `CLAUDE.md` carries project commands, file-path conventions, and Claude-specific "ask before" boundaries that don't belong in a generic agent baseline. Drift between the two is acceptable as long as the *operating rules* don't contradict.
- **Generated.** A small script renders one file from the other plus a header. Worth it only if you maintain many agent memory files in the same project.

Don't leave the choice implicit. Drift between memory files is the same problem this harness warns about elsewhere; don't reproduce it inside the example.

## What this example is not

- Not a runnable project. There is no `pyproject.toml`, no source code, no migrations.
- Not a recommendation that your project should look exactly like this. `audra-chat` is one shape; yours will differ.
- Not a substitute for reading the harness's doctrine. This is the *what*; the *why* lives in `01-engineering-canon/` and the rest of the numbered directories.
