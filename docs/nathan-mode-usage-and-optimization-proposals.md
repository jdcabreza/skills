# Nathan-mode usage review and optimization proposals

**Date:** 2026-10-27 (updated same day)  
**Scope:** Local Cursor conversations from 2026-10-27 that invoked `/nathan-mode`, plus the nstack skill tree in this repository.  
**Goal:** Reconcile the skill with how you actually work, cut cost where it does not buy trust, and move default behavior from steering in-thread to **delegate → proof → you review MR**.

**Status:** Proposals and todos only. Nothing in this doc is implemented in the repo until a follow-up session lands it.

---

## Executive summary

Today's usage was **parent-heavy** (long threads, minimal `nathan-agent` spawns). That matched **low trust in agent output**, not the **target workflow**. The target is **delegation**: you agree on specs and constraints; agents implement, verify, and land with proof; you review **MR + proof** (trust **L2**), including when stepping away during **big-changes → orchestrate**.

Cost drivers remain **token volume** (re-inlined skill on many turns, long threads, always-applied rules) more than model tier. [**measured / inferred**. see Data sources.]

**Direction for the repo:**

1. **Default change path:** spec brief (you approve once) → **`nathan-agent`** implements → mandatory verify artifact → parent lands → **you review MR + proof only**.
2. **Investigate (extended):** **how** and **why** feed judgment; add explicit **implications** (prod, ops, downstream, blast radius). No separate `/judge` skill. No alternate “output modes.”
3. **big-changes / orchestrate:** plan front-loads verify + implications per PR; coordinator runs boxes **unattended**; you are not in the loop per box—only plan approval, escalations, and **L2 MR review**.
4. **Session workflow:** **Bounded nathan-mode chats** (one `/nathan-mode` attach, few user turns for **Align**, then hand off). **`nstack-discipline.mdc`** stays on in every chat. Custom Mode is **optional** when Cursor fixes it; do **not** re-inline the full skill every turn.

Peer engineer is **not** the goal. It was an emergent stage. Playbooks should **discourage** parent-implement except explicit **`pair`** override.

---

## Data sources

| Source | What we used it for |
|--------|---------------------|
| `SearchConversations` | Five local chats today mentioning `nathan-mode` |
| Agent transcripts under `~/.cursor/projects/.../agent-transcripts/<id>/` | Turn counts, Task spawns, attachment size, verify behavior |
| Skill files in this repo | Intended workflow vs observed behavior |
| User feedback (2026-10-27) | Custom Mode failure, investigate shape, L0→L2 jump, orchestrate unattended |

### Today's `/nathan-mode` chats (local)

| Chat title | Conversation ID | User turns | Assistant turns | Task spawns | Subagent transcripts |
|------------|-----------------|------------|-----------------|-------------|----------------------|
| [Gate email min auto suspend branch](5a343e75-f9f4-401e-a5d8-fbd3818a8c42) | `5a343e75-…` | 7 | 85 | 0 | 0 |
| [Delta migration and test fixes](f831ae64-795b-4829-ab63-dafd8fb2444f) | `f831ae64-…` | 7 | 102 | 0 | 0 |
| [Control versioning for evidence tables](c9f74c28-09ba-473e-a619-5c06aeb7304c) | `c9f74c28-…` | 3 | 41 | 1 × `nathan-agent` | 1 |
| [PDF text extraction discrepancy](8318df28-af6f-46b9-ae50-7e161ff97324) | `8318df28-…` | 7 | 70 | 1 × `explore` (`how`) | 1 |

**Approximate repeated `nathan-mode` inline payload** (serialized user messages containing `SKILL.md content`):

| Chat ID (prefix) | ~Inline chars (cumulative in main transcript) |
|------------------|-----------------------------------------------|
| `5a343e75` | ~82k |
| `8318df28` | ~55k |
| `f831ae64` | ~28k |
| `c9f74c28` | ~14k |

[**measured**. Python pass over main `.jsonl` files counting messages containing `SKILL.md content`.]

