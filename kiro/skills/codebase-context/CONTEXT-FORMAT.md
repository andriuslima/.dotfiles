# CONTEXT.md Format

Unlike AGENTS.md, there's no cross-industry standard for CONTEXT.md — treat it as this repo's own onboarding knowledge base. It's read less often than AGENTS.md (agents pull it in when they need background, not every single turn), so it can afford more prose — but "can afford more" isn't a license to dump the whole codebase in; keep every section skimmable in under a couple minutes.

Covers exactly what the user asked for: what it does, the ins and outs, dependencies.

## Template

```markdown
# CONTEXT.md

## What this is

2-4 sentences: what the project does, who/what it serves, and its rough scale or age if relevant ("a 6-year-old internal billing service" tells an agent a lot). This is the elevator pitch, not the architecture doc — save details for below.

## Ins and outs

### Structure

Top-level folders and what each is for — a map, not a file listing. Call out anything a newcomer would misread (a `utils/` that's actually load-bearing, a `legacy/` still in production, a folder name that doesn't match its contents).

### How it fits together

The few sentences that explain the actual flow: entry point(s) → main subsystems → where data lives → what talks to what. If there's a diagram already in the repo's docs, point to it instead of re-deriving it.

### Non-obvious history / quirks

The stuff a new contributor (human or agent) would otherwise learn the hard way: "this repo was migrated from X to Y in 2022 and both patterns still coexist," "the `v1/` API is deprecated but still serves 40% of traffic," "tests in `integration/` are flaky and often skipped in CI." This section is often the highest-value part of the whole file for an old repo — prioritize it.

## Dependencies

- Group by purpose, not alphabetically: framework, data layer, key libraries, external services/APIs it calls, dev/build tooling.
- Note _why_ a dependency is there when it's not obvious from its name, and flag anything unusual (an unmaintained package, a fork, a version pinned for a specific reason) if you found evidence of it in the repo (comments, changelogs, issues referenced in code).
- Don't just restate the manifest file — that's already in the repo and re-queryable; add the reasoning a manifest can't show.
```

## Notes from research

- If the repo has a working README already, CONTEXT.md should not duplicate it — link to it for things it already covers well (e.g. detailed local setup) and focus CONTEXT.md on what the README is missing: the _why_, the quirks, the parts only visible from history.
- For a genuinely large/old repo, resist the urge to document every subsystem exhaustively. A map plus pointers ("see `services/billing/AGENTS.md` for that subsystem's specifics" or "ask in #team-billing") beats an encyclopedic file nobody keeps updated.
- Treat stale structural claims as worse than no claim — if you're not confident a described piece of architecture is still accurate, say so or mark it `[UNKNOWN / verify]` rather than assert it.
