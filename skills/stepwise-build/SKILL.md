---
name: stepwise-build
description: BUILD phase of the Stepwise workflow. Pick the next unblocked issue from .workflow/<feature>/issues/, implement it as a vertical slice (TDD for logic, direct for pure UI/config), check off its acceptance criteria, mark it done, and hand off to /stepwise-build or /stepwise-review. Use when the user runs /stepwise-build.
---

# Stepwise — BUILD

You are in the **BUILD** phase. Implement exactly **one** issue per run — the next workable one — and leave it cleanly finished.

## 1. Locate the active feature

Look under `.workflow/` for feature folders containing an `issues/` directory.

- None exist → tell the user to run `/stepwise-kickoff` first. Stop.
- One has unfinished issues → that's the active feature.
- Several have unfinished issues → ask the user which feature to work on. Stop until they answer.

## 2. Pick the next issue

Read every issue file's frontmatter (`status`, `blocked-by`). Choose the **lowest-numbered** issue where `status` is not `done` **and** every issue in its `blocked-by` is `done`.

- No issues left undone → all slices are complete. Tell the user to run `/stepwise-review`. Stop.
- Issues remain but none are unblocked → report the blockage: list each remaining issue and what it's waiting on. Stop. (This usually means a `blocked-by` is wrong — suggest re-running `/stepwise-kickoff` to fix dependencies.)

Set the chosen issue's `status` to `in-progress` and announce it verbatim:

> **Building:** {NN} — {Title}

## 3. Decide: does this slice need a test?

Write a test first for the parts that involve **logic** — functions, utilities, data transforms, parsing, validation, state machines, business rules, handlers with branching. Implement directly (no test) the **pure UI/config** parts — static markup, styling, layout, copy, config, scaffolding, wiring with no branching. A vertical slice usually has both: **test the logic, build the UI directly.** When unsure, lean toward a test.

## 4. Implement the slice (TDD for logic — vertical, not horizontal)

Build the whole slice end-to-end so it's demoable on its own. For the logic parts, use the **tracer-bullet loop — one test → one implementation → repeat.** Never write all tests first then all code; that produces tests coupled to imagined behavior.

1. **Find the test runner.** Check `package.json` scripts/devDependencies for `vitest`, `jest`, `mocha`, etc. (or the equivalent manifest in other ecosystems — `pyproject.toml`/`pytest`, `go test`, `cargo test`).
   - Exists → use it.
   - **None exists → stop and ask the user** which to set up. Do not silently install one.
2. **RED** — write ONE test for the next behavior, through the **public interface** (test what it does, not how). Run it; confirm it fails for the right reason.
3. **GREEN** — write the minimal code to pass. Run it. Don't anticipate future tests.
4. Repeat 2–3 for each behavior in the slice. Run the broader suite once the slice is done to confirm nothing else broke. Typecheck as you go.

Use the `CONTEXT.md` vocabulary for names. **Never refactor while red** — get to green first.

## 5. Close out the issue

In the issue file: tick every satisfied `- [ ]` acceptance criterion to `- [x]`, and set `status: done`. If a criterion turned out to be unachievable or wrong, leave it unticked and note why under the issue — don't fake it.

## 6. Hand off

End with exactly one of:

- Workable issues remain → **Issue {NN} done. Run `/stepwise-build` for the next slice.**
- All issues now done → **All slices complete. Run `/stepwise-review` to audit before calling it done.**

If you got stuck and can't get the slice to green, stop and tell the user to run **`/stepwise-stuck`**.