---

## Reconciliation: observed vs intended

| What happened | Why it happened | What we change |
|---------------|-----------------|----------------|
| 0 Task spawns on largest pipeline chats | You corrected semantics, migrations, naming inline; delegation felt risky | **Default delegate** after approved brief; parent edits product code only on verify failure or explicit `pair` |
| Judgment mixed into implement threads | No clear “stop and investigate” routing | Route implications / “should we?” to **investigate**; implement waits on brief approval |
| You prompted for verify | Proof not required in worker report or MR by default | **Verify artifact** gate before `open-pr`; MR must embed proof |
| Re-attached skill every message | `disable-model-invocation: true` + fear skill would drop | **One attach per chat** + **`nstack-discipline.mdc`**; stop manual re-inline (see Session workflow) |
| Long implement threads (7+ user turns, 0 delegates) | Same chat carried L0 steering + parent work | **Bounded Align** then **fresh execution chat** or worker; see Session workflow |
| Custom Mode untried or broken | Product issue | **Bounded session** primary; Mode optional later |
| Playbook “user verification” steps | Agents summarized and continued | **Brief + hard stop**; see Spec brief |
| Wrong abstractions when delegating | Generic “clean” vs team layout (hex, etc.) | **Architecture and placement** in brief + AGENTS.md in worker path |

**Trust model (target): skip L1 as a steady state.** You want to jump from **L0** (steering) to **L2** (review MR + proof), not live at “parent verifies every hunk.”

| Stage | Your role | Agent role |
|-------|-----------|------------|
| **L0** (legacy / learning repo) | Steer in thread | Parent implements |
| **L2** (**target default**) | Approve **spec** or **plan**; later review **MR + proof** only | Worker implements + verifies; parent/coordinator drains, lands |
| **L3** | Approve multi-PR plan; async MR review | **orchestrate** coordinator + workers until **Ready to land** |

**L1** (parent verifies before you look) is optional training wheels, not the documented happy path.

---

## Session workflow (bounded chats; Custom Mode optional)

`nathan-mode` has `disable-model-invocation: true` and `mode: true`. [**observed**. skill frontmatter.]

**Do not** re-attach the full skill on every follow-up message. That duplicates ~14k+ characters per turn in history. [**measured**.]

**Decision:** Default topology is **not** “one long nathan chat until done.” It is **short Align chats** plus **execution elsewhere**. Custom Mode tried to keep the full SKILL on every turn for long threads; that optimizes for **peer-engineer** context. Your target is **L2 delegate**, so bounded sessions beat fixing Mode first. [**inferred**. user direction 2026-10-27.]

### Default: three phases (implement, bugfix, refactor, investigate)

| Phase | Chat | User turns (target) | Agent work | You |
|-------|------|---------------------|------------|-----|
| **Align** | Same chat as single `/nathan-mode` attach | **1–3** (brief, clarify, **go**) | Draft brief or investigate output; **Waiting on you** until go | Approve spec or answer clarifiers |
| **Execute** | **New chat** (or worker; you away) | **0** in Align chat | **`nathan-agent`** + verify; coordinator for plan boxes | Not steering product code |
| **Review** | GitLab / async | **0** in execution chat | MR + proof artifact | **L2** review only |

**Align chat rules:**

1. **One** `/nathan-mode` attach on the first message (normal Enter). Follow-ups: plain language only; **no** skill re-inline.
2. **`nstack-discipline.mdc`** (`alwaysApply`) carries sureness + principles on every turn in every chat (see Discipline drift).
3. Optional **workflow pointer** in user/project rules: on `/nathan-mode`, read `~/.cursor/skills/nathan-mode/SKILL.md` **once** that chat for playbooks and landing.
4. After **go** on the brief: **stop** the Align chat for product work. Open execution with: branch name, approved brief path (or plan box id), “delegate L2.”
5. **Investigate-only** asks may complete entirely in Align (one turn is fine).

