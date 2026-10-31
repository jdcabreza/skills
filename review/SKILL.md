---
name: review
description: >-
  Mine recent local /nathan-mode (and related nstack) conversations for trust,
  cost, and friction patterns. Produce a rundown with sureness-labeled claims
  and a Waiting-on-you gate before any playbook hand-off. Use for /review or
  "review my last N days of nathan-mode usage."
disable-model-invocation: true
---

# Review (usage mining)

Parent-only for the mining and synthesis loop (like `unslop` / `open-pr`). You may spawn one explore agent only to map the skill tree. Do **not** spawn a code `nathan-agent`. Do **not** edit skills or open MRs inside this skill.

## Steps

### 1. Lookback

Ask for (or take) the lookback window: **X days**. If the user omits it, state a default (for example 7 days) and proceed only if they already accepted that default or say go. Prefer an explicit number from the user.

### 2. Mine

Search local transcripts / conversation search for that window. Focus on `/nathan-mode` and related nstack invocations when present. Note data limits (missing transcripts, truncated tools, no remote history). Degrade gracefully: say what you could not read.

### 3. Patterns

Look for recurring signals, not one-off bad turns unless labeled weak:

- parent-heavy vs delegate
- skill re-inline
- missing verify
- soft gates ignored
- long mixed Align/Execute threads
- model or token pain
- repeated corrections
- **user frustration** (reverts, “stop”, repeated steering, abandoned threads)

Prefer patterns across chats. Label single-chat findings as weak evidence.

### 4. Rundown

Produce:

- **Problems** (sureness on each claim)
- **Opportunities**
- **Ordered todos** (what to change, suggested playbook)

Do **not** edit skills, commit, or open MRs here. Prefer a throwaway artifact under `docs/` or `agent_space/` so user-owned proposal docs stay untouched unless asked.

### 5. Action gate

End with **Waiting on you:** whether to action any items. On explicit go, hand off to the right **nathan-mode** playbook:

- multi-item → **big-changes** (usual)
- small skill edit → **authoring a skill**
- docs → **document**
- question only → **investigate**

Pass the review artifact path. Name the playbook and path in the gate reply.

## Reply

Lookback used, data limits, rundown, artifact path if written, then **Waiting on you:** with the proposed hand-off.
