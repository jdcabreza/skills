# Big Changes

**You own the plan, not the code. The plan is an auditable checklist that an owner runs box-by-box. Humans verify the plan and progress using evidence.** The plan is the deliverable. Do not implement. **orchestrate** runs the approved plan later.

Use this when the ask is too large for one playbook (many asks, stacked work) or when a change that looked small has a large blast radius and needs a safer multi-step plan. Brainstorming architectures or approaches belongs to the **design** skill, not this playbook.

1. When the change is 1-2 files with an obvious approach, skip the plan. Say so and re-route to the appropriate playbook.
2. Ask the user for context surrounding the changes (who asked, why needed, what triggered). Determine a rough ordering of todos/PRs that we can route to the smaller playbooks, broken down from the bigger ask. For each todo, run the **how** and **why** skills over the relevant code surface. Return to the user your understanding of the ask, the current behavior, intended impact, context, and rough list of todos (with justification) for user verification.
3. Copy the skeleton below into the plan file and fill up. Use `agent_space/` if existing, otherwise use `docs/`. Keep every heading and sub-block in the order shown.
4. For each rough todo/PR from step 2, dry-run the matching playbook into the plan only. Fill that PR's Context (include **Implications**), Changes, Alternatives, Risks, Verification, and Boxes. **Verification** must list concrete commands: repo verify skills and/or gitignored `agent_space/` scripts, plus what pass looks like. Each box’s evidence must map to a checklist item under Verification. You may run **how**, **why**, **design**, and **write** (then **unslop**) as those playbooks would for planning. Do not create a branch, spawn a code `nathan-agent`, edit product code, commit, run **sequence-changes**, or run **open-pr**. Those steps belong to a later **orchestrate** or playbook run on an approved box. Work with the human to determine scope, context, and verification. Return the artifact for verification. Move on to the next todo/PR when approved.
5. Link the plan file to the user for final review. When they approve the plan, run the **orchestrate gate** below. Do not start **orchestrate** until they answer.

**Orchestrate gate**. After plan approval, ask whether to continue **orchestrate** in this chat or start a fresh chat with only the plan. Prefer a fresh chat when planning burned a lot of context. You cannot open a new chat yourself.

- Same chat: run **orchestrate** on the plan path in this conversation.
- Fresh chat: end this turn. Tell them to open a new Agent chat in the same workspace and send a message like `/nathan-mode orchestrate` plus the absolute plan path. Do not keep babysitting here.

**Verification**. Tests alone are not sufficient verification. A PR is only verified when unit tests pass, lints and formatting pass, and behavior is as-intended.

```
# Plan: <name-for-your-plan>

## How to read this

One PR section is one landable unit. Boxes under a PR are the ordered worker steps that finish that unit.
A nested box is a sub-step of the box above it.
Mark a box `(parallel)` only when it may run alongside sibling `(parallel)` boxes under the same PR.
Check a box only when its evidence exists: a file, a log line, a screenshot, a test run.
Flip **Ready to land** to yes only when every box under that PR is checked and **Proof** is filled.
The body is a how-to.
Appendices explain and record.
**Coordinator Notes** is plan-wide. **orchestrate** owns that section and the Ready/Proof/box checkmarks. This file is not an implementation.

Each box should be runnable by the playbooks within `nathan-mode`. Prefer **implement**, **bugfix**, or **refactor** for code PRs. Use **document** or **authoring a skill** only when that PR is docs or skill work; **orchestrate** escalates those shapes to the parent instead of spawning code workers.

Tests alone are not sufficient verification. A PR is only verified when unit tests pass, lints and formatting pass, and behavior is as-intended.

## PRs

### <Task as a verb phrase> (<PR id>)

**Depends on:** <PR id, or None.>

**Playbook:** <implement | bugfix | refactor | document | authoring a skill>

**Branch:** <feature/<name> or bugfix/<name>. one branch per PR. if Depends on is set, base this branch on that PR's branch tip.>

**Context**

<context surrounding the change. intent, intended behavior, why it's being made.>

**Implications:** <prod, ops, data, compliance, consumers, blast radius.>

**Changes**

<changes to be made. each change should correspond to a visible artifact, e.g., a log line or response change.>

**Alternatives Considered**

<alternative changes considered, and why they were rejected if any.>

**Risks**

<risks when the PR lands.>

**Verification**

<concrete commands: verify-* skills and/or agent_space/ scripts; unit/lint/format; behavior pass criteria. each box evidence maps to an item here. proof lands in Proof / MR body, not a committed verify file.>

**Boxes**

- [ ] <checkable step> — evidence: <file, log, screenshot, or test run that proves it; maps to Verification>
- [ ] <checkable step> `(parallel)` — evidence: <...>

**Ready to land:** no

**Proof**

<proof that the changes are working as intended. fill when boxes are done.>

## Coordinator Notes

<plan-wide. leave empty until orchestrate runs. for each PR id: ready-to-land with proof pointers, blocked with the reason, or escalated with the ask for the human.>

```

**Reply**: plan path, PR ids in dependency order, which playbook each PR uses, the orchestrate-gate choice (same chat vs fresh chat), and either that **orchestrate** continues here or the exact next message for a new chat.
