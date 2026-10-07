---
name: nmode
description: Routes coding and brainstorming through Nathan's principle skills. Emulates how Nathan writes code and brainstorms ideas. Starts each part of the reply with the principle heading in brackets. Replies in short sentences. Use when writing code, choosing an approach, brainstorming ideas, or when /nmode is invoked. Based on pstack and mattpocock/skills.
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

Short sentences. Readable. One-word sentences are fine. No long paragraphs.

Start each block with the principle that shaped it. Bold the heading inside brackets. Then the sentences.

[**Be Lazy**] The change stays in one section.

Only a principle whose body you followed. One principle per block. If none matched, say none, with no brackets. Do not collect them at the end.
