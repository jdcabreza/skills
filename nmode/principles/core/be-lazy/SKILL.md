---
name: be-lazy
description: Deletes and simplifies first, then gets the most impact from the least code, call depth, and machinery. Use when writing or editing code, adding behavior, adding a file, type, or wrapper, or when the current code already does more than the ask needs.
disable-model-invocation: true
---

# Be Lazy

Delete what the ask makes dead. Then make the smallest change that still does the job. Fewer lines is better than elegant boilerplate. If a human finds the code exhausting to maintain, or has to hold a lot of context, it is bad code.

A plain line that shows the logic is the impact. A shorter clever line is not. A new file, type, or wrapper is a cost. Pay it only when the change is worse without it.

## Do

1. Read the code the ask touches. Mark what the ask makes dead, duplicate, or more specific than it needs to be.
2. Make the first edit a deletion or a simplification of that code. If removing a condition meets the ask, remove it and stop.
3. Edit the code that already does this job. Add only the behavior that is still missing. Touch only the lines the task needs.
4. Keep one path. The old behavior and the new behavior do not live behind a switch.
5. Inline a function that only forwards arguments, renames them, or returns the call. If two layers each add no decision, collapse them.
6. Stop when a reader can hold the change in their head. If they must remember a framework, a config surface, or a chain of wrappers, the change is too big.
7. You are done when the diff adds only what the simplified code still could not do, and removing another line would remove behavior the task asked for.

## Don't

- Add a branch beside the old branch.
- Leave the old path "in case", commented out, or behind a flag.
- Write a new function that special-cases around code you should have changed.
- Add compatibility code for a caller this change is allowed to update.
- Add a service, factory, mapper, or interface for one call site.
- Add a seam "for later": strategy, plugin, options object, or feature flag.
- Refactor code the task does not touch.
- Split one decision across several files so each file looks small.

## Not this

- Code the ask does not touch. Leave it.
- Behavior the user still needs. Deleting it is not simplifying. Ask if you cannot tell.
- A type, a boundary parse, a pure rule, a reproduction, or a proof that **Types**, **Pure Logic**, **Root Cause**, or **Prove It** requires. Those lines are the impact. Laziness cuts the extra structure around them.
- A readable branch. Do not compress it into a clever expression to save lines. That is **Descriptive Code**.

## Example

Agent default: archived orders must be skipped, so you add `if not archived` beside the three filters already there, inside a new `OrderService`.

Do this: delete the two filters the new rule replaces. The handler calls the query and returns the orders.
