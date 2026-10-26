# Big Changes

**You own the plan, not the code. The plan is an auditable checklist that an owner runs box-by-box. Humans verify the plan and progress using evidence.** The plan is the deliverable. Do not implement.

Use this when the ask is too large for one playbook (many asks, stacked work) or when a change that looked small has a large blast radius and needs a safer multi-step plan. Brainstorming architectures or approaches belongs to the **design** skill, not this playbook.

1. When the change is 1-2 files with an obvious approach, skip the plan. Say so and re-route to the appropriate playbook.
2. Ask the user for context surrounding the changes (who asked, why needed, what triggered). Determine a rough ordering of todos/PRs that we can route to the smaller playbooks, broken down from the bigger ask. For each todo, run the **how** and **why** skills over the relevant code surface. Return to the user your understanding of the ask, the current behavior, intended impact, context, and rough list of todos (with justification) for user verification.
3. Copy the skeleton below into the plan file and fill up. Use `agent_space/` if existing, otherwise use `docs/`. Keep every heading and sub-block in the order shown. 
4. For each rough todo/PR determined from step 2, run it through the corresponding playbook (without writing code), and fill the corresponding PR section in the plan file. Work with the human to determine scope, context, and verification. Write using the **write** skill in full, then run the **unslop** skill. Return to the user your artifact for verification. Move on to the next todo/PR when approved.
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

Each box should be runnable by the playbooks within `nathan-mode`. Agents are meant to implement each box.

Tests alone are not sufficient verification. A PR is only verified when unit tests pass, lints and formatting pass, and behavior is as-intended.

## PRs

### <Task as a verb phrase> (<PR id>)

**Depends on:** <PR id, or None.>

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

**Proof** 

<proof that the changes are working as intended.>

### Coordinator Notes

<notes from the coordinator agent spawned by the orchestrate playbook. leave empty until orchestrate runs.>

```
