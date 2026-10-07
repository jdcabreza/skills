---
name: verifiable-units
description: Splits work into small atomic units that can each be checked, committed, or merged on their own. Use when planning a change, starting work that touches more than one behavior, splitting commits or merge requests, or deciding how to land the work.
disable-model-invocation: true
---

# Verifiable Units

Sequence work into verifiable units (commits, MRs). Each unit must be atomic, small, and is verifiable. Iterative development over one big change.

A unit is one behavior a reviewer can check without the next unit. Atomic means the product still makes sense with that unit alone.

## Do

1. Before you edit, split the ask into units. Write one sentence for each: what it changes, and how you will tell it works.
2. If you cannot say that in one sentence, the unit is too big. Split it.
3. Finish one unit and follow Prove It before you start the next.
4. Keep a rename, a move, or a cleanup out of a behavior unit. Give it its own unit, and only if it is still needed after the behavior change.
5. When the user asks to commit or open a merge request, one unit is one commit or one merge request.
6. You are done with a unit when Prove It has run.

## Don't

- Mix a refactor, a behavior change, and a drive-by cleanup in one unit.
- Start the next unit while the current one is unverified.
- Split one behavior so the first unit is broken and only the stack of units works.
- Create a commit or a merge request the user did not ask for.

## Not this

- A change that is already one sentence and one check. Do that change. Do not invent extra units.
- The user asked to land the current work as it stands. Land it. Slice the next piece of work, not the history the user asked you to keep.

## Example

Agent default: one change renames the module, changes the rule, and rewrites the tests.

Do this: the first unit changes the rule. Prove It runs before the next unit. The check that rule can affect passes, and the new rule works. The rename is a later unit, and only if it is still needed.
