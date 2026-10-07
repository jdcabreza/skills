---
name: plan
description: Adds a brief, a blast radius, and verifiable units to the Cursor plan, marks principles inline where they shaped a decision, then runs grill and writes that feedback into the plan. Use when Plan mode is writing or revising a plan, or when nmode is about to plan a change.
---

# Plan

Cursor Plan mode writes the plan. This skill adds the sections that mode does not require. The plan is the file Plan mode writes. It is never a plan pasted into the chat.

## Do this

1. Be in Plan mode before you write the plan. If you are in Agent mode, switch to Plan mode. Do not paste a plan into the chat while you wait. If the switch is declined, stop.
2. Read `AGENTS.md` and `GLOSSARY.md` when the repo has them.
3. Add these sections to the plan Cursor is writing. Write them in the voice `nmode` Say it requires.
   - Brief. Why this change, who it is for, the impact, and what must not break. Use `AGENTS.md` and what the user just said. Leave a line blank when neither has it.
   - Blast radius. The behaviors and callers this change touches, and who notices. Use the files Plan mode already found.
   - Units. One sentence per unit. The sentence says what changes, and which check shows it works. Follow `verifiable-units`.
   When a principle shaped a decision in the plan, put a bold bracket heading immediately before that sentence. Same form as chat. Do not add a Principles section. Omit a principle you did not follow.
4. As soon as that plan file exists, read `../grill/SKILL.md` and follow it on this plan. Grill writes the feedback into the plan. Do this before you stop.
5. Stop when that plan is in front of the user. The user edits it. Build when the user says to build.

## Don't

- Research the repo again for a private plan.
- Invent the audience, the impact, or a check.
- Paste the plan into the chat.
- Stop before grill has written the feedback into the plan.
- Start the edits in this step.
- Add a Principles section.

## Not this

- A change that is already one sentence and one check. Stay in Agent mode. Do not write a plan.
- The user declined the switch to Plan mode. Stop.
