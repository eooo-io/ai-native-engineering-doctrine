# Permission Boundaries

How an AI agent's authority is bounded is the central operational question for AI-native engineering. The guidance in `ai-agent-operating-principles.md` is about *what an agent does well*; this page is about *what an agent is allowed to do at all*.

## Allow / deny philosophy

Two postures, both useful, both sometimes wrong.

- **Allow-list (whitelist).** Default-deny everything; explicitly allow what's known safe. Slow to set up, slow to evolve, hard to outgrow safely. Right for production-adjacent surfaces, security-sensitive code, and any environment where the cost of a mistake outweighs the cost of friction.
- **Deny-list (blacklist).** Default-allow most things; explicitly deny the known-dangerous. Fast to start, fast to break. Right for personal scratch projects and exploration, wrong for shared infrastructure.

Most teams end up with a hybrid: allow-list at the boundary (filesystem, network, command execution), deny-list within the allowed surface. Be deliberate about which is which.

## Sandboxing posture

Decide for each tool an agent can invoke: does this run unsupervised, does this require confirmation, or is this off-limits?

- **Unsupervised** (read filesystem, run linters, run unit tests, read public docs): low blast radius, reversible, no shared state.
- **Confirmation required** (write to source files, install dependencies, run integration tests, hit external APIs that cost money): reversible but consequential.
- **Off-limits** (`rm -rf`, force pushes to shared branches, production deploys, credential reads): no permission level should make these automatic.

The line between categories is team-specific. Write it down rather than discovering it after an incident.

## Autonomy ceilings

Even within allowed territory, some operations should always cause the agent to stop and ask:

- The user's intent is ambiguous in a way the agent could resolve in multiple incompatible ways.
- The proposed action is hard to reverse (force-push, destructive SQL, mass file deletion).
- The proposed action affects shared state visible to other people (PRs, pings in chat, deploys).
- The proposed action is outside the obvious scope of the task — the agent noticed something else and wants to "also fix" it.

Permission alone is not justification. "I had permission to run that command" is the AI-engineering equivalent of "the spec didn't say I couldn't."

## Failure modes

When boundaries are crossed, what happens, and what's recoverable.

- **Exceeded a confirmation requirement** (agent wrote to a file it should have asked about first). Usually recoverable from git. Note the case and tighten policy if recurrent.
- **Took an action visible to others** (opened a PR, sent a message, pinged a channel). Not recoverable; the action exists. Acknowledge, document, fix the policy.
- **Took an action with cost** (paid API call, deploy, infrastructure change). Variably recoverable. Audit the trigger; this is usually a category-line problem, not a permission-line problem.
- **Took a destructive action** (force-push, table drop). Often partially recoverable; sometimes not. Treat as an incident with a post-mortem.

Audit logs (transcripts, hook outputs, command history) need to be good enough to reconstruct what happened. If they're not, that's the first fix.

## Team-adoption note

This is contentious territory for many teams. Expect negotiation with security, compliance, and (depending on industry) audit. Useful framings:

- The boundary is not "do we trust the AI" but "do we trust the boundary." Same posture as any other automation.
- A written policy people can argue with is more useful than an implicit one that lives in tribal knowledge.
- Permission posture is not static. Revisit it on the same cadence as other security policy reviews.

A defensible policy says what is allowed, what requires confirmation, what is off-limits, what happens when boundaries are crossed, and who owns the policy. If a draft is missing any of those, keep drafting.
