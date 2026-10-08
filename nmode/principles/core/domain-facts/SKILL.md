---
name: domain-facts
description: Names actors, entities, types, data structures, and shared state, finds where this repo already places outside work, then reasons from those facts. Use when choosing an approach, designing how something works, introducing a type, entity, or shared state, or placing a load, save, client call, or other outside work.
disable-model-invocation: true
---

# Domain Facts

Name the actors, the entities, the types, and the shared state. Find where this repo already places this kind of outside work. Then reason from those facts.

Shared-state owner and placement owner are different. Shared state is the one place that owns a fact two actors can change. Placement is where this repo already puts this kind of outside work.

## Do

1. Before you settle an approach, take these from the code and from what the user stated:
   - Actors: who starts the work. A person, a job, a webhook, another service. A controller is not an actor.
   - Foundational entities: the nouns that already exist, such as an order or an account. A helper you might invent is not one.
   - Types and data structures: what each entity holds, and which combinations cannot exist.
   - Shared state: a fact two actors can change. Name the one place that owns it.
2. Resolve placement for any new outside work. Precedence: confirmed Conventions in `AGENTS.md`, then Feature map paths, then one nearby path in the code that already does comparable outside work. If those disagree, ask. Do not invent a placement owner.
3. Put the new outside work on that placement owner. When Conventions name a repository, store, hook, service, or other home, that confirmed name is evidence. Follow it.
4. Solve from those facts. Pick the smallest design that uses them.
5. If a fact is missing and you cannot point to it in the code, ask the user. Do not invent the shared-state owner, the placement owner, the lifecycle, or a new noun.
6. On a local edit inside a design that already has these facts, name only the entity you reuse or add, and reuse the placement owner already in play.
7. You are done when the approach follows from those facts, new outside work sits on the placement owner, and a new entity exists only because no current one can hold the fact.

## Don't

- Start from a pattern name (repository, saga, queue, hook, store) with no evidence and pour the problem into it.
- Copy a nearby feature before naming what this feature is.
- Add a second copy of a fact that already has a shared-state owner.
- Treat the shared-state owner as the placement owner when Conventions or the nearby path put the outside work elsewhere.

## Not this

- A typo, a rename, or a one-line fix inside an entity that is already named. Do the edit.

## Example

Agent default: this looks like a job for a queue and a worker, so you add both.

Do this: one actor creates an order. The order is one record. Nothing else reads it yet. You write the record. You add a queue when a second actor must do work later.

Agent default: the ask is to pull models from object storage, so you invent a puller beside business logic.

Do this: Conventions or a nearby path already name where outside loads live. You put the load there. You ask only when no placement owner exists.