**Custom Mode:** Option/Alt+Enter can stay on for an Align chat if the product works. [**observed**. Cursor docs.] Your experience: prompt did not go through. [**observed**. user report.] Treat Mode as **optional**; bounded topology + discipline rule do not depend on it.

**Anti-pattern:** Implement, fix, or refactor in the same thread after brief approval “just one more tweak.” That recreates L0 decay. New tweak → brief delta or new execution chat.

### Long-thread exceptions (big-changes, orchestrate)

These playbooks can produce **more assistant turns** or **more Align turns** than a single brief. They are **exceptions**, not permission for open-ended implement steering.

| Playbook | Chat role | Longer thread OK? | What may grow | Hard limits |
|----------|-----------|-------------------|---------------|-------------|
| **big-changes** | **Plan authoring only** | **Yes, Align phase** | Plan file edits, how/why for scope, implications per PR, box breakdown | **No product code.** No parent-implement. Ends at **plan approved** (explicit go). |
| **orchestrate** | **Coordinator babysit + land** | **Yes, execution chat** | Many parent turns **draining** workers, checking evidence, **sequence-changes** + **open-pr** | **No L0 steering.** You only: start with plan path, answer **escalations**, optional batch “land ready PRs.” Agent verify is mandatory; you do not confirm each box. |
| **implement / bugfix / refactor** | Align + separate execute | **No** long mixed thread | Align ≤ few user turns | Execute in **fresh chat** or **`nathan-agent`** |

**big-changes → orchestrate gate (decided):**

1. **Planning chat(s):** `/nathan-mode` + **big-changes** until the plan file is ready and you say **approve plan**. May take more than three **user** turns when blast radius is large; still **no code** and **no** re-inline.
2. **Mandatory fresh chat for orchestrate:** After plan approval, **new chat** with **only** the plan file path (and repo). Reduces peer drift and token reread. [**observed**. existing orchestrate gate in skill.]
3. **Optional split for huge plans:** Chat A scaffolds plan structure; Chat B refines with “continue plan at `<path>`” if context is heavy. Still plan-only until approval.

**orchestrate while away (decided):**

1. Coordinator + workers run boxes **unattended** in the orchestrate chat; parent **ends turns** while background workers run (**drain before you depend**).
2. Your thread stays **L3 at the gate**: plan already approved; you read **Coordinator Notes** only for escalations (plan gaps, irreversible actions, brief/plan conflicts).
3. When you return: parent lands **Ready to land** PRs in **Depends on** order; you **L2** review MR + **Proof** on GitLab. MR discussion does not need to stay in the orchestrate chat.

**Why orchestrate is not “bounded” like implement Align:** Turn count grows from **machinery** (spawn, drain, land), not from you correcting naming in-thread. [**inferred**. separates decay cause from coordinator loop.] Discipline rule still applies to parent replies; workflow SKILL is read once at orchestrate chat start.

### Pointer rule (optional, workflow only)

Short Always Apply pointer example (in addition to **`nstack-discipline.mdc`**):

*When the user invokes `/nathan-mode`, read `~/.cursor/skills/nathan-mode/SKILL.md` once at the start of that chat if not already read; follow it for the rest of the chat without re-attachment.*

Do not rely on this alone for sureness/principles (see Discipline drift).

### Discipline drift (no inline → no sureness labels, no principles)

**Symptom:** After stopping per-message skill inline, replies drop the two things that matter for trust: **sureness on each statement** and **principles on each decision**. Prose “voice” (tone, unslop) is secondary.

**Cause (not user error):**

| Factor | Effect |
|--------|--------|
| `disable-model-invocation: true` on nathan-mode | Full skill is **not** auto-loaded on later turns |
| Single-message `/nathan-mode` attach | **Writing the reply** (sureness levels) and **Principles** drop out of context as the thread grows |
| Pointer rule (“read SKILL once”) | Models **often skip** re-read or do not treat it as binding on turn 10+ |
| User + default assistant rules | Default chat tone replaces epistemic discipline when the skill body is absent |

