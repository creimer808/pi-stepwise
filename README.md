# Stepwise

An opinionated, linear **4-command workflow** for the [Pi](https://pi.dev) coding agent. No decision fatigue, no menu of tools — every command ends by telling you exactly what to run next.

```
/kickoff  →  /build  →  /build  →  …  →  /review
                ↑                          ↓
                └────────  /stuck  ────────┘   (when something breaks)
```

## The 4 commands

| Command | When | What it does |
|---------|------|--------------|
| **`/kickoff`** | Starting anything new | Interviews you about the project, then generates `CONTEXT.md` (domain glossary) and `PLAN.md` (dependency-ordered task checklist). Ends → run `/build`. |
| **`/build`** | Working through the plan | Finds the first unchecked task, announces it, implements it (TDD for logic, direct for pure UI/config), checks it off. Ends → run `/build` again, or `/review` when done. |
| **`/stuck`** | Something is broken | Runs a structured 6-step debug loop: reproduce → minimize → hypothesize → instrument → fix → regression test. Ends → run `/build`. |
| **`/review`** | Plan complete / end of session | Zooms out over the whole codebase, flags overloaded files, repeated logic, and naming drift, then writes `REVIEW.md`. Documents only — no code changes. Ends → `/kickoff` a cleanup plan or call it done. |

## Workflow files

All state lives in a `.workflow/` folder at your project root:

- **`.workflow/CONTEXT.md`** — the project's shared vocabulary. The source of truth `/review` checks naming against.
- **`.workflow/PLAN.md`** — a flat markdown checklist driving `/build`.
- **`.workflow/REVIEW.md`** — findings and suggested refactors from `/review`.

## How `/build` decides to test

`/build` writes a failing test first when a task involves **logic** (functions, utils, parsing, validation, business rules), and implements directly for **pure UI/config** (markup, styling, copy, scaffolding). It uses whatever test runner is already configured in your project — it checks `package.json` for `vitest`/`jest`/etc. (and the equivalent manifest in other ecosystems). If **no** runner is configured, it asks you before setting one up.

## Install

This is a Pi extension package. Install it into a project (or globally) with the Pi CLI:

```bash
pi add stepwise
# or from a local checkout:
pi add ./stepwise
```

Pi auto-discovers the package's **prompt templates** (`prompts/`) as the `/kickoff`, `/build`, `/stuck`, and `/review` slash commands, and loads the matching **skills** (`skills/`) on demand when each command runs.

Then, in any project:

```
/kickoff
```

## Package layout

```
stepwise/
├── pi.json              # package manifest (points Pi at skills/ and prompts/)
├── README.md
├── prompts/             # slash commands — thin entry points that name the phase
│   ├── kickoff.md
│   ├── build.md
│   ├── stuck.md
│   └── review.md
└── skills/              # the detailed phase logic, loaded on demand
    ├── kickoff.md
    ├── build.md
    ├── stuck.md
    └── review.md
```

**Prompt templates** are the commands you type; they're intentionally thin and just declare which phase you're in. **Skills** carry the full operating procedure for each phase and are loaded on demand so the agent always knows exactly what to do next.

## License

MIT
