# Refactor

**You own the contract. The structure changes, but the behavior does not.** Distinct from **implement** (adds/changes behavior) and **bugfix** (corrects behavior).

Small-to-medium changes only. If the ask is too large for one playbook or blast radius needs a multi-step plan, route to **big-changes**. If you need to brainstorm architectures first, run **design**. If a refactor would change behavior, name it and re-route to **implement**. If it reveals a missing feature or real bug, name it and ask how to proceed.

Default after go: delegate code movement to a `nathan-agent`. Parent-implement only with explicit **`pair`**.

Shared brief: `playbooks/_spec-brief.md`.

## Phase A — Spec (Align)

0. **Standards ingestion.** Read `AGENTS.md` if present (if absent, note it and fill Architecture and placement by hand). Discover repo verification skills. Note `docs/decisions/` when relevant.
1. Ask for context if missing (who asked, why, trigger). Run **how** and **why** over the relevant surface. Draft the **spec brief** including Current behavior, judgment whether the refactor is justified, Behavior pin / reader-load intent, Architecture and placement, Approach, Verify checklist, and Land. Be wary of unwarranted refactors.
2. Pin the behavior. Write or point at a harness (tests, scripts that diff old vs new; prefer gitignored `agent_space/` for throwaways). Type checking and lints are not a pin.
3. Name the target shape. Catch dead or overly complex branches and invalid states. Plan to remove dead code, collapse thin wrappers, drop redundant validators, remove orphan references. Reduce hidden state and call-stack depth when evidence supports it. Do not speculate. If the target shape is unclear, run **design**. If too large, route to **big-changes**.
4. Return the full brief. Todo items for user alignment / brief approval stay **pending** until explicit go. Do not mark them completed when you only drafted the brief. End with **Waiting on you:** and stop. Do **not** create a branch, spawn a code delegate, edit product code, or land until explicit go.

## Phase B — Execute (after go)

5. Create a scoped branch if not already on `feature/<branch-name>` or `bugfix/<branch-name>`. Prefer `feature/` for refactors. Never commit on `develop`, `main`, or `master`. Playbooks own the branch and commits. **open-pr** does not create branches.
6. Move in behavior-preserving steps. Keep the behavior pin green after each change. For API reshapes, migrate every caller and delete the old API in the same wave. No compatibility layer unless the user explicitly asks. Spot-check renames against real files. Default: delegate to a `nathan-agent` with the slim worker brief from `_spec-brief.md`. Model from the nstack-models `refactor` role. Do not parent-implement unless the user said **`pair`**.

## Phase C — Proof and land

7. Prove behavior is unchanged on the final artifact with the pin. Confirm reader-load dropped (or state why it did not). Confirm the brief Outcome. Put proof into REPORT. Do **not** commit a verification artifact file into the repo.
8. Rebase into ordered, atomic commits. Stack PRs if needed. Use **sequence-changes**.
9. Run **open-pr**. Default unless the user says otherwise.

## Reply

- **Pre-approval:** the full brief, including justified-or-not judgment. Then stop.
- **Post-land (L2):** context, behavior maintained, what changed, pin proof, reader-load delta, MR + proof pointers.