Inlining worked because it **re-injected sureness + principles every turn**. Removing inline without a replacement removed that **always-on discipline**, not the playbook/workflow slice.

**Fix strategy: split “discipline” from “workflow.”**

| Layer | What it carries | How it stays on |
|-------|-----------------|-----------------|
| **Discipline (small)** | Sureness label on claims; principle tag on decisions | **`alwaysApply: true`** user rule (~50–100 lines) |
| **Workflow (large)** | Playbooks, subagents, landing, brief gate, reply prose shape | Read `nathan-mode/SKILL.md` once per chat on `/nathan-mode` |
| **Prose polish** | Short sentences, no em-dashes, unslop | Stays in **nathan-mode** + **unslop** when playbooks run; **not** the Always Apply rule |

Do **not** put the full SKILL in Always Apply (token cost). Do **not** conflate discipline with “writing voice.”

**Decision:** Always Apply discipline in **all** chats (user rule at `~/.cursor/rules/`).

**Todo: add `nstack-discipline.mdc`**

Location: `~/.cursor/rules/nstack-discipline.mdc` with `alwaysApply: true`.

**1. Sureness (every material claim in the same sentence)**

After the claim: `[**<level>**. <short reason>.]`

| Level | Meaning |
|-------|---------|
| **measured** | You ran a check or took a quantity |
| **observed** | Inspectable fact or known outcome; you did not necessarily instrument the path |
| **inferred** | Reasoned from evidence |
| **guess** | Prediction or unseen cause |

Never offer a check you could run as inferred. Never hand-wavy confidence without a label.

**2. Principles (decisions that shaped the answer)**

When a choice reflects nathan-mode thinking, tag **inline** with the principle **first**, then the choice. Not a principles appendix at the end.

Format: `[**<principle>**] <decision it affected>`

Include the **principle names and one-line definitions** in the rule (copy from `nathan-mode/SKILL.md` Principles list), so the agent does not need the full SKILL to tag correctly. Precedence paragraph optional but short.

**3. Explicitly out of scope for this rule**

- Playbooks, subagents, nathan-agent, landing (workflow skill).
- Unslop / tired-engineer prose (unless you later choose to merge; default: keep separate to save tokens).

**Optional one-liner in the same rule or a second always-apply pointer rule:** when the user invokes `/nathan-mode`, read `~/.cursor/skills/nathan-mode/SKILL.md` once that chat for workflow.

**Todo: ship template from this repo**

- **setup-nstack** writes or copies `nstack-discipline.mdc` alongside `nstack-models.mdc`.
- README: discipline rule is **required** for sureness + principles without re-inlining; Custom Mode does not replace it.

**Todo: workers**

- Every `nathan-agent` brief includes the **same sureness + principle rules** (compact). Workers do not inherit user Always Apply rules reliably.

**Todo: nathan-mode SKILL cross-link**

- **Writing the reply** section: “Sureness and principles are enforced by user rule `nstack-discipline.mdc`; this section is normative for playbook replies.” Avoid duplicating full principle list in two places long-term: rule = always-on; SKILL = canonical definitions + workflow.

**Rejected**

| Idea | Why |
|------|-----|
| Re-inline full nathan-mode every message | Restores discipline; burns ~14k+ chars per turn |
| Custom Mode only | Broken for you today |
| “Read SKILL once” without discipline rule | Observed failure this chat |
| Post-hoc unslop to add labels | Sureness is epistemic discipline at draft time, not polish |
| Thin auto-invoke “voice” skill | Wrong framing; use Always Apply discipline rule |

---

## Spec brief (shared contract)

**Todo:** add `nathan-mode/playbooks/_spec-brief.md` and wire **implement**, **bugfix**, and **refactor** to it.

The brief **replaces** the playbook pattern “return your understanding for user verification.” Today agents treat that as optional narration and keep working. **Alignment is the brief.** The parent must **stop** with **Waiting on you:** and must not branch, delegate, or land until explicit go.

### Brief sections (draft template)

