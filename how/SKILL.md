---
name: how
description: Traces how a behavior works end to end in this codebase, with a citation on each step. Use when the user invokes /how or asks how something works across the repository.
disable-model-invocation: true
---

# How

Trace one behavior from the start of the path to the end.

## Do this

1. Find the path they named. Read the code before you explain it.
2. If that path crosses more than a few files, send the read to a subagent. Keep the summary in this thread.
3. Say the steps in order. Cite the file or symbol for each step.
4. Short sentences. Stay on that path.

## Don't

- Explain why a decision was made. That is `why`.
- Restate the last reply. That is `huh`.
- Paste file bodies into the reply.

## Not this

- The code does not show the path. Say what you could not find.
