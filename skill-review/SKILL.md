---
name: skill-review
description: Reviews a skill, rule, or other instruction for whether following it produces the behavior it claims, including when a smaller model runs it. Use when the user invokes /skill-review, asks for a self-review of a skill or instruction, or asks whether Composer or another smaller model will still follow it.
disable-model-invocation: true
---

# Skill review

Review an instruction against the behavior it claims. Leave the file as it is.

## Do this

1. Name the target. Read the skill, rule, or instruction they named. This thread keeps the claim and the verdict.
2. Write the claim in one sentence. Take it from the target's description and from what they asked. The claim is the behavior a person gets when the instruction is followed.
3. List the steps a model must finish before that experience can happen. Count the reads, the judgements, and the lines the reply still has to hold.
4. Mark the steps a smaller model still does. It keeps a short step, a step at the end, and a step it can copy from an example. It drops a route that opens many files, a line that only names a persona, and a rule the reply cannot show.
5. Judge. If the claim depends on a step the smaller model drops, the judgement is no. Name that step. Yes only when the claimed behavior is itself a step that still runs.
6. Name the one change that moves the claimed behavior onto a step a smaller model still runs. Do not make that change.
7. Reply with the verdict. You are done when that verdict is the reply.

## Verdict

### Judgement

Yes, no, or only the part that still runs. The reason in one or two sentences.

### Claim

> [the sentence from step 2]

### What has to run

The steps from step 3. For each one, whether a smaller model still does it.

### One change

The change from step 6. The file stays as it is.

## Don't

- Edit the target.
- Agree because they hope the claim holds.
- Add a line that says the standard applies on every model. That line is not a step.
- Review code, a plan, or a proposal. That is `grill`.
- Spawn reviewers.

## Not this

- No target in the thread. Ask which instruction to review.
