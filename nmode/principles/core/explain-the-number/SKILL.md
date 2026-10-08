---
name: explain-the-number
description: Names what limits a measured number and rules out that the number measured something else, before the number is trusted, reported, or acted on. Use when a task would trust, report, or act on a speedup, regression, throughput, latency, or other measured number.
disable-model-invocation: true
---

# Explain the Number

Before a measured number is trusted, reported, or acted on, name what limits it and rule out that it measured something else.

## Do

1. Name the resource or code path that bounds the number. Take it from a run, not from a guess while reading the code.
2. List what else the number could be measuring. Errors, skipped work, a cache, noise, a piece too small to matter. Rule each out with a run.
3. Keep the run count, the spread, and the limiter with the number.
4. You are done when a reader can check the claim from that evidence.

## Don't

- Report a number that has no named limiter.
- Treat a plausible printout as the measurement.
- Depend on a benchmark skill from another plugin.

## Not this

- The task is to show the feature works. Follow **Prove It** and paste the output.

## Example

Agent default: one run prints a 2x speedup, so you report the speedup.

Do this: the profile shows the limiter, the run count and the spread sit with the number, and a failed-request count rules out that the speedup was skipped work.
