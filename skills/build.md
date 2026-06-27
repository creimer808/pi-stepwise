---
name: build
description: BUILD phase of the Stepwise workflow. Read .workflow/PLAN.md, implement the first unchecked task (TDD for logic, direct for pure UI/config), check it off, and hand off to /build or /review. Use when the user runs /build.
---

# Stepwise — BUILD

You are in the **BUILD** phase. Implement exactly **one** task per run — the first unchecked one — and leave the plan in a clean state.

## 1. Find the task

Read `.workflow/PLAN.md`. Find the **first unchecked** (`- [ ]`) task, top to bottom.

- If there are no tasks at all → tell the user to run `/kickoff` first. Stop.
- If every task is checked → tell the user the plan is complete and to run `/review`. Stop.

Announce the task verbatim so the user knows what phase they're in:

> **Building:** <task text>

## 2. Decide: does this task need a test?

Write a test first when the task involves **logic** — functions, utilities, data transforms, parsing, validation, state machines, business rules, API handlers with branching.

Skip the test (implement directly) for **pure UI/config** — static markup, styling, layout, copy, config files, scaffolding, wiring with no branching logic. If a task mixes both, test the logic part and implement the UI part directly.

When unsure, lean toward writing the test.

## 3. If testing — TDD loop

1. **Find the test runner.** Check `package.json` scripts/devDependencies for `vitest`, `jest`, `mocha`, etc. For other ecosystems check the obvious manifest (`pyproject.toml`/`pytest`, `go test`, `cargo test`).
   - If a runner exists, use it.
   - If **none** exists, **stop and ask the user** which to set up before proceeding — do not silently install one.
2. **Write a failing test** that captures the task's expected behavior. Run it. Confirm it fails for the right reason (not a typo/import error).
3. **Implement** the minimum to make it pass.
4. **Run the test.** Iterate until green. Run the broader suite to confirm nothing else broke.

## 4. If not testing — implement directly

Build the task. Keep it small and aligned with `.workflow/CONTEXT.md` naming. Verify it works (build/lint/manual check as appropriate).

## 5. Check it off

Edit `.workflow/PLAN.md`: change this task's `- [ ]` to `- [x]`. Change nothing else.

## 6. Hand off

End with exactly one of these:

- Tasks remain → **One task done and checked off. Run `/build` to continue with the next task.**
- All tasks now checked → **Plan complete. Run `/review` to audit the codebase before calling it done.**

If something broke and you can't get the task green, stop and tell the user to run **`/stuck`**.
