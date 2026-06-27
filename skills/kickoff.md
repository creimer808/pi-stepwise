---
name: kickoff
description: KICKOFF phase of the Stepwise workflow. Interview the user about a new project or feature, then generate .workflow/CONTEXT.md (domain glossary) and .workflow/PLAN.md (dependency-ordered task checklist). Use when the user runs /kickoff or starts anything new.
---

# Stepwise — KICKOFF

You are in the **KICKOFF** phase. The goal is to turn a vague idea into two artifacts the rest of the workflow runs on: a shared vocabulary (`CONTEXT.md`) and an ordered plan (`PLAN.md`). Do not write implementation code here.

## 1. Interview the user

Ask targeted questions. Don't dump all of them at once — ask in small batches, react to the answers, and dig where the answer is thin. Cover:

- **Purpose** — What is this? What problem does it solve? What does "done" look like?
- **Users** — Who uses it? What's their main job-to-be-done?
- **Constraints** — Deadlines, performance, platform, compliance, budget, things that must NOT change.
- **Tech stack** — Languages, frameworks, datastore, deployment target. If greenfield, propose a sensible default and confirm.
- **Scope** — What's explicitly in v1? What's explicitly out? Where are the edges?

Stop interviewing once you can name the core entities and write a plan you'd stake your reputation on. If the user says "just go," fill gaps with sensible defaults and note them as assumptions.

## 2. Write `.workflow/CONTEXT.md`

A domain glossary — the project's shared vocabulary. For every key term, entity, and concept, give a one-to-three sentence definition of what it means *in this project specifically*. This file is the source of truth that `/review` later checks naming against.

```markdown
# Context — <Project Name>

## Purpose
<1–3 sentences>

## Users
<who, and their main job-to-be-done>

## Tech Stack
<languages, frameworks, datastore, deploy target>

## Constraints
- <constraint>

## Glossary
- **<Term>** — <what it means in this project>
- **<Entity>** — <what it represents, its key attributes>

## Assumptions
- <any gap you filled with a default>
```

## 3. Write `.workflow/PLAN.md`

A flat markdown checklist. Order tasks by dependency (earliest unblocked work first). Each task is one checkbox with a one-line description — small enough that a single `/build` can finish it. Avoid nesting; keep it flat and linear.

```markdown
# Plan — <Project Name>

> Run `/build` to implement the next unchecked task.

- [ ] <Task> — <one-line description>
- [ ] <Task> — <one-line description>
```

Guidelines:
- Sequence so each task only depends on tasks above it.
- Split anything that mixes logic and UI into separate tasks (the build phase tests them differently).
- Foundational/setup tasks (scaffolding, test runner, data models) come first.

## 4. Hand off

After writing both files, print the full plan to the user, then end with exactly this instruction:

> **Kickoff complete.** `.workflow/CONTEXT.md` and `.workflow/PLAN.md` are ready. Run **`/build`** to start the first task.
