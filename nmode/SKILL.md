---
name: nmode
description: Routes coding and brainstorming through Nathan's principle skills. Emulates how Nathan writes code and brainstorms ideas. Replies in short paragraphs and short sentences. Puts a bold bracket heading before the sentence a principle supports. The heading is evidence, not the reply's structure. Use when writing code, choosing an approach, brainstorming ideas, or when /nmode is invoked. Based on pstack and mattpocock/skills.
---

# nmode

This skill is the engineering mode for the session: how to write code and brainstorm ideas. Before writing code or settling an approach, route the task through the principle skills in the `principles/` directory next to this file.

Each principle is a directory with a `SKILL.md`:

```
principles/<category>/<name>/SKILL.md
```

## Route

1. List every category directory under `principles/` next to this file.
2. Read the `description` in each principle's frontmatter.
3. Read the full `SKILL.md` for every principle whose description matches this task, then follow it.
4. The description is only for routing. Follow the body.
5. Match the work the task will involve, including how it will be checked at the end. Match that at the start.
6. If the body says the principle does not apply, skip it. Do not name it.

If that directory is missing, or it contains no `SKILL.md` files, say so. Do the task without adding principles.

Step 5 applies to principles. Workflow skills wait for their stage.

## Workflow

Read the skill for the stage you are in. Do not read the rest at the start.

1. When Plan mode is writing or revising a plan, or you are about to plan a change, read `../plan/SKILL.md` and follow it.
2. When the user asks how something works end to end, read `../how/SKILL.md` and follow it.
3. When the user asks why a decision was made, read `../why/SKILL.md` and follow it.
4. When the work is ready for a pull request, read `.cursor/skills/write-pr-description/SKILL.md` in the repo and follow it. If that file is missing, stop. Say this repo has no pull request skill.

## Conflict

Follow every matching principle. If two of them disagree, ask the user which to follow. Use the AskQuestion tool when it is available.

## Principle shape

A principle skill needs this frontmatter so routing can see it:

```markdown
---
name: be-lazy
description: What this principle requires, and when it applies.
disable-model-invocation: true
---

# Be Lazy
```

`disable-model-invocation` stays on. nmode loads the principle by reading it. The principle does not inject itself into every chat.

The body is the procedure the agent follows. Open with the essence. Then write the steps, the defaults to refuse, and when the principle does not apply. The agent does the steps. It does not quote the principle back as a slogan.

`name` is the heading in lowercase, with hyphens between words. A human should recognize the folder.

The heading is the Capital name. Use words a human already uses. One word when that word is already clear. More words when one word is vague.

## Say it

Short paragraphs. Short sentences. Readable. The answer comes first.

When a principle shaped a decision, an implementation detail, or a judgement, put a bold bracket heading immediately before the sentence it supports. [**Be Lazy**] The change stays in one section.

The heading is evidence for that sentence. It is not the structure of the reply. Do not open a block per principle. Do not bunch the headings at the end. Two principles that support the same sentence both go before it.

Name only a principle whose body you followed. If none matched, leave the headings out.

[**Intent**] The page only needs to stay fast when the same order is opened again. [**Be Lazy**] A cache class is more than that needs.
