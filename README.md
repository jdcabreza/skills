# Skills

This directory holds the skills for agent work. Each skill is a `SKILL.md` the agent reads and follows.

Two kinds live here. A workflow skill runs at a stage you name. A principle skill lives under `nmode/principles/` and loads when its description matches the task.

Each `SKILL.md` is the procedure. This file says when to open it.

## Intended workflow

Set a repo up once. After that, `nmode` stays on while you choose an approach or write code. The other workflow skills wait until their stage.

### Set up

1. Run `/init-agent-repo` in the project. It asks for context and gotchas, infers a short Feature map and entry points list from the codebase, names what is missing, and waits. After you confirm the distill, it writes `AGENTS.md` (including Feature map and entry points when you confirmed any), a `CLAUDE.md` symlink, `GLOSSARY.md`, `CONTEXT.md`, README troubleshooting, and a gitignored `agent_space/` directory. If you name a pull request template, it writes that template and `.cursor/skills/write-pr-description/SKILL.md` in the project. Run it again to bring those files up to date with the skill: it distills from the existing agent files and asks whether context or business logic changed and whether any entry points moved.

2. Run `/setup-models` on this machine. It lists the Task models it can use. After you accept the list, it writes `~/.cursor/rules/nmode-models.mdc` with `alwaysApply: true`. Grill reads the `grill reviewers` line from that file. Cursor applies the rule to new sessions.

3. Run `/create-verification` in the project. It asks how you check the repo, then writes one skill per check and one skill that runs those checks in order and stops on the first failure. Then run `/create-verification-maintenance`. That writes the skill that updates those checks when a later change makes them wrong.

### Understand

Run `/how` when you need one behavior from the start of the path to the end. Each step cites a file or a symbol.

Run `/why` when you need the decision and the tradeoff. It reads `CONTEXT.md`, then a source-control or docs tool when one exists. If nothing recorded the choice, it says so.

Run `/huh` when you did not understand the last reply. It restates that reply in plain English.

### Decide and implement

Use `/nmode` when writing code, choosing an approach, or brainstorming. At the start it reads every principle description. It follows each principle whose description matches the task, including how the work will be checked at the end. If two principles disagree, it asks which to follow.

Open one workflow skill for the stage you are in.

A change that is already one sentence and one check stays in Agent mode. The agent does not write a plan for it.

A change with a significant blast radius goes to Plan mode. The agent switches. You do not pick the mode. `plan` adds a brief, a blast radius, the principles it followed, and units to the plan file. As soon as that file exists, the agent runs grill and writes that feedback into the plan. You edit the plan. The agent builds when you say to build.

A bug with an unknown cause follows Root Cause. Reproduce it, then trace it, before changing code. A second failure at the same check follows Assumptions.

A new interaction with no pattern in the repo follows Design Options. The agent shows two or three ideas and writes no code until you pick one.

When you want the paths before any code, run `/propose`. Two explorers each generate hypotheses with pros, cons, and proof. The main agent runs an intermediary pass between them, then returns the consolidated paths. It does not write a prototype.

When a unit finishes, Prove It runs the checks that unit can affect and pastes the path's request, response, log, or command output. It does not write an HTML file to show the result. The last unit runs every check the overarching verification skill names. If the project has no verification skill, Prove It reads `create-verification`. If a change makes a verification skill wrong and the project has no maintenance skill, Prove It reads `create-verification-maintenance`.

When the work is ready for a pull request, `nmode` reads `.cursor/skills/write-pr-description/SKILL.md` in the project. That skill fills the template from the brief, the units, and the verification output, and returns it as one fenced markdown block you can copy into the merge request. If the file is missing, `nmode` stops and says this repo has no pull request skill.

Run `/grill` to pressure-test code, a plan, or a proposal. Reviewers look for holes. The agent judges the findings. The code stays as you left it. When the target is a plan file, the feedback is written into the plan. A proposal with no file is revised in the reply. `plan` also runs grill as soon as it writes a plan.

`unslop` applies to any writing. It cuts the listed AI patterns and keeps the meaning.

## Where they fit

