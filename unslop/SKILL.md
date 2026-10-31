---
name: unslop
description: >-
  Clean up writing by removing AI tells and rewording into plain human
  language. Use for /unslop, after write drafts, investigate replies, or when
  nathan-mode or a playbook says to run unslop. Parent-only, never delegated.
disable-model-invocation: true
---

# Unslop

Parent-only. In-process. No subagent spawn. No setup model role. Runs on the parent chat model. Never delegate.

Apply to the current output (the draft or reply you are about to send, or the text the user pointed at). Keep the overall structure.

## Steps

1. Review the current output for any AI tells (em dashes, colon/semicolon overuse, weird wording). Remove these.
2. Reword the sentences so that they're in plain, day-to-day, human language. Vary sentence cadence. Clear writing. Assume you're a human writing for another human. Keep the overall structure of the current output.

## Reply

The unslopped version of the previous message/output.
