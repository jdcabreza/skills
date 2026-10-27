# Verification contract

Shared rules for VERIFY and REPORT on change work (**implement**, **bugfix**, **refactor**) and for plan **Proof** / MR bodies.

## What VERIFY may include

- Repo verification skills (`verify-<repo>/` and leaf `verify-*`) when they fit the signal.
- Pin harnesses (tests or scripts that lock behavior for refactors).
- **Gitignored `agent_space/` throwaway scripts** when skills miss the signal (example: start a process, assert log lines, exit non-zero on miss). Skills that only hit an endpoint and exit are not enough when the needed signal is a log line, side effect, or multi-step flow.

Inconclusive is not a pass.

## Required REPORT fields

Worker (or parent-in-`pair`) REPORT must include:

- **Commands** run (skill paths or script paths).
- **Outcomes** with **verbatim** output for the decisive checks.
- **Scope** touched (paths).
- **Evidence labels** on material claims (`measured` / `observed` / `inferred` / `guess`).

## Where proof lives

Copy proof into the plan file’s **Proof** section (when orchestrating) and into the MR description. Do **not** commit a verification artifact into the product or skills git tree (no `.cursor/verification/<branch>.md` on the branch as the ship vehicle). Local throwaway notes under gitignored paths are fine while working.
