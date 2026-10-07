---
name: design-options
description: Presents 2-3 evidenced ideas and no code when an interaction or solution has no precedent. Use when brainstorming something new, when the repo has no pattern for this interaction, or before inventing a new kind of UI or flow.
disable-model-invocation: true
---

# Design Options

Given a novel interaction, solution, etc. with no precedent, show the user 2-3 ideas that might work, along with evidence. Don't write code here.

Precedent means this repo, or a pattern the user already uses, already does this kind of interaction. A common pattern in the industry is not precedent here.

## Do

1. Look for a precedent before you design. Search the product and the nearby code.
2. If you find one, follow it. This principle does not apply.
3. If you do not, stop coding. Do not scaffold, spike, or draft the diff.
4. Show two or three ideas. For each one, say what the user does, what has to be true for it to work, and the evidence. Evidence is a constraint in this product, a behavior it already has, or a comparable path that already works. A guess about taste is not evidence.
5. Ask the user which idea to build. Use the AskQuestion tool when it is available.
6. You are done when the user has a choice, and you have written no code for it.

## Don't

- Present one idea as the answer.
- List options with no evidence.
- Add a fourth or fifth idea to look thorough.
- Start the implementation "so we can see it" before the user picks.

## Not this

- A bugfix, a change that follows a pattern already in the repo, or an approach the user already picked. Build that.
- A small decision inside a design the user already chose, such as a name or a field. Decide and move.
- The user asked for proposals, paths, or hypotheses. Read `../../../../propose/SKILL.md` and follow it. This principle does not apply.

## Example

Agent default: the product has never moved a card, and you implement a drag-and-drop board because boards usually work that way.

Do this: you stop. You show two ways a person could move a card. Each one cites a constraint or a path this product already has. You wait.
