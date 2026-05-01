# Engineering Principles

## Default stance

Build systems that are understandable, testable, observable, secure, and changeable.

Prefer boring clarity over fashionable complexity. A system that the team can reason about at 02:00 is more valuable than an architecture diagram that takes three meetings to interpret.

## Principles

- Prefer simple designs until complexity is justified.
- Make boundaries explicit.
- Optimize for maintainability before cleverness.
- Use dependency injection or explicit configuration where appropriate.
- Fail fast with meaningful errors.
- Avoid silent catches and hidden side effects.
- Treat security and observability as design requirements, not post-launch decorations.
- Never hard-code secrets.
- Keep tests runnable, relevant, and close to the behavior they protect.
- Document trade-offs where future maintainers will need context.

## AI-assisted development rule

AI can accelerate implementation, review, test generation, and exploration. It must not replace engineering judgment, source verification, threat modeling, or ownership of final decisions.
