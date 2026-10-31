---
name: why
description: >-
  Recover the motivation and history behind a design or implementation
  decision and write a comprehensive explanation. Use for /why, investigate
  when intent is asked, or when a playbook says to run why over a surface.
---

# Why

Figure out why something is the way it is. Read-only. One explore subagent, model from the `why` line in the models file (path in the **harness terms** table in `../nathan-mode/SKILL.md`). If that file is missing, stop and tell the user to run `/setup-nstack`. Do not override the spawn to `nathan-agent`. Parent owns intent, synthesis, and the reply. Never pass the explore report through verbatim.

## Steps

1. Determine the user's intent. What decision, tradeoff, or shape are they asking about. Name it in one or two sentences before spawning.
2. **Already-explored shortcut:** if the same surface was traced earlier in this chat with citations still in context, and no material file change for that surface has landed since that trace, do **not** respawn the explore agent. Synthesize from the prior report and skip to step 3. Otherwise spawn one explore agent (`run_in_background: true`, model from the `why` role; omit `model` when the role is `inherit-parent` or `auto`). Brief it with the intent and this checklist. Default thoroughness `medium`; use `very thorough` when history spans many PRs or years.
   - **Decision log.** Search `docs/decisions/`, `DECISIONS.md`, ADRs, RFCs, and similar repo context for relevant entries.
   - **Git history.** Read relevant commit messages and blame on the surface. Prefer messages that state intent over drive-by renames.
   - **Remote history.** If MCP or CLI tools are available: GitLab MRs (`glab`) for what landed and discussion; Confluence for design notes; Jira for related tickets. Skip quietly when a source is unavailable.
   - Return paths, MR/ticket ids, dates, and short quotes of stated rationale. Do not write the final user doc. Do not invent history.
3. Drain the explore report. Write the comprehensive doc below from the findings. Separate stated rationale from inference. Label claims per nathan-mode evidence rules when this skill runs under `/nathan-mode`. Apply the **unslop** skill to the draft.

## Doc shape

```markdown
# Why: <decision or surface>

## Overview
<what exists today and what question this answers>

## History
<timeline of relevant decisions, commits, MRs, tickets, docs>

## Why it is this way now
<constraints, tradeoffs, and the surviving rationale>

## Impact of changing it
<what would move, break, or need revisiting if this changed>
```

Drop a section only when it has nothing true to say. If no rationale is findable, say so and mark remaining explanations as inference or guess.

## Reply

The comprehensive doc.
