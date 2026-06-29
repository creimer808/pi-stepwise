# Issue Format

One file per issue: `.workflow/<feature-slug>/issues/NN-<slug>.md`, numbered from `01` in dependency order.

## Vertical-slice rules (tracer bullets)

- Each issue is a thin **vertical** slice cutting end-to-end through ALL layers (schema, API, UI, tests) — **not** a horizontal slice of one layer.
- A completed slice is **demoable or verifiable on its own**.
- Any prefactoring ("make the change easy, then make the easy change") is its own earliest issue.
- Keep slices small enough that a single `/stepwise-build` run finishes one.

## File template

```md
---
status: todo        # todo | in-progress | done
blocked-by: []      # e.g. [01, 03] — issue numbers that must be done first; [] = can start immediately
---

# {NN} — {Title}

## What to build

A concise description of this vertical slice. Describe the end-to-end behavior, not the layer-by-layer implementation. Avoid specific file paths or code snippets — they go stale fast.

## Acceptance criteria

- [ ] Criterion 1 — observable behavior
- [ ] Criterion 2
- [ ] Criterion 3

## User stories covered

- PRD story #1, #4
```

`/stepwise-build` reads `status` and `blocked-by` to choose the next workable issue, and checks the acceptance-criteria boxes as it satisfies them.
