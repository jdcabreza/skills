# Orchestrate

**You own kickoff and landing. The coordinator owns babysitting.** A plan file already exists (usually from **big-changes**). You spawn a coordinator to drive boxes while the human can step away. You do not author product code. You still land what ships. Human verify is **MR + plan Proof**, not per-box confirmation.

1. Confirm the plan file path with the user. If none exists, stop and route to **big-changes** first. If the plan has no PR sections with filled Boxes, stop and send them back to **big-changes**. A fresh chat that only has the plan path is a valid start. Do not require the **big-changes** transcript.
2. Brief and spawn one coordinator as `nathan-agent` with `run_in_background: true`, model from the `orchestrate` role. Pass the absolute path to `nathan-mode/SKILL.md`, the plan file path, and the rules below. Do not run the plan boxes yourself.
3. Tell the user the coordinator is running, where to read **Coordinator Notes**, and that they can step away during babysitting. End the turn once the spawn is confirmed.
4. When the coordinator returns or the user checks back, drain and review. Read **Coordinator Notes** and each PR with **Ready to land:** yes. Then run **sequence-changes** and **open-pr** yourself for each accepted PR, in **Depends on** order. For **document** or **authoring a skill** PRs the coordinator escalated, run that playbook yourself (skip **sequence-changes** as those playbooks say). **open-pr** is the default unless the user says otherwise. Do not land unreviewed work. After a land, set that PR's **Ready to land** aside in **Coordinator Notes** as shipped with the MR link. Report what you landed and what stays blocked.

**Coordinator rules** (include in the brief)

- You are the coordinator. Local. Never author or edit product code yourself.
- Walk PR sections in **Depends on** order. Finish one PR's boxes before starting a PR that depends on it. Independent PRs may proceed once their dependencies are ready-to-land locally (stacked tip exists). Do not wait for the parent to merge an MR before stacking the next dependent PR.
- Boxes under a PR are the worker steps for that landable unit. One box at a time unless the box is marked `(parallel)` with sibling `(parallel)` boxes under the same PR.
- For each code box (**implement**, **bugfix**, **refactor**), write a worker brief in the template below. Spawn workers as `nathan-agent` with `run_in_background: true` and the model for that box's playbook shape. Drain each required worker before starting a dependent box. Review their report. Write your own summary into **Coordinator Notes**. Do not paste worker output verbatim.
- Workers **MUST** run VERIFY from the brief. REPORT must include **verbatim** command output for decisive checks. Coordinator fills plan **Proof** (paste or pointer to local non-committed notes if needed) and sets **Ready to land**. Do not escalate routine verify results; green or loop the worker. Prefer repo verify skills and listed `agent_space/` scripts per `_verification.md`.
- For a PR whose **Playbook** is **document** or **authoring a skill**, do not spawn a code worker. Log an escalation in **Coordinator Notes** naming the PR id and stop that PR for the parent.
- Before the first code box of a PR, ensure that PR's **Branch** exists: `feature/<branch-name>` or `bugfix/<branch-name>` only. Create it if missing. If **Depends on** names another PR, base the new branch on that PR's branch tip. Never commit on `develop`, `main`, or `master`. Workers leave commits on the current PR's branch.
- When a box's evidence exists, check that box in the plan. When every box under a PR is checked, fill **Proof**, set **Ready to land:** yes, and record ready-to-land in **Coordinator Notes** with proof pointers.
- Do not land. No push to remote, no open or update PR, no **sequence-changes**, no **open-pr**, no telling the human the plan is shipped. Leave local work on the scoped branches.
- Escalate only for **plan gaps** (unscoped box, missing VERIFY), **irreversible actions**, or **conflicts with the approved brief/plan**. Escalation is an **interrupt**: log the ask in **Coordinator Notes**, stop that box or PR, and wait for **explicit human go** before continuing that work. Do not escalate preference nits or routine verify.
- For reversible calls you can evidence, log in **Coordinator Notes**, then act. The human course-corrects later.
- When the plan is ready-to-land or blocked, return a final report: PRs ready, PRs blocked, open decisions, where proof lives.

**Worker brief**

Keep slim: **file pointers**, not inlined diffs. Match `_spec-brief.md` slim worker rules.

```
GOAL: one sentence. the outcome.
SCOPE: paths the worker should change and should not change.
CONTEXT: pointers to relevant context: approved brief path, commits, docs, plan PR id, box text.
ACCEPTANCE: checkable criteria, one per item
VERIFY: checklist from the brief/plan. Prefer repo verify skills when they fit; allow listed gitignored agent_space/ throwaway scripts otherwise. Include known gotchas.
TIMEBOX: rough cap on runtime. on expiry, return partial findings and stop rather than running on.
FORBIDDEN: force-push; remote push; open-pr; landing; fixes outside SCOPE; committing verification artifacts; inlined-diff-only context dumps.
REPORT: proof of work with verbatim VERIFY output, scope touched, evidence labels, suggested follow ups.
```

Size the brief to the unit. A field you cannot fill means the box is not scoped yet. Fix the plan with the human before spawning that worker.

**Reply**: plan path, coordinator status, what you landed after review, what remains ready-to-land or blocked.
