---
name: redesign
description: Changes the shape when a new requirement would have changed that shape if it had been there from the start. Use when a new requirement is being added and the current shape would only hold it as a bolt-on. A field on a shape that already holds the fact stays a field.
disable-model-invocation: true
---

# Redesign

When a new requirement would have changed the shape if it had been there from the start, change the shape.

## Do

1. Write the shape you would have built if this requirement had been there from the start.
2. If the current shape already holds the fact, add the field and stop.
3. If it does not, change the shape. Those lines are the task.
4. When that shape change is more than one behavior, name the units and stop. Do not start the other units in this turn.
5. You are done when the shape can hold the requirement without a bolt-on, or the field was enough.

## Don't

- Bolt a field onto a shape that cannot hold the requirement.
- Leave the old shape beside the new one.
- Treat the shape lines as code the task does not touch.

## Not this

- The current shape already holds the fact. Add the field.
- The repo has no pattern for this interaction. That match is no precedent.

## Example

Agent default: orders now expire, so you add `expired` next to the three status flags.

Do this: a status that already includes expired would have been one field from the start. You replace the flags with that field.
