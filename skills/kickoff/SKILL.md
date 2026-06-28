---
name: kickoff
description: KICKOFF phase of the Stepwise workflow. Interview the user one question at a time, then produce three artifacts — a strict domain glossary (.workflow/CONTEXT.md), a synthesized PRD (.workflow/<feature>/PRD.md), and a folder of vertical-slice issues (.workflow/<feature>/issues/NN-*.md). Use when the user runs /kickoff or starts anything new.
---

# Stepwise — KICKOFF

You are in the **KICKOFF** phase. Turn a vague idea into the artifacts the rest of the workflow runs on. **Do not write implementation code here.** Work the steps in order.

## 1. Interview (grill — one question at a time)

Interview the user relentlessly until you reach a shared understanding. **Ask one question at a time and wait for the answer** — dumping multiple questions at once is bewildering. For each question, give your *recommended* answer so the user can just confirm. If a question can be answered by exploring the codebase, **explore instead of asking.**

Walk the design tree, resolving dependencies between decisions one by one. Cover:

- **Purpose** — what problem, from the user's perspective. What does "done" look like?
- **Users** — who, and their main job-to-be-done.
- **Constraints** — deadlines, platform, performance, things that must NOT change.
- **Tech stack** — languages, frameworks, datastore, deploy target. Propose a default if greenfield.
- **Scope** — explicitly in v1 vs. out.

Stop interviewing once you can name the core domain entities and sketch the vertical slices you'd stake your reputation on. If the user says "just go," fill gaps with sensible defaults and record them in the PRD's *Further Notes*.

## 2. Pick the feature slug

Choose a short kebab-case slug for this body of work (e.g. `user-auth`, `csv-export`). All per-feature artifacts live under `.workflow/<feature-slug>/`. Confirm the slug with the user in one line.

## 3. Write the glossary — `.workflow/CONTEXT.md`

The project-wide ubiquitous language. **Glossary only — zero implementation details, no file paths, no code.** Be opinionated: when several words mean the same thing, pick one and list the rest under `_Avoid_`. Follow [CONTEXT-FORMAT.md](./CONTEXT-FORMAT.md). This file persists across features and is what `/review` later checks naming against. If it already exists, sharpen it rather than overwrite it.

## 4. Synthesize the PRD — `.workflow/<feature-slug>/PRD.md`

**Synthesize from the interview — do NOT re-interview.** Use the domain vocabulary from `CONTEXT.md` throughout. Sketch the test seams (prefer existing seams, the highest seam possible, the fewest possible — ideally one) and confirm they match the user's expectations. Then write the PRD using [PRD-FORMAT.md](./PRD-FORMAT.md). No specific file paths or code snippets — they go stale fast.

## 5. Break the PRD into vertical-slice issues — `.workflow/<feature-slug>/issues/`

Break the PRD into **tracer-bullet** issues: each a thin vertical slice cutting end-to-end through ALL layers (schema → API → UI → tests), independently demoable, NOT a horizontal slice of one layer. Follow [ISSUE-FORMAT.md](./ISSUE-FORMAT.md).

Present the proposed breakdown as a numbered list (title, blocked-by, user stories covered) and **quiz the user**: is the granularity right? are the dependencies correct? merge or split any? Iterate until they approve. Then write one file per slice — `issues/NN-<slug>.md`, numbered from `01` in dependency order (blockers first) — so each issue's `Blocked by` can reference real earlier issue numbers.

## 6. Hand off

Print the issue list, then end with exactly:

> **Kickoff complete.** Glossary → `.workflow/CONTEXT.md`. PRD + issues → `.workflow/<feature-slug>/`. Run **`/build`** to start the first unblocked issue.
