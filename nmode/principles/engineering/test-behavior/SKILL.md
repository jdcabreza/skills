---
name: test-behavior
description: Tests the behavior a user or caller sees, and deletes tests locked to internals. Use when writing tests, reviewing tests, or deciding whether a test should exist.
disable-model-invocation: true
---

# Test Behavior

Write tests that emulate how users would use the codebase. Don't write tests for the sake of writing tests. If a test is tied to implementation details, rewrite it or delete it.

The user of a test is whoever calls the surface: a person using the product, or a caller of the public function, endpoint, or command. The test uses that surface and asserts the outcome they can observe.

## Do

1. Call the surface the user or the caller uses. Pass the input they would pass.
2. Assert the outcome they care about: the return value, the response, the persisted state, the visible error.
3. If a test fails after a rename, an inline, or a move, and the outcome did not change, rewrite it to assert the outcome or delete it.
4. Delete a test whose only job is coverage, call count, or locking the current private structure.
5. You are done when each test would still pass after an internal rewrite that keeps the same behavior, and each test would fail if that behavior broke.

## Don't

- Mock the unit's own helpers so you can assert call order.
- Assert a private function, a private call, or a snapshot of internal state.
- Add a test per branch of the current implementation.
- Keep a test that fails when the behavior is right.

## Not this

- A characterization test the user asked for while changing a legacy path. Pin the behavior the caller sees. Still don't pin the private calls.
- A missing test for a private branch. That absence is fine. A missing test for a user-visible behavior is in scope.

## Example

Agent default: the test mocks `calculateTax` and asserts `saveInvoice` was called once.

Do this: the test submits an invoice and asserts the stored total and the response status.
