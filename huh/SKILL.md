---
name: huh
description: Restates the agent's last reply in plain English. Use when the user invokes /huh or does not understand what was just said.
disable-model-invocation: true
---

# Huh

Say what the agent just said, in plain English. A person who did not follow the reply should be able to follow this one.

## Do this

1. Use the reply they pointed at. If they did not point, use the last agent reply.
2. Restate that reply in plain words. Keep the meaning. Keep a concrete detail the meaning needs.
3. Short sentences. Stay on that reply.

## Don't

- Explain the codebase on your own.
- Add a recommendation the reply did not make.
- Invent a point the reply did not contain.

## Not this

- There is no agent reply to restate. Say that.
