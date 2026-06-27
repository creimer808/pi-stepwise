---
name: review
description: REVIEW phase of the Stepwise workflow. Zoom out over the whole codebase, flag structural problems and naming drift against CONTEXT.md, and write findings to .workflow/REVIEW.md. Documents only — makes no code changes. Use when the user runs /review or the plan is complete.
---

# Stepwise — REVIEW

You are in the **REVIEW** phase. Zoom out from individual tasks and look at the codebase as a whole. **You document findings only — you do not change code.**

## 1. Orient
Read `.workflow/CONTEXT.md` (especially the glossary) and `.workflow/PLAN.md`. Then survey the actual source tree — entry points, modules, the files that grew during the build phase.

## 2. Audit
Look specifically for things that compound into a mess if left alone:

- **Overloaded files** — a file doing too many unrelated jobs; a good candidate to split.
- **Repeated logic** — the same logic copy-pasted in 2+ places that should be extracted.
- **Naming drift** — identifiers that don't match the `CONTEXT.md` glossary, or the same concept named differently in different places.
- **Leaky boundaries** — layers reaching past their responsibility (UI doing data access, utils knowing about HTTP, etc.).
- **Dead ends** — unused code, TODOs, half-finished paths, missing error handling on real failure modes.
- **Test gaps** — logic with no coverage that will break silently later.

Be concrete: cite `file:line` and say *why* it's a problem and what it will cost later.

## 3. Write `.workflow/REVIEW.md`

```markdown
# Review — <Project Name> — <date>

## Summary
<2–3 sentences: overall health, biggest risk>

## Findings
### <Short title>
- **Where:** `path/to/file.ts:42`
- **Problem:** <what's wrong and why it compounds>
- **Suggested refactor:** <concrete change — do not apply it>
- **Priority:** high | medium | low

## Naming drift vs CONTEXT.md
- <code identifier> → should be <glossary term> (`file:line`)

## What's healthy
- <things that are well-structured — worth preserving>
```

Order findings by priority. If the codebase is genuinely clean, say so — don't invent problems.

## 4. Hand off
End with exactly this:

> **Review complete.** Findings are in `.workflow/REVIEW.md`. Either address them by running **`/kickoff`** to generate a focused cleanup plan, or call it done.

Do not start fixing anything — that's a new `/kickoff` → `/build` cycle.