| Section | Purpose |
| -------- | -------- |
| Outcome | Observable behavior or refactor end state |
| Non-goals | |
| Context | Who asked, why, trigger |
| Current behavior | Required for refactor; for others when not obvious |
| Intended impact | Downstream effects |
| Implications | Prod, ops, data, compliance, consumers |
| **Architecture and placement** | Paths to extend in **this** repo (e.g. hex: handler → service → repository → client). Forbidden: new top-level packages or parallel stacks unless approved |
| Naming and semantics | Domain terms, fields, APIs |
| Approach | High-level steps |
| Verify checklist | From repo overarching verification skill |
| Land | Branch, stack base, MR notes |
| Behavior pin / reader-load intent | Refactor only |

### Playbook return shapes (align brief with playbook Reply)

Map what playbooks already ask for into the brief **before** work; after land, reply only at **L2** (MR + proof).

| Playbook | Before work (return **full** brief, wait for go) | After land (L2 reply) |
|----------|---------------------------------------------------|---------------------|
| **implement** | Context, outcome, impact, implications, architecture and placement, naming, approach, verify checklist | Built, significant decisions, open decisions, MR + proof (per implement **Reply**) |
| **bugfix** | **Stop 1:** problem brief + repro plan. **Stop 2:** after root cause, updated brief with cause, proposed fix, architecture, naming, verify | Broken, root cause, fix, verbatim repro fail/pass (per bugfix **Reply**) |
| **refactor** | Context, behavior today, impact, **judgment if justified**, behavior pin, target shape, architecture, reader-load intent, verify | Behavior held, structural delta, pin proof, reader-load delta (per refactor **Reply**) |

**Todo:** rewrite implement / bugfix / refactor steps so step 1–2 are brief + stop; delegate only after go; split playbook **Reply** into pre-approval (brief) vs post-land.

### Worker brief block (todo: in `_spec-brief.md`)

Pass to `nathan-agent`: approved brief path, mandatory **AGENTS.md**, architecture FORBIDDEN list, VERIFY checklist, REPORT with verbatim output.

### Taste and codebase-context (delegation blocker)

Agents optimize for **generic cleanliness** (new modules, new layers, textbook patterns). You need **local reasonableness**: hexagonal layout in services, existing package boundaries, domain naming.

**Mitigation (in brief, mandatory):**

- **Architecture and placement:** list paths to extend; forbid new top-level packages unless you approve.
- **AGENTS.md** conventions (e.g. handler ↔ service ↔ repository ↔ client) referenced in brief and worker **FORBIDDEN** block.
- **Naming and semantics** section so steering is front-loaded, not turn-by-turn micromanagement.

Without this, L2 delegation reproduces wrong abstractions that “look clean” globally.

After approval: **execute (delegate) → verify artifact → sequence-changes → open-pr → you review MR + proof**.

**`pair` override:** explicit in-thread pairing only. Not the default.

### Verification skills (new repo scaffolding)

**Todo:** two sibling skills under this repo (names tentative):

| Skill | Purpose |
|-------|---------|
| **create-verification-skill** | Scaffold `.cursor/skills/verify-<repo>/` (overarching), leaf `verify-*` skills (one command + pass criteria each, `disable-model-invocation: true`), README **Verification** bullets, AGENTS.md pointer-only, stub `maintain-<repo>-verification`. Mirror address-parser and kyc-1-controls-pipeline. |
| **create-verification-maintainer-skill** | Write or refresh `maintain-<repo>-verification/` with repo-specific triggers (Makefile, routes, job YAML, CI), optional sub-maintainers (makefile vs HTTP vs dry-run table), rules for when to edit which leaf skill. |

Brief **Verify checklist** should reference the overarching skill. Greenfield repos run **create-verification-skill** before expecting L2 delegation. README usage table should list both skills when they exist.

**Dependency:** thin **AGENTS.md** (architecture + practices) makes brief **Architecture and placement** enforceable; verification skills alone do not fix taste.

---

## Investigate (extend, no new skill, no output modes)

