# AWS & CDK Preferences

## Profiles and Environments

- DevQA or Development environment: `ca-devqa` or `devqa`
- UAT or Staging environment: `ca-uat` or `uat`
- Production or Prod environment: `ca-prod` or `prod`

## CLI Authentication

- Use `aws sso login --profile [PROFILE]` to authenticate

## Region & scope

- Never hardcode the region. Use `this.region` (or the construct's stack region).
- Pass the current scope (`this`) into child constructs.

## Construct design

- Prefer L2/L3 constructs over L1 (`Cfn*`) constructs.
- Make constructs props-driven and reusable.
- Use readable `Duration` helpers (`Duration.minutes(15)`), not raw seconds (`900`).
- Give resources explicit names rather than relying on CloudFormation auto-generated names.
- Group related configuration as lists.

## Naming conventions

- Stacks: `CommunityArchives<X>Stack`.
- Files: kebab-case, e.g. `community-archives-<x>-stack.ts`.

## SDK & services

- Use official AWS SDK packages and follow AWS auth best practices.
- Prefer serverless services where they fit.
