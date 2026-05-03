# Contributing

This repo's contribution model is "fork it and curate," not "send a PR." That changes what contributing actually means.

## If you want to use the doctrine yourself

The primary way to use the doctrine is to fork it and shape it into your own personal or team version.

### Forking and shaping

1. Fork the repo, or grab a tarball — there's no requirement to use Git's fork mechanism.
2. Decide what fits and what doesn't. The doctrine is opinion, not law. Disagree with a rule? Rewrite it. Don't need a stack profile? Delete it. Find a section thin? Expand it. The result should reflect *your* doctrine, not the upstream's.
3. Keep what's still useful. Delete what isn't. Don't leave content sitting because "someone might want it" — see the file-shape rule in the README.
4. Negotiate the contentious parts with your team if this is a team fork. Things worth raising: permission boundaries (`01-engineering-canon/permission-boundaries.md`), the AI-specific security posture, the no-default-pattern stance, which stack profiles you keep.
5. Add private extensions, client-specific examples, and proprietary doctrine in a separate private vault — not in your public fork.

### Staying in sync vs. diverging deliberately

You have two reasonable options:

- **Track upstream.** Pull periodically, accept the changes you agree with, reject the ones you don't. Reasonable if you broadly agree with the upstream's direction.
- **Diverge deliberately.** Fork once, never sync, treat the upstream as historical influence rather than current source. Reasonable if your doctrine is genuinely yours and the upstream's drift no longer matches.

Don't half-do it. A fork that's "kind of" tracking upstream and "kind of" diverging will accumulate merge pain and unowned content. Pick a posture and write it down.

## If you want to send a PR upstream

Upstream PRs are welcome, but the bar is real. The doctrine is opinionated; opinions don't change because someone disagreed once.

Good upstream PRs:

- Doctrine improvements with reasoning. "This rule is wrong because X, here's the better rule, here's why X applies generally."
- Concrete content additions that fill gaps the doctrine already acknowledges (see open issues labeled `new-content`).
- Fixes for genuine errors: broken links, factual mistakes, references to artifacts that don't exist.
- Small, well-scoped clarifications.

Not good upstream PRs:

- Personal-preference shifts ("I prefer Black to Ruff," "I always use trunk-based"). These are exactly what forks are for.
- Adding new opinions to existing pages without removing or addressing the old ones.
- Wholesale rewrites of canon pages without prior discussion.
- "I added my company's stack profile." Profiles ship as peer options; the upstream doesn't take on every team's stack.

If you're unsure whether a PR fits, open an issue first.

## Filing issues

Issues are useful for:

- Reporting broken links, factual mistakes, or references to artifacts that don't exist.
- Proposing content gaps the doctrine should fill.
- Asking whether a particular change would be welcome upstream before doing the work.

Issues are not useful for asking the maintainer to make the doctrine reflect your team's preferences. That's what your fork is for.

## Releases

The doctrine uses [Semantic Versioning](https://semver.org/) starting at `v1.0.0`.

- **Major** (`vN.0.0`) — breaking doctrine changes: rule reversals, file removals, structural moves that downstream forks may rely on.
- **Minor** (`vN.M.0`) — new pages, expansions, additions that don't reverse existing doctrine.
- **Patch** (`vN.M.P`) — typos, broken-link fixes, voice tweaks, mechanical corrections.

If you want a stable base for your fork, pin to a specific tag. If you want the upstream's current opinion, track `main`. Release notes for tagged versions live in the annotated git tag (`git show vX.Y.Z`).

The `v1.0.0 → v2.0.0` jump was a structural deletion (the personal/portfolio directories `09-interview-proof-pack/` and `10-stack-profiles/` were removed), not a doctrine reversal. Forks pinned at `v1.0.0` lose those two directories on the way to `v2.x`; everything else is additive.

## Code of conduct

Disagree with the doctrine, not with the people who hold it.
