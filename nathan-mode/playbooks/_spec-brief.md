# Spec brief

Shared contract for **implement**, **bugfix**, and **refactor**. Alignment is this brief. Soft “for user verification” narration is not a gate.

Parent drafts the brief in Align. Ends the turn with **Waiting on you:** and does not create a branch, spawn a code delegate, or land until explicit go. User-alignment and brief-approval todos stay **pending** until that go. Do not mark them completed when the brief is only drafted.

Save the approved brief under `agent_space/` when that directory exists, otherwise under `docs/` (or a path the user names). Pass workers the **path**, not an inlined copy of the brief or of diffs.

## Brief sections

Fill every section that applies. Mark N/A only when the section truly does not apply.

### Outcome

Observable behavior or refactor end state. What a verifier can check.

### Non-goals

What this change must not do.

### Context

Who asked, why, trigger.

### Current behavior

Required for **refactor**. For others when not obvious.

### Intended impact

Downstream effects the human cares about.

### Implications

Prod, ops, data, compliance, consumers. Carry forward investigate output when it exists. Do not re-debate implications in a long implement thread.

### Architecture and placement

Paths to extend in **this** repo. Prefer existing packages and layouts. Forbidden: new top-level packages, modules, or parallel stacks unless this brief lists them. Point at `AGENTS.md` when present.

### Naming and semantics

Domain terms, fields, APIs. Front-load naming so workers do not invent synonyms.

### Approach

High-level steps only. Not a commit-by-commit script.

### Verify checklist

Prefer repo verification skills when they fit. Allow listed throwaway scripts (usually under a gitignored `agent_space/`) when skills miss the signal. Each item: command or skill path, and what pass looks like. Proof goes into the worker REPORT and later into plan **Proof** / MR body. Never commit a verification artifact into the product or skills tree as part of verify.

### Land

Branch name (`feature/<name>` or `bugfix/<name>`), stack base if any, MR notes.

### Behavior pin / reader-load intent

**Refactor only.** What pins equivalence. What reader-load change is intended.

## Playbook return shapes

| Playbook | Before work (return full brief, wait for go) | After land (L2 reply) |
|----------|-----------------------------------------------|------------------------|
| **implement** | Context, outcome, impact, implications, architecture and placement, naming, approach, verify checklist, land | Built, significant decisions, open decisions, MR + proof |
| **bugfix** | Stop 1: problem brief + repro plan. Stop 2: after root cause, updated brief with cause, proposed fix, architecture, naming, verify, land | Broken, root cause, fix, verbatim repro fail/pass |
| **refactor** | Context, behavior today, impact, judgment if justified, behavior pin, target shape, architecture, reader-load intent, verify, land | Behavior held, structural delta, pin proof, reader-load delta |

## Slim worker brief

Parent passes **file pointers**, the approved brief path, and the verify checklist. No inlined diffs, whole files, or a second copy of the brief body.

```
GOAL: one sentence. the outcome.
SCOPE: paths to change and paths not to change.
CONTEXT: approved brief path; AGENTS.md path if present; plan PR id / box text pointers; other file pointers to read.
ACCEPTANCE: checkable criteria, one per item (from brief Outcome / Approach).
VERIFY: checklist from the brief. Prefer repo verify skills when they fit; allow listed agent_space/ throwaway scripts otherwise. Include known gotchas.
TIMEBOX: rough cap. on expiry, return partial findings and stop.
FORBIDDEN: force-push; remote push; open-pr; landing; fixes outside SCOPE; new top-level packages/modules unless the brief lists them; committing verification artifacts; inventing clean abstractions that bypass Architecture and placement / AGENTS.md.
REPORT: proof of work. commands run and verbatim outcomes. scope touched. evidence labels (measured/observed/inferred/guess). suggested follow-ups.
```

### Compact rules for every worker

- Read `nathan-mode/SKILL.md` Principles **once per branch scope**, not every message. Read the relevant playbook section for this box.
- Label material claims with sureness in the same sentence.
- Tag decisions with the principle that shaped them, inline.
- Extend listed paths. Do not invent parallel stacks.
- Run VERIFY from this brief. Paste verbatim command output into REPORT.
- Parent lands. Worker does not push or open MRs.
