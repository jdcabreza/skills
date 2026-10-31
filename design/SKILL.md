---
name: design
description: >-
  Brainstorm architectures, solutions, or implementations with a parallel
  panel of 2-3 designer models, then a judge synthesis. Use for /design, or
  when a playbook says to run design before the user decides an approach.
disable-model-invocation: true
---

# Design

Brainstorm approaches. No code. Parent owns context, verification gates, unslop, and the reply. Spawn `design-count` parallel general-purpose designers (`design-1` .. `design-N`), then one general-purpose judge (`design-judge`). Models from the models file (path in the **harness terms** table in `../nathan-mode/SKILL.md`). If that file is missing, or `design-count` / a needed seat / `design-judge` is missing, stop and tell the user to run `/setup-nstack`. Do not override these spawns to `nathan-agent`. Never pass a subagent's words through verbatim.

## Steps

1. Gather context. Ask who asked, what triggered this, and why it is needed. Run the **how** and **why** skills over the relevant code surfaces. If a playbook or earlier turn already supplied that context in-session, reuse it. Do not ask twice. In your own words, return your understanding of the ask, the intended impact, and the related context. Wait for user verification before spawning designers.
2. Spawn `design-count` parallel general-purpose designers (`run_in_background: true`, models from `design-1` .. `design-N`; omit `model` when a seat is `inherit-parent` or `auto`). Same prompt for every seat: verified ask, intended impact, and related context. Each designer proposes one solution and the tradeoffs it accepts. Drain every designer before the next step.
3. Spawn one general-purpose judge (`run_in_background: true`, model from `design-judge`; omit `model` when that role is `inherit-parent` or `auto`). Prefer `design-judge+1` when that step line exists. Brief it with the verified context and every designer proposal. The judge weighs solutions and tradeoffs, combines the strongest parts when that improves the result, and returns one final proposal, its tradeoffs, and a decision record (why this tradeoff, why that option was dropped). Drain the judge.
4. Apply the **unslop** skill to the final proposal. Check it yourself. Return the proposal and your own take. Do not implement. The caller (or the user) decides next.

## Reply

The unslopped proposal, the decision record, and your take.