Keep one **investigate** playbook. Do **not** add `/judge` or a separate “decide mode” switch.

**Judgment is powered by how and why**, not by skipping them for “opinion” questions.

| Step | Change |
|------|--------|
| 1 | **how** always when mechanics are unclear; **why** when intent, history, or “why built this way” matters |
| 2 | Doc shape keeps how/why sections; for decision-style asks, add **Recommendation**, **Tradeoffs**, **Assumptions**, and **Implications** (prod, ops, downstream, data, compliance) — not instead of how/why |
| 3 | **unslop** as today |

**Reply** already requires real judgment for “are we sure”; strengthen to require **Implications** when the ask touches shipping, prod, or cross-team consumers.

**Routing:**

| Ask type | Playbook |
|----------|----------|
| How does X work? / trace a surface | **investigate** |
| Should we ship Y? / implications / prod readiness | **investigate** (how/why as needed, implications required) |
| Build or change Z | **implement** / **bugfix** / **refactor** after brief approval — brief **Implications** section carries investigate output forward |

Change playbooks should **reference** investigate implications in the brief, not re-debate them in a 100-turn implement thread.

---

## Change playbooks (implement, bugfix, refactor)

### Shared three phases

**Phase A — Spec (parent, interactive)**  
Read `AGENTS.md` and repo verification skills. Run **how** / **why** when facts or intent are missing. Draft brief (including **Implications**). Todo for user alignment stays **pending** until you say go.

**Phase B — Execute (default: delegate)**  
Spawn **`nathan-agent`** with brief + paths + verify checklist. Parent does **not** edit product code except unblockers (env, credentials) or after failed verify loop.

**Phase C — Proof gate (agents, not you)**  
Worker runs verify checklist; parent drains and sanity-checks; proof written to artifact + MR. **You** enter at **L2**: review MR + proof. You do not need to be at the keyboard for Phase B/C on a single box.

### Refactor

Same brief template plus behavior pin (refactor steps 2, 5–6). Delegation default applies to code movement, not only greenfield implement.

### bugfix

Same brief; Phase A includes repro and root cause with evidence; Phase B delegates the fix scope.

---

## big-changes and orchestrate (unattended L2)

**Problem:** If every box needs you, orchestrate cannot run while you step away.

**Intent:** You approve the **plan once**. Coordinator + workers run boxes, check evidence, fill **Proof**, set **Ready to land**. Parent lands MRs when you return (or in batch). You **review MR + proof** (L2), not every intermediate verify.

### big-changes (plan quality = trust)

Plans already have **Verification**, **Boxes** with evidence, and **Proof** per PR. [**observed**. `playbooks/big-changes.md`.]

Tighten planning so L2 is credible:

1. Each PR **Verification** must list **concrete commands** (from repo skills), not “run tests.”
2. Each box **evidence** must map to a verify checklist item or file artifact.
3. Each PR **Context** includes **Implications** (same heading as brief) so prod/ops decisions are settled at plan time.
4. **Worker brief** template in orchestrate already has VERIFY and REPORT; plan boxes must be scoped enough that coordinator can fill VERIFY without asking you.

Do not implement code in big-changes; dry-run playbooks into the plan only (unchanged).

### orchestrate (coordinator owns agent verify)

Align coordinator rules with L2:

| Today | Proposed |
|-------|----------|
| Human escalations for preference calls | Escalate only for **plan gaps**, **irreversible** actions, or **conflicts with brief/plan** — not routine verify |
| Parent lands after review | Unchanged; parent still owns **sequence-changes** + **open-pr** |
| Worker returns report | Worker **must** run VERIFY from brief; REPORT includes verbatim command output |
| You verify every step | **Agent verify is mandatory; human verify is MR gate only** |

Coordinator loop (unattended):

1. Walk PRs in **Depends on** order.
2. Per box: spawn worker → drain → check evidence → check box.
3. When all boxes checked: fill **Proof** (paste or pointer to `.cursor/verification/<branch>.md`), **Ready to land: yes**.
4. Return to parent; parent lands each ready PR in order.

