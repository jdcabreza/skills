---
name: intent
description: Derives what the user intends the change to do, and treats the code as how that intent is implemented. Use when reading an ask, choosing an approach, or when the request names a mechanism, a file, or a pattern.
disable-model-invocation: true
---

# Intent

All code is based on what users intend for it to do. The code itself is implementation detail. Derive the intent of the user's ask yourself, and work with that goal in mind.

The intent is one sentence: what the user wants to be true when the work is done. A file, a flag, or a pattern in the ask is a clue to that sentence.

## Do

1. Before you choose an approach or write code, write that sentence. Derive it from the ask and the code. Do not wait for the user to restate it.
2. Implement the intent. If a named mechanism is a worse way to make the intent true, use the better way.
3. If two intents fit the ask and they need different code, ask which one. Ask only then.
4. You are done when the change makes that sentence true, and the diff has no behavior the sentence does not need.

## Don't

- Code the words of the ask when those words miss the intent.
- Keep a structure because the current code already has it.
- Add behavior that sits next to the intent.

## Not this

- The user stated the exact shape to build. Build that shape.
- The intent and the ask are the same sentence, such as a typo or a rename. Do the edit.

## Example

Agent default: the ask says "add a cache", so you add a cache class and a TTL.

Do this: the user intends the order page to stay fast when the same order is opened again. You keep the result the page already loaded. You add a cache only if that is still too slow.
