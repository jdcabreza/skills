---
name: idempotent
description: Makes crashable or retryable operations converge to the same end state when run again. Use when writing code that can crash, retry, restart, time out, or run more than once, including jobs, webhooks, writes, and idempotency.
disable-model-invocation: true
---

# Idempotent

Always converge to the same end state when designing code that can crash or retry. A second run leaves that same fact.

The end state is the fact the operation claims when it succeeds: one payment for this order, one membership row, the message sent once. A second run, a crash in the middle, or a retry from the caller leaves that same fact. "The caller should only invoke this once" is not a design.

## Do

1. Name the end state in one sentence before you write the effect.
2. Key the effect on a natural identity the system already has: the order id, the event id, the unique constraint.
3. On a repeat, find that fact and leave it. Do not append a second row, send a second message, or advance a step twice.
4. Assume the process dies after the effect starts and before it records success. The next run finishes the end state or sees that it is already there.
5. Use the unique constraint, the conditional write, or the compare-and-set the system already has. A check in memory, then a write, is not enough when two runs can overlap.
6. You are done when you can describe the second run, and the database, the queue, and the user-visible result match the first success.

## Don't

- Insert on every attempt.
- Rely on a boolean you set at the end of the first attempt. A crash before that write must still be safe.
- Add a retry loop around an effect that appends.
- Treat a pure calculation as a problem. Running it twice is already safe.

## Not this

- A read, a render, or a function with no effect. Leave it.
- An effect that cannot retry, crash mid-write, or be delivered twice. Do not add an idempotency framework to it.

## Example

Agent default: a retry inserts another payment row for the same order.

Do this: the second run finds the payment for that order id and leaves it. One payment.
