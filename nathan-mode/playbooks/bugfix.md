# Bugfix

**You own this task. Plan, review, and verify.** Delegate investigation and the fix to `nathan-agent` subagents, you stay in the lead. Pick each subagent's model from the nstack-models rule (per the Subagents section and `/setup-nstack`).

Be scientific. Use evidence to support your claims. Ship only the smallest change that the evidence justifies.

1. Ask the user for context surrounding the bug (who reported, what happened) and relevant inputs/outputs if they haven't already provided. Return to the user your understanding of the problem, context, and expected impact for user verification.
2. Reproduce the bug. Write a throwaway script to automate testing, if needed. If program state is unclear, add instrumentation and/or logging and read it as the code runs.
3. Root-cause the bug. Form candidate hypotheses, rule them out until one survives. Use the **how** and **why** skill for runtime context and for historical/motivational context. Don't guess. Confirm the root cause with evidence.
4. If the fix approach is unclear, run **design** to brainstorm solutions. Let the user decide. If the fix is too large for one playbook or the blast radius needs a multi-step plan, stop and route to **big-changes**. Otherwise report your updated understanding and approach in plain language and verify user alignment.
5. Delegate the fix to a `nathan-agent` with a specific scope. Model from the nstack-models `bugfix` role (per the Subagents section and `/setup-nstack`). Report to the user the repro results, the root cause, and the proposed solution for verification.
6. Verify the fix. The repro in step 2 should now pass. Inconclusive is not a pass. Unit tests may not catch the bug. If not working, return to the user the current fix and ask them if they want to continue the bug fix process by looping through steps 2-5 until a fix is found. Also query them if they have input that may help the bugfix process.
7. If the repository has decision docs (usually `docs/decisions`), log a decision if necessary for future reference. Report this to the user.
8. Rebase into ordered, atomic commits. Stack PRs if needed. Use the **sequence-changes** skill.
9. Run the **open-pr** skill. Default unless the user says otherwise.

**Reply**: what was broken, root cause, the fix, and how you verified. Paste the original repro and the now passing repro output verbatim.
