---
name: init-agent-repo
description: Initializes a repository for agent work. Asks the user for project context, scrutinizes the reply for holes, and distills after the user clarifies. Writes AGENTS.md, a CLAUDE.md symlink, GLOSSARY.md, CONTEXT.md, the template he names, .cursor/skills/write-pr-description/SKILL.md when he names a template, and a gitignored agent_space directory. Use when the user asks to initialize a repo for agents, set up AGENTS.md, add a glossary for agents, or invokes /init-agent-repo.
disable-model-invocation: true
---

# Init Agent Repo

Ask what this repository is. Scrutinize the reply. Distill the clarified reply into facts, conventions, practices, and vocabulary. Write those into the files below.

`agent_space/` is a scratch space for AI agents to dump any files in. Agents can use this as they wish. It is gitignored. Facts live in `AGENTS.md` and `GLOSSARY.md`. Decisions live in `CONTEXT.md`. The pull request template lives at the path he names. When he names one, the skill that fills it is `.cursor/skills/write-pr-description/SKILL.md`. That skill is in the repo, so teammates use it.

## Do

1. Read the repo. README, existing `AGENTS.md`, `GLOSSARY.md`, `CONTEXT.md`, and `.gitignore`. Note only what those files state. If a pull request template is already in the repo, note its path.
2. If `AGENTS.md`, `CLAUDE.md`, `GLOSSARY.md`, `CONTEXT.md`, or `.cursor/skills/write-pr-description/SKILL.md` already exists, stop. Ask whether to replace it. Write nothing until the user answers.
3. Ask the user for project context directly. One ask, in the reply. Ask only for what the repo does not already hold.
4. Scrutinize the reply. A hole is a gap that would leave a fact, a convention, a practice, a term, a template path, or a decision too vague for an agent to follow without asking again. A decision is a choice and the tradeoff. Present the holes in one reply. Skip a hole that does not change the files. When there are holes, wait for the user to clarify. When there are none, distill.
5. Distill. Show the facts, the conventions, the practices, the glossary terms, the template path, and the decisions. Ask the user to confirm. Write nothing before that confirmation.
6. Write `AGENTS.md` from the confirmed distill. Include the scratch space section below, same words.
7. From the repo root, symlink `CLAUDE.md` to `AGENTS.md`: `ln -s AGENTS.md CLAUDE.md`.
8. Write `GLOSSARY.md` from the confirmed terms. One term, then the meaning the user gave.
9. Write `CONTEXT.md`. A decision he confirmed is the choice, then the tradeoff. When he confirmed none, write the heading and no decisions.
10. Write the pull request template at the path he confirmed, using the text he confirmed. Skip this step when he gave no template.
11. When he confirmed a template, write `.cursor/skills/write-pr-description/SKILL.md` with the skill below. Skip this step when he gave no template.
12. Create `agent_space/`. Add a line `agent_space/` to `.gitignore` when no line already ignores that directory. Create `.gitignore` when the repo has none.
13. Show the paths you wrote.

### AGENTS.md

```markdown
# Agents

## Project

<Distilled facts. What this repo is, who it is for, and what an agent must not break. Only what the user confirmed.>

## Conventions

<How code and names are done here. Only what the user confirmed. Omit this section when the user gave none.>

## Practices

<How work is done here. Only what the user confirmed. Omit this section when the user gave none.>

## Pull request template

`<path he confirmed>`: the template `write-pr-description` fills. Omit this section when he gave no template.

## Scratch space

`agent_space/` is a scratch space for AI agents to dump any files in. Agents can use this as they wish. It is gitignored. Create `agent_space/` if it is missing. Do not commit anything inside it.
```

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

<Choice>: <Tradeoff he confirmed.>
```

Omit every decision entry when he confirmed none.

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

- Invent a fact, a convention, a practice, or a term the user did not confirm.
- Copy the interview into the files. Distill.
- Add a file this skill does not name.
- Write a secret value. Name the env var.
- Interrogate. One ask, then the holes, then the distill.

## Not this

- You presented a hole and the user has not clarified it. Wait. Distill nothing yet.
- The user has not confirmed the distill. Ask. Write nothing yet.
- Those files already exist and the user has not said to replace them. Stop.
