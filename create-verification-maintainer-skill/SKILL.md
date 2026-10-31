---
name: create-verification-maintainer-skill
description: >-
  Write or refresh maintain-<repo>-verification with repo-specific triggers
  (Makefile, routes, CI, jobs) and rules for which verify-* leaf to edit. Use
  after create-verification-skill or when verify leaves drift from the app.
disable-model-invocation: true
---

# Create verification maintainer skill

Keep `verify-<repo>/` honest as Makefile targets, routes, job YAML, and CI drift.

## Before you start

1. Confirm `verify-<repo>/` exists (run **create-verification-skill** first if not).
2. Gather repo triggers: Makefile/`just` recipes, HTTP routes or health checks, CI workflow job names, dry-run or table-driven harnesses.
3. Prefer editing the **leaf** that owns the command. Do not fold unrelated checks into one leaf.

## Steps

1. Write or refresh `.claude/skills/maintain-<repo>-verification/SKILL.md`:
   - frontmatter: `name: maintain-<repo>-verification`, description, `disable-model-invocation: true`
   - **Triggers:** what file or surface changes should cause a leaf edit (e.g. Makefile target rename → that leaf; new public route → new leaf or route leaf)
   - **Leaf map:** table of leaf name → command → pass criteria → when to edit
   - **Rules:** one command per leaf; inconclusive is not a pass; throwaway `agent_space/` scripts remain valid for signals no leaf covers; do not commit verification artifacts into the app as proof files
2. Optional: split sub-maintainers only when the map is large (e.g. makefile vs HTTP vs dry-run). Prefer one maintainer skill first.
3. Cross-check leaf `SKILL.md` files still match real commands. Update leaves that drifted. Add leaves for new critical paths. Delete leaves for removed commands.
4. Point README Verification bullets at any new or renamed leaves.
5. Validate: maintainer frontmatter present; every mapped leaf path exists; no leaf documents a command that is gone from the repo.

## Reply

What drifted, which leaves changed, trigger summary, and any signals still covered only by throwaway scripts.
