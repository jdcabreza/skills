# Authoring a skill

**You own the skill's voice.**

1. Use the harness's skill authoring skill: **create-skill** in Cursor, **skill-creator** in Claude Code.
2. Validate the skill: frontmatter has `name` and `description`, referenced files exist, cross-skill links resolve.
3. Test cases if structural. Skip if subjective.
4. Create a scoped branch if not already on `feature/<branch-name>` or `bugfix/<branch-name>` (prefer `feature/`). Commit on that branch. Never commit on `develop`, `main`, or `master`. Skip **sequence-changes** unless the user asks. Run **open-pr** unless the user says otherwise.

When in doubt, delete. Keep only prose that changes a decision. Tell it to do the thing and skip the reason. Explain only when the rule is confusing without one. Match tone to scope. Point at structural sources (READMEs, configs, etc.) if needed. Delegate to other skills by path. Don't restate. If you keep hitting a workflow that's not captured, propose a new skill.

**Reply**: summary of the skill, key design decisions, validation notes.
