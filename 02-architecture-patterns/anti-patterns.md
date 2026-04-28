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