**You** approve plan upfront and review landed MRs + **Proof**. You do **not** need to confirm each box unless notified via **Coordinator Notes** escalation.

### Chat topology (links Session workflow)

| Step | Chat |
|------|------|
| Plan | **big-changes** Align chat(s); approve plan once |
| Run boxes | **Fresh orchestrate** chat with plan path only |
| Land | Parent in orchestrate chat when PRs **Ready to land** |
| Review | You on **MR + Proof** (async); not per-box in thread |

See **Session workflow → Long-thread exceptions** for limits and anti-patterns.

---

## Cost: subagents vs parent, models vs tokens

### Subagent vs parent (delegate-first)

| Work type | Recommendation |
|-----------|----------------|
| Approved brief / plan box | **`nathan-agent`** (default) |
| Investigate (how/why/implications) | Parent synthesizes after **explore** when surface is wide; parent-only ok when cites exist |
| MR body from proof artifact | Parent + **unslop**; no **write-review** for routine MRs |
| design | Rare; user-approved only |
| Long peer thread | **Avoid** — bounded Align + fresh execute chat per landable unit |
| big-changes plan | **Plan-only** chat; may exceed 3 user turns; then **fresh orchestrate** chat |
| orchestrate | **Long assistant turn count OK**; **few user turns**; no L0 steering |

[**inferred**. Subagents pay startup tokens but stop 100-turn parent rereads; L2 depends on verify in worker REPORT, not you running commands.]

### Model configuration vs volume

`grok-4.7-low` for code and `gpt-5.6-sol-low` for how/why/write/design is already lean. [**observed**. `nstack-models.mdc`.]

Prefer **fewer judgement spawns** (lite open-pr, no duplicate skill inline, fresh chats) over downgrading implement further.

---

## Proposals (implementation backlog)

### P0 — High impact

#### 1. Session workflow (bounded chats; Custom Mode optional)

- Document **Align → Execute handoff → L2 review** as default (see Session workflow).
- Add **`nstack-discipline.mdc`** (`alwaysApply: true`): sureness levels + inline principle tags (see Discipline drift).
- Add optional **workflow pointer rule** (read `nathan-mode/SKILL.md` once per chat on invoke) beside discipline.
- Document **long-thread exceptions**: **big-changes** (plan-only Align); **orchestrate** (fresh chat after plan approval; long drain/land OK, no L0 steering).
- Extend **setup-nstack** to install `nstack-discipline.mdc` alongside `nstack-models.mdc`.
- README: no per-message re-inline; **discipline rule required**; Custom Mode optional when product works.

#### 2. Verification artifact + MR proof

- Shared **`playbooks/_verification.md`** (or SKILL section): commands, outcomes, scope, evidence labels.
- Path: `.cursor/verification/<branch>.md` on branch (reviewers see it) or plan **Proof** section for orchestrate.
- **open-pr:** compose MR from template + artifact; **unslop** only; skip **write-review** for standard MRs.

#### 3. Spec brief + delegate default

- Add **`playbooks/_spec-brief.md`** (sections and worker block above).
- Update **implement**, **bugfix**, **refactor**: brief gate, **Waiting on you**, architecture/taste sections, L2 reply split; remove any prose that encourages parent-implement except **`pair`** override.
- Update **`agents/nathan-agent.md`**: read **AGENTS.md** + approved brief; extend in-repo layout; no new modules unless brief lists them.

#### 3b. Verification scaffolding skills

- Add **`create-verification-skill/SKILL.md`** and **`create-verification-maintainer-skill/SKILL.md`** (see Spec brief → Verification skills).
- README + nathan-mode pointer: run on new repos before L2 delegation.

#### 4. Repo standards ingestion

- Step 0 for change + investigate playbooks: **`AGENTS.md`**, repo verification skills, `docs/decisions/` when relevant.

#### 5. Extend **investigate** playbook

