---
name: never-block
description: Proceeds on a reversible choice and shows the result, instead of waiting for permission. Use when about to ask "should I do X?", or when the human could course-correct after seeing the result.
disable-model-invocation: true
---

# Never Block

Never block on the human. If you want to ask "should I do X?", check if it is reversible. If it is reversible, proceed, present the result, and let the human course-correct.

## Do

1. When you are about to ask whether to do something, check whether the action is reversible.
2. Reversible means the human can undo it, or tell you to undo it, after seeing the result. A local edit, a draft, a name, a default.
3. If it is reversible, do it. Present the result. Name the choice in one sentence.
4. If it is not reversible, ask before you do it. A push, a delete of their data, a sent message, a spend, or a public post.
5. You are done when a reversible choice is done and visible, or an irreversible choice is waiting on the human.

## Don't

- Ask "should I do X?" when doing X and showing it is reversible.
- Stop the task to confirm a default the human can change after seeing it.
- Hide the choice. Course-correction needs the result in front of them.

## Not this

- Two intents that need different code. Ask which one. That question decides the change.
- An assumption you cannot check, and that changes the design. Ask that one.
- The human already said no, or said to ask first. Stop.

## Example

Agent default: "Should I name the field `status` or `state`?"

Do this: you use `status` and show the result. The user can rename it.
