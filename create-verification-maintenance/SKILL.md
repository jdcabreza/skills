---
name: create-verification-maintenance
description: Writes the project skill or skills that keep this repo's verification skills true as the repo changes. Indexes those skills in README Verification and points AGENTS.md at that section. Use when verification skills exist and the user wants them kept current, or when the user invokes /create-verification-maintenance.
disable-model-invocation: true
---

# Create Verification Maintenance

Write the skill that keeps this repo's verification skills true. Maintenance differs by repo. Derive the steps from how this repo is verified. Keep README Verification true. Keep AGENTS.md Verification as a pointer to that section.

The verification skills already say what a check is. This skill writes the procedure that edits them when the repo changes.

## Do

1. Read `.cursor/skills/` and find the overarching verification skill and the specific skills it runs. If there is no overarching verification skill, stop. Tell the user to run `/create-verification` first.
2. Ask which changes would make those skills wrong, and how the user would update them. Use the AskQuestion tool when it is available.
3. Write one maintenance skill when those ways share one update procedure. Write a set when the procedures do not share steps. When you write a set, also write one skill that runs the set, so a model has one call.
4. Put each skill at `.cursor/skills/<name>/SKILL.md`. Name it for what it maintains, in the user's words.
5. The maintenance skill edits verification skills. It reads the user's description of the change and the diff. It edits the specific skill that change made wrong. It adds or removes a specific skill when the user adds or drops a way, and updates the list in the overarching skill. It asks only for a gap it cannot point to in the repo or the current skill. It names an env var and never writes the secret.
6. Use the shape below. Omit `disable-model-invocation` on the skill a model should call. Set `disable-model-invocation: true` on a specific maintenance skill that the overarching one runs.
7. If a verification maintenance skill already exists for this repo, do not rewrite the verification skills. Tell the user to follow that skill. Still check README Verification and the AGENTS.md pointer. If README Verification is missing, or its skill list does not match the overarching verification skill's list, or AGENTS.md is missing the pointer or still holds a duplicated skill list, show the proposed README index and AGENTS pointer. Write them only after the user confirms. If the existing overarching maintainer lacks the docs-update steps in the template below, add those steps to that overarching maintainer only. Then stop.
8. Show the user each maintenance skill name, which verification skills it edits, the proposed README Verification index (with the Maintenance line naming only the overarching maintainer), and the AGENTS.md pointer. Ask the user to confirm any step that is still your guess. Write the docs only after that confirmation.
9. Write or replace `## Verification` in README using the README shape below. Leave every other README section alone. If README is missing, create a file that contains only that section. No Overview.
10. Write or replace `## Verification` in `AGENTS.md` using the AGENTS pointer shape below. Leave every other AGENTS section alone. If `AGENTS.md` is missing, create `# Agents` and that pointer section only. Do not invent Project facts or Practices. If AGENTS Verification still holds a duplicated skill list, replace it with the pointer.

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
4. Add or remove a specific skill when the user adds or drops a way, and update the list in the overarching skill.
5. Update README Verification when this change adds, removes, or renames a way, when the overarching name changes, or when a check's prove sentence changes. Keep AGENTS.md Verification as the pointer to README. Do not maintain a second skill list in AGENTS.md.
6. Ask only for a gap you cannot point to in the repo or the current skill. Use the AskQuestion tool when it is available.
7. Show the user what changed in those skills and in README Verification.

## Don't

- Edit a check the change did not touch.
- Invent a command, a path, a credential, or an expected result.
- Write a secret value. Name the env var.
- Write an HTML file, page, or report to show a check's result.
- Duplicate the skill list in AGENTS.md.

## Not this

- The verification skills are already right for this change. Say so.
```

When the procedures do not share steps, each specific maintenance skill owns one procedure. The overarching maintenance skill reads the change, follows the specific maintainer that change affects, and updates the overarching verification skill when the set of ways changes. Only the overarching maintainer updates README Verification and keeps the AGENTS pointer. Specific maintainers do not own those sections.

### README Verification

One-line "what this check proves" comes from that specific skill's opening sentence. Do not invent it. Do not put a command, path, credential, or secret value in this section. Name an env var if needed. Name only the overarching maintainer in the Maintenance line when a set exists.

```markdown
## Verification

Ask the agent to run `<overarching>` after a unit of work, or before claiming the repo works. After a unit, the agent runs the specific checks that unit can affect. Before claiming the repo works, it runs `<overarching>` so every check runs.

- `<overarching>`: runs every check below, stops on the first failure. Skill: `.cursor/skills/<overarching>/SKILL.md`
- `<way>`: <one sentence from that specific skill>. Skill: `.cursor/skills/<way>/SKILL.md`

Maintenance: ask the agent to run `<maintainer>` when a change makes a check wrong. Skill: `.cursor/skills/<maintainer>/SKILL.md`.
```

### AGENTS.md Verification

```markdown
## Verification

Skill names, when to run them, and maintenance live in `README.md` under Verification. Follow that section. Do not keep a second copy of the list here.
```

The bracket text is for you. The files you write contain the user's steps and names.

## Don't

- Update the verification skills in this step. Write the maintainer.
- Copy another repo's maintenance steps into this one.
- Invent a maintenance step the user did not describe and the verification skills do not imply.
- Leave a placeholder.
- Write README or AGENTS Verification before the user confirms.
- Invent a prove sentence for the README index.
- Put a command, path, credential, or secret value in README Verification.
- Duplicate the skill list in AGENTS.md.
- Have a specific maintainer own the README or AGENTS sections.

## Not this

- This repo has no verification skills yet. Tell the user to run `/create-verification`.
- The user asked to verify the repo now. Follow the overarching verification skill.
- A maintainer already exists. Still backfill README Verification and the AGENTS pointer when those docs are missing or stale, and add the docs-update steps to the overarching maintainer when they are missing.

## Example

`verify-shop` runs `verify-health` and `verify-checkout`. The user says a change that touches a check is the same kind of edit: update that check, and update `verify-shop` only when a way was added or removed.

Write `maintain-shop-verification`. It does that edit. After confirm, README Verification lists the three verification skills and names `maintain-shop-verification` on the Maintenance line. AGENTS.md Verification points at that README section.

The user says a route change and a screen change are updated by different steps. Write `maintain-health-verification` and `maintain-checkout-verification`. Write `maintain-shop-verification`. A model calls `maintain-shop-verification`, and it runs the maintainer the change affects. Only `maintain-shop-verification` updates README Verification and keeps the AGENTS pointer.
