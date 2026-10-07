---
name: types
description: Uses types so illegal states cannot be represented, and parses outside data only at the boundary. Use when defining data, signatures, models, or states, when a value could be missing, conflicting, or a bare string, or when handling requests, webhooks, third-party clients, library calls, or other data crossing into the system, or when adding a defensive check inside the system.
disable-model-invocation: true
---

# Types

Use types where possible to prevent misuse of code. Make illegal states unrepresentable. Parse outside data once, where it enters, then trust the internal type.

The type is the constraint. If a value would be a bug, the caller should be unable to write it. A comment that lists the legal values is not a type. A boundary is where data enters your code from outside your types: an HTTP request, a webhook, a queue message, a third-party response, or an untyped library. Internal code is everything after a successful parse.

## Do

1. Give the value a type that names the domain, not a bare string, a bare number, or an untyped bag.
2. Make illegal combinations unwritable. One variant for the state. Not two booleans that can both be true. Not several optional fields the caller must keep in sync.
3. Put required data on the variant that needs it. An invited user has no password field. A disabled account has no "active since" field.
4. At the boundary, check the shape and parse it into that type. Fail there. Drop a value that failed the parse. Do not pass a partial object, a nullable, or `any` inward.
5. Pass the internal type inward. Callers inside the system do not re-check fields the type already guarantees. Do not cast it away.
6. When a library's types are loose or wrong, parse its result at the call. The rest of the code sees your type.
7. When the check fails, fix the type or the caller. A cast, `any`, or a suppression is a bug in the type.
8. In a language without static types, use one schema, constructor, or parser at the boundary and keep that structure inside.
9. You are done when a wrong state does not compile, or does not pass the single boundary parser, and a search for the same guard inside the system finds nothing.

## Don't

- Use `status: string` and a comment that lists the statuses.
- Add `isOpen` and `isClosed`, or `role` plus `isAdmin`, so two fields can disagree.
- Widen the type to get the code to compile.
- Build a type hierarchy for a value that is already a clear local used once, when no caller can misuse it.
- Repeat `if email is a string` in the handler, the service, and the rule.
- Trust JSON, a form body, or a client SDK value as your domain type because the field names match.
- Add an internal guard "to be safe" on a value that already has the internal type.
- Catch a bad payload deep in the stack and turn it into a default.

## Not this

- A throwaway script whose values never cross a caller. Still don't introduce a stringly state. Do not build a framework of types around it.
- A third-party type you do not control. Parse it into yours at the edge. Do not edit their types by casting.
- A function you just wrote, called only with a value of your internal type. Trust it.
- A check that encodes a business rule, such as "this account cannot buy this". That belongs in **Pure Logic**, and it runs on the parsed model.

## Example

Agent default: `status: string`, plus `isAdmin: boolean`, and every function checks `typeof email === "string"`.

Do this: the handler parses the body into `CreateUser`. `status` is `active | invited | disabled`. Admin is one role variant. `createUser` takes a `CreateUser` and uses the email.
