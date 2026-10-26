# Document

**You own the voice and the content of the documentation. Review and verify.** Delegate investigation and writing when appropriate. You stay in the lead.

1. Ask the user for context surrounding the documentation (who asked, audience and technical level, what needs to be conveyed, why is it needed, medium). Run the **how** and **why** skills over the relevant code surface. Return to the user your understanding of the ask, the docs to be written, intended language, and other context for user verification.
2. Write a local draft using the **write** skill in full (writer then audience reviewer). Use `agent_space/` if present, otherwise use a `docs/` directory within the project. Run the **unslop** skill afterwards.
3. Return the current state to the user for review and ask if it needs further revision along with points to consider. If user says to revise, loop back through step 2 until the user approves.
4. Ask the user where to push the documents (PR, Confluence, etc.) along with relevant details (Confluence link, etc.) necessary for you to push.
5. If it's a PR, create a scoped branch if not already on `feature/<branch-name>` or `bugfix/<branch-name>` (prefer `feature/`), commit on that branch, then run the **open-pr** skill. Never commit on `develop`, `main`, or `master`. Docs do not use **sequence-changes**. If it's a Confluence doc or otherwise, look for the relevant MCP skill.

**Reply**: the context surrounding the doc, quick summary of what you wrote, and where the doc was pushed to.
