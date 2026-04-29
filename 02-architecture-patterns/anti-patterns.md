# Architecture Anti-Patterns

## Distributed monolith

Multiple services that must deploy together, share databases, and fail together. All the pain of microservices, none of the freedom. A magnificent achievement in self-harm engineering.

## Framework-shaped domain

Business logic scattered across controllers, ORM models, request validators, and observers until nobody knows where the truth lives.

## God service

One service owns everything because boundaries were inconvenient, deadlines were loud, and entropy brought snacks.

## Premature microservices

Distributed architecture adopted before team size, scaling pressure, or operational maturity justify it.

## Secret soup

Credentials stored in source files, screenshots, chat logs, or random JSON blobs. Treat any committed secret as exposed.

---

The following anti-patterns emerged with AI-assisted engineering. They are stylistically of a piece with the patterns above.

## Vibe-merging

Shipping AI-generated changes without understanding them, on the basis that the diff "looks fine." A reliable way to introduce subtle bugs whose authorship nobody will admit to in the post-mortem. Read the change before merging it; if you can't read it, you can't own it.

## Autonomy creep

Quietly widening the agent's permissions one task at a time until "ask before destructive operations" has eroded into "yolo." Each individual loosening seemed fine in context. Re-read the boundary deliberately, not by accumulation.

## Prompt-shaped requirements

Writing specs as prompts and conflating intent with implementation. The agent now decides what the feature is. Specs go in tickets; prompts are a tool for executing them, not a substitute for naming what you wanted.

## Infinite-context dumps

Pasting the whole repository into context as a substitute for thinking about scope. The model will gamely produce something based on it. The result will be a confident hallucination shaped roughly like your codebase.

## Skill sprawl

Accumulating skills that nobody reviews, prunes, or removes. The fortieth skill named `some-domain-helper-v3` confuses routing for the sake of a clever idea three quarters ago. Skills earn their place; revisit them on a cadence.

## One-shot illusion

Treating one successful agent run as evidence that the workflow generalizes. The next ten tasks in the same shape will reveal the cases the first one happened to dodge. Trust the workflow only after it has survived its first ugly task.
