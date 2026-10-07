---
name: create-verification-maintenance
description: Writes the project skill or skills that keep this repo's verification skills true as the repo changes. Use when verification skills exist and the user wants them kept current, or when the user invokes /create-verification-maintenance.
disable-model-invocation: true
---

# Create Verification Maintenance

Write the skill that keeps this repo's verification skills true. Maintenance differs by repo. Derive the steps from how this repo is verified.

The verification skills already say what a check is. This skill writes the procedure that edits them when the repo changes.

## Do

1. Read `.cursor/skills/` and find the overarching verification skill and the specific skills it runs. If there is no overarching verification skill, stop. Tell the user to run `/create-verification` first.
2. Ask which changes would make those skills wrong, and how he would update them. Use the AskQuestion tool when it is available.
3. Write one maintenance skill when those ways share one update procedure. Write a set when the procedures do not share steps. When you write a set, also write one skill that runs the set, so a model has one call.
4. Put each skill at `.cursor/skills/<name>/SKILL.md`. Name it for what it maintains, in his words.
5. The maintenance skill edits verification skills. It reads his description of the change and the diff. It edits the specific skill that change made wrong. It adds or removes a specific skill when he adds or drops a way, and updates the list in the overarching skill. It asks only for a gap it cannot point to in the repo or the current skill. It names an env var and never writes the secret.
6. Use the shape below. Omit `disable-model-invocation` on the skill a model should call. Set `disable-model-invocation: true` on a specific maintenance skill that the overarching one runs.
7. If a verification maintenance skill already exists for this repo, stop. Tell him to follow that skill.
8. Show him each maintenance skill name and which verification skills it edits. Ask him to confirm any step that is still your guess.

### Maintenance skill

```markdown
---
name: <maintainer>
description: Updates this repo's verification skills when a change makes them wrong. Use when a verification command, expected result, or way of verifying changes, or when the user asks to update verification.
---

# <Maintainer>

<One sentence: what this skill keeps true for this repo.>

## Do

1. Read the overarching verification skill and the specific skills it names.
2. Read the change: the user's description and the diff.
3. Edit the specific skill that change made wrong. Leave every other check as written.
4. Add or remove a specific skill when he adds or drops a way, and update the list in the overarching skill.
5. Ask only for a gap you cannot point to in the repo or the current skill. Use the AskQuestion tool when it is available.
6. Show him what changed in those skills.

## Don't

- Edit a check the change did not touch.
- Invent a command, a path, a credential, or an expected result.
- Write a secret value. Name the env var.
- Write an HTML file, page, or report to show a check's result.

## Not this

- The verification skills are already right for this change. Say so.
```

When the procedures do not share steps, each specific maintenance skill owns one procedure. The overarching maintenance skill reads the change, follows the specific maintainer that change affects, and updates the overarching verification skill when the set of ways changes.

The bracket text is for you. The files you write contain his steps and his names.

## Don't

- Update the verification skills in this step. Write the maintainer.
- Copy another repo's maintenance steps into this one.
- Invent a maintenance step he did not describe and the verification skills do not imply.
- Leave a placeholder.

## Not this

- This repo has no verification skills yet. Tell him to run `/create-verification`.
- He asked to verify the repo now. Follow the overarching verification skill.

## Example

`verify-shop` runs `verify-health` and `verify-checkout`. The user says a change that touches a check is the same kind of edit: update that check, and update `verify-shop` only when a way was added or removed.

Write `maintain-shop-verification`. It does that edit.

He says a route change and a screen change are updated by different steps. Write `maintain-health-verification` and `maintain-checkout-verification`. Write `maintain-shop-verification`. A model calls `maintain-shop-verification`, and it runs the maintainer the change affects.
