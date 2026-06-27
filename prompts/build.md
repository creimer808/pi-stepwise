---
name: build
description: Implement the next unchecked task in PLAN.md, TDD when it involves logic.
---

Load and follow the **build** skill.

You are entering the **BUILD** phase of the Stepwise workflow.

Your job:
1. Read `.workflow/PLAN.md` and find the first unchecked task.
2. Announce the task, then implement it. If it involves logic/functions/utils (not pure UI/config), write a failing test first, then make it pass.
3. Check the task off in `.workflow/PLAN.md`.
4. Tell the user to run `/build` again if tasks remain, or `/review` if the plan is complete.

Follow the build skill exactly. Implement only the one task you announced.

$ARGUMENTS
