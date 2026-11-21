---
inclusion: fileMatch
fileMatchPattern: "**/*.{ts,tsx,js,jsx,mjs,cjs}"
---

# Node.js (JavaScript / TypeScript) Style & Preferences

## Language & runtime

- TypeScript 5.9.
- Node 22 is the runtime target.

## Formatting (Prettier) and Linting (ESLint)

- Always follow the Prettier configuration in the repository for code style.
- Always follow the ESLint configuration in the repository for linting.
- Use eslint and prettier tools to ensure the code is formatted correctly.

## General practices

- Prefer using script definitions on package.json instead of running commands via npx so the commands can be easily reused
- Prefer application code over shell scripts for logic.
- Validate environment variables at startup; throw if a required var is missing.
- Avoid `ls` inside loops — use `find` (or a proper directory API) instead.
- Map fields explicitly to typed structures; avoid generic/untyped dictionaries.
- Fail gracefully and log on error.
- Prefer writing structured output files over `console.log` for meaningful output.
