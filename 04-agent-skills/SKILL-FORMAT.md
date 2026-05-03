# SKILL Format

Meta-rule for the doctrine's agent skills. Every `SKILL.md` under `04-agent-skills/` follows this shape so a model picking from many skills can route correctly, and a forker adding a new skill doesn't have to invent structure.

## File layout

- One skill per directory: `04-agent-skills/<skill-name>/SKILL.md`.
- `<skill-name>` is kebab-case and matches the `name` field in the frontmatter exactly.
- A skill directory may contain supporting files (templates, examples, fixtures), but the skill definition itself lives in `SKILL.md` at the directory root.

## Frontmatter

```yaml
---
name: <kebab-case-name>
description: <one sentence — when to use this skill, not just what it does>
---
```

- `name` is required, kebab-case, and matches the directory name.
- `description` is required and routing-quality (see below).

Tool-specific adapters may layer additional frontmatter fields on top of these two. The canon requires only `name` and `description`.

## Body shape

The body is markdown. Required and optional sections:

- `# <Skill Name>` — one H1. Use a human-readable title, not the kebab name.
- `## Purpose` — **required**. One short paragraph: what the skill produces and the problem it's for. A reader skimming should know in two lines whether this skill applies to their task.
- `## <domain-fitting heading>` — **recommended**. Concrete bullets the skill should walk through. The heading fits the skill: review-shaped skills use `## Checklist` or `## Review areas`; design-shaped skills use `## Test types` or `## Design dimensions`. Don't force a generic name.
- `## Output format` — **recommended for skills that produce structured artifacts** (reviews, design docs, audit reports). A fenced markdown template the skill is expected to fill in. Skip for process-oriented skills where the output shape is the conversation itself.
- `## Rules` — **optional**. Additional constraints the skill must follow ("Be specific", "Mark uncertainty", "Do not invent requirements"). Only include rules that aren't already obvious from the canon.

Sections beyond these are fine when they earn their place. Don't pad.

## Description-writing guidance

The description is what a model reads to decide whether to invoke the skill. A bad description means the skill never fires, or fires when it shouldn't.

- **Lead with a verb.** *"Review ..."*, *"Design ...", *"Generate ..."*, *"Audit ..."*. The verb is the trigger condition.
- **Name the inputs.** *"Review **architecture decisions**, **boundaries**, **trade-offs**, **scalability**, and **operational risk**."* Those are the words a routing query will match against.
- **Don't talk about the skill.** Avoid *"This skill helps you ..."* or *"Use when you want to ..."*. Just describe the action.
- **One sentence.** If two are needed, the skill is doing too much; split it.
- **Avoid verb collisions.** *"Review code"* and *"Review architecture"* are fine — distinct domains. *"Review tests"* and *"Review test design"* will fight; collapse or rename.

## Skill vs. canon rule vs. one-off prompt

Three places content can live. Use the right one.

- **Skill** when the work is repeatable, has a well-defined output shape, and benefits from being routable by description (e.g. code review, architecture review, test design). Skills accumulate; review them periodically (see `skill-evaluation.md`).
- **Canon rule** (in `01-engineering-canon/` or a domain page like `07-security-and-secrets/`) when the rule applies to all work in that domain regardless of who or what is doing it. *"Never bake secrets into images"* belongs in security canon, not in every Docker-touching skill.
- **One-off prompt** when the task is bespoke and won't be repeated. Don't promote a prompt to a skill until you've used the same prompt three times for genuinely similar tasks.

## Authority

This file is the source of truth for the canonical SKILL format used in the doctrine. Tool-specific adapters (under `05-tool-adapters/`) may layer additional fields, sections, or routing metadata on top, but the required elements above must be preserved.
