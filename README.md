# nstack

a repository containing skills and workflows that i use day-to-day to ship code.
ideas heavily taken from [pstack](https://github.com/cursor/plugins/tree/main/pstack).
adjusted based on my constraints, ideas, and personal workflow.

also a personal attempt to better understand modern agentic workflows and how to better utilize agents.

## context

i work in a fintech environment where it's prudent to know what's going on. we're not _that_ free to break things.
humans remain accountable for the code we put out. when something breaks, we affect real people and their banking.
hopefully, this set of skills allows us to:
- maintain a low-level understanding of and agency within our codebases
- put out high-quality code that doesn't sloppify our codebases
- still take advantage of what agents enable: ease of writing code

plus, i don't have a large token budget so i tried to make this cheaper to use. hehe.

## getting started

works in Cursor and Claude Code. no plugin or marketplace needed.

1. clone this repo anywhere except inside `~/.cursor/skills`. Cursor would load each skill twice. cloning straight into `~/.claude/skills` works; Claude Code also writes its synced org skills to `synced/` there, which `.gitignore` covers.
2. run `./install.sh`. it symlinks each skill into `~/.claude/skills` and `agents/nathan-agent.md` into `~/.claude/agents`. Cursor reads both for Claude compatibility. it also copies the always-on `nstack-discipline` rule to `~/.claude/rules/` and `~/.cursor/rules/`. that rule keeps sureness and principles on without re-inlining `nathan-mode` every turn. `git pull` updates skills; rerun `./install.sh` to refresh the rule.
3. restart the harness, then run `/setup-nstack` to pick models per role. run it once in each harness you use, since model slugs differ. Cursor writes `~/.claude/nstack-models-cursor.md`. Claude Code writes `~/.claude/nstack-models-claude.md`.

**cost profile:** after setup, lean tiers are fine. prefer fewer judgement spawns and fresh chats over downgrading implement further. `inherit-parent` / `auto` for write-review only when you still run it (long docs); routine MRs skip write-review. savings come from delegation, no skill re-inline, and lite open-pr — not from skipping verify. never use `fast` or `max`.

## usage

### nathan-mode

`/nathan-mode` is the main catch-all skill. it'll read your request, pick from a set of playbooks, and orchestrate across the other skills as needed. i typically just use this unless i have a specific set of steps to run.

sibling skills live at the same level as `nathan-mode/` in this repository.

| skill | use when |
| --- | --- |
| `/nathan-mode` | default entry point. picks a playbook for code changes, investigation, docs, plans, skill edits. call `/design` when you want a parallel approach panel outside a playbook. |
| `/setup-nstack` | run `install.sh` and configure models per role. |
| `/how` | figure out how something works. |
| `/why` | get the motivation and intent behind why something was built that way. |
| `/unslop` | clean up writing. removes AI tells. |
| `/huh` | rewrite the last agent reply into plain language a tired engineer can follow. |
| `/write` | technical writing. docs, RFCs, READMEs, PR descriptions, commit messages. writer then audience reviewer. |
| `/design` | parallel panel of 2-3 models plus a judge. use when a playbook says so, or when you want approaches without writing code yet. |
| `/sequence-changes` | organize local work into atomic, verifiable commits or stacked branches. does not push. |
| `/open-pr` | push the scoped branch, open a GitLab MR with `glab`, comment `cursor review` for Bugbot. default last step of change playbooks unless you say otherwise. GitLab-only. |
| `/create-verification-skill` | scaffold `.claude/skills/verify-<repo>/` plus leaf `verify-*` skills, README Verification bullets, AGENTS.md pointer, and a `maintain-<repo>-verification` stub. for greenfield or thin repos before L2. |
| `/create-verification-maintainer-skill` | write or refresh `maintain-<repo>-verification` with repo-specific triggers and which leaf to edit when Makefile/routes/CI drift. |
| `/review` | mine recent local `/nathan-mode` chats for trust/cost/friction patterns; rundown + **Waiting on you:** before handing off to a playbook. does not edit skills itself. |

`authoring a skill` also uses the harness's skill authoring skill: `/create-skill` in Cursor, `skill-creator` in Claude Code.

code and orchestrate workers use `subagent_type: "nathan-agent"`. source file is `agents/nathan-agent.md`. routed skills (`how`, `why`, `design`, `write`) keep their own spawn shapes in `nathan-mode/SKILL.md`. parent-only skills (`unslop`, `huh`, `sequence-changes`, `open-pr`) never spawn subagents. per-harness tool names and file paths live in the **harness terms** table in `nathan-mode/SKILL.md`.

landing defaults to `sequence-changes` then `/open-pr` after the parent reviews. say otherwise if you want local-only. **document** and **authoring a skill** skip `sequence-changes`. **big-changes** produces a plan file only; after approval it asks same-chat vs fresh-chat before **orchestrate**. **orchestrate** leaves local commits; the parent lands each ready PR.

### session workflow

default topology is short Align chats, then Execute elsewhere, then L2 review on the MR. do **not** re-attach `/nathan-mode` on every follow-up. one attach per chat is enough. the `nstack-discipline` rule carries sureness and principles on every turn.

| phase | chat | you | agent |
| --- | --- | --- | --- |
| **Align** | same chat as the `/nathan-mode` attach | 1–3 turns: brief, clarify, **go** | draft brief or investigate; stop at **Waiting on you:** |
| **Execute** | fresh chat and/or `nathan-agent` | not steering product code | implement + verify; coordinator for plan boxes |
| **Review** | GitLab/GitHub async | L2: MR + proof only | proof in plan **Proof** / MR body (not a committed verify file) |

**trust ladder:** L2 is the default (approve spec or plan, later review MR + proof). L0 parent-implement only with explicit `pair`. L3 is multi-PR plans under **orchestrate**. L1 (parent verifies every hunk) is optional training wheels, not the happy path.

**long-thread exceptions:** **big-changes** may take more Align turns while authoring the plan (still no product code). **orchestrate** should start in a **fresh chat** with only the plan path after you approve the plan. escalations are interrupts that need explicit go. do not confirm every box yourself.

**verify:** prefer repo `verify-*` skills when they fit. use throwaway `agent_space/` scripts when skills miss the signal (logs, process boot, etc.). scaffold greenfield verify trees with `/create-verification-skill` and keep them honest with `/create-verification-maintainer-skill`. use `/review` to mine recent agent usage before proposing skill changes.

**optional usage log:** `docs/usage-log.md` is a one-line-per-land convention (`date | playbook | branch/MR | note`). not required for Ready to land. create the file only when you opt in during a land. it is not a verify artifact.

### playbooks

all the playbooks that `/nathan-mode` supports:

| playbook | used for |
| --- | --- |
| investigate | a read-only question. how does X work, why was Y built this way, are we sure about Z. |
| bugfix | fixing known issues. reproduce a defect, root-cause it, then fix. |
| implement | implementing new or changed behaviors. |
| refactor | a behavior-preserving change. usually to improve maintainability or performance. |
| big-changes | catch-all when the ask is too large for one playbook, or blast radius needs a multi-step plan. produces the plan file; then same-chat vs fresh-chat gate before orchestrate. |
| authoring a skill | writing or editing a skill. |
| document | writing documentation. |
| orchestrate | babysit an approved plan (usually from big-changes; fine in a fresh chat with the plan path). coordinator drives boxes; parent lands each ready PR. |

### principles

`nathan-mode` uses a set of principles to guide the agent. they live in `nathan-mode/SKILL.md`.