- Require **Implications** section in output when shipping/prod/consumers are in scope.
- Decision asks: **Recommendation + Tradeoffs + Assumptions** alongside how/why material.
- **No** `/judge` skill. **No** output mode flag.

### P1 — Medium impact

#### 6. how/why “already explored” shortcut

- If same surface was traced in-session with citations, do not respawn **explore**.

#### 7. Slimmer `nathan-agent` brief

- Workers: Principles + relevant playbook section; full SKILL once per branch scope.
- Parent passes file pointers, brief path, verify checklist — not inlined diffs.

#### 8. Todo discipline

- User alignment and brief approval todos stay **pending** until explicit user go.

#### 9. orchestrate + big-changes L2 wording

- Coordinator: mandatory worker VERIFY; human only on escalation and MR review.
- big-changes: implications + concrete verify in every PR section.

### P2 — Longer term

#### 10. Context budget in `nathan-mode/SKILL.md`

- **Align:** one attach, few user turns; **execute** in fresh chat or worker.
- **big-changes:** plan chat may be longer; **orchestrate** always fresh after plan approval.
- Fresh chat after land for the next landable unit; no respawn how/design/write when proof exists.

#### 11. README trust ladder

- Document **L2 as default target**; L0 as anti-pattern except `pair`; L3 for plans.

#### 12. setup-nstack / cost profile note

- Document post-setup `-low` tiers and `inherit-parent` for write-review on long docs only.

#### 13. Optional usage log

- One line per land in `docs/usage-log.md` for before/after metrics.

---

## Removed / rejected ideas

| Idea | Reason |
|------|--------|
| Separate **`/judge`** skill | Duplicates **investigate**; how/why must power judgment |
| **Output mode** on investigate | User rejected; same doc shape with extra sections instead |
| **Parent implement as default** | Conflicts with delegate goal; keep **`pair`** only |
| **Custom Mode only** workflow | Does not work for user; bounded sessions + discipline rule |
| **One long chat for plan + orchestrate + implement** | Recreates L0 decay; **fresh orchestrate** after plan approval; execute off Align chat |
| **Human verify every orchestrate box** | Blocks unattended run; agent verify + L2 MR review instead |
| **Applying “≤3 user turns” to orchestrate** | Wrong metric; limit **user steering**, not coordinator drain/land turns |

---

## Suggested implementation order

1. **`playbooks/_spec-brief.md`** + implement, bugfix, refactor playbook edits + **`nathan-agent.md`**.
2. **`create-verification-skill`** + **`create-verification-maintainer-skill`** + README table.
3. **`playbooks/_verification.md`** + **open-pr** lite write + **investigate** playbook implications wording.
4. **AGENTS.md** ingestion step on change + investigate playbooks.
5. **orchestrate** + **big-changes** L2 / unattended wording.
6. **README** session workflow (bounded chats, big-changes/orchestrate exceptions, no re-inline) + trust ladder.
7. **`nstack-discipline.mdc`** template (sureness + principles, `alwaysApply: true`) + setup-nstack wiring.
8. Optional workflow pointer rule for read-once **nathan-mode** playbooks.
9. **nathan-mode/SKILL.md** cross-link: discipline in user rule; workflow + prose shape in SKILL; todo gate for brief approval.

---

## Open decisions

1. **Verification file on branch:** commit `.cursor/verification/<branch>.md` vs plan **Proof** only for orchestrate stacks?
2. **Escalation channel:** Coordinator Notes only vs notify when blocked (subscription / you check GitLab)?
3. **Lite open-pr:** default skip write-review for all MRs, or keep full **write** for customer-facing release notes?

---

## Appendix: nstack model map (current)

From `~/.cursor/rules/nstack-models.mdc`:

| Role | Model |
|------|--------|
| implement, refactor, bugfix | grok-4.7-low |
| how, why, orchestrate, design-*, write, write-review | gpt-5.6-sol-low |

Judgement and code are already split; savings come from **delegation in fresh threads**, **no skill re-inline**, and **fewer write-review spawns**, not from skipping agent-side verify.
