---
name: stepwise-review
description: Zoom out, audit the codebase against CONTEXT.md and the PRD, and write REVIEW.md. Documents findings — no changes.
---

Load and follow the **stepwise-review** skill.

You are entering the **REVIEW** phase of the Stepwise workflow.

Your job:
1. Read the active feature's `PRD.md` and the project `.workflow/CONTEXT.md`, then zoom out over the whole codebase.
2. On two axes — **structure** (overloaded files, repeated logic, naming drift vs the glossary, leaky boundaries, test gaps) and **spec** (does the code match the PRD?) — flag anything that will compound into a mess.
3. Write findings and suggested refactors to `.workflow/<feature>/REVIEW.md`.

**Do not make code changes in this phase — only document.** Follow the review skill exactly. End by telling the user to either turn the findings into a new plan with `/stepwise-kickoff` or call it done.

$ARGUMENTS
