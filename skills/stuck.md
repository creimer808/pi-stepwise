---
name: stuck
description: STUCK phase of the Stepwise workflow. A structured debug loop — reproduce, minimize, hypothesize, instrument, fix, regression test — for when something is broken. Use when the user runs /stuck or reports a bug.
---

# Stepwise — STUCK

You are in the **STUCK** phase. Something is broken. Resist the urge to guess-and-patch. Work these six steps **in order** and tell the user which step you're on as you go.

## 1. Reproduce
Get the failure to happen reliably and on demand. Capture the exact command, input, and observed-vs-expected output. If you can't reproduce it, you can't fix it — gather more detail from the user before continuing.

## 2. Minimize
Strip the failing case down to the smallest thing that still fails. Remove unrelated code, inputs, and dependencies. A small reproduction usually points straight at the cause.

## 3. Hypothesize
State a single, specific, falsifiable hypothesis about the root cause: "X fails because Y." Don't list ten maybes — commit to the most likely one.

## 4. Instrument
Test the hypothesis with evidence, not vibes. Add logging, assertions, a breakpoint, or a probe that will confirm or kill the hypothesis. Run it.
- Hypothesis confirmed → go to step 5.
- Hypothesis wrong → return to step 3 with what you just learned.

## 5. Fix
Fix the **root cause**, not the symptom. Keep the change minimal and aligned with `.workflow/CONTEXT.md` naming. Remove any temporary instrumentation you added in step 4.

## 6. Regression test
Add a test that fails before your fix and passes after, so this bug can never silently come back. Use the project's existing test runner. Run the full suite to confirm the fix holds and nothing else broke.

## Hand off
End with:

> **Resolved.** Root cause: <one line>. Regression test added: <test name>. Run **`/build`** to continue the plan.

If after the loop the bug is environmental or genuinely out of scope, say so plainly and propose the next concrete action instead of forcing a fix.
