---
name: open-pr
description: >-
  Open a GitLab merge request for work already committed on a feature/ or
  bugfix/ branch. Fills the MR template via write, pushes, creates the MR,
  comments cursor review for Bugbot. Use for /open-pr, nathan-mode landing,
  or when a playbook says to run open-pr. Does not create branches or commits.
disable-model-invocation: true
---

# Open PR

Parent-only. In-process. No Task spawn. Runs on the parent chat model.

Playbooks own the branch and the commits. This skill only opens the MR.

## Steps

1. Confirm the current branch is `feature/<branch-name>` or `bugfix/<branch-name>`. If it is not, stop. Do not create a branch here. Do not open from `develop`, `main`, or `master`.
2. Read the repository's MR template if it exists (GitLab: `.gitlab/merge_request_templates/`, or a root `MERGE_REQUEST_TEMPLATE.md`). Fill it out using the **write** skill in full (writer then audience reviewer). The description must contain proof that the change is working. No need for user review of the draft.
3. Push the branch to remote (usually `origin`). Create the MR with the GitLab CLI (`glab`). Set the description from the artifact in step 2. Prefer `glab` for every GitLab host. Only fall back to another tool if `glab` cannot talk to that remote.
4. Post a top-level MR comment with `glab` that is exactly `cursor review` so Cursor Bugbot runs. Not a thread reply.
5. Return the MR link to the user.

## Reply

The MR link, a short overview of what went in the MR description, the branch name, and the commits involved.

## Notes

- GitLab-only. Use `glab` for push-adjacent MR create and the Bugbot comment (`glab mr create`, `glab mr note`). Do not default to `gh`.
- Auto-land is the default from change playbooks. Skip only when the user explicitly says otherwise.
- Do not invent proof. Use verification the playbook already ran. If there is no proof, say so in the description and stop before creating the MR unless the user explicitly accepts shipping without it.
- Stacked MRs: open only the MR this invocation was asked for. Do not open the whole stack unless asked. Each stack entry's branch base is the prior tip; **sequence-changes** must use that same prior tip as its sequencing base.
