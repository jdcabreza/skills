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

before you do anything, run `/setup-nstack` to determine the models to be used across the skills.

## usage

### nathan-mode

`/nathan-mode` is the main catch-all skill. it'll read your request, pick from a set of playbooks, and orchestrate across the other skills as needed. i typically just use this unless i have a specific set of steps to run.

sibling skills live at the same level as `nathan-mode/` in this repository.

| skill | use when |
| --- | --- |
| `/nathan-mode` | default entry point. picks a playbook for code changes, investigation, docs, plans, skill edits. call `/design` when you want a parallel approach panel outside a playbook. |
| `/setup-nstack` | configure models per role; install `nathan-agent` to `~/.cursor/agents/`. |
| `/how` | figure out how something works. |
| `/why` | get the motivation and intent behind why something was built that way. |
| `/unslop` | clean up writing. removes AI tells. |
| `/huh` | rewrite the last agent reply into plain language a tired engineer can follow. |
| `/write` | technical writing. docs, RFCs, READMEs, PR descriptions, commit messages. writer then audience reviewer. |
| `/design` | parallel panel of 2-3 models plus a judge. use when a playbook says so, or when you want approaches without writing code yet. |
| `/sequence-changes` | organize local work into atomic, verifiable commits or stacked branches. does not push. |
| `/open-pr` | push the scoped branch, open a GitLab MR with `glab`, comment `cursor review` for Bugbot. default last step of change playbooks unless you say otherwise. GitLab-only. |

`authoring a skill` also uses Cursor's built-in `/create-skill`.

code and orchestrate workers use `subagent_type: "nathan-agent"`. source file is `agents/nathan-agent.md`. `/setup-nstack` copies it to `~/.cursor/agents/nathan-agent.md` so Task can discover it without the marketplace. routed skills (`how`, `why`, `design`, `write`) keep their own Task shapes in `nathan-mode/SKILL.md`. parent-only skills (`unslop`, `huh`, `sequence-changes`, `open-pr`) never spawn Tasks. model choices live in `~/.cursor/rules/nstack-models.mdc` after setup.

landing defaults to `sequence-changes` then `/open-pr` after the parent reviews. say otherwise if you want local-only. **document** and **authoring a skill** skip `sequence-changes`. **big-changes** produces a plan file only; it does not implement or open an MR.

### playbooks

all the playbooks that `/nathan-mode` supports:

| playbook | used for |
| --- | --- |
| investigate | a read-only question. how does X work, why was Y built this way, are we sure about Z. |
| bugfix | fixing known issues. reproduce a defect, root-cause it, then fix. |
| implement | implementing new or changed behaviors. |
| refactor | a behavior-preserving change. usually to improve maintainability or performance. |
| big-changes | catch-all when the ask is too large for one playbook, or blast radius needs a multi-step plan. produces the plan file. |
| authoring a skill | writing or editing a skill. |
| document | writing documentation. |
| orchestrate | babysit a plan file (usually from big-changes) via a coordinator. parent lands after review. |

### principles

`nathan-mode` uses a set of principles to guide the agent. they live in `nathan-mode/SKILL.md`.
