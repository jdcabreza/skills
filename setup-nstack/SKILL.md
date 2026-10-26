---
name: setup-nstack
description: >-
  Configure which models nstack uses per role, and install the nathan-agent
  subagent for local use. Detects available models, writes an always-applied
  rule that nathan-mode reads, and copies agents/nathan-agent.md to
  ~/.cursor/agents/. Use for /setup-nstack, "configure nstack models", or
  first-time nstack setup.
disable-model-invocation: true
---

# Setup nstack

Write `~/.cursor/rules/nstack-models.mdc`, an always-applied rule that sets nstack's model per role. Install `nathan-agent` for Option 1 local discovery (no marketplace). `/nathan-mode` hard-requires both files before spawning workers or reading role models.

## Roles

Derived from `nathan-mode` Subagents lines and every playbook model call site. Code roles default to the code model. Judgement and prose roles default to the judgement model.

| role | used by | default tier |
| --- | --- | --- |
| `implement` | implement playbook code delegates; orchestrate workers for implement-shaped boxes | code |
| `refactor` | refactor playbook code delegates | code |
| `bugfix` | bugfix playbook code delegates | code |
| `orchestrate` | coordinator agent that babysits a big-changes plan | judgement |
| `how` | investigate, and how/why steps in other playbooks | judgement |
| `why` | investigate when motivation/intent is asked; how/why steps elsewhere | judgement |
| `design-count` | how many parallel design agents to spawn. value `2` or `3` only | n/a |
| `design-1` | first design panel seat | judgement |
| `design-2` | second design panel seat | judgement |
| `design-3` | third design panel seat. unused when `design-count` is `2` | judgement |
| `write` | writer agent for docs and plan prose | judgement |
| `write-review` | reviewer agent. reads the draft through the audience lens | judgement |

`unslop`, `sequence-changes`, and `open-pr` are parent-only, in-process skills. They have no setup model role and never get a Task spawn. They run on the parent chat model (`/nathan-mode` chat).

Optional step lines per model role (not for `design-count`): `role+1`, `role+2`, `role-1`, `role-2`. nathan-mode uses these as one/two-step raise and lower. Write full slugs the user confirmed from the detected set. Omit a step line when no distinct slug exists.

Defaults when the user accepts them without edits:

- code: `grok-4.7-medium`
- judgement: `grok-4.7-high`
- `design-count`: `2`

Never write a `fast` slug. nathan-mode forbids fast mode. If the only available Grok slug is a `fast` variant, stop and ask the user to pick from the detected set. Never write a `max` slug into a step line.

## Steps

### 1. Detect available models

Enumerate the model slugs you can pass to a `Task` subagent in this session. That is the dependable source. If you cannot detect any, ask the user to paste the slugs they have access to. Never write a real slug you have not confirmed is available. The aliases `inherit-parent` and `auto` are always valid even though they are not detected slugs.

### 2. Load current state

If `~/.cursor/rules/nstack-models.mdc` already exists, read it and treat its role values as the current choices. Otherwise start from the defaults above. Drop any role line not in the Roles table and any step line whose base role is gone. Keep `design-count` as `2` or `3` only.

### 3. Map and confirm

Show every role with its proposed value. For model roles, also show proposed `+1` / `-1` step slugs when a distinct detected slug exists one notch away on the same family. Mark any real slug not in the detected set as needing a choice. Ask whether to accept as-is or change specific roles, panel size, or step lines. Offer the detected models plus `inherit-parent` and `auto` (both mean: this role runs on the parent chat model; omit Task `model`). Prefer a structured choice over free text when available.

If a default slug is missing from the detected set, do not silently substitute a `fast` variant. Ask the user to pick.

### 4. Validate

Every real slug written must be in the detected set. `inherit-parent` and `auto` always pass. `design-count` must be `2` or `3`. If `design-count` is `2`, `design-3` may be omitted. If a chosen real slug is not available, stop and ask again. Reject any `fast` or `max` slug.

### 5. Write the rule

Write `~/.cursor/rules/nstack-models.mdc` with `alwaysApply: true` and one line per role (plus any confirmed step lines). Overwrite the whole file so re-runs stay idempotent. Shape:

```
---
description: nstack per-role model choices (overrides skill defaults)
alwaysApply: true
---
# nstack model configuration. One line per role. Delete a line to fall back to the skill default.
# `inherit-parent` or `auto` as a value: the role runs on the parent chat model (omit Task `model`).
# optional `role+1` / `role+2` / `role-1` / `role-2`: full slugs for nathan-mode raise/lower steps.
# never use fast mode. never use max.
implement: grok-4.7-medium
implement+1: grok-4.7-high
refactor: grok-4.7-medium
refactor+1: grok-4.7-high
bugfix: grok-4.7-medium
bugfix+1: grok-4.7-high
orchestrate: grok-4.7-high
how: grok-4.7-high
why: grok-4.7-high
design-count: 2
design-1: grok-4.7-high
design-2: grok-4.7-high
write: grok-4.7-high
write-review: grok-4.7-high
```

Replace the slug values with the confirmed choices from step 3. Include `design-3` only when `design-count` is `3`. Include step lines only when confirmed.

### 6. Install nathan-agent

Copy this repository's `agents/nathan-agent.md` to `~/.cursor/agents/nathan-agent.md`.

Find the source by checking, in order:

1. `agents/nathan-agent.md` next to this skill's sibling `nathan-mode/` (same parent directory as `setup-nstack/` and `nathan-mode/`)
2. a path ending in `agents/nathan-agent.md` under `~/.cursor/skills/`
3. the same under `~/.cursor/plugins/`

If more than one plugin copy matches, use the copy whose `.cursor-plugin/plugin.json` has the highest `version`. If no source file exists, stop and tell the user. Create `~/.cursor/agents/` if needed. Overwrite an existing `nathan-agent.md` so re-runs stay idempotent.

Tell the user to reload the window (Developer: Reload Window) or start a new Agent chat so Task picks up `nathan-agent`.

### 7. Confirm

Tell the user the rule path, the role table that was written, and that `nathan-agent` was installed to `~/.cursor/agents/nathan-agent.md`. Note that the rule applies to new sessions. Re-running this skill updates both the rule and the agent file.
