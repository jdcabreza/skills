---
name: how
description: >-
  Trace how a system surface works and write a comprehensive explanation.
  Use for /how, investigate playbook routing, or when a playbook says to run
  how over a code or infra surface.
disable-model-invocation: true
---

# How

Figure out how something works. Read-only. One explore subagent, model from the `how` line in the models file (path in the **harness terms** table in `../nathan-mode/SKILL.md`). If that file is missing, stop and tell the user to run `/setup-nstack`. Do not override the spawn to `nathan-agent`. Parent owns intent, synthesis, and the reply. Never pass the explore report through verbatim.

## Steps

1. Determine the user's intent. What do they really want to know about the system? Name the surface and the question in one or two sentences before spawning.
2. **Already-explored shortcut:** if the same surface was traced earlier in this chat with citations still in context, and no material file change for that surface has landed since that trace, do **not** respawn the explore agent. Synthesize from the prior report and skip to step 3. Otherwise spawn one explore agent (`run_in_background: true`, model from the `how` role; omit `model` when the role is `inherit-parent` or `auto`). Brief it with the intent and this checklist. Default thoroughness `medium`; use `very thorough` for wide or unfamiliar surfaces.
   - **Code.** Trace control flow from the relevant entrypoint until the surface is hit. Note the immediate vicinity. How was it triggered. Inputs, outputs, algorithms, transformations. Trace downstream impact.
   - **Infra.** Read Terraform (or the repo's infra layout) for the surface. Note providers, modules, and what the surface provisions or depends on.
   - **Docs.** If Confluence or similar MCP tools are available, search for existing diagrams, API docs, or runbooks for this surface. Skip quietly when no such MCP is present.
   - Return file paths, symbols, and short evidence notes. Do not write the final user doc.
3. Drain the explore report. Write the comprehensive doc below from the findings. Cite paths. Label claims per nathan-mode evidence rules when this skill runs under `/nathan-mode`. Apply the **unslop** skill to the draft.

## Doc shape

```markdown
# How: <surface>

## Overview
<what it is and what job it does>

## Key concepts
<terms, types, or components needed to follow the rest>

## How it works
<entry → surface → downstream. control flow, algorithms, transformations>

## Inputs and outputs
<what goes in, what comes out, contracts>

## Triggers and impact
<what fires it, who calls it, what breaks or changes downstream>
```

Drop a section only when it has nothing true to say. Add a short "Where it lives" list of paths when that helps navigation.

## Reply

The comprehensive doc.
