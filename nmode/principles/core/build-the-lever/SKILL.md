---
name: build-the-lever
description: Writes the smallest script that performs the same edit in many places. Use when the same edit would be made in many places. A one-off edit and a check stay out.
disable-model-invocation: true
---

# Build the Lever

When the same edit would be made in many places, write the smallest script that performs that edit.

## Do

1. Confirm the edit is the same change in many places. One site is not this.
2. Do one site by hand so the script has a recipe.
3. Write the smallest script that performs that edit on the rest.
4. Run the script on the site you did by hand. The diff matches.
5. You are done when the script is in the diff and the other sites came from that run.

## Don't

- Write a script for one site.
- Write a script whose only job is the check.
- Build a framework around one edit.

## Not this

- One edit. Follow **Be Lazy** and make the edit.
- A check the repo runs. Follow **Prove It**.

## Example

Agent default: the same field rename hits forty call sites, so you edit them by hand.

Do this: you rename one site, then a script renames the rest. You run it on the first site and the diff matches.
