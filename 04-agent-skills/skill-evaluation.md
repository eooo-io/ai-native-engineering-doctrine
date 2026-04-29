# Skill Evaluation

Skills accumulate. Without a review discipline they become dead weight that confuses routing, bloats context, and pretends to be a workflow because it has a YAML frontmatter.

This page is the agenda for a skill-review session. Run it on a cadence; the cadence matters less than running it at all.

## Dogfood logs

For evaluation to be honest, you need data on what skills are actually doing.

- Capture which skill fires for which task, and what it produced.
- Capture the false fires — times the skill picked up a task it shouldn't have, and times it didn't pick up one it should have.
- Capture downstream change quality — was the skill's output used as-is, edited heavily, or thrown out.

Mechanism is tool-specific (Claude transcripts, hook outputs, manual logging in a shared doc). The point is having something concrete to evaluate, not a particular file format.

## Review cadence

- Quarterly is a reasonable default for a small team. Monthly if the skill set is changing rapidly, twice a year if it has stabilized.
- A review takes longer than people expect. Budget about an hour per ten skills.
- Tie it to a calendar event, not to "when we have time."

## Earning its keep

For each skill, four questions:

1. **Usage frequency.** Did this skill fire? How often? If never, why is it here.
2. **Downstream change quality.** When the skill produced output, was it useful? Used as-is, or rewritten? Heavily-rewritten output is a signal: the skill's shape may not match the actual work.
3. **False-fire rate.** How often did the skill activate for a task it shouldn't have? That's a description problem, usually fixable. How often did it fail to activate when it should have? Also a description problem, but harder to detect — look for tasks people prompted manually instead.
4. **Redundancy.** Does this skill overlap with another? If two skills are competing for the same trigger condition, one of them is dead weight.

A skill that fails any question gets a fix or a retirement plan. Skills don't get to coast on having been useful once.

## Retirement

When a skill earns retirement:

- Remove the directory, not just the `SKILL.md`. Stranded supporting files are confusing.
- If a downstream fork is using it, leave a one-line note in the project changelog or a `RETIRED-SKILLS.md` so curators can match versions.
- Do not "deprecate" by leaving the skill present with a "do not use" comment. Routing models do not respect comments.

## Anti-patterns

- **Skill sprawl.** See `02-architecture-patterns/anti-patterns.md`.
- **Description rot.** Skills whose descriptions have drifted from what the body actually says they do. Each review cycle, re-read the `description` against the body and reconcile.
- **Refusing to retire.** Keeping a skill because someone might use it some day. Some day is "after another review cycle proves it earns its place."