| Skill | When you use it | Stage |
| --- | --- | --- |
| `init-agent-repo` | Initialize or update a repo for agents, or add `AGENTS.md` and a glossary | Set up |
| `setup-models` | Configure models, or change the model budget | Set up |
| `create-verification` | Set up how agents confirm this repo | Set up |
| `create-verification-maintenance` | Keep those checks current after they exist | Set up |
| `how` | How one behavior works across the repo | Understand |
| `why` | Why a decision was made | Understand |
| `huh` | The last reply was unclear | Understand |
| `nmode` | Write code, choose an approach, or brainstorm | Decide and implement |
| `propose` | See two or three paths for an ask before any code | Decide and implement |
| Principles under `nmode` | The task matches that principle's description | Decide and implement |
| `plan` | Plan mode is writing or revising a plan | Plan |
| Prove It | A unit is finished, or you are about to claim the change works | Verify |
| `grill` | Pressure-test code, a plan, or a proposal | Review |
| `write-pr-description` | The work is ready for a pull request | Review |
| `unslop` | Any writing | Any stage |

`write-pr-description` lives in the project. `/init-agent-repo` writes it there when you name a template.

## Workflow skills

### nmode

Routes coding and brainstorming through the principle skills. Use it when writing code, choosing an approach, brainstorming, or with `/nmode`.

It is the mode for decide and implement. The result is a routed reply. It switches to Plan mode when the blast radius is significant. You do not pick the mode. It reads `propose`, `plan`, `how`, `why`, or the project's pull request skill only at that stage. A reply that followed a principle names that principle on the sentence it supports.

### propose

Spawns two explorers that each generate proposals for an ask, then acts as intermediary between them and returns the consolidated paths. Use it with `/propose`, or when you ask for proposals, paths, or hypotheses before any code.

A proposal is a hypothesis with pros, cons, and proof. Proof is a constraint, a behavior, or a path this product already has. The explorers use the first two models from `grill reviewers`. The main agent consolidates. It does not write code. It does not call `grill`.

### plan

Adds a brief, a blast radius, the principles used, and verifiable units to the Cursor plan, then runs grill and writes that feedback into the plan. Use it when Plan mode is writing or revising a plan, or when `nmode` is about to plan a change.

It reads `AGENTS.md` and `GLOSSARY.md` when the repo has them. The plan is the file Plan mode writes. It stops when that file is in front of you, after grill has added the feedback. A change that is already one sentence and one check stays in Agent mode.

### how

Traces how a behavior works end to end, with a citation on each step. Use it with `/how`, or when you ask how something works across the repository.

A question about why a decision was made goes to `why`. A restatement of the last reply goes to `huh`.

### why

Cites the decision and the tradeoff for a choice in the repository. Use it with `/why`, or when you ask why a decision was made.

It reads `CONTEXT.md` and the source-control or docs tools that exist. A question about how the code runs goes to `how`.

### grill

Spawns reviewers to interrogate code, a plan, or a proposal, then judges the findings. Use it with `/grill`, or when you ask to pressure-test one of those.

It reads `grill reviewers` from `~/.cursor/rules/nmode-models.mdc`. If that file is missing, it uses the two default models named in the skill. It leaves the code unchanged. When the target is a plan file, it writes the feedback into that file.

### huh

Restates the agent's last reply in plain English. Use it with `/huh`, or when you did not understand what was just said.

It can follow any other skill.

### unslop

Cuts AI tells from writing. It applies to any writing. The description says it must always apply.

The rule ids in the skill are stable. Other skills can cite them.

### init-agent-repo

Initializes or updates a repository for agent work. It asks for project context and gotchas, infers a short Feature map and entry points list from the codebase for you to confirm, scrutinizes the reply for holes, and distills after you clarify. Use it with `/init-agent-repo`, or when you ask to set up or refresh `AGENTS.md` or a glossary for agents.

It writes the repo files listed in the setup stage above. Confirmed entry points land in `AGENTS.md` under Feature map and entry points. A second run updates from the existing agent files and asks whether those paths moved.

### setup-models

Detects available Task models and writes the rule that sets grill's reviewers. Use it with `/setup-models`, or when you ask to configure models or change the model budget.

It overwrites `~/.cursor/rules/nmode-models.mdc` after you accept the list. Grill keeps reading that file.

### create-verification

Asks how this repository is verified, then writes one project skill that runs a specific verification skill for each way. Use it with `/create-verification`, or when you ask to set up verification.

The skills land in the project's `.cursor/skills/` directory. If an overarching verification skill already exists, this skill stops and points at the maintenance skill. After a fresh setup, it tells you to run `/create-verification-maintenance`.

### create-verification-maintenance

Writes the project skill that keeps this repo's verification skills true as the repo changes. Use it with `/create-verification-maintenance`, or when verification skills exist and you want them kept current.

This step writes the maintenance skill. A later change updates the checks. If the project has no overarching verification skill, it tells you to run `/create-verification` first. A request to verify the repo now follows that overarching skill.

## Principles

`nmode` loads a principle when the task matches its description. The description is only for routing. The body is the procedure. `disable-model-invocation` stays on. `nmode` loads the principle by reading it.

