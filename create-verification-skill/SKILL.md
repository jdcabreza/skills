---
name: create-verification-skill
description: >-
  Scaffold repo verification skills under .cursor/skills/verify-<repo>/ with
  leaf verify-* commands, README Verification bullets, AGENTS.md pointer, and a
  maintain-<repo>-verification stub. Use when a greenfield or thin repo needs
  an app-works verify path before L2 delegation.
disable-model-invocation: true
---

# Create verification skill

Scaffold an **app-works** verification tree for the current repo. This does not forbid throwaway `agent_space/` scripts for signals skills miss. Prefer both: skills for repeatable checks; scripts when skills cannot observe the signal.

## Before you start

1. Confirm the **repo short name** (slug for paths), e.g. `address-parser` → `verify-address-parser`.
2. Confirm target root: usually the app repo’s `.cursor/skills/` (project skills), not `~/.cursor/skills/`.
3. If `AGENTS.md` is missing, note that in the brief/README risk; still scaffold verify skills. Taste still needs AGENTS.md separately.

Do **not** copy proprietary trees from other companies into this skills repo. When useful, name public or known-good patterns in prose only (e.g. address-parser-style leaf = one Makefile target; kyc-pipeline-style = one HTTP or job dry-run per leaf).

## Layout to create

```
.cursor/skills/
  verify-<repo>/
    SKILL.md                 # overarching: when to run which leaf
    verify-<check-a>/
      SKILL.md               # one command + pass criteria
    verify-<check-b>/
      SKILL.md
  maintain-<repo>-verification/
    SKILL.md                 # stub; refresh via create-verification-maintainer-skill
```

## Steps

1. Create `verify-<repo>/SKILL.md` with frontmatter `name: verify-<repo>`, a short description, and `disable-model-invocation: true` if the overarching skill should stay user-invoked. Body: how to pick leaves, order if any, and that inconclusive is not a pass. Point at throwaway `agent_space/` scripts when a signal is not covered by a leaf.
2. Add leaf skills `verify-<check>/SKILL.md`. Each leaf:
   - frontmatter: `name`, `description`, **`disable-model-invocation: true`**
   - exactly **one** primary command (Makefile target, script, or documented CLI)
   - explicit **pass criteria** (exit code, log line, assertion)
   - no product-code edits; verify only
3. Add or extend README **Verification** bullets: list the overarching skill and each leaf in one line each.
4. If `AGENTS.md` exists, add a **pointer-only** line to `verify-<repo>/` (no duplicated command tables). If absent, say so in your reply and still ship the skills.
5. Stub `maintain-<repo>-verification/SKILL.md` with name/description and a one-paragraph “run create-verification-maintainer-skill to fill triggers.” Do not invent repo-specific Makefile/CI rules in the stub.
6. Validate: every new skill has `name` + `description`; leaf paths resolve; README bullets match leaf names.

## Reply

Repo slug, paths created, leaf commands, whether AGENTS.md was updated or absent, and any checks left to a throwaway script on purpose.
