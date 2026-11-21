# Git Preferences

## Integration strategy

- Always rebase over merge.

## Branch naming

- Pattern: `type/kebab-case-description`.
- Allowed types: `feature/`, `fix/`, `bugfix/`, `hotfix/`, `release/`, `misc/`.
- Examples: `feature/jurisdiction-export`, `fix/null-metrics`, `release/1.4.0`.

## Commit messages

- Follow Conventional Commits: `feat:`, `fix:`, `chore:`, `docs:`.
- Scopes are optional but encouraged: `feat(order):`, `fix(export):`.

## Branching model (GitFlow)

- `develop` -> DevQA environment.
- `release/*` -> UAT environment.
- `master` -> Production.
- CI/CD via Bitbucket Pipelines.

## Formatting scripts

- Format check: `scripts/check-format.sh`.
- Auto-format: `scripts/format-code.sh`.
