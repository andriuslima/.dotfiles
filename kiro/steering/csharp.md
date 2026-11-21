---
inclusion: fileMatch
fileMatchPattern: "**/*.{cs,csproj,sln}"
---

# C# / .NET Style & Preferences

## Fields, naming, and language usage

- Private fields use `_camelCase` and are marked `private readonly` wherever possible.
- Interfaces are prefixed with `I` (e.g. `IJurisdictionRepository`).
- Public methods and types are `PascalCase`; local variables are `camelCase`.
- Prefer `var` for local variables when the type is obvious from the right-hand side.
- Use constructor injection for dependencies. Avoid service-locator patterns.

## Async

- Return `Task` / `Task<T>` from async methods and suffix them with `Async` (e.g. `GetJurisdictionAsync`).
- Avoid fire-and-forget calls; always await or explicitly justify.

## Architecture / layering

- Follow Controller -> Service -> Repository layering.
- Keep business logic and metrics emission in the **service layer**, not controllers or repositories.
- Name repositories after their backing store, not the domain concept
  (e.g. `S3Repository`, not `JurisdictionExportRepository`).

## Logging

- Use Serilog via the static `Log.X` API with structured message templates.
- Use structured destructuring for objects: `Log.Information("Creating Document: {@Document}", document)`.
- Follow the "Creating X:" (before) / "Created X:" (after) log phrasing convention around operations.

## Testing

- xUnit + Moq + FluentAssertions.
- Use `[Fact]` for tests.

## Stack & tooling

- Target `net8.0`.
- EF Core for data access; AutoMapper for mapping.
- Lint / format check: `dotnet format --verify-no-changes --exclude '**/Migrations/**'`.
- `CommunityArchives.Common` is a shared internal library.
- NuGet packages come from AWS CodeArtifact (domain `community-archives`, source `CA`).
- Run the command to authenticate to AWS CodeArtifact: `aws codeartifact login --tool dotnet --repository nuget --domain community-archives --domain-owner 395174433435 --region us-west-2 --profile [PROFILE]`
