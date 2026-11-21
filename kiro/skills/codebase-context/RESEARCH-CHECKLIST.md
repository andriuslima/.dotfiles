# Research checklist

Goal: get to ground truth fast, from files that can't lie (manifests, CI, lockfiles) before trusting files that can go stale (READMEs, wikis, comments).

## 1. What kind of repo is this?

- `ls` the root and top two levels. Monorepo (multiple `package.json`/`*.csproj`/`pyproject.toml` under one root) or single-project?
- If monorepo: is there already a root-level agent file plus per-package ones? Plan the same shape — a lean root AGENTS.md/CONTEXT.md plus optional nested `AGENTS.md` in subprojects with genuinely different stacks or conventions. Don't duplicate the root content in each subproject file.

## 2. Dependencies — find the manifest + lockfile for the ecosystem present

| Ecosystem   | Manifest                                                        | Lockfile                                             | Notes                                                                 |
| ----------- | --------------------------------------------------------------- | ---------------------------------------------------- | --------------------------------------------------------------------- |
| Node/JS/TS  | `package.json`                                                  | `package-lock.json` / `yarn.lock` / `pnpm-lock.yaml` | lockfile tells you the actual resolved tool (npm vs yarn vs pnpm)     |
| Python      | `pyproject.toml` / `setup.py` / `requirements.txt`              | `poetry.lock` / `uv.lock` / `Pipfile.lock`           | check for multiple requirements files (dev/test/prod split)           |
| .NET        | `*.csproj` / `*.fsproj`                                         | `packages.lock.json` (if enabled)                    | also check `Directory.Build.props`/`nuget.config` for shared settings |
| Java/Kotlin | `pom.xml` (Maven) or `build.gradle`/`build.gradle.kts` (Gradle) | —                                                    | check `settings.gradle` for multi-module structure                    |
| Ruby        | `Gemfile`                                                       | `Gemfile.lock`                                       |                                                                       |
| Go          | `go.mod`                                                        | `go.sum`                                             |                                                                       |
| Rust        | `Cargo.toml`                                                    | `Cargo.lock`                                         | check for a workspace `Cargo.toml`                                    |

For each major dependency, note _why_ it's there if you can tell (framework, DB driver, internal-only package, etc.) — a bare version list isn't useful in CONTEXT.md, the reasoning is.

## 3. Real build/test/lint commands — trust CI over docs

- `.github/workflows/*.yml`, `.gitlab-ci.yml`, `.circleci/config.yml`, `Jenkinsfile`, `azure-pipelines.yml`, `.drone.yml`
- These give the _actual_ invoked commands, flags, and env vars — often more accurate than a hand-written README that's drifted.
- Cross-check against `package.json` scripts, a `Makefile`, `justfile`, `Taskfile.yml`, or `.NET`'s launch/build configs.

## 4. Code style / conventions actually enforced

- Linter/formatter configs: `.eslintrc*`, `.prettierrc*`, `ruff.toml`/`.flake8`/`pyproject.toml [tool.ruff]`, `.editorconfig`, `.stylecop.json`, `checkstyle.xml`
- Only document conventions in AGENTS.md that _aren't_ already enforced by one of these tools — if a linter catches it, the agent doesn't need to be told, the tool is the constraint.
- Pre-commit hooks (`.pre-commit-config.yaml`, `husky`/`lint-staged` config) often reveal the real required checks before a commit is accepted.

## 5. Architecture / "ins and outs"

- Top-level folder structure and what each directory is for (skim, don't enumerate every file).
- Entry points: `main.*`, `index.*`, `Program.cs`, `manage.py`, `app.py`, Dockerfiles / `docker-compose.yml` (reveal running services and how they connect).
- Existing design docs: `docs/`, `ADR/` or `adr/`, `RFC/`, wiki links in the README, comments referencing tickets/design docs.
- `git log --oneline -20` and `git log --stat` on the busiest files for a sense of what's actively touched vs. legacy/frozen code — useful for flagging "this area is old and fragile" in CONTEXT.md.
- Look for a `.env.example` / `config/` — reveals required external services, secrets, and integrations without exposing real credentials.

## 6. Testing approach

- Test directory layout (`tests/`, `__tests__/`, `spec/`, `*.Tests/`) and the framework in use (pytest, Jest, xUnit, RSpec, etc.) — usually visible from the dependency manifest plus a sample test file.
- Note whether tests are unit-only, or there's an integration/e2e layer needing services (docker-compose, testcontainers) — this belongs in AGENTS.md as a "how to run tests" note if non-obvious.

## 7. What to flag as [UNKNOWN] rather than guess

Business/product context, why an unusual or inconsistent pattern exists, current deployment process (if not in CI config), code ownership, which of several competing conventions in an old repo is the one to follow going forward. These need the user, not the repo.
