---
name: stuck
description: Something is broken. Build a tight feedback loop first, then diagnose, fix, and add a regression test.
---

Load and follow the **stuck** skill.

You are entering the **STUCK** phase of the Stepwise workflow.

Work the diagnosis loop in order: **build a tight, red-capable feedback loop first** (the hard part) → reproduce + minimize → 3–5 ranked falsifiable hypotheses → instrument one variable at a time (tagged `[DEBUG-...]` logs) → fix the root cause → regression test → cleanup.

Do not theorize about the cause before you have a single command, already run, that goes red on this exact bug. Follow the stuck skill exactly. When resolved, tell the user to run `/build` to continue.

$ARGUMENTS
