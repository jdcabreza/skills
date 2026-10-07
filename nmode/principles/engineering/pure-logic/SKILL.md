---
name: pure-logic
description: Keeps business rules in pure functions and in a typed domain model, separate from I/O and transformation. Use when writing domain rules, pricing, permissions, eligibility, or lifecycle, or when I/O and rules are in the same function.
disable-model-invocation: true
---

# Pure Logic

Keep business logic in pure functions. Model the domain in a structure (typed model, etc.) instead of relying on conditionals. Separate I/O, transformation, etc. from business logic.

A business rule decides money, permission, eligibility, status, or another domain fact. Pure means the function takes values and returns values. The clock, the network, the database, and randomness stay outside. Pass in a timestamp or a random value when the rule needs one.

## Do

1. Name the rule and the domain values it needs.
2. Put the rule in a function that does not read or write the outside world.
3. Represent the domain as data. A state, a variant, or a typed model holds the fact. A chain of conditions scattered through a handler does not.
4. Keep three steps apart when all three exist: I/O loads or saves, a mapper turns the outside shape into the model and back, the rule runs on the model.
5. When a new conditional encodes a domain fact, add that fact to the model and branch on the model in one place.
6. You are done when the rule can run in a test with no sockets, no files, and no database.

## Don't

- Put the rule in the route handler, the component, the job body, or the query.
- Let the rule fetch what it needs.
- Encode the domain as flags and string modes checked in several files.
- Add a domain layer for a script that only renames a field and exits.

## Not this

- Glue that only loads and saves. That is I/O. Keep it in the handler.
- A one-off transformation with no domain rule. Keep it as the transformation. Do not invent a model for it.

## Example

Agent default: the handler loads the cart, applies the discount with three conditionals, and saves.

Do this: the handler loads the cart and maps it to a `Cart`. `discountedTotal(cart)` returns the total. The handler saves that total.
