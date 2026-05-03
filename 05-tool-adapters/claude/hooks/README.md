# Hooks

Hooks let you intercept Claude Code's actions — before or after a tool call, at session boundaries, when the user submits a prompt. They run shell commands you write.

## When to reach for a hook

Three places enforcement can live: memory, skills, hooks. Pick the right one.

- **Memory** (`CLAUDE.md`, `AGENTS.md`) is for guidance the model reads and may follow.
- **Skills** are for routable, repeatable workflows the model invokes by description.
- **Hooks** are for enforcement that doesn't depend on the model's cooperation.

If the consequence of the model not following a rule is bad enough that you can't trust persuasion, it's a hook.

## When *not* to use hooks

- Stylistic preferences the model already follows reasonably from `CLAUDE.md`. Hooks are operational machinery, not a way to enforce wishes.
- Problems better solved by tightening permissions in `settings.json`. A hook that catches a forbidden command after the fact is a worse fix than denying the command upfront.
- One-off tasks. If you'd run it manually three times before deciding to automate, you don't need a hook yet.

## Hook events

Common events Claude Code fires hooks on:

- **PreToolUse** — before a tool runs. Can deny.
- **PostToolUse** — after a tool runs. Can flag, log, transform.
- **UserPromptSubmit** — when the user submits a prompt. Can rewrite or annotate.
- **Stop** — when the agent ends a turn. Useful for summaries and audit trails.

Each event fires with structured input on stdin (the tool name, arguments, output) and can write to stdout or exit non-zero to influence the agent.

## Example

See [`post-tool-use-secrets-flag.md`](./post-tool-use-secrets-flag.md) for the annotated explainer, and [`post-tool-use-secrets-flag.sh`](./post-tool-use-secrets-flag.sh) for the copy-able script. The `.sh` is checked in without the execute bit — copy it into your project's `.claude/hooks/` and `chmod +x` to enable it. The "no executable scripts" rule is about tooling that operates on the doctrine repo itself, not about copy-able example artifacts that the doctrine describes.

## Operational notes

- Hooks run on the user's machine with the user's permissions. They are not a sandbox.
- Hooks run synchronously. Slow hooks slow turns. Keep them lean.
- If a hook fails, the agent gets a non-zero exit and surfaces the error. Failing closed is fine; failing silently is not.
