---
name: huh
description: >-
  Rewrite the prior agent reply into plain language a tired engineer can
  follow. Use for /huh, when the user did not understand a reply, or asks
  to explain what was just said in simpler terms. Parent-only, never
  delegated.
disable-model-invocation: true
---

# Huh

Parent-only. In-process. No subagent spawn. No setup model role. Runs on the parent chat model. Never delegate.

Rewrite the last assistant reply (or the span the user pointed at) so a tired engineer gets it on one read. Keep the facts. Change the words and the shape.

## Steps

1. Target the prior assistant message in this chat, or the excerpt the user named. Do not pull in unrelated turns.
2. Pull out what actually matters: the answer, the decisions, the actions, the caveats that change behavior. Drop filler, hedging theater, and process narration that does not help understanding.
3. Apply the **unslop** skill to that content.
4. Reshape for a tired reader. Bottom line first. Short sentences. One idea each. Gloss jargon once in plain words, then keep using the plain words. Prefer what this means and what you need to do over abstract framing. You may change structure. You may not invent facts, paths, or conclusions that were not in the source.
5. If the source had no substance, say that in one sentence. Do not pad.

## Reply

The plain rewrite only. No preamble about what you did.
