# Implement

**You own the design. Plan, review, and verify.** Delegate implementation, you stay in the lead.

1. Ask the user for context surrounding the change (who asked, what needs to happen, why it needs to happen). Run the **how** and **why** skills over the relevant code surface. Return to the user your understanding of the ask, resulting behavior, intended impact, and context for user verification.
2. If the approach is unclear, run **design** to brainstorm architectures, solutions, or implementations. Let the user decide. If the ask is too large for one playbook or the blast radius needs a multi-step plan, stop and route to **big-changes**. Otherwise report what you're going to do high-level, in plain language, and verify user alignment.
3. Delegate code writing to a `nathan-agent` with a specific scope. Model from the nstack-models `implement` role (per the Subagents section and `/setup-nstack`). 
4. Verify that the feature works as intended. Inconclusive is not a pass. If the new feature does not work as expected, report to the user current progress and what's broken. Continue implementation, loop through steps 3-4 until behavior is correct. If there's an issue with the design itself, report to the user and go back to step 2.
5. If the repository has decision docs (usually `docs/decisions`), log a decision if necessary for future reference. Report this to the user.
6. Rebase into ordered, atomic commits. Stack PRs if needed. Use the **sequence-changes** skill.
7. Run the **open-pr** skill. Default unless the user says otherwise.

**Reply**: the context surrounding the feature, what you built, significant decisions, and open decisions.
