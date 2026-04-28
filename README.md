# AI-Native Engineering Harness

A public-safe scaffolding for a portable engineering standards, agent-skills, and review-policy system.

This repository is intended to act as a reusable operating layer for modern software work: coding conventions, architecture principles, delivery rules, agent instructions, review rubrics, and interview-ready proof artifacts.

It is deliberately vendor-neutral. Tool-specific files such as `SKILL.md`, `AGENTS.md`, Cursor rules, Copilot instructions, Claude skills, and Codex skills should be generated or adapted from the canonical material in this harness.

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
09-interview-proof-pack/     Interview narratives, matrices, and portfolio talk tracks
10-stack-profiles/           Opinionated stack bundles for real work
scripts/                     Placeholder scripts for generation and validation
```

## Core positioning

I maintain a portable AI-native engineering standards system that turns architecture principles, coding conventions, security rules, and review policies into tool-specific instructions for coding agents and human teams.

## Usage model

1. Treat `01-engineering-canon` as the source of durable principles.
2. Treat `02` through `08` as the practical doctrine library.
3. Treat `05-tool-adapters` as generated or adapted outputs for specific AI tools.
4. Treat `09-interview-proof-pack` as the public-facing explanation layer.
5. Keep private extensions in a vault, not in the public repo.

## Suggested workflow

```bash
# review structure
find . -maxdepth 2 -type f | sort

# later, generate adapters from canon
node scripts/generate-adapters.js

# later, validate required docs exist
node scripts/validate-harness.js
```

## Non-goals

This is not a replacement for project-specific architecture decisions.
It is not a credential dump.
It is not a prompt zoo.
It is not a magic productivity talisman, because those are usually just YAML with delusions of grandeur.

## License

Choose a license before publishing. MIT is fine for broad reuse. Apache-2.0 is stronger if patent language matters. Keep private materials private.
