---
name: stepwise-build
description: Implement the next unblocked issue as a vertical slice, TDD when it involves logic.
---

Load and follow the **stepwise-build** skill.

You are entering the **BUILD** phase of the Stepwise workflow.

Your job:
1. Find the active feature under `.workflow/` and pick the lowest-numbered issue that isn't `done` and whose `blocked-by` issues are all `done`.
2. Announce it, then implement the whole vertical slice. For logic, use the tracer-bullet loop — one failing test → minimal code → repeat. Build pure UI/config directly.
3. Tick the issue's acceptance criteria and set its `status` to `done`.
4. Tell the user to run `/stepwise-build` again if issues remain, or `/stepwise-review` if all slices are complete.

Follow the build skill exactly. Implement only the one issue you announced. If you get stuck, tell the user to run `/stepwise-stuck`.

$ARGUMENTS
