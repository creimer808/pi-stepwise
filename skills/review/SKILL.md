---
name: review
description: REVIEW phase of the Stepwise workflow. Zoom out over the whole codebase, audit structure and naming against CONTEXT.md and the PRD, and write findings to .workflow/<feature>/REVIEW.md. Documents only — makes no code changes. Use when the user runs /review or all issues are done.
---

# Stepwise — REVIEW

You are in the **REVIEW** phase. Zoom out from individual issues and look at the codebase as a whole. **You document findings only — you do not change code.**

## 1. Orient

Identify the active feature folder under `.workflow/`. Read its `PRD.md` and the project `CONTEXT.md` (especially the **glossary** and its `_Avoid_` terms). Then survey the actual source tree — entry points, the modules that grew during the build phase, the test suite.

## 2. Audit on two axes

**Standards / structure** — things that compound into a mess if left alone:
- **Overloaded files** — one file doing too many unrelated jobs; a split candidate.
- **Repeated logic** — the same logic in 2+ places that should be extracted.
- **Naming drift** — identifiers that don't match the `CONTEXT.md` glossary, or `_Avoid_` terms that leaked into code, or one concept named two ways.
- **Leaky boundaries** — UI doing data access, utils knowing about HTTP, etc.
- **Test gaps** — logic with no behavioral coverage that will break silently; bug-prone seams `/stuck` flagged as untestable.

**Spec** — does the code match what the PRD asked for?
- Requirements that are missing or only partial.
- Behavior in the code that the PRD never asked for (scope creep).
- Requirements that look implemented but look wrong.

Be concrete: cite `file:line`, say *why* it's a problem, and what it will cost later. Quote the glossary term or PRD line behind each finding.

## 3. Write `.workflow/<feature-slug>/REVIEW.md`

```markdown
# Review — {Feature} — {date}

## Summary
{2–3 sentences: overall health, biggest risk}

## Standards & structure
### {Short title}
- **Where:** `path/to/file.ts:42`
- **Problem:** {what's wrong and why it compounds}
- **Suggested refactor:** {concrete change — do not apply it}
- **Priority:** high | medium | low

## Spec gaps (vs PRD)
- {requirement} — missing / partial / looks wrong — PRD: "{quoted line}"

## Naming drift (vs CONTEXT.md)
- `{code identifier}` → should be `{glossary term}` (`file:line`)

## What's healthy
- {well-structured things worth preserving}
```

Order findings by priority. If the codebase is genuinely clean, say so — don't invent problems.

## 4. Hand off

End with exactly:

> **Review complete.** Findings → `.workflow/<feature-slug>/REVIEW.md`. Either run **`/kickoff`** to turn the findings into a focused cleanup plan, or call it done.

Do not start fixing — that's a new `/kickoff` → `/build` cycle.
