# Bugfix

**You own this task. Plan, review, and verify.** Route root-cause through **how** and **why**. Default after go: delegate the fix to a `nathan-agent`. You stay in the lead. Parent-implement only with explicit **`pair`**.

Be scientific. Use evidence. Ship only the smallest change the evidence justifies.

Shared brief: `playbooks/_spec-brief.md`.

## Phase A — Spec (Align)

1. Ask for context if missing (who reported, what happened, inputs/outputs). Return a problem brief plus repro plan from `_spec-brief.md`. End with **Waiting on you:** if the user must confirm the problem framing before you spend on repro. Todo items for that alignment stay **pending** until explicit go.
2. Reproduce the bug. Write a throwaway script if needed (prefer gitignored `agent_space/`). If program state is unclear, add instrumentation and/or logging and read it as the code runs.
3. Root-cause with evidence. Form hypotheses; rule them out until one survives. Use **how** and **why**. Do not guess. Confirm the root cause with evidence.
4. If the fix approach is unclear, run **design**. If the fix is too large for one playbook or blast radius needs a multi-step plan, stop and route to **big-changes**. Update the **spec brief** with cause, proposed fix, Architecture and placement, Naming and semantics, Verify checklist, and Land. Todo items for brief approval stay **pending** until explicit go. Do not mark them completed when you only drafted the brief.
5. Return the updated brief. End with **Waiting on you:** and stop. Do **not** create a branch, spawn a code delegate, edit product code (except temporary repro instrumentation you will discard), or land until explicit go.

## Phase B — Execute (after go)

6. Create a scoped branch if not already on `feature/<branch-name>` or `bugfix/<branch-name>`. Prefer `bugfix/` for defect fixes. Never commit on `develop`, `main`, or `master`. Playbooks own the branch and commits. **open-pr** does not create branches.
7. Default: delegate the fix to a `nathan-agent` with the slim worker brief from `_spec-brief.md`. Model from the nstack-models `bugfix` role. Do not parent-implement unless the user said **`pair`**.

## Phase C — Proof and land

8. Verify the fix. The Phase A repro should now pass. Inconclusive is not a pass. Unit tests alone may miss the bug. Put proof into REPORT (commands and verbatim fail/pass output). Do **not** commit a verification artifact file into the repo. If not working, report current fix state; loop Phase B–C, or return to Phase A if the cause was wrong. Ask for user input only when blocked.
9. If the repository has decision docs (usually `docs/decisions`), log a decision when future readers need it. Report that to the user.
10. Rebase into ordered, atomic commits. Stack PRs if needed. Use **sequence-changes**.
11. Run **open-pr**. Default unless the user says otherwise.

## Reply

- **Pre-approval:** problem brief and/or full post-cause brief. Then stop.
- **Post-land (L2):** what was broken, root cause, the fix, how you verified. Paste original repro and now-passing repro output verbatim. MR + proof pointers.
