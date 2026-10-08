---
name: separate-writes
description: Gives each actor its own write target when two actors would write independent facts into one shared target. Use when two actors would write independent facts into one file, branch, key, or state. One shared fact keeps one owner.
disable-model-invocation: true
---

# Separate Writes

When two actors would write independent facts into one shared target, give each its own target.

## Do

1. Name the two writes. If they are one fact, stop. **Domain Facts** keeps one owner.
2. If they are independent facts, give each actor its own file, key, branch, or state.
3. Merge only where a reader needs both.
4. You are done when each actor writes a target it owns.

## Don't

- Split one fact into two copies.
- Add a lock when the writes did not need the same target.
- Use a comment or a convention as the only guard.

## Not this

- The same write can run twice. Follow **Idempotent**.
- One fact that two actors change. Follow **Domain Facts**. One owner.

## Example

Agent default: two workers write `lastIndexed` and `lastMetric` into one `state.json`, so you add a lock.

Do this: the facts are independent. Each worker writes its own file. A reader joins them.
