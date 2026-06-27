---
name: review
description: Zoom out, audit the whole codebase, and write REVIEW.md. Documents findings — no changes.
---

Load and follow the **review** skill.

You are entering the **REVIEW** phase of the Stepwise workflow.

Your job:
1. Read `.workflow/CONTEXT.md` and zoom out over the whole codebase.
2. Flag overloaded files, repeated logic, naming that drifts from CONTEXT.md, and anything that will compound into a mess.
3. Write findings and suggested refactors to `.workflow/REVIEW.md`.

**Do not make code changes in this phase — only document.** Follow the review skill exactly. End by telling the user to either start a new plan with `/kickoff` or call it done.

$ARGUMENTS
