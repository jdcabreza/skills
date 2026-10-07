---
name: setup-models
description: Detects available Task models and writes an always-applied rule that sets grill's reviewers. Use when the user invokes /setup-models, asks to configure models, or asks to change the model budget.
disable-model-invocation: true
---

# Setup models

Write `~/.cursor/rules/nmode-models.mdc`. Grill reads the `grill reviewers` line from that file.

## Do this

1. Detect the model slugs this session can pass to a Task subagent. `inherit-parent` and `auto` are always valid. If you detect no real slug, ask the user to paste the slugs they have. Never write a slug you have not confirmed.
2. If `~/.cursor/rules/nmode-models.mdc` exists, keep its `# budget` line and its `grill reviewers` value. Drop any other role line. Name each dropped line.
3. Ask for a budget with AskQuestion. Name the current budget. If there is no rule, say `large` is the starting point. Use these labels:
   - `unlimited — max reasoning`
   - `large — xhigh reasoning`
   - `medium — high reasoning`
   - `small — medium reasoning`
4. Apply the budget to every real slug. `unlimited`, `large`, `medium`, and `small` set the effort token to `max`, `xhigh`, `high`, or `medium`. The effort token is the last token, or the token before a trailing `fast`, on the ladder `max` > `xhigh` > `high` > `medium` > `low`. The family is the slug with that token, and a trailing `fast`, removed. If the resulting slug is not in the detected set, use the same family's detected slug with the highest effort at or below the target. If that family has none, ask. Leave `inherit-parent` and `auto` unchanged.
5. Show `grill reviewers` and its models. Mark any real slug that is not detected as needing a choice. Name each line step 2 dropped. Ask the user to accept the list or change it. Use AskQuestion. The options are the detected slugs plus `inherit-parent` and `auto`. One reviewer runs per entry. The list length is the reviewer count.
6. Validate. Every real slug must be in the detected set. `inherit-parent` and `auto` pass. If a chosen real slug is not available, stop and ask again.
7. Overwrite the whole file so a re-run stays idempotent. `alwaysApply` is true. The `# budget` line records the chosen label and its target effort. The `grill reviewers` line is the confirmed list. Use this shape:

```
---
description: Model choices per role. Grill reads grill reviewers.
alwaysApply: true
---
# Delete a line to fall back to the skill default.
# inherit-parent or auto: omit Task model. Each list entry is one reviewer.
# budget: large (xhigh)
grill reviewers: claude-opus-5-5-medium, grok-4.7-high-fast
```

8. Say the rule was written, that it applies to new sessions, and that running this skill again updates it.

## Don't

- Write a real slug that is not in the detected set.
- Keep a role line other than `grill reviewers`.
- Edit grill. Grill already reads this rule.

## Not this

- The user has not chosen a budget. Ask. Write nothing yet.
