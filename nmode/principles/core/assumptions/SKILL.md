---
name: assumptions
description: Checks assumptions the user brought and assumptions you brought, and stops after two failed fixes at the same gate to challenge the shared assumption. Use when an ask, a design, or a plan depends on an assumption or premise that is not in the code and not in what the user just stated, or when a second attempt fails the same test, check, error, or review, or when about to try a third fix for the same failure.
disable-model-invocation: true
---

# Assumptions

An assumption is something the change needs that you cannot point to in the code or in what the user just stated. The user's can be wrong. Yours can be wrong. Work until the assumptions make sense. After two failed fixes at the same gate, stop and challenge the assumption those fixes shared.

A gate is the same test, the same error, the same check, or the same review comment. A fix is a code change aimed at that gate. Reading the code and reproducing the failure are not fixes.

## Do

1. Before you settle an approach, name the assumptions the change needs. Separate the user's from yours. A guess you have not checked is yours.
2. Check each one against the code, the real input, or what the user just stated.
3. If you cannot check it, ask the user. Ask the assumption that changes the design. Do not ask the rest.
4. When the user's assumption and the evidence disagree, show both. Decide together which one stands. Do not override the user in silence. Do not keep a false assumption in silence.
5. After the second failed fix at the same gate, stop editing. Name the assumption both fixes shared. Typical ones: the test is the real input, the bug is in this function, the shape of the data is right, the gate is right.
6. Check that assumption against the real input, the caller, and the code that produced the value. Find which assumption is false.
7. If the false assumption is a requirement the user stated, ask before dropping it. If the assumption is yours or the code's, drop it and fix from the new one.
8. You are done when the change rests only on assumptions that still hold, and the next edit would be wrong if a dropped assumption were true.

## Don't

- Treat the ask as proof of its assumption.
- Treat your reading of the code as proof when you did not look.
- Build, then mention the assumption you used.
- Swap in a new assumption and continue without the user when it changes the result.
- Try a third variation of the same patch.
- Loosen the assertion, widen the timeout, or catch the error so the gate goes green.
- Add another guard at the line that failed.

## Not this

- A fact you can point to in the code or in what the user just stated. Use it.
- The first failure. Fix it. If you have not reproduced it and traced it, follow **Root Cause**.
- A new failure at a different gate. Treat that as a new problem.
- Two failures that only look related. Say why they are the same gate before you stop.

## Example

Agent default: the user says the bug is a null user, so you add a null check. The test fails again, so you add another.

Do this: you have not seen a null user. You show the value the path returns. Both fixes assumed the fixture was the real input. The fixture never set the field the path requires. You fix the fixture, or you fix the path the real input takes. You edit after that.
