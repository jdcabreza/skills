---
name: context-window
description: Sends bulk context to a subagent and keeps a summary in the main thread. Use when a task would load files, logs, search results, or other bulk context into the main thread, or when the thread is about to hold more than the decision needs.
disable-model-invocation: true
---

# Context Window

Context fills up quickly. Route the bulk of additional context to subagents. Keep summaries in the main thread.

## Do

1. Before you read a pile of files, logs, or search results into this thread, send that work to a subagent.
2. Tell the subagent the question and what to bring back. A summary, the paths, and the lines that decide the question.
3. Keep that summary in the main thread. Decide and edit from it.
4. Open a file in this thread when you are about to change it, or when the summary is not enough to act.
5. You are done when the main thread has the decision and the summary, and the bulk stayed in the subagent.

## Don't

- Paste long file bodies, logs, or search dumps into the main thread.
- Read the same bulk here after a subagent already summarized it.
- Spawn a subagent for a fact you already have, or for the one file you are about to edit.

## Not this

- The user pasted the context they want used. Use it here.
- A read of the one file this edit changes. Read it here.

## Example

Agent default: you search the repo and read twelve files in this thread, then lose the ask.

Do this: a subagent reads the twelve files and returns which three matter and why. This thread keeps that summary and edits those three.
