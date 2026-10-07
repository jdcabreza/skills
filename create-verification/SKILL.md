---
name: create-verification
description: Asks how this repository is verified, then writes one project skill that runs a specific verification skill for each way. Use when the user asks to set up verification, add a way for agents to confirm this repo, or invokes /create-verification.
disable-model-invocation: true
---

# Create Verification

Ask the user how this repository is verified. Write one skill a model can call. That skill runs one specific skill for each way the user names.

A repo can have more than one way to verify it works.. The overarching skill is the call. Each specific skill is one check.

## Do

1. Read how this repo already runs and checks itself. README, start scripts, tests, and existing examples. Note only commands, paths, and checks those files state.
2. Ask the user for the context the repo does not hold: what this repo is, and what a correct change has to prove. Use the AskQuestion tool when it is available.
3. Ask how the user would verify this repository. Ask for every way. Show the commands you found and let the user keep, drop, or add ways. Do not write a skill before the user answers.
4. If an overarching verification skill already exists under `.cursor/skills/`, stop. Tell the user to follow this repo's verification maintenance skill. If that skill does not exist, tell the user to run `/create-verification-maintenance`. If the only verification file is `.cursor/skills/verify/SKILL.md` and it does not run specific skills, ask the user whether to replace it. That file is the old shape.
5. Write one specific skill per way the user confirmed, at `.cursor/skills/<name>/SKILL.md`. Name it for that way, in the user's words. Lowercase, hyphens, no abbreviation you invent.
6. Write one overarching skill at `.cursor/skills/<name>/SKILL.md`. Name it for this repo, in the user's words. It reads and follows every specific skill, in the order the user cares about, and stops when one fails. When a unit finishes, it runs every check, including a check that unit did not touch. That run is how an agent shows the repository still works.
7. Write every skill in the shape below. A command, path, credential, or expected result comes from the repo or from the user. Name an env var. Never write the secret value.
8. Omit `disable-model-invocation` on the overarching skill. Set `disable-model-invocation: true` on each specific skill. The overarching skill reads those files.
9. Show the user the overarching name, each specific name, and the check it runs. Ask the user to confirm any command or check that is still your guess. Then tell the user to run `/create-verification-maintenance`.

### Specific skill

```markdown
---
name: <way>
description: <What this one check proves.> Use when the overarching verification skill runs this check.
disable-model-invocation: true
---

# <Way>

<One sentence: the result this check proves.>

## Do

1. <Commands and inputs the user or the repo supplied.>
2. <The result that means this way passed.>
3. Show the output you just ran in the reply. That is the request and the response, the log, or the command output.

## Don't

- Invent a command, a path, a credential, or an expected result.
- Claim this check passed without the output you just ran.
- Write an HTML file, page, or report.

## Not this

- The command this skill names is gone. Stop and say so.
```

### Overarching skill

Repeat the read-and-follow step once per specific skill.

```markdown
---
name: <repo>
description: Verifies this repo still works by running every specific verification skill. Use when a unit of work is finished, before claiming the repo works, or when the user asks to verify it.
---

# <Repo>

Verify this repo still works by running each specific check. Run every check, including one this unit did not touch.

## Do

1. Read and follow `.cursor/skills/<way>/SKILL.md`.
2. Stop at the first check that fails. Report its output.
3. You are done when each check's output is in the reply.

## Don't

- Run one check and skip the rest.
- Add an HTML file, page, or report.

## Not this

- A docs-only change. Say that there is nothing to run.
```

The bracket text is for you. The files you write contain the user's commands and names.

## Don't

- Invent a way the user did not name.
- Limit the checks to a backend, an HTTP call, or a test suite.
- Fold the checks into the overarching skill and skip the specific skills.
- Leave a placeholder, a sample port, or a made-up expected body.
- Write a second overarching skill.

## Not this

- The user wants to update verification skills that already exist. That update belongs to this repo's verification maintenance skill.
- The user has not answered how they would verify it. Ask. Write nothing yet.

## Example

The user says they verify this shop by calling the health endpoint and by posting a checkout.

Write `verify-health` and `verify-checkout`. Health shows the command output. Checkout shows the request and the response. Neither writes HTML. Write `verify-shop`. It reads both skills and runs both. A model calls `verify-shop`.
