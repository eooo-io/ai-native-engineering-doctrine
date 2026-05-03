# Claude Adapter

The reference adapter for the AI-Native Engineering Doctrine. Of all the adapters in `05-tool-adapters/`, this one is the deepest worked example: the others (Cursor, Copilot, Codex, generic AGENTS.md) are intentionally lighter sketches scaled to what each tool actually consumes.

Use this directory as the starting point for setting up Claude Code in a new project.

## What's here

| File | Purpose |
| --- | --- |
| `CLAUDE.md` | Template for the project-root memory file Claude reads on every turn. |
| `settings.json` | Conservative permissions baseline (allow / ask / deny), env-var slot, and a hook stub. |
| `hooks/README.md` | When a hook is the right answer vs. memory or skills. |
| `hooks/post-tool-use-secrets-flag.md` | Annotated PostToolUse hook that flags secret-like patterns in tool output. |

Skills are not mirrored under this directory. Copy directly from [`04-agent-skills/`](../../04-agent-skills/) into your project's `.claude/skills/` — each `SKILL.md` is self-contained and follows the format defined in `04-agent-skills/SKILL-FORMAT.md`. If a Claude-specific tuning becomes necessary later (description rewording for routing, Claude-tool-aware Output sections), reintroduce a mirror here at that point — not before.

## Quick-start

In a new or existing project:

1. Copy `CLAUDE.md` to the project root. Fill in the placeholder sections; delete what doesn't apply.
2. Copy `settings.json` to `.claude/settings.json`. Read the comments; tighten further if your stack is risk-sensitive.
3. (Optional) Copy individual skills from [`04-agent-skills/`](../../04-agent-skills/) into `.claude/skills/`. Each `SKILL.md` is self-contained.
4. (Optional) If you want a hook running, copy the script body from `hooks/post-tool-use-secrets-flag.md` into `.claude/hooks/post-tool-use-secrets-flag.sh`, `chmod +x`, and uncomment the matching block in `settings.json`.

After step 1, the project has a working Claude Code memory file. Each subsequent step adds a layer; none of them require the doctrine at runtime.

## What to extend

- **`CLAUDE.md`.** This file is project-specific by design. Almost everything in it should be your project's content, not the template's.
- **`settings.json` permissions.** The defaults are conservative. Add stack-specific allowed commands, additional denies, project-specific environment variables.
- **Skills in your project's `.claude/skills/`.** Add skills for workflows specific to your project, starting from `04-agent-skills/` as the canonical source. Tune the `description` lines if Claude's routing isn't picking the right one.

## What to leave alone (initially)

- **Hook structure.** Get one hook working before adding more. Hook proliferation is its own anti-pattern.
- **The deny list.** Don't loosen `Bash(rm -rf*)`, `Bash(git push --force*)`, or pushes to `main`/`master`/`production` without writing down why.
- **Skill format.** If you're adding skills, follow `04-agent-skills/SKILL-FORMAT.md`. Don't reinvent the shape — routing accuracy depends on consistency.

## Why this is the reference adapter

Claude Code consumes more of the doctrine's surface area than other tools — memory files, structured permissions, hooks, skills, sub-agents — so the Claude adapter is where the doctrine becomes most concrete. The other adapters in `05-tool-adapters/` cover the same engineering principles, but compressed to what those tools can actually act on. If a forker lives primarily in Cursor or Copilot, they should still treat this directory as the canonical example and extend their own adapter accordingly.
