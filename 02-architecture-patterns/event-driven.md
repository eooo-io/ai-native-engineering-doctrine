# Event-Driven Design

## Intent

Use events to decouple workflows, preserve auditability, and react to domain changes without tightly binding producers and consumers.

## Use when

- Multiple parts of the system must react to a business fact.
- Work can happen asynchronously.
- Audit trails or integration boundaries matter.
- Coupling through direct service calls would become brittle.

## Guardrails

- Events should describe facts that already happened.
- Event names should be past-tense and domain-oriented.
- Consumers must be idempotent.
- Retries must be bounded and observable.
- Poison messages need handling.
- Event schemas require versioning once externally consumed.

## Anti-patterns

- Using events to hide unclear ownership.
- Turning every method call into a message.
- Ignoring ordering, retries, and duplicate delivery.
