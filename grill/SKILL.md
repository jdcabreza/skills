---
name: grill
description: Spawns reviewers to interrogate code changes, plans, and proposals, then judges the findings. Use when the user invokes /grill or asks to pressure-test code, a plan, or a proposal.
disable-model-invocation: true
---

# Grill

Pressure-test code, a plan, or a proposal until the decision holds. The reviewers find the holes. You judge them. Leave the code as it is.

## Do this

1. Name the target.
   - Code. The files they named, `git diff` against the base branch, or the recent work they named.
   - Plan. The plan they named.
   - Proposal. The proposal they named.
   Package that material for the reviewers. This thread keeps the intent and the verdict.
2. State the intent in one paragraph. Take it from their message, the commits, and the material. If the intent is unclear, ask before you spawn reviewers.
3. Read `~/.cursor/rules/nmode-models.mdc`. Use the `grill reviewers` list. Spawn one Task reviewer per entry, all in one message. If that file is missing, use `claude-opus-5-5-medium` and `grok-4.7-high-fast`. For `inherit-parent` or `auto`, omit `model`. Set `subagent_type` to `generalPurpose`. Give every reviewer the same prompt. The prompt contains the intent, the material, and the rubric below, and it says do not edit files. If Task rejects a slug, use the closest allowed slug of that family from the error, say so, and continue.
4. Synthesize. A finding from two or more reviewers is consensus. Keep a finding from one reviewer. Merge two descriptions of the same issue. Note a disagreement when one reviewer flags what another denies.
5. Judge each finding. Put it in act on, consider, noted, or dismissed. Name who raised it. Give one line why.
6. State the decision. Revise a plan or proposal in the reply where it broke. Leave the code as it is. Ask a question only when the answer changes the decision.

### Rubric

Correctness, security, maintainability, and where it breaks given the intent. For code, also naming, control flow, and a comment only when it records a why. For a plan or proposal, where the decision breaks.

### Verdict

### Intent

> [the paragraph from step 2]

### Reviewers

- Reviewer [label]: [model], [N findings]

### Act on

Findings that should be addressed. For each one, what is wrong, who raised it, and why it matters.

### Consider

Findings worth a decision. For each one, what is wrong, who raised it, and the tradeoff.

### Noted

Valid findings that do not change the decision. A short list.

### Dismissed

Rejected findings, with one line why.

### Agreement

Where the reviewers agreed, where they diverged, and what that pattern says.

### Decision

The decision, and the revised plan or proposal where it broke.

## Don't

- Edit code, or apply a plan by editing files.
- Spawn reviewers before the intent is stated.
- Give reviewers different prompts.
- Ask a question that does not change the decision.

## Not this

- No target in the thread. Ask what to grill.
