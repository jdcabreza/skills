---
name: propose
description: Spawns two explorers that each generate proposals for an ask, then acts as intermediary between them and returns the consolidated paths. A proposal is a hypothesis with pros, cons, and proof. It does not write code or a prototype. Use when the user invokes /propose, or when they ask for proposals, paths, or hypotheses before any code.
disable-model-invocation: true
---

# Propose

Two explorers generate proposals. You are the intermediary. You consolidate and show the paths. A proposal is a hypothesis, its pros, its cons, and the proof that it could work. Do not write code to try it.

## Do this

1. Write the ask as one sentence. That sentence is what the user wants to be true. If two asks need different proposals, ask which ask before you spawn explorers.
2. Read `~/.cursor/rules/nmode-models.mdc`. Use the first two entries from the `grill reviewers` list. If that file is missing, or the list has fewer than two entries, use `claude-opus-5-5-medium` and `grok-4.7-high`. For `inherit-parent` or `auto`, omit `model`. Set `subagent_type` to `generalPurpose`. Spawn both explorers in one message. Give them the same prompt. The prompt contains the intent and the explorer return shape below, and it says explore the product and the nearby code, do not edit files, and do not write a prototype. If Task rejects a slug, use the closest allowed slug of that family from the error, say so, and continue.
3. Intermediary pass. Resume each explorer with the other explorer's return. Ask each one to revise against that material. They may keep a proposal, merge two that are the same path, drop one whose proof fails, or challenge one that still holds. They may not invent a third explorer. They return the same shape.
4. Consolidate. Merge two descriptions of the same path. Keep a disagreement as separate paths when both still hold. Drop a proposal both explorers abandoned. Cap the list at two or three paths for the user.
5. Reply with the Paths format below. Ask which path to take. Use the AskQuestion tool when it is available.
6. Stop. Write code only after the user picks a path.

### Explorer return

### Intent

> [the sentence from step 1]

### Proposals

For each proposal:

- Hypothesis. What we would do, and what has to be true for it to work.
- Pros. What this path buys.
- Cons. Where it breaks, costs, or depends on something unproven.
- Proof. A constraint in this product, a behavior it already has, or a comparable path that already works. Point at the file or the path. A guess is not proof.

### Paths

### Intent

> [the sentence from step 1]

### Explorers

- Explorer [label]: [model], [N proposals after the intermediary pass]

### Paths

For each path: the revised hypothesis, pros, cons, and proof. Name who raised it and who challenged it.

### Agreement

Where the explorers agreed, where they diverged, and what that pattern says.

### Recommendation

The path you would take, and why. One path.

## Don't

- Write the proposals yourself instead of the explorers.
- Skip the intermediary pass.
- Give the explorers different prompts on the first spawn.
- Prototype in code.
- Treat a guess as proof.
- Paste the raw explorer threads into the reply.
- Add a fourth or fifth path to look thorough.
- Start building before the user picks.

## Not this

- The user already picked the path. Build that.
- A bugfix, or a change that already follows a pattern in the repo, when the user did not ask for proposals.
