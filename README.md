# Stepwise

An opinionated, linear **4-command workflow** for the [Pi](https://pi.dev) coding agent. No decision fatigue, no menu of tools — every command ends by telling you exactly what to run next.

```
/stepwise-kickoff  →  /stepwise-build  →  /stepwise-build  →  …  →  /stepwise-review
                ↑                          ↓
                └────────  /stepwise-stuck  ────────┘   (when something breaks)
```

> Design inspired by the engineering skills in [mattpocock/skills](https://github.com/mattpocock/skills) — specifically the PRD → vertical-slice-issues → implement pipeline, the feedback-loop-first debugging discipline, and the strict domain glossary. Stepwise distills those into a single linear 4-command flow.

## The 4 commands

| Command | When | What it does |
|---------|------|--------------|
| **`/stepwise-kickoff`** | Starting anything new | Interviews you one question at a time, then generates a domain glossary (`CONTEXT.md`), a synthesized **PRD**, and a folder of **vertical-slice issues**. Ends → run `/stepwise-build`. |
| **`/stepwise-build`** | Working through the issues | Picks the next *unblocked* issue, announces it, implements it as a full end-to-end slice (TDD for logic, direct for pure UI/config), then ticks its acceptance criteria. Ends → `/stepwise-build` again, or `/stepwise-review` when all slices are done. |
| **`/stepwise-stuck`** | Something is broken | A diagnosis loop that builds a **tight, red-capable feedback loop first**, then minimizes, ranks 3–5 falsifiable hypotheses, instruments, fixes the root cause, and adds a regression test. Ends → run `/stepwise-build`. |
| **`/stepwise-review`** | All slices done / end of session | Zooms out over the whole codebase on two axes — **structure** and **spec (vs the PRD)** — and writes `REVIEW.md`. Documents only — no code changes. Ends → `/stepwise-kickoff` a cleanup plan or call it done. |

## Workflow files

All state lives under a `.workflow/` folder at your project root. The glossary is project-wide; everything else is organized per feature:

```
.workflow/
├── CONTEXT.md                      # project-wide domain glossary (the source of truth /stepwise-review checks)
└── <feature-slug>/
    ├── PRD.md                      # problem, solution, user stories, decisions, scope
    ├── issues/
    │   ├── 01-<slug>.md            # a vertical slice — status + blocked-by + acceptance criteria
    │   ├── 02-<slug>.md
    │   └── …
    └── REVIEW.md                   # findings from /stepwise-review
```

### Vertical slices, not a flat checklist

Each issue is a **tracer bullet**: a thin slice that cuts end-to-end through *every* layer (schema → API → UI → tests) and is demoable on its own — not a horizontal slice of one layer. Issues declare their dependencies with `blocked-by`, so `/stepwise-build` always knows the next workable slice and you never build a layer that has nothing to stand on.

### CONTEXT.md is a strict glossary

`CONTEXT.md` is the project's ubiquitous language and **nothing else** — no implementation details, no file paths. It's opinionated: when several words mean the same thing, one is chosen and the rest are listed under `_Avoid_`. `/stepwise-review` flags any `_Avoid_` term that leaks into the code.

## How `/stepwise-build` decides to test

`/stepwise-build` writes a failing test first for the **logic** in a slice (functions, utils, parsing, validation, business rules) and implements **pure UI/config** directly (markup, styling, copy, scaffolding). It uses the tracer-bullet loop — *one test → one implementation → repeat*, never all-tests-then-all-code — and tests behavior through the public interface so the tests survive refactors. It uses whatever test runner is already configured (`package.json` → `vitest`/`jest`/etc., or the equivalent manifest in other ecosystems). If **no** runner is configured, it asks you before setting one up.

## Install

This is a [Pi package](https://pi.dev/docs). You need Pi installed first:

```bash
npm install -g --ignore-scripts @earendil-works/pi-coding-agent
# or:  curl -fsSL https://pi.dev/install.sh | sh
```

Then add Stepwise with `pi install`. Pick the scope you want:

```bash
# Global — available in every project (writes ~/.pi/agent/settings.json)
pi install git:github.com/creimer808/pi-stepwise

# Project-only — writes .pi/settings.json, which you can commit so your
# team gets it automatically (Pi installs it on startup once the project is trusted)
pi install -l git:github.com/creimer808/pi-stepwise

# Try it for a single run without installing anything
pi -e git:github.com/creimer808/pi-stepwise
```

Pin a version with a tag or commit, e.g. `pi install git:github.com/creimer808/pi-stepwise@v0.3.0`. Other source forms also work — a local checkout (`pi install ./pi-stepwise`) or, if published, npm (`pi install npm:pi-stepwise`). Update later with `pi update --extensions`, remove with `pi remove git:github.com/creimer808/pi-stepwise`, and list installed packages with `pi list`.

> **Security note:** Pi packages run with full system access and skills can instruct the agent to run commands. Review the source before installing — this one only reads/writes files under `.workflow/` and your project, and runs your existing test runner.

### Using it

Start Pi in your project (`pi`), then type the slash commands. Pi loads the four **prompt templates** (`prompts/`) as `/stepwise-kickoff`, `/stepwise-build`, `/stepwise-stuck`, `/stepwise-review`, and pulls in the matching **skill** (`skills/<name>/SKILL.md`) on demand when each runs:

```
/stepwise-kickoff
```

If the agent ever skips loading a skill, you can force it directly with `/skill:stepwise-kickoff` (or `stepwise-build`/`stepwise-stuck`/`stepwise-review`). Confirm everything registered with `/help` or by typing `/` to see the autocomplete list.

## Use with Cursor

Cursor implements the same [Agent Skills](https://agentskills.io) standard as Pi, so the `skills/` folders work there unchanged — `name` already matches each folder, and reference files load on demand. You don't need the `prompts/` templates in Cursor: **the skill name *is* the slash command** (`/stepwise-kickoff`, `/stepwise-build`, `/stepwise-stuck`, `/stepwise-review`).

Run the bundled installer — it copies the four skills to wherever Cursor looks:

```bash
git clone https://github.com/creimer808/pi-stepwise && cd pi-stepwise

./install-cursor.sh                # global Cursor:   ~/.cursor/skills
./install-cursor.sh --project      # this project:    .cursor/skills (commit to share with a team)
./install-cursor.sh --agents       # shared, global:  ~/.agents/skills  (Pi AND Cursor read this)
./install-cursor.sh --agents --project   # shared, project: .agents/skills
```

Or copy by hand: `cp -r skills/* ~/.cursor/skills/`. Then open Cursor's Agent chat and type `/stepwise-kickoff`.

> **One workflow, both tools.** Pi and Cursor both auto-discover `.agents/skills/` (project) and `~/.agents/skills/` (global). Install there with `--agents` and a single set of files drives both harnesses.
>
> **Want strict, user-only invocation?** Add `disable-model-invocation: true` to each `SKILL.md` frontmatter so Cursor's agent never auto-fires a phase — you still trigger them manually with `/stepwise-kickoff` etc.

## Package layout

```
stepwise/
├── package.json             # Pi manifest (the `pi` key points at skills/ and prompts/)
├── README.md
├── install-cursor.sh        # copies skills/ into Cursor (.cursor/skills) or shared (.agents/skills)
├── prompts/                 # slash commands — thin entry points that name the phase (Pi only)
│   ├── stepwise-kickoff.md
│   ├── stepwise-build.md
│   ├── stepwise-stuck.md
│   └── stepwise-review.md
└── skills/                  # the detailed phase logic, loaded on demand
    ├── stepwise-kickoff/
    │   ├── SKILL.md
    │   ├── CONTEXT-FORMAT.md     # glossary format
    │   ├── PRD-FORMAT.md         # PRD template
    │   └── ISSUE-FORMAT.md       # vertical-slice issue template
    ├── stepwise-build/SKILL.md
    ├── stepwise-stuck/SKILL.md
    └── stepwise-review/SKILL.md
```

**Prompt templates** are the commands you type; they're intentionally thin and just declare which phase you're in. **Skills** carry the full operating procedure for each phase (with format references kept in sibling files so each `SKILL.md` stays short) and are loaded on demand so the agent always knows exactly what to do next.

## License

MIT
