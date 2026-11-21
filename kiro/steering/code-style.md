# General Code Style & Preferences

These apply across all stacks and languages.

## Architecture

- The API's run on AWS Lambda.
- Accounts for the serverless runtime when making implementation choices
- Prefer event driven architecture with queues over long running process

## Logging

- Always add logs with identifier that can be used to observ the flow of the code for a specific process

## Philosophy

- Prefer readable and simple code over clever code.
- Actively reduce project complexity; avoid anti-patterns.

## Robustness

- Validate inputs.
- Fail gracefully and log on error.

## Documentation

- Prefer bullet lists over tables.
- Keep Mermaid diagrams as separate files under `docs/`, generate an SVG from them,
  and reference the generated image in the markdown (rather than inlining raw Mermaid).

## Dependencis

- Always prefer to use the exact version of a dependency (version=3.123.0) instead of qualifiers
