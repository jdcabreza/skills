---
name: user-first
description: Chooses the caller's experience over the easier implementation, at the API and at the class interface. Use when a design or code choice can push work, data, or complexity onto the user or the caller.
disable-model-invocation: true
---

# User First

Bias towards user delight over implementation convenience. This applies to API-level decisions (e.g., don't bomb users with large responses), class-level decisions (prefer shallow but deep interfaces).

The interface is shallow: few concepts, little for the caller to learn. The module is deep: it does the real work. The caller is the user of that surface. An end user, a client of an API, and the next caller of a class all count.

## Do

1. Name the caller of the surface you are changing.
2. Write the interaction they should have: what they pass, what they get back, what they never have to know.
3. Implement behind that interaction. If the convenient query, shape, or layer makes the caller filter, join, retry, or learn your internals, change the implementation.
4. Return what that interaction uses. Load the rest on the path that needs it.
5. Keep the class or module interface small. The caller does not assemble the steps, and does not see the storage shape, the internal flags, or the partial failures you found easier to pass through.
6. You are done when the caller can succeed without knowing how the work is done.

## Don't

- Add a parameter or a flag so you do not have to decide.
- Return the whole row, tree, or log because the query already loaded it.
- Expose an internal enum, a database column, or a wrapper error the caller must interpret.
- Split one user action across several calls because each call maps to one function you already have.

## Not this

- A private helper with one caller. That caller is not a user. Write the smallest code that does the work.
- The user stated the exact shape. Build that shape.

## Example

Agent default: `GET /orders` returns every line, note, and audit row. The screen drops most of them.

Do this: return the order summary the screen renders. Load lines on the order page and notes on the note page.
