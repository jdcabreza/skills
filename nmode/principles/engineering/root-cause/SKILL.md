---
name: root-cause
description: Reproduces a failure, then traces it to the root cause before changing code. Use when debugging, investigating a failure, or the cause of a bug is not yet known.
disable-model-invocation: true
---

# Root Cause

When debugging, trace symptoms to root causes and always reproduce first. Keep asking why until you reach the root.

The root is the cause where a fix removes the failure, and a fix one layer up would only hide it. "The function received null" is a symptom until you know why it received null.

## Do

1. Reproduce the failure before you change code. Same input, same failure. Write down the input and the result.
2. If you cannot reproduce it, say so. Do not patch from a guess.
3. From the failure, ask why. Then ask why of that answer. Stop when changing that cause removes the reproduced failure, and a guard, a default, or a retry above it would leave the cause in place.
4. Fix that cause. Add a guard at the crash site only when that site is the boundary that should have rejected the bad value.
5. Run the reproduction again. The failure is gone. Nearby behavior you did not mean to change is still there.
6. You are done when you can point to the cause, the fix, and the reproduction that now succeeds.

## Don't

- Start with a null check, a broader catch, a default value, or a retry at the line that threw.
- Stack a second guess on top of an unreproduced first guess.
- Stop at the first frame in the stack trace.
- Keep asking why into product strategy after the reproduced failure is gone.

## Not this

- A typo or a wrong literal you can see, and the reproduction is the line itself. Fix the line.
- A failure you already reproduced and traced in this session. Fix the cause you found. Do not restart the search to look diligent.
- The second failed fix at the same gate. Follow **Assumptions**.

## Example

Agent default: the page crashed on `user.name`, so you write `user?.name`.

Do this: you reproduce the crash. The loader returns a user before the profile exists. You change the loader so a user exists only when the profile is there. The crash input now renders.
