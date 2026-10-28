# Investigate

**You own the answer**. Plan, route, then write.

Investigation requests are read-only. They produce a cited explanation or recommendation, not a code change. No `/judge` skill. No output-mode flag.

## Already-explored shortcut

If the **same surface** was traced earlier **in this chat** with citations still in context, and no material file change for that surface has landed since that trace, do **not** respawn **explore** for **how** / **why**. Synthesize from the prior report. Same rule when a playbook step says “run how/why” and the parent already has that surface. If the surface changed or citations are gone, run how/why normally.

## Steps

0. **Standards ingestion.** Read `AGENTS.md` if present. Discover repo verification skills when the ask is about how the app is proven. Note `docs/decisions/` when intent or history may live there. Do this before how/why when those sources apply.
1. Route through the **how** skill when mechanics are unclear. If motivation or intent is asked, also route through the **why** skill. Honor the already-explored shortcut above.
2. Produce the skill's doc (how: overview, key concepts, how it works, inputs/outputs, triggers and impact; why: overview, history, why it is this way now, impact of changing it).
3. When the ask is a **decision** between alternatives (or “are we sure / should we”), include **Recommendation**, **Tradeoffs**, and **Assumptions** alongside how/why. Prefer a tradeoffs table when comparing options.
4. When the ask touches **shipping, prod, ops, data, compliance, or cross-team consumers**, require an **Implications** section (blast radius and who feels it). Do not skip implications by calling the ask “just informational.”
5. Apply the **unslop** skill to the reply if the routed skill has not already.

If the investigation precedes a code change, hand back to the user and re-route to **bugfix**, **implement**, or **refactor** (brief carries Implications forward).

## Reply

The investigation output. For “are we sure” answers, include real judgement with reasons. Push back if the premise is wrong. Include Implications when shipping/prod/consumers are in scope.