They apply while you decide and while you implement. You add a new principle as another `SKILL.md` under `nmode/principles/`. The `nmode` skill states the shape.

### Core

**Intent.** `nmode/principles/core/intent`. Derives what you want the change to do, and treats the code as how that intent is implemented. Use it when reading an ask, choosing an approach, or when the request names a mechanism, a file, or a pattern.

**Domain Facts.** `nmode/principles/core/domain-facts`. Names the actors, entities, types, and shared state, then reasons from those facts. Use it when choosing an approach, designing how something works, or introducing a type, entity, or shared state.

**Assumptions.** `nmode/principles/core/assumptions`. Checks assumptions you brought and assumptions the agent brought. After two failed fixes at the same gate, it challenges the shared assumption. Use it when an ask, a design, or a plan depends on a premise that is not in the code and not in what you just stated, or when a second attempt fails the same test, check, error, or review.

**Candor.** `nmode/principles/core/candor`. Replies with a real judgement, and declines or pushes back when that judgement is no. Use it when you ask the agent to do something, when it would otherwise agree by default, or when a recommendation would only validate the ask.

**Design Options.** `nmode/principles/core/design-options`. Presents two or three evidenced ideas and no code when an interaction has no precedent in the repo. Use it when brainstorming something new, when the repo has no pattern for this interaction, or before inventing a new kind of UI or flow.

**User First.** `nmode/principles/core/user-first`. Chooses the caller's experience over the easier implementation, at the API and at the class interface. Use it when a design or code choice can push work, data, or complexity onto you or the caller.

**Be Lazy.** `nmode/principles/core/be-lazy`. Deletes and simplifies first, then gets the most impact from the least code. Use it when writing or editing code, adding behavior, adding a file, type, or wrapper, or when the current code already does more than the ask needs.

**Verifiable Units.** `nmode/principles/core/verifiable-units`. Splits work into small units that can each be checked, committed, or merged on their own. Use it when planning a change, starting work that touches more than one behavior, splitting commits or merge requests, or deciding how to land the work.

**Encode Lessons.** `nmode/principles/core/encode-lessons`. Turns a repeated line or instruction into a lint, a check, or a script. Use it when the agent is about to write the same line, comment, or instruction again, or when more text would restate a rule a check can enforce.

**Prove It.** `nmode/principles/core/prove-it`. When a unit finishes, runs the checks that unit can affect, and proves the feature by pasting the request, the response, the log, or the command output. It does not write an HTML file to show the result. The last unit runs every check. Use it when finishing a unit, before claiming a change works, or when verifying behavior. If the project has no verification skill, it reads `create-verification`. If a change makes a verification skill wrong and the project has no maintenance skill, it reads `create-verification-maintenance`.

### Engineering

**Descriptive Code.** `nmode/principles/engineering/descriptive-code`. Writes code a reader can describe back. Domain names, plain control flow, and a comment only for a why or a gotcha. Use it when writing or editing code, naming identifiers, choosing a language feature or API, or when adding, editing, or reviewing comments.

**Types.** `nmode/principles/engineering/types`. Uses types so illegal states cannot be represented, and parses outside data only at the boundary. Use it when defining data, signatures, models, or states, when a value could be missing, conflicting, or a bare string, or when data crosses into the system.

**Pure Logic.** `nmode/principles/engineering/pure-logic`. Keeps business rules in pure functions and in a typed domain model, separate from I/O. Use it when writing domain rules, pricing, permissions, eligibility, or lifecycle, or when I/O and rules are in the same function.

**Idempotent.** `nmode/principles/engineering/idempotent`. Makes an operation that can crash or retry converge to the same end state when run again. Use it when writing code that can crash, retry, restart, time out, or run more than once, including jobs, webhooks, and writes.

**Root Cause.** `nmode/principles/engineering/root-cause`. Reproduces a failure, then traces it to the root cause before changing code. Use it when debugging, investigating a failure, or when the cause of a bug is not yet known.

**Test Behavior.** `nmode/principles/engineering/test-behavior`. Tests the behavior a user or caller sees, and deletes tests locked to internals. Use it when writing tests, reviewing tests, or deciding whether a test should exist.

### Delegation

**Context Window.** `nmode/principles/delegation/context-window`. Sends bulk context to a subagent and keeps a summary in the main thread. Use it when a task would load files, logs, search results, or other bulk into the main thread.

**Never Block.** `nmode/principles/delegation/never-block`. Proceeds on a reversible choice and shows the result. Use it when the agent is about to ask whether to do something you could undo after seeing the result.
