# PRD.md Format

A product requirements document, written from the user's perspective. Use the project's domain vocabulary (`CONTEXT.md`) throughout. No specific file paths or code snippets — they go stale fast.

```md
# {Feature Name} — PRD

## Problem Statement

The problem the user is facing, from the user's perspective.

## Solution

The solution to the problem, from the user's perspective.

## User Stories

A long, numbered list. Each story:

1. As a {actor}, I want {feature}, so that {benefit}.

> Example: As a mobile bank customer, I want to see the balance on my accounts, so that I can make better-informed decisions about my spending.

Be extensive — cover all aspects of the feature.

## Implementation Decisions

Decisions made during the interview. May include:

- Modules to build or modify, and their interfaces
- Architectural decisions and technical clarifications
- Schema changes, API contracts, specific interactions

Do NOT include specific file paths or code snippets.

Exception: if a decision is captured more precisely by a small snippet (state machine, reducer, schema, type shape) than by prose, inline just the decision-rich part and note where it came from.

## Testing Decisions

- What makes a good test here (test external behavior, not implementation details)
- Which modules will be tested, and at which seams
- Prior art — similar tests already in the codebase

## Out of Scope

What this PRD explicitly does NOT cover.

## Further Notes

Anything else — including any defaults you assumed when the user said "just go".
```
