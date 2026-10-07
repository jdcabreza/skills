---
name: descriptive-code
description: Writes code a reader can describe back. Domain names, plain control flow, and a comment only for a why or a gotcha. Use when writing or editing code, naming identifiers, choosing a language feature or API, or when adding, editing, or reviewing comments.
disable-model-invocation: true
---

# Descriptive Code

The code describes what it does. A reader who has not seen the line gets it in one pass. The name says what the value is, what the boolean asserts, or what the function returns. A comment explains a why or a gotcha the code cannot show.

Established words stay: `id`, `url`, `api`. An abbreviation you invent does not. Prefer the longer name a reader already uses. A short clever name is a worse name. A user-level decision is who asked, what the product owner wanted, what the chat decided, or which principle suggested the line. That record lives in the merge request or the commit, not in the file. A gotcha is a constraint the next editor cannot see from the code: a library bug, an ordering trap, a unit, a legacy value.

## Do

1. Name the value for the domain thing it is. `archivedUsers`, not `data`. `alreadyAssigned`, not `ok` or `flag`. `archiveUser`, not `handle` or `process`.
2. Spell the name out. `user`, `configuration`, `transaction`. Not `usr`, `cfg`, `txn`.
3. Use the common form of the language. A branch, a loop, a named function.
4. Use an obscure operator, API, or language trick only when the plain form cannot do the job. Then leave a comment with the gotcha, if the reason is not visible.
5. Keep a longer plain block when the shorter version makes the reader decode it.
6. Default to no comment. Add one only when the code cannot show the reason, and the next edit will be wrong without it. State the constraint. Name the bad outcome it prevents.
7. Delete a comment that restates the next line, the function name, or the signature. Delete one that cites a person, a ticket, a chat, or a product request. If the line still needs a technical why, write that why and nothing else.
8. You are done when a tired reader can say what each name holds, can trace the values without re-reading the line, and every remaining comment would change a later edit.

## Don't

- Use `data`, `info`, `temp`, `result`, `item`, `obj`, `helper`, `manager`, or `process` when the domain has a word.
- Shorten a name so it sounds punchy.
- Nest ternaries, boolean puzzles, or dense comprehensions that hide a branch.
- Abbreviate to fit a line.
- Pick a clever standard-library function the next reader would have to look up, when a few plain lines say it.
- Import a style from another language so the code looks expert.
- Narrate the code. `// get the user by id` above a lookup.
- Leave a block of commented-out code.
- Write the product story in the file. `// users complained about long pages`.
- Add a comment so a change looks documented.

## Not this

- Boilerplate added so the code looks "explicit". A direct line is easier to read.
- A name that is already the domain's word, even if it is short (`id`). Do not expand it into something the domain does not say.
- A file format that is the comment, such as a license header the repo already requires. Leave it.
- A public API whose existing convention is a one-line contract for callers. Follow that convention. Still delete a line that only repeats the signature.

## Example

Agent default: `const ok = u && u.p && !u.p.some(x => x === id)`, with `// Filter out archived users because the user asked for it`.

Do this:

```
const alreadyAssigned = user.projects.some(project => project.id === projectId)
```

No comment, if the code shows the filter. If the reason is invisible: `// Legacy rows used status 0 for archived before the status enum existed.`
