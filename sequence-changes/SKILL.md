---
name: sequence-changes
description: >-
  Organize local work into atomic, individually verifiable commits or stacked
  PRs. Use for /sequence-changes, nathan-mode landing after verify, or when a
  playbook says to rebase into ordered atomic commits. Does not push or open
  MRs. Parent-only, never delegated.
disable-model-invocation: true
---

# Sequence Changes

Parent-only. In-process. No Task spawn. No setup model role. Runs on the parent chat model. Never delegate.

Playbooks own the branch. This skill rewrites local history into reviewable units. **open-pr** pushes and opens the MR afterward.

## Units

Each unit is a commit, or a stacked PR of commits when one MR would be too large or mixes concerns.

**Atomic** means the work is self-contained. Not a huge change. Good examples: wrote scaffold for a new feature, fixed data transformation for image intake. When we revert the commit, the codebase should still be working.

**Individually verifiable** means we can check that the change does what it claims. Example: fixed data transformation → does the data actually get transformed as intended?

Order units so the sequence proves the work (scaffold before feature, failing test before fix, subtraction before reshape). Foundations before consumers. Prefer one branch with ordered commits. Stack PRs only when the dependency is real or a single MR would bury review.

## Sequencing base

The sequencing base is the commit this branch's unique work starts from.

- First stack entry (or a solo branch): merge-base with the default branch (`develop`, `main`, or `master` as appropriate).
- Later stack entry: the prior stack tip that this branch was created from (its upstream / parent MR branch). Do not soft-reset a later tip to the default-branch merge-base. That would fold earlier stack commits into this rewrite.

## Steps

1. Confirm the current branch is `feature/<branch-name>` or `bugfix/<branch-name>`. If it is not, stop. Do not create a branch here. Do not sequence on `develop`, `main`, or `master`.
2. Resolve the sequencing base (see above). Survey the work against that base (`git status`, `git log`, `git diff` vs the base). Include uncommitted changes and existing commits unique to this branch. Name the logical units you see and the check that makes each one verifiable.
3. If the units are already ordered, atomic, and each has a clear verify story, stop. Report that. Otherwise plan the target sequence: unit title, paths or hunks, verify check, and whether the unit is a commit on this branch or its own stacked PR.
4. Rewrite into that sequence. Prefer a soft reset to the sequencing base, then stage named paths or hunks and commit each unit in order. For large already-landed blobs, reorganize the code so each unit is self-contained before committing it. Never use interactive rebase (`git rebase -i` or any `-i` git command). Never discard work: if a rewrite is risky, snapshot first (`git branch backup/<branch>-pre-sequence-<timestamp>` or an equivalent recoverable ref). Do not push. Do not force-push.
5. If stacking PRs, create each additional `feature/` or `bugfix/` branch locally with the prior stack tip as its base, and leave the matching commits on it. When you later sequence that later tip, its sequencing base is that prior tip. Do not open MRs here. Hand **open-pr** one stack entry per invocation unless the user asks for the whole stack.
6. Sanity-check the final tip matches the intended tree. Spot-check that each unit still reads as atomic and verifiable. If an intermediate commit is supposed to keep the tree working, verify the ones you can cheaply; say so when you could not.

## Reply

The unit list in order (commit subjects or stacked PR titles), the verify check for each, the sequencing base used, the branch or stack tips involved, and whether **open-pr** should run next on one tip or walk the stack.

## Notes

- **document** and **authoring a skill** skip this skill. Do not run it for those playbooks unless the user asks.
- Do not invent verify checks. Use proof the playbook already produced when it still applies to the unit. If a unit has no check, say so before handing off to **open-pr**.
- Commit messages: one thought per unit. No "and" subjects that hide a second change.
- This skill does not push, open MRs, or mark plan boxes shipped. That is landing via **open-pr** and the parent.
