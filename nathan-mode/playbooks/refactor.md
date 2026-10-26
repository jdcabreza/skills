# Refactor

**You own the contract. The structure changes, but the behavior does not**. Distinct from **implement**, which adds/changes behavior, and **bugfix**, which corrects behavior.

This playbook is for small-to-medium-sized changes. If the ask is too large for one playbook or the blast radius needs a multi-step plan, route to **big-changes**. If you need to brainstorm architectures or approaches first, run **design**.
If a refactor results in different behavior, name it, and re-route to the **implement** playbook.
If a refactor reveals a missing feature or a real bug, name it, and ask the user how to proceed.

1. Ask the user for context surrounding the refactor (who asked, why needed, what triggered). Run the **how** and **why** skills over the relevant code surface. Return to the user your understanding of the ask, the current behavior, intended impact, and context for user verification. Also return to the user with your judgement if this refactor is justified and/or necessary. Be wary of unwarranted refactors.
2. Pin the behavior. Write a harness (unit tests, scripts that diff old vs. new behavior, etc.; if not already existing) to ensure equivalence. Type checking and lints are not pinned.
3. Name the target shape of the code surface. Catch dead or overly complex branches, invalid states. Remove dead code, collapse thin or one-caller wrappers, drop redundant validators, remove orphan references. Reduce hidden state, call stack depth if possible. Do not speculate. If the target shape is unclear, run **design** to brainstorm approaches. If the change is too large for one playbook or the blast radius needs a multi-step plan, stop and route to **big-changes**. Otherwise report what you're going to do high-level, in plain language, and verify user alignment.
4. Move in behavior-preserving steps. For each change, make sure the behavior pin is green. For API reshapes, migrate every caller and delete the old API in the same wave. No compatibility considerations unless user explicitly says so. Spot-check renames against actual files. Delegate code changes to a `nathan-agent` with a specific scope. Model from the nstack-models `refactor` role (per the Subagents section and `/setup-nstack`).
5. Prove behavior is unchanged on the final artifact using your behavior pin. Confirm that the changes reduced reader load (amount of context humans/agents have to keep in their heads to understand the codebase). Confirm that the changes satisfies the user's intent.
6. Rebase into ordered, atomic commits. Stack PRs if needed. Use the **sequence-changes** skill.
7. Run the **open-pr** skill. Default unless the user says otherwise.

**Reply**: the context surrounding the refactor, what behavior to maintain, what changed, the proof that behavior remained the same, and the reader-load delta.
