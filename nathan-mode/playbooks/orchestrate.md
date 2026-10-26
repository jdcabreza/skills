# Orchestrate

**You own kickoff and landing. The coordinator owns babysitting.** A plan file already exists (usually from **big-changes**). You spawn a coordinator to drive boxes while the human can step away. You do not author product code. You still land what ships.

1. Confirm the plan file path with the user. If none exists, stop and route to **big-changes** first.
2. Brief and spawn one coordinator as `nathan-agent` with `run_in_background: true`, model from the `orchestrate` role. Pass the absolute path to `nathan-mode/SKILL.md`, the plan file path, and the rules below. Do not run the plan boxes yourself.
3. Tell the user the coordinator is running, where to read **Coordinator Notes**, and that they can step away during babysitting. End the turn once the spawn is confirmed.
4. When the coordinator returns or the user checks back, drain and review. Read **Coordinator Notes** and each ready-to-land box. Then run **sequence-changes** and **open-pr** yourself for boxes you accept. **open-pr** is the default unless the user says otherwise. Do not land unreviewed work. Report what you landed and what stays blocked.

**Coordinator rules** (include in the brief)

- You are the coordinator. Local. Never author or edit product code yourself.
- Execute plan boxes in dependency order. One box at a time unless the plan marks boxes as parallel.
- For each box, write a worker brief in the template below. Spawn workers as `nathan-agent` with `run_in_background: true` and the model for that box's shape (`implement`, `refactor`, or `bugfix`).
- Drain each required worker before starting a dependent box. Review their report. Write your own summary into **Coordinator Notes**. Do not paste worker output verbatim.
- Before the first code box, ensure a scoped branch exists: `feature/<branch-name>` or `bugfix/<branch-name>` only. Never commit on `develop`, `main`, or `master`. Create it if missing. Workers leave commits on that branch.
- Do not land. No push to remote, no open or update PR, no **sequence-changes**, no **open-pr**, no telling the human the plan is shipped. Leave local work on the scoped branch. Mark each finished box ready-to-land in **Coordinator Notes** with proof pointers.
- Escalate to the human for irreversible actions, genuine product or preference calls, or a blocker you cannot clear. Log the escalation in **Coordinator Notes** and stop that box.
- For reversible calls you can evidence, log in **Coordinator Notes**, then act. The human course-corrects later.
- When the plan is ready-to-land or blocked, return a final report: boxes ready, boxes blocked, open decisions, where proof lives.

**Worker brief**

```
GOAL: one sentence. the outcome.
SCOPE: paths the worker should change and should not change.
CONTEXT: pointers to relevant context: commits, docs, plan box id.
ACCEPTANCE: checkable criteria, one per item
VERIFY: how to verify work. include known gotchas.
TIMEBOX: rough cap on runtime. on expiry, return partial findings and stop rather than running on.
FORBIDDEN: what the worker shouldn't do. no force-push, no remote push, no open-pr, no fixes outside scope, etc.
REPORT: what the worker should return as proof of work. suggested follow ups, etc.
```

Size the brief to the unit. A field you cannot fill means the box is not scoped yet. Fix the plan with the human before spawning that worker.

**Reply**: plan path, coordinator status, what you landed after review, what remains ready-to-land or blocked.
