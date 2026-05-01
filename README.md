# AI-Native Engineering Harness

A doctrine-only scaffold for engineering standards, agent skills, and review policies that travels between projects.

This is a **fork-and-curate seed**, not a runnable tool. Forkers copy the repo, shape it into their own personal or team version, and carry the result into projects, interviews, contracts, or roles. The harness ships principles, conventions, skills, and adapters as text. Nothing here executes, generates, or validates anything.

> Wondering if this is for you? See [`WHO-THIS-IS-FOR.md`](./WHO-THIS-IS-FOR.md). Want to see the shape of a project after adoption? See [`examples/imported-into-project/`](./examples/imported-into-project/).

## Purpose

The harness helps answer a practical question:

> How do I carry my engineering standards, architecture doctrine, and AI-agent workflows into any project, interview, contract, or role without rewriting the same tribal wisdom every time?

## Public-safe boundary

This scaffold contains no private credentials, employer-specific confidential information, client names, proprietary code, or undisclosed architecture details.

Use it as a portfolio-safe base. Keep sensitive examples, private prompts, client-specific decisions, and internal artifacts in a private vault.

## Directory map

```text
01-engineering-canon/        Durable principles and operating doctrine
02-architecture-patterns/    Design patterns, trade-offs, and anti-patterns
03-coding-standards/         Language and framework-specific rules
04-agent-skills/             Reusable AI-agent skill definitions
05-tool-adapters/            Tool-specific instruction adapters
06-cloud-and-delivery/       Docker, Kubernetes, CI/CD, IaC, observability
07-security-and-secrets/     Security, secrets, dependency, and supply-chain rules
08-review-rubrics/           Code, architecture, test, and security review rubrics
examples/                    Worked end-state examples of the harness adopted into a project
```

## How to adopt this

1. Fork the repo, or grab a tarball — whichever feels less like inheritance and more like raw material.
2. Read `01-engineering-canon/` first. That's the doctrine layer. Keep what fits, rewrite what doesn't.
3. Treat `02` through `08` as a doctrine library. Most teams will use 60–80% as-is and rewrite the rest.
4. Treat `05-tool-adapters/` as the bridge between doctrine and AI tooling. Claude is the **reference adapter** — the deepest worked example. Cursor, Copilot, Codex, and the generic `AGENTS.md` are intentionally lighter sketches, scaled to what each tool actually consumes. Extend them yourself if you live in one of those tools.
5. See `examples/imported-into-project/` for what files end up where after adoption — a worked end-state for a fictional FastAPI service. The example is doctrine-only like the rest of the repo; it shows shape, not runnable code.
6. Keep private extensions, client-specific examples, and proprietary doctrine in a private vault — not in your public fork.

**File shape.** Default to short. Pages exist to be read by humans in a hurry, fed to AI agents as context, and edited by forkers — each of those scales poorly with length. If a page grows long *because its sub-topics are independently curatable* (a forker might link to one without the others, or remove one without the rest), promote them to sibling files. If it grows long because the sub-topics belong together, leave it.

**Doctrine here is the seed, not the canonical source.** Anything you copy into a downstream project must work standalone — downstream forks should not assume access to this repo.

## Core positioning

I maintain a portable AI-native engineering standards system that turns architecture principles, coding conventions, security rules, and review policies into tool-specific instructions for coding agents and human teams.

## Non-goals

This is not a replacement for project-specific architecture decisions. It is not a credential dump. It is not a prompt zoo. It is not a magic productivity talisman, because those are usually just YAML with delusions of grandeur.

## License

MIT. See [`LICENSE`](./LICENSE). Keep private materials private.
