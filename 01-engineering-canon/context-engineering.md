# Context Engineering

## Stance

Context engineering is the discipline of putting the right information in front of an AI agent — and only the right information. The model is fast and patient; your token budget, cache window, and ability to debug the result are not.

This page is pattern-agnostic. Claude is the reference adapter elsewhere in the harness, but the principles below apply to any tool that consumes a system prompt, a memory file, or a session-scoped instruction set.

## What belongs in `CLAUDE.md` / `AGENTS.md`

These files are durable, project-scoped instructions read every turn. They are expensive: every line shows up in every prompt for the lifetime of the project.

Belongs:

- The shape of the project: what it is, what it isn't.
- Conventions a reader couldn't infer from the code in 60 seconds.
- "Always" and "never" rules with non-obvious motivation.
- Pointers to where doctrine lives (e.g. "code style: see `03-coding-standards/`").

Doesn't belong:

- The full architecture document — link it.
- Things the model can read from the code on demand (file names, function signatures).
- Personal preferences that change weekly.
- "Be helpful," "be careful," and other instructions the model ignores by design.

## Scoping a task

The first decision on any non-trivial task is *what context this work needs*. Get it wrong and you either drown the agent in irrelevance or starve it of the one fact it needed.

- **Keep in the main thread** when the task is small, when prior conversation is part of the problem, or when the result needs discussion before action.
- **Spawn a sub-agent** when the work is independent, the output is a structured deliverable, or the parent's context window is more valuable than the cost of running a second agent.
- **Hand off to a skill** when the shape of the work matches a skill description (see `04-agent-skills/SKILL-FORMAT.md`).

Do this:

> Spawn a sub-agent for "audit `src/auth/` for the four common token-handling mistakes," because the output is a self-contained report and the main thread doesn't need 4,000 tokens of grep output.

Not that:

> Drop the audit into the main thread because "we'll need to discuss it" — when the discussion is going to be about the report, not the search.

## Context budgets

A model's input window is not free. Most providers cache part of the prompt across turns; what gets cached, and what invalidates the cache, drives both cost and latency.

- The stable parts of the prompt (system instructions, doctrine references, project description) belong at the start so the cache holds.
- The volatile parts (the current task, recent tool results) belong at the end.
- When the conversation grows past the useful context window, decide deliberately: summarize the relevant facts and keep going, or start fresh with the summary as the new system context. Don't drift past the window and hope.

A short, well-shaped prompt beats a long, well-meaning one.

## Memory hygiene

Three rough categories of memory live around an agent. Keep them separate.

- **Persistent (cross-session)**: facts about the user, durable preferences, infrastructure pointers. Slow-changing. Worth writing down.
- **Project (per-repo)**: `CLAUDE.md`, `AGENTS.md`, doctrine pointers. Lives with the code.
- **Session (per-conversation)**: the current task, intermediate results. Discarded at the end.

Keep secrets out of all three. Memory files are read by every agent that touches the project; transcripts may be retained by the model provider; "ephemeral" is rarely as ephemeral as it sounds.

## Anti-patterns

- **The repo dump.** Pasting the whole repository into context as a substitute for scoping. See `02-architecture-patterns/anti-patterns.md` (Infinite-context dumps).
- **Boilerplate at the top of every turn.** "Please be careful, write good code, follow best practices ..." The model reads it; it doesn't change behavior. Save the tokens.
- **Vague "be helpful" prompts.** Instructions that don't name a goal, a deliverable, or a constraint produce confidently helpful nonsense. Be specific or accept the result.
- **Conflating memory with task.** Writing "we are currently working on auth" into a persistent memory file. By next session you aren't, and the file is now lying.
