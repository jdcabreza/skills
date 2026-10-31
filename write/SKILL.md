---
name: write
description: >-
  Technical writing with outline alignment, a writer pass, audience review,
  and a verify loop. Use for /write, docs, RFCs, READMEs, PR descriptions,
  commit messages, or when a playbook says to run write in full.
---

# Write

Technical writing. Parent owns intent, outline alignment, incorporating review feedback, and the reply. One general-purpose writer (`write` role), then one general-purpose reviewer (`write-review` role). Models from the models file (path in the **harness terms** table in `../nathan-mode/SKILL.md`). If that file is missing, stop and tell the user to run `/setup-nstack`. Do not override these spawns to `nathan-agent`. Apply the **unslop** skill on the parent after the draft and after incorporating feedback. Never pass a subagent's words through verbatim.

## Steps

1. Restate the user's intent in your own words. Capture context, audience (who reads this and at what technical level), and language or tone. Draft an initial outline. Refine it so it flows for that audience. Use numbered headers when order matters. Show the user the restated intent, context, audience, language, and outline. Do not write the full doc until they approve. Skip this wait only when the caller says user review of the draft is not needed (for example **open-pr** filling an MR template).
2. Start a new doc at the path the caller named, or a sensible new path if none was given. For short-lived artifacts (MR body, commit message), keep the draft in chat instead of a file. Spawn one general-purpose writer (`run_in_background: true`, model from the `write` role; omit `model` when the role is `inherit-parent` or `auto`). Brief it with the approved intent, context, audience, language, outline, and destination. The writer must follow the approved outline verbatim: same headers, same order. Fill each header with the relevant details. Do not invent sections. Drain the writer. Apply **unslop** to the whole document.
3. Spawn one general-purpose reviewer (`run_in_background: true`, model from the `write-review` role; omit `model` when the role is `inherit-parent` or `auto`). Brief it with the document path or text, plus the expected audience. The reviewer reads only through that audience's eyes. Return what is hard to understand for them, language that misses them, and other improvements that serve that audience. Drain the report.
4. Incorporate the feedback into the document. Apply **unslop** again. Resume or re-spawn the same reviewer brief and have them re-read. Stop when the reviewer says the doc works for that audience, or when leftover notes are optional polish.

## Reply

The peer-reviewed doc.
