# CONTEXT.md Format

A glossary of the project's ubiquitous language — and nothing else.

## Structure

```md
# {Project Name} — Context

{One or two sentences on what this project is and why it exists.}

## Language

**Order**:
A confirmed customer request for goods. Immutable once placed.
_Avoid_: purchase, transaction

**Invoice**:
A request for payment sent to a customer after delivery.
_Avoid_: bill, payment request

**Customer**:
A person or organization that places orders.
_Avoid_: client, buyer, account
```

## Rules

- **Be opinionated.** When several words exist for one concept, pick the best and list the rest under `_Avoid_`. `/stepwise-review` flags `_Avoid_` terms that leak into code.
- **Keep definitions tight.** One or two sentences. Define what it *is*, not what it *does*.
- **Only project-specific terms.** General programming concepts (timeouts, retries, error types) do not belong, even if used heavily. Ask: is this unique to this domain, or generic? Only the former belongs.
- **No implementation details.** No file paths, no code, no schema. This is not a spec or a scratchpad — it is a dictionary.
- **Group under subheadings** when natural clusters emerge; a flat list is fine otherwise.
