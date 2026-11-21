# AGENTS.md Format

Plain Markdown, no required frontmatter. Placed at repo root (nested copies allowed in subprojects of a monorepo with genuinely different stacks). Target: well under 150 lines for most repos; 30-50 is plenty for a simple one.

**Litmus test for every line: "would removing this cause an agent to make a mistake it wouldn't otherwise make?"** If not, cut it. Generic advice ("write clean code", "use descriptive names") wastes the tokens sent on every single session and doesn't come from your research — leave it out.

## Template

```markdown
# AGENTS.md

## What this project is

One or two sentences. Not a repeat of CONTEXT.md's full description — just enough to orient an agent mid-task.

## Setup / dev environment

- Exact commands to install deps and get a working local environment.
- Required env vars / config files (name them; never put real secrets here).
- Anything non-default about the environment (specific runtime version, required services running locally, docker-compose up, etc.)

## Build

Exact command(s), with flags that matter. E.g. `pnpm turbo run build --filter=api`, not "build the project."

## Test

- Exact command(s) to run the test suite (and a fast subset if one exists).
- Anything the agent must do before tests will pass (seed data, services up, env vars).

## Lint / format

Exact command(s) — only if not already auto-run by a pre-commit hook the agent will trigger anyway.

## Code conventions

Only conventions NOT already enforced by a linter/formatter/type checker in the repo. E.g. "this repo still has both `src/legacy/` (callback-style) and `src/v2/` (async/await) — don't backport patterns between them" — the kind of thing no linter catches.

## Boundaries — do not touch

Files/directories an agent should never modify or must ask before touching: generated code, vendored dependencies, `/legacy/`, migration files already applied, etc.

## Commit / PR conventions

Only if the repo actually enforces one (check CI, CONTRIBUTING.md, commit history) — e.g. conventional commits, required PR template, squash-only.
```

## Notes from research

- Skip any section with nothing repo-specific to say — an empty "## Code conventions: follow best practices" heading is worse than no heading.
- If commands differ from what's discoverable in `package.json`/CI, always prefer what CI actually runs — that's ground truth.
- For an old repo with drifted conventions, it's fine (and useful) to note the drift explicitly rather than pretend the repo is consistent: "Most of the codebase still uses `requests`; new code should use `httpx`, per the migration started in #1234."
- If the repo already has a `CLAUDE.md`, `.cursorrules`, or `.github/copilot-instructions.md`, mention that AGENTS.md is now the shared source and, where practical, suggest the tool-specific file become a symlink to it rather than a duplicate — but don't do this migration without the user's OK, since tool-specific files may carry vendor-specific fields AGENTS.md doesn't support.
