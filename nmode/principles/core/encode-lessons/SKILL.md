---
name: encode-lessons
description: Turns a repeated line or instruction into a lint, check, or script. Use when you are about to write the same line, comment, or instruction again, or when more text would restate a rule a check can enforce.
disable-model-invocation: true
---

# Encode Lessons

If you catch yourself writing the same line or instruction more than once, that is a sign it should be a lint, a check, or a script, instead of more text.

## Do

1. When you are about to write a line, a comment, or an instruction you already wrote, stop.
2. Name the lesson. That is the mistake the repeated text is trying to prevent.
3. Put the lesson in the nearest thing that runs without a reader. A lint, a check, or a script.
4. Delete the repeated text that mechanism now makes unnecessary.
5. You are done when the lesson fires on its own, and the text that restated it is gone.

## Don't

- Add another copy of the instruction in a doc, a comment, or a skill.
- Leave the repeated line and also add the check.
- Build the mechanism the first time you write the line. Repetition is the sign.

## Not this

- A why or a gotcha that only this site has. A comment there is enough. Do not build a lint for one site.
- A judgement that changes with the task. A script cannot hold it. Leave it as a principle.

## Example

Agent default: you add "do not log the token" to the skill, the README, and a comment above the logger.

Do this: a check fails when the logger is called with a token. The extra sentences are gone.
