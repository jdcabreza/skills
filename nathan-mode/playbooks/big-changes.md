# Big Changes

**You own the plan, not the code. The plan is an auditable checklist that an owner runs box-by-box. Humans verify the plan and progress using evidence.** The plan is the deliverable. Do not implement.

Use this when the ask is too large for one playbook (many asks, stacked work) or when a change that looked small has a large blast radius and needs a safer multi-step plan. Brainstorming architectures or approaches belongs to the **design** skill, not this playbook.

1. When the change is 1-2 files with an obvious approach, skip the plan. Say so and re-route to the appropriate playbook.
2. Ask the user for context surrounding the changes (who asked, why needed, what triggered). Determine a rough ordering of todos/PRs that we can route to the smaller playbooks, broken down from the bigger ask. For each todo, run the **how** and **why** skills over the relevant code surface. Return to the user your understanding of the ask, the current behavior, intended impact, context, and rough list of todos (with justification) for user verification.
3. Copy the skeleton below into the plan file and fill up. Use `agent_space/` if existing, otherwise use `docs/`. Keep every heading and sub-block in the order shown. 
4. For each rough todo/PR from step 2, dry-run the matching playbook into the plan only. Fill that PR's Context, Changes, Alternatives, Risks, Verification, and Boxes. You may run **how**, **why**, **design**, and **write** (then **unslop**) as those playbooks would for planning. Do not create a branch, spawn a code `nathan-agent`, edit product code, commit, run **sequence-changes**, or run **open-pr**. Those steps belong to a later **orchestrate** or playbook run on an approved box. Work with the human to determine scope, context, and verification. Return the artifact for verification. Move on to the next todo/PR when approved.
5. Link the plan file to the user for final review.

**Verification**. Tests alone are not sufficient verification. A PR is only verified when unit tests pass, lints and formatting pass, and behavior is as-intended.

```
# Plan: <name-for-your-plan>

## How to read this

One box is one unit of work. Every box names the evidence that checks it.
A nested box is a sub-step of the box above it.
Check a box only when its evidence exists: a file, a log line, a screenshot, a test run.
The body is a how-to.
Appendices explain and record.

Each box should be runnable by the playbooks within `nathan-mode`. Agents are meant to implement each box later via **orchestrate** or a direct playbook run. This file is not an implementation.

Tests alone are not sufficient verification. A PR is only verified when unit tests pass, lints and formatting pass, and behavior is as-intended.

## PRs

### <Task as a verb phrase> (<PR id>)

**Depends on:** <PR id, or None.>

**Playbook:** <implement | bugfix | refactor | document | authoring a skill>

**Context**

<context surrounding the change. intent, intended behavior, why it's being made. >

**Changes**

<changes to be made. each change should correspond to a visible artifact, e.g., a log line or response change.>

**Alternatives Considered**

<alternative changes considered, and why they were rejected if any.>

**Risks**

<risks when the PR lands.>

**Verification**

<how to verify the changes at the unit test, lint/format, and behavior levels.>

**Boxes**

- [ ] <checkable step> — evidence: <file, log, screenshot, or test run that proves it>
- [ ] <checkable step> — evidence: <...>

**Ready to land:** no

**Proof**

<proof that the changes are working as intended. fill when boxes are done.>

### Coordinator Notes

<notes from the coordinator agent spawned by the orchestrate playbook. leave empty until orchestrate runs. for each finished box, record ready-to-land with proof pointers, or blocked with the reason.>

```
