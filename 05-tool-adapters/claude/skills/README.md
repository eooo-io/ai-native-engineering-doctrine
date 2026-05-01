# Claude Skills

These skills mirror `04-agent-skills/` with the same canonical format defined in `04-agent-skills/SKILL-FORMAT.md`. They start as verbatim copies and may diverge over time when Claude-specific routing tuning is needed (description rewording, additional sections, Claude-tool-aware Output format templates).

If you're maintaining a fork: when a canon skill changes, update the mirror here, or — if the mirror has diverged — reconcile deliberately. Drift is acceptable; silent drift is not.

## Adoption

Copy the skill directories you want into your project's `.claude/skills/` (or wherever your Claude Code installation reads skills from). Each skill's `SKILL.md` is self-contained.
