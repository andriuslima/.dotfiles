---
name: codebase-quality
description: Identifies and fixes diagnostic warnings, formatting, and linting issues across C# (.NET) and CDK (Node.js/TypeScript) projects. Use when linting, formatting, fixing code style, resolving ESLint/Prettier/dotnet format issues, or checking for NuGet dependency warnings.
---

## Overview

This skill identifies and fixes diagnostic warnings, formatting, and linting issues across both codebases in this repository:

1. **C# projects** — .NET solution at the repository root
2. **CDK project** — Node.js/TypeScript infrastructure code in the `cicd/` directory

## Step 1: Check if tooling exists

### C# Tooling

Verify the following exist:

- `.editorconfig` at the repository root (defines formatting rules for `dotnet format`)
- The `dotnet format` CLI is available (ships with .NET SDK)

### CDK Tooling

Verify the following exist in the `cicd/` directory:

- `.eslintrc.json` — ESLint configuration
- `.prettierrc.json` — Prettier configuration
- `.prettierignore` — Prettier ignore patterns (should exclude `dist/` and `cdk.out/`)
- `package.json` with the following scripts defined:
  - `format:check` — runs `prettier --check .`
  - `format:write` — runs `prettier --write .`
  - `lint:check` — runs `eslint './**/*.ts' --max-warnings=0`
  - `lint:write` — runs `eslint './**/*.ts' --fix`
- `scripts/check-format.sh` — orchestrates all checks
- `scripts/format-code.sh` — orchestrates all fixes
- Node modules installed (`node_modules/` exists or run `npm install`)

## Step 2: Ensure CI pipeline enforces formatting on PRs

Check that `bitbucket-pipelines.yml` exists at the repository root and includes a `format-lint` step that runs on every pull request.

### What to verify

1. A step definition (e.g. `&format-lint`) that runs `./cicd/scripts/check-format.sh`
2. The step downloads the `.awsauth` artifact (needed for NuGet private feed authentication during `dotnet format` restore)
3. The `pull-requests` section includes the `format-lint` step for all branches (`"**"`)

### Reference: format-lint step definition

```yaml
- step: &format-lint
    name: Check formatting & Linting
    caches:
      - cdk-cache
    artifacts:
      download:
        - .awsauth
    script:
      - /bin/bash ./cicd/scripts/check-format.sh
```

### Reference: pull-requests section

The `format-lint` step must be included in the `pull-requests` pipeline. It can run in parallel with other checks:

```yaml
pull-requests:
  "**":
    - step: *get-aws-credentials
    - step: *install-dependencies
    - parallel:
        - step: *format-lint
        - step: *build-test
```

If the `format-lint` step or its inclusion in `pull-requests` is missing, create or update the pipeline accordingly.

### Ensure custom `code-analysis` pipeline exists

In addition to PR enforcement, verify that a **custom pipeline** named `code-analysis` exists under `pipelines > custom` in `bitbucket-pipelines.yml`. This pipeline allows developers to trigger a full code analysis (SonarCloud) on-demand from Bitbucket without opening a pull request.

#### What to verify

1. A `code-analysis` entry exists under `pipelines > custom`
2. It includes the `get-aws-credentials` step first (needed for NuGet private feed authentication)
3. It runs the `build-test` step with the `coverage.opencover.xml` artifact output (needed by SonarCloud for coverage reporting)
4. It runs the `code-analysis` step that executes the SonarCloud scanner

#### Reference: custom code-analysis pipeline

```yaml
pipelines:
  custom:
    code-analysis:
      - step: *get-aws-credentials
      - step:
          <<: *build-test
          artifacts:
            - coverage.opencover.xml
      - step:
          <<: *code-analysis
```

If the `code-analysis` custom pipeline is missing, add it to `bitbucket-pipelines.yml` using the reference above. The `code-analysis` step definition (`&code-analysis`) should already exist in the `definitions > steps` section — if not, create it using the reference in `references/tooling-config.md`.

## Step 3: Create or update tooling if necessary

If any of the tooling from Step 1 is missing or incomplete, create them using the reference configurations in `references/tooling-config.md`.

Make sure shell scripts are executable (`chmod +x`).

## Step 4: Run tooling to gather warnings and errors

Run each check independently to collect all issues (don't stop at the first failure).

### C# diagnostics

Run from the repository root:

```bash
dotnet format --verify-no-changes --exclude '**/Migrations/**' -v diag
```

This will report:

- **FINALNEWLINE errors** — extra or missing trailing newlines
- **Whitespace/indentation errors** — formatting rule violations from `.editorconfig`
- **NU1603 warnings** — NuGet dependency version mismatches

### CDK diagnostics

Run from the `cicd/` directory:

```bash
npm run format:check
```

This reports Prettier formatting violations.

```bash
npm run lint:check
```

This reports ESLint warnings and errors (with `--max-warnings=0`, any warning is a failure).

## Step 5: Fix all issues using best practices

### C# fixes

1. **Formatting errors** — Run `dotnet format --exclude '**/Migrations/**'` from the repository root to auto-fix.
2. **NU1603 NuGet warnings** — Update the `PackageReference` version in affected `.csproj` files to a version that exists on the feed. Check the diagnostic output for the resolved version and update accordingly.
3. **Other analyzer warnings** — Read the affected files, understand the issue from the diagnostic code, and apply the appropriate fix following C# best practices.

### CDK fixes

1. **Prettier formatting** — Run `npm run format:write` from the `cicd/` directory to auto-fix.
2. **ESLint errors** — Read the affected files and fix manually following TypeScript best practices. Common fixes:
   - Replace `any` types with proper type annotations
   - Add missing return types
   - Remove unused variables/imports
   - Fix naming conventions

## Step 6: Run tooling again to validate no errors exist

Re-run all checks to confirm everything passes:

```bash
# From repository root
dotnet format --verify-no-changes --exclude '**/Migrations/**' -v diag

# From cicd/ directory
npm run format:check
npm run lint:check
```

All commands must exit with code 0. If any still fail, go back to Step 4 and fix the remaining issues. Repeat until clean.

## Important Notes

- Always exclude `**/Migrations/**` when running `dotnet format` — migration files are auto-generated.
- Use `-v diag` on verification runs to surface NuGet and MSBuild warnings that are otherwise hidden.
- The CDK lint script uses `--max-warnings=0` — even warnings are treated as failures.
- Run `npm install` in `cicd/` if `node_modules` doesn't exist before running lint/format commands.
- Do not modify files in `cdk.out/` or `dist/` — these are build outputs.
