---
name: setup-nstack
description: >-
  Install nstack for Cursor and Claude Code and configure which models it
  uses per role. Links skills and the nathan-agent subagent into ~/.claude,
  installs the always-on nstack-discipline rule, detects available models,
  and writes the models file nathan-mode reads. Use for
  /setup-nstack, "configure nstack models", or first-time nstack setup.
disable-model-invocation: true
---

# Setup nstack

Install nstack and write the models file for the harness you are running in. Terms and paths per harness are in the **harness terms** table in `../nathan-mode/SKILL.md`. `/nathan-mode` hard-requires `~/.claude/agents/nathan-agent.md` and the models file before spawning workers or reading role models. The nstack-discipline rule keeps sureness labels and principles on in every chat without re-inlining `nathan-mode`.

Run this skill once in each harness you use. Each harness keeps its own models file because their slugs differ.

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
| `design-judge` | synthesizes the design panel into one proposal | judgement |
| `write` | writer agent for docs and plan prose | judgement |
| `write-review` | reviewer agent. reads the draft through the audience lens | judgement |

`unslop`, `huh`, `sequence-changes`, and `open-pr` are parent-only, in-process skills. They have no setup model role and never get a subagent spawn. They run on the parent chat model (`/nathan-mode` chat).

Optional step lines per model role (not for `design-count`): `role+1`, `role+2`, `role-1`, `role-2`. nathan-mode uses these as one/two-step raise and lower. Write full slugs the user confirmed from the detected set. Omit a step line when no distinct slug exists.

Defaults when the user accepts them without edits:

| | Cursor | Claude Code |
| --- | --- | --- |
| code | `grok-4.7-medium`, `+1` `grok-4.7-high` | `sonnet`, `+1` `opus`, `-1` `haiku` |
| judgement | `grok-4.7-high` | `inherit-parent` |
| `design-count` | `2` | `2` |

Never write a `fast` slug. nathan-mode forbids fast mode. If the only available slug for a default is a `fast` variant, stop and ask the user to pick from the detected set. Never write a `max` slug into a step line.

## Steps

### 1. Install

Run `install.sh` at this repository's root (the parent directory of `setup-nstack/`). It symlinks every skill and `agents/nathan-agent.md` into `~/.claude`, which both harnesses read. It copies `templates/nstack-discipline.md` to `~/.claude/rules/nstack-discipline.md` for Claude Code and, when `~/.cursor` exists, to `~/.cursor/rules/nstack-discipline.mdc` for Cursor. It is idempotent. Report any `skip:` or `warn:` lines to the user.

### 2. Detect available models

Enumerate the model values you can pass to a subagent spawn in this session. That is the dependable source. In Claude Code these are the `Agent` tool's `model` options. If you cannot detect any, ask the user to paste the slugs they have access to. Never write a real slug you have not confirmed is available. The aliases `inherit-parent` and `auto` are always valid even though they are not detected slugs.

### 3. Load current state

If this harness's models file already exists, read it and treat its role values as the current choices. Otherwise start from this harness's defaults above. Drop any role line not in the Roles table and any step line whose base role is gone. Keep `design-count` as `2` or `3` only.

### 4. Map and confirm

Show every role with its proposed value. For model roles, also show proposed `+1` / `-1` step slugs when a distinct detected slug exists one notch away on the same family. Mark any real slug not in the detected set as needing a choice. Ask whether to accept as-is or change specific roles, panel size, or step lines. Offer the detected models plus `inherit-parent` and `auto` (both mean: this role runs on the parent chat model; omit `model`). Prefer a structured question over free text.

If a default slug is missing from the detected set, do not silently substitute a `fast` variant. Ask the user to pick.

### 5. Validate

Every real slug written must be in the detected set. `inherit-parent` and `auto` always pass. `design-count` must be `2` or `3`. If `design-count` is `2`, `design-3` may be omitted. If a chosen real slug is not available, stop and ask again. Reject any `fast` or `max` slug.

### 6. Write the models file

Write this harness's models file with one line per role (plus any confirmed step lines). Overwrite the whole file so re-runs stay idempotent. Shape:

```
# nstack model configuration. One line per role from the Roles table. Keep every required role present; re-run /setup-nstack to change values.
# `inherit-parent` or `auto` as a value: the role runs on the parent chat model (omit `model`).
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
design-judge: grok-4.7-high
write: grok-4.7-high
write-review: grok-4.7-high
```

Replace the slug values with the confirmed choices from step 4. Include `design-3` only when `design-count` is `3`. Include step lines only when confirmed.

### 7. Confirm

Tell the user the models file path, the role table that was written, where `nathan-agent` was linked, and where the discipline rule was copied. Tell them to restart the harness (Cursor: Developer: Reload Window. Claude Code: restart the session.) New skills and `nathan-agent` load after the restart. Re-running this skill refreshes both the links and the models file.

### Cost profile (tell the user)

After setup, lean tiers are fine. Prefer fewer judgement spawns and fresh chats over downgrading implement further. Use `inherit-parent` / `auto` for `write-review` only when you still run it (long docs). Routine MRs skip `write-review` per lite `open-pr`. Savings come from volume (delegation, no skill re-inline, lite open-pr), not from skipping verify. Never suggest `fast` or `max`.
