---
name: init-agent-repo
description: Initializes or updates a repository for agent work. Distills from existing AGENTS.md and related files when present, asks whether context or business logic changed and whether entry points moved, and brings files up to date with this skill. Infers a short Feature map and entry points list from the codebase for the user to confirm. Writes AGENTS.md with a fixed anti-slop Practices block, optional Feature map and entry points, a CLAUDE.md symlink, GLOSSARY.md, CONTEXT.md, README troubleshooting from gotchas the user names, the template the user names, .cursor/skills/write-pr-description/SKILL.md when the user names a template, and a gitignored agent_space directory. Use when the user asks to initialize or update a repo for agents, set up AGENTS.md, add a glossary for agents, or invokes /init-agent-repo.
disable-model-invocation: true
---

# Init Agent Repo

Ask what this repository is, or refresh it from existing agent files. Scrutinize the reply. Distill into facts, entry points, conventions, practices, vocabulary, and README troubleshooting. Write those into the files below.

`agent_space/` is a scratch space for AI agents to dump any files in. Agents can use this as they wish. It is gitignored. Facts and entry points live in `AGENTS.md`. Glossary terms live in `GLOSSARY.md`. Decisions live in `CONTEXT.md`. Gotchas and common issues live in README troubleshooting. Technical detail does not live in README. The pull request template lives at the path the user names. When the user names one, the skill that fills it is `.cursor/skills/write-pr-description/SKILL.md`. That skill is in the repo, so teammates use it.

Running this skill again updates the repo to match the current skill. It does not require a wipe.

## Do

1. Read the repo. README, existing `AGENTS.md`, `GLOSSARY.md`, `CONTEXT.md`, `.cursor/skills/write-pr-description/SKILL.md`, and `.gitignore`. Treat README as unverified overview only. Do not take architecture, API, or convention claims from it as distill facts. Prefer existing agent files, the code, and the user. If a pull request template is already in the repo, note its path. Infer a short Feature map and entry points list from the codebase layout: main areas and their paths. This is a one-time pass. Prefer top-level packages and directories that hold product code. Skip noise such as `node_modules`, build output, and vendor trees. Do not ask the user to invent that list.
2. When `AGENTS.md`, `GLOSSARY.md`, or `CONTEXT.md` already exists, this run is an update. Distill the current facts, entry points from `## Feature map and entry points`, conventions, project practices, terms, decisions, and template path from those files. Tell the user you will bring the files up to date with this skill. Ask whether any context or business logic has changed. Ask whether any entry points moved. Ask for gotchas or common issues to put in README troubleshooting. One ask, in the reply. Wait for the answer.
3. When those files do not exist, ask the user for project context directly. In the same ask, ask for gotchas or common issues to put in README troubleshooting. Ask only for what the repo does not already hold from confirmed sources. Do not treat README as a confirmed source. Do not ask the user to supply the entry point list. One ask, in the reply.
4. Scrutinize the reply. A hole is a gap that would leave a fact, an entry point area or path, a convention, a practice, a term, a template path, a decision, or a troubleshooting gotcha too vague for an agent to follow without asking again. A decision is a choice and the tradeoff. Present the holes in one reply. Skip a hole that does not change the files. When there are holes, wait for the user to clarify. When there are none, distill.
5. Distill. Show the facts, the entry points, the conventions, the fixed Practices block below, any project practices, the glossary terms, the template path, the decisions, and the README troubleshooting gotchas. Entry points in the distill are the list inferred in step 1, or the existing section on an update. When the user said entry points moved, or the section is missing, re-infer from the codebase and show that list. Mark the entry points as proposed from the code. The user confirms or corrects them. On an update, start from what the existing agent files held, then apply what the user said changed. The fixed Practices block is not optional. Ask the user to confirm. Write nothing before that confirmation. If the user asks to drop the fixed block, push back once. Then obey.
6. Write `AGENTS.md` from the confirmed distill. Include the fixed Practices block below, same words. Append any project practices the user confirmed after that block. Include the Feature map and entry points section below when the user confirmed any. Include the scratch space section below, same words.
7. From the repo root, symlink `CLAUDE.md` to `AGENTS.md`: `ln -s AGENTS.md CLAUDE.md`. Replace a broken or wrong `CLAUDE.md` link when needed.
8. Write `GLOSSARY.md` from the confirmed terms. One term, then the meaning the user gave.
9. Write `CONTEXT.md`. A decision the user confirmed is the choice, then the tradeoff. When the user confirmed none, write the heading and no decisions.
10. Write README troubleshooting from the confirmed gotchas. Use the README section below. Create README when the repo has none, with only Overview, Getting started, and Troubleshooting. When README already exists, add or replace only the Troubleshooting section. Leave Overview and Getting started as they are unless the user confirmed changes to them. Do not add technical detail outside Troubleshooting.
11. Write the pull request template at the path the user confirmed, using the text the user confirmed. Skip this step when the user gave no template.
12. When the user confirmed a template, write `.cursor/skills/write-pr-description/SKILL.md` with the skill below. Skip this step when the user gave no template.
13. Create `agent_space/`. Add a line `agent_space/` to `.gitignore` when no line already ignores that directory. Create `.gitignore` when the repo has none.
14. Show the paths you wrote or updated.

