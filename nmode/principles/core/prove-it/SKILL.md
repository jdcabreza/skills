---
name: prove-it
description: When a unit finishes, runs the verification checks that unit can affect, and proves the new feature by pasting the request, the response, the log, or the command output. Do not write an HTML file to show the result. When the last unit finishes, runs every check. Unit tests are not enough. Use when finishing a unit, before claiming a change works, or when verifying behavior. Uses create-verification and create-verification-maintenance when that skill or its maintainer does not exist yet.
disable-model-invocation: true
---

# Prove It

When a unit of work is finished, show two things. The checks this unit can affect still pass. The new feature works. Unit tests are not enough.

The new feature works when you run the path this unit changed and the reply contains that run. Paste the request and the response, the new log line, or the command output. Do not write an HTML file, page, or report to show the result.

When the last unit is finished, show that the repository still works. That means every specific verification skill has run, including a check the last unit did not touch.

## Do

1. Do this at the end of the unit, before the next unit starts.
2. Run the specific verification skills this unit can affect. Name each one and why this unit can affect it. A check this unit cannot affect waits.
   - When this unit made a verification skill wrong, follow this repo's verification maintenance skill first, then run the checks. When that maintenance skill does not exist, read `create-verification-maintenance` and follow it, follow the maintenance skill it wrote, then run the checks.
   - When the repo has no verification skill, read `create-verification` and follow it, then run the checks it describes.
3. When this unit is the last one, follow this repo's overarching verification skill. Run every specific check it names.
4. Show that the new feature works. Run the path the user or the caller will hit for this unit. If that path is already one of the specific checks, use the output from that check.
5. In the reply, paste the outputs you ran. That is the request and the response, the log, or the command output.
6. If you cannot run one of them, say what you did not run and why. Do not claim that part works.
7. You are done when the reply contains those outputs, or a stated reason for the one you could not run.

## Don't

- Treat a passing test suite as either proof.
- Describe the output you expect without running it.
- Write an HTML file, page, or report to show the result.
- Skip a check this unit can affect.
- Run the full suite before the last unit.
- Invent a start command, a path, a credential, or an expected result.
- Claim the feature works because the checks passed.

## Not this

- A docs-only or comment-only change. Say that there is no behavior to run.

## Example

Agent default: "Unit tests passed, so the endpoint works."

Do this: this unit changes checkout, so you run `verify-checkout`. The reply includes that result and the new endpoint's status and body. Health waits. After the last unit, you run `verify-shop`, and the reply includes health too.
