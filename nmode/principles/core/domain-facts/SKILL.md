---
name: domain-facts
description: Names actors, entities, types, data structures, and shared state, then reasons from those facts. Use when choosing an approach, designing how something works, or introducing a type, entity, or shared state.
disable-model-invocation: true
---

# Domain Facts

Name the actors, the entities, the types, and the shared state. Then reason from those facts.

## Do

1. Before you settle an approach, take these from the code and from what the user stated:
   - Actors: who starts the work. A person, a job, a webhook, another service. A controller is not an actor.
   - Foundational entities: the nouns that already exist, such as an order or an account. A helper you might invent is not one.
   - Types and data structures: what each entity holds, and which combinations cannot exist.
   - Shared state: a fact two actors can change. Name the one place that owns it.
2. Solve from those facts. Pick the smallest design that uses them.
3. If a fact is missing and you cannot point to it in the code, ask the user. Do not invent the owner, the lifecycle, or a new noun.
4. On a local edit inside a design that already has these facts, name only the entity you reuse or add.
5. You are done when the approach follows from those facts, and a new entity exists only because no current one can hold the fact.

## Don't

- Start from a pattern name (repository, saga, queue, hook, store) and pour the problem into it.
- Copy a nearby feature before naming what this feature is.
- Add a second copy of a fact that already has an owner.

## Not this

- A typo, a rename, or a one-line fix inside an entity that is already named. Do the edit.

## Example

Agent default: this looks like a job for a queue and a worker, so you add both.

Do this: one actor creates an order. The order is one record. Nothing else reads it yet. You write the record. You add a queue when a second actor must do work later.