### AGENTS.md

```markdown
# Agents

## Project

<Distilled facts. What this repo is, who it is for, and what an agent must not break. Only what the user confirmed.>

## Feature map and entry points

Agents should adjust this based on code changes.

<Area>: <path the user confirmed.>

## Conventions

<How code and names are done here. Only what the user confirmed. Omit this section when the user gave none.>

## Practices

- Prefer the smallest change that meets the intent. Delete dead code before adding a layer.
- Name things for the domain. Comment only for a why or a gotcha.
- Do not invent facts, conventions, or behavior the user did not confirm.
- Prove a change with the check or output that path produces. Do not claim it works.
- Prefer a lint, test, or script over repeating the same rule in prose.
- Test what the caller sees. Do not lock tests to internals.
- Do not treat README as source of truth for architecture or API detail. Confirm with the user or the code.
- README holds only a quick overview, getting started, and troubleshooting. Put technical detail in AGENTS.md, GLOSSARY.md, CONTEXT.md, or the code.

<Any project practices the user confirmed. Append after the fixed list. Omit these lines when the user gave none.>

## Pull request template

`<path the user confirmed>`: the template `write-pr-description` fills. Omit this section when the user gave no template.

## Scratch space

`agent_space/` is a scratch space for AI agents to dump any files in. Agents can use this as they wish. It is gitignored. Create `agent_space/` if it is missing. Do not commit anything inside it.
```

Always write the fixed Practices list. Do not omit the Practices section. Omit Feature map and entry points when the user confirmed none. Each entry point row is a main area and a path, not a file inventory. Propose that list from the codebase. Write it only after the user confirms.

### README

When creating README:

```markdown
# <Project name the user confirmed>

## Overview

<One short paragraph from the confirmed project facts. No architecture or API detail.>

## Getting started

<Only steps the user confirmed. Omit this section when the user gave none.>

## Troubleshooting

<Gotcha the user confirmed>: <What to check or do.>
```

When README already exists, write only:

```markdown
## Troubleshooting

<Gotcha the user confirmed>: <What to check or do.>
```

A gotcha is a common issue when running or using this repo, such as expired credentials and checking `~/.aws/credentials`. Omit Troubleshooting entries the user did not confirm. When the user confirmed none, omit the Troubleshooting section on a new README, and leave an existing Troubleshooting section unchanged.

### GLOSSARY.md

```markdown
# Glossary

<Term>: <Meaning the user confirmed.>
```

A glossary term is a word humans and agents must use the same way. Omit a term the user did not confirm.

### CONTEXT.md

```markdown
# Context

A decision is a choice and the tradeoff. Write a decision only after the user confirms it.

## Decisions

<Choice>: <Tradeoff the user confirmed.>
```

Omit every decision entry when the user confirmed none.

### Write PR description

```markdown
---
name: write-pr-description
description: Fills this repository's pull request template from the brief, the units, and the verification output. Use when the work is ready for review, or when the user invokes /write-pr-description.
disable-model-invocation: true
---

# Write PR Description

Fill this repo's pull request template.

## Do this

1. Read the template path in `AGENTS.md`. Read that file.
2. Fill the template from the brief, the units, and the verification output already in the thread.
3. Leave a section blank when the thread does not have that fact. Name the blank section in one sentence.
4. Return the filled template as one fenced markdown block the user can copy into the merge request. The block is the description.

## Don't

- Invent a section the template does not have.
- Invent a result the verification did not produce.
- Copy the plan in full when the template asks for a summary.
- Surround the block with a restatement of the description.

## Not this

- `AGENTS.md` names no template. Stop. Say the template path is missing.
```

## Don't

- Invent a fact, an entry point, a convention, a practice, a term, or a gotcha the user did not confirm.
- Write entry points before the user confirms them. Proposing them from the codebase in the distill is required. Writing them without confirmation is not.
- Ask the user to invent the entry point list.
- Put entry points in `CONTEXT.md`. Decisions only live there.
- Take architecture, API, or convention claims from README as distill facts.
- Put technical detail in README outside Troubleshooting.
- Drop the fixed Practices block unless the user insisted after one push-back.
- Wipe existing agent files and re-interview from scratch when an update would do.
- Copy the interview into the files. Distill.
- Add a file this skill does not name.
- Write a secret value. Name the env var.
- Interrogate. One ask, then the holes, then the distill.

## Not this

- You presented a hole and the user has not clarified it. Wait. Distill nothing yet.
- The user has not confirmed the distill. Ask. Write nothing yet.
- Agent files already exist. This is an update. Distill from them, ask what changed, whether entry points moved, and for gotchas, then confirm before writing.
