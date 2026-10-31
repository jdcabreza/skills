# Implement

**You own the design. Plan, review, and verify.** Default after go: delegate implementation to a `nathan-agent`. You stay in the lead. Parent-implement only with explicit **`pair`**.

Shared brief: `playbooks/_spec-brief.md`.

## Phase A — Spec (Align)

0. **Standards ingestion.** Read `AGENTS.md` if present (if absent, say so in the brief and fill Architecture and placement by hand). Discover repo verification skills (`.claude/skills/verify-*` or README Verification). Note `docs/decisions/` when relevant to the ask.
1. Ask for context if missing (who asked, what must happen, why). Run **how** and **why** over the relevant surface when facts or intent are unclear. If the approach is unclear, run **design**. If the ask is too large for one playbook or blast radius needs a multi-step plan, stop and route to **big-changes**.
2. Draft the full **spec brief** from `_spec-brief.md` (Outcome through Land; Implications and Architecture and placement required when they apply). Point Architecture / FORBIDDEN at AGENTS.md and verify skills from step 0. Todo items for user alignment / brief approval stay **pending** until explicit go. Do not mark them completed when you only drafted the brief.
3. Return the brief. End with **Waiting on you:** and stop. Do **not** create a branch, spawn a code delegate, edit product code, or land until explicit go.

## Phase B — Execute (after go)

4. Create a scoped branch if not already on `feature/<branch-name>` or `bugfix/<branch-name>`. Prefer `feature/` for new behavior. Never commit on `develop`, `main`, or `master`. Playbooks own the branch and commits. **open-pr** does not create branches.
5. Default: delegate code writing to a `nathan-agent` with the slim worker brief from `_spec-brief.md` (pointers, approved brief path, VERIFY checklist). Model from the `implement` role in the models file. Do not parent-implement unless the user said **`pair`**.

## Phase C — Proof and land

6. Verify from the brief checklist. Inconclusive is not a pass. Put proof into the worker REPORT (and later MR / plan Proof). Do **not** commit a verification artifact file into the repo. If behavior is wrong, report progress and what broke; loop Phase B–C until correct. If the design itself is wrong, report and return to Phase A.
7. If the repository has decision docs (usually `docs/decisions`), log a decision when future readers need it. Report that to the user.
8. Rebase into ordered, atomic commits. Stack PRs if needed. Use **sequence-changes**.
9. Run **open-pr**. Default unless the user says otherwise.

## Reply

- **Pre-approval:** the full brief. Then stop.
- **Post-land (L2):** what you built, significant decisions, open decisions, MR + proof pointers.
