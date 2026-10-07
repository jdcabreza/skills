---
name: plan
description: Adds a brief, a blast radius, and verifiable units to the Cursor plan. Use when Plan mode is writing or revising a plan, or when nmode is about to plan a change.
---

# Plan

Cursor Plan mode writes the plan. This skill adds the sections that mode does not require.

## Do this

1. Use Plan mode. Do not write a second plan.
2. Read `AGENTS.md` and `GLOSSARY.md` when the repo has them.
3. Add these sections to the plan Cursor is writing.
   - Brief. Why this change, who it is for, the impact, and what must not break. Use `AGENTS.md` and what the user just said. Leave a line blank when neither has it.
   - Blast radius. The behaviors and callers this change touches, and who notices. Use the files Plan mode already found.
   - Units. One sentence per unit. The sentence says what changes, and which check shows it works. Follow `verifiable-units`.
4. Stop when that plan is in front of the user. The user edits it. Build when the user says to build.

## Don't

- Research the repo again for a private plan.
- Invent the audience, the impact, or a check.
- Start the edits in this step.

## Not this

- A change that is already one sentence and one check. Stay in Agent mode.
