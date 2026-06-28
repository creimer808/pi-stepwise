---
name: stuck
description: STUCK phase of the Stepwise workflow. A diagnosis loop for broken things — build a tight red-capable feedback loop FIRST, then minimize, rank hypotheses, instrument, fix, and add a regression test. Use when the user runs /stuck or reports something broken/failing/slow.
---

# Stepwise — STUCK

You are in the **STUCK** phase. Something is broken. Resist guess-and-patch. Tell the user which phase you're in as you go.

## Phase 1 — Build a feedback loop (this is the skill)

Everything else is mechanical. With a **tight pass/fail signal that goes red on *this* bug**, you will find the cause. Without one, no amount of staring at code will. Spend disproportionate effort here. Be aggressive, be creative, refuse to give up.

Construct a loop — roughly in this order of preference: a **failing test** at the seam that reaches the bug; a **curl/HTTP script** against the dev server; a **CLI invocation** diffing output against known-good; a **headless browser script**; **replay a captured trace**; a **throwaway harness** exercising the code path; a **property/fuzz loop** for "sometimes wrong"; a **bisection harness** if it appeared between two known states.

Then **tighten** it — treat the loop as a product:
- **Faster** — cache setup, skip unrelated init, narrow scope.
- **Sharper** — assert the *specific* symptom, not "didn't crash".
- **Deterministic** — pin time, seed RNG, isolate filesystem, freeze network.

For **non-deterministic** bugs the goal is a higher reproduction rate, not a clean repro: loop the trigger 100×, parallelize, add stress, inject sleeps. 50% flake is debuggable; 1% is not — raise the rate first.

**Completion criterion:** you can name **one command you have already run at least once** (paste the invocation + its output) that is red-capable (drives the real bug path, asserts the user's *exact* symptom), deterministic, fast, and agent-runnable. **No red-capable command → do not proceed to a hypothesis.** Catching yourself theorizing before this command exists is the exact failure this phase prevents.

If you genuinely cannot build a loop, **stop and say so** — list what you tried and ask the user for environment access, a captured artifact (HAR, log dump, recording), or permission to add temporary instrumentation. Do not hypothesize without a loop.

## Phase 2 — Reproduce + minimize

Run the loop; watch it go red. Confirm it produces the failure the **user** described (not a nearby one) and that it's reproducible. Then shrink the repro to the **smallest scenario that still goes red** — cut inputs, callers, config, data, steps **one at a time**, re-running after each cut. Done when every remaining element is load-bearing. This shrinks the hypothesis space and becomes your regression test.

## Phase 3 — Hypothesize

Generate **3–5 ranked, falsifiable hypotheses before testing any** — single-hypothesis generation anchors on the first plausible idea. Each must state a prediction: *"If X is the cause, then changing Y makes it disappear / changing Z makes it worse."* No prediction = a vibe; sharpen or discard it. Show the ranked list to the user — they often re-rank instantly ("we just deployed #3"). Don't block if they're away; proceed with your ranking.

## Phase 4 — Instrument

Each probe maps to a specific prediction. **Change one variable at a time.** Prefer a debugger/REPL breakpoint over logs; targeted logs at the boundaries that distinguish hypotheses over "log everything and grep". **Tag every debug log with a unique prefix** like `[DEBUG-a4f2]` so cleanup is a single grep. For performance bugs, measure first (baseline + profiler/timing), then bisect — logs are usually wrong.

## Phase 5 — Fix + regression test

Write the regression test **before** the fix — *if* a correct seam exists (one exercising the real bug pattern at the call site). If the only seam is too shallow to catch the real pattern, **that absence is itself the finding** — note it; the architecture is preventing the bug from being locked down. With a seam: turn the minimized repro into a failing test → watch it fail → apply the fix (root cause, not symptom) → watch it pass → re-run the Phase 1 loop against the original un-minimized scenario.

## Phase 6 — Cleanup + hand off

- [ ] Original repro no longer reproduces (re-run the loop).
- [ ] Regression test passes (or absence of seam is documented).
- [ ] All `[DEBUG-...]` instrumentation removed (grep the prefix).
- [ ] Throwaway harnesses deleted.

End with:

> **Resolved.** Root cause: {one line}. Regression test: {name} (or: no seam — documented). Run **`/build`** to continue.

Then ask: what would have prevented this? If the answer is architectural (no test seam, tangled callers), say so — it's a candidate for the next `/review`.
