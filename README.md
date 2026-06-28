# Stepwise

An opinionated, linear **4-command workflow** for the [Pi](https://pi.dev) coding agent. No decision fatigue, no menu of tools — every command ends by telling you exactly what to run next.

```
/kickoff  →  /build  →  /build  →  …  →  /review
                ↑                          ↓
                └────────  /stuck  ────────┘   (when something breaks)
```

> Design inspired by the engineering skills in [mattpocock/skills](https://github.com/mattpocock/skills) — specifically the PRD → vertical-slice-issues → implement pipeline, the feedback-loop-first debugging discipline, and the strict domain glossary. Stepwise distills those into a single linear 4-command flow.

## The 4 commands

| Command | When | What it does |
|---------|------|--------------|
| **`/kickoff`** | Starting anything new | Interviews you one question at a time, then generates a domain glossary (`CONTEXT.md`), a synthesized **PRD**, and a folder of **vertical-slice issues**. Ends → run `/build`. |
| **`/build`** | Working through the issues | Picks the next *unblocked* issue, announces it, implements it as a full end-to-end slice (TDD for logic, direct for pure UI/config), then ticks its acceptance criteria. Ends → `/build` again, or `/review` when all slices are done. |
| **`/stuck`** | Something is broken | A diagnosis loop that builds a **tight, red-capable feedback loop first**, then minimizes, ranks 3–5 falsifiable hypotheses, instruments, fixes the root cause, and adds a regression test. Ends → run `/build`. |
| **`/review`** | All slices done / end of session | Zooms out over the whole codebase on two axes — **structure** and **spec (vs the PRD)** — and writes `REVIEW.md`. Documents only — no code changes. Ends → `/kickoff` a cleanup plan or call it done. |

## Workflow files

All state lives under a `.workflow/` folder at your project root. The glossary is project-wide; everything else is organized per feature:

```
.workflow/
├── CONTEXT.md                      # project-wide domain glossary (the source of truth /review checks)
└── <feature-slug>/
    ├── PRD.md                      # problem, solution, user stories, decisions, scope
    ├── issues/
    │   ├── 01-<slug>.md            # a vertical slice — status + blocked-by + acceptance criteria
    │   ├── 02-<slug>.md
    │   └── …
    └── REVIEW.md                   # findings from /review
```

### Vertical slices, not a flat checklist

Each issue is a **tracer bullet**: a thin slice that cuts end-to-end through *every* layer (schema → API → UI → tests) and is demoable on its own — not a horizontal slice of one layer. Issues declare their dependencies with `blocked-by`, so `/build` always knows the next workable slice and you never build a layer that has nothing to stand on.

### CONTEXT.md is a strict glossary

`CONTEXT.md` is the project's ubiquitous language and **nothing else** — no implementation details, no file paths. It's opinionated: when several words mean the same thing, one is chosen and the rest are listed under `_Avoid_`. `/review` flags any `_Avoid_` term that leaks into the code.

## How `/build` decides to test

`/build` writes a failing test first for the **logic** in a slice (functions, utils, parsing, validation, business rules) and implements **pure UI/config** directly (markup, styling, copy, scaffolding). It uses the tracer-bullet loop — *one test → one implementation → repeat*, never all-tests-then-all-code — and tests behavior through the public interface so the tests survive refactors. It uses whatever test runner is already configured (`package.json` → `vitest`/`jest`/etc., or the equivalent manifest in other ecosystems). If **no** runner is configured, it asks you before setting one up.

## Install

This is a Pi extension package. Install it into a project (or globally) with the Pi CLI:

```bash
pi add stepwise
# or from a local checkout:
pi add ./stepwise
```

Pi auto-discovers the package's **prompt templates** (`prompts/`) as the `/kickoff`, `/build`, `/stuck`, and `/review` slash commands, and loads the matching **skill** (`skills/<name>/SKILL.md`) on demand when each command runs.

Then, in any project:

```
/kickoff
```

## Package layout

```
stepwise/
├── pi.json                  # package manifest (points Pi at skills/ and prompts/)
├── README.md
├── prompts/                 # slash commands — thin entry points that name the phase
│   ├── kickoff.md
│   ├── build.md
│   ├── stuck.md
│   └── review.md
└── skills/                  # the detailed phase logic, loaded on demand
    ├── kickoff/
    │   ├── SKILL.md
    │   ├── CONTEXT-FORMAT.md     # glossary format
    │   ├── PRD-FORMAT.md         # PRD template
    │   └── ISSUE-FORMAT.md       # vertical-slice issue template
    ├── build/SKILL.md
    ├── stuck/SKILL.md
    └── review/SKILL.md
```

**Prompt templates** are the commands you type; they're intentionally thin and just declare which phase you're in. **Skills** carry the full operating procedure for each phase (with format references kept in sibling files so each `SKILL.md` stays short) and are loaded on demand so the agent always knows exactly what to do next.

## License

MIT
