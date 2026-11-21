---
name: codebase-context
description: Generates AGENTS.md and CONTEXT.md for an existing repository, especially large/old ones with no current AI-agent docs. Researches the codebase first (manifests, CI, docs, git history) to draft both files, then asks the user only about what couldn't be determined — each question paired with a recommendation based on repo findings and best practices. Use whenever the user asks to document a repo for AI agents, create/update AGENTS.md or CONTEXT.md, onboard a legacy codebase, or set up agent context files.
---

# Repo Context Docs

Produces two complementary files at the repo root:

- **AGENTS.md** — terse, operational instructions for coding agents (build/test/lint commands, conventions, boundaries). Follows the open [agents.md](https://agents.md) spec. Read on every agent session start, so every line costs context — keep it lean.
- **CONTEXT.md** — a narrative knowledge doc: what the project does, how it's put together, its dependencies. Not a formal standard; think "onboarding doc for whoever (human or agent) has never seen this repo." Can be longer than AGENTS.md but should stay skimmable, not exhaustive.

Never conflate the two. AGENTS.md tells an agent _how to act_. CONTEXT.md tells it (or a person) _what this thing is_. Don't restate CONTEXT.md's narrative in AGENTS.md, and don't stuff AGENTS.md's command lists into CONTEXT.md.

## Workflow

### 1. Check for existing files

Look for an existing `AGENTS.md`, `CLAUDE.md`, `CONTEXT.md`, or `README.md` at the repo root. If `AGENTS.md`/`CLAUDE.md` already exists, ask whether to update it in place or start fresh — don't silently overwrite. If a `README.md` exists, treat it as a primary source, not something to duplicate.

### 2. Research the repo before asking anything

Work through `RESEARCH-CHECKLIST.md`. In short: package manifests + lockfiles (dependencies), CI config (real build/test/lint commands), linter/formatter configs (real style rules), folder structure (architecture), existing docs/ADRs/wiki links, `git log` (age, active areas, recent conventions), test directory layout (testing approach). Prefer ground truth from config files and CI over what a stale README claims.

Take real notes as you go (a scratch file is fine) — you'll need them for both output files and for step 4.

### 3. Draft both files from research

- Draft **AGENTS.md** using `AGENT-FORMAT.md`. Include only what an agent can't infer from the code itself: exact commands, non-obvious conventions, and hard boundaries. Cut anything generic ("write clean code") — it's noise that dilutes the signal on every session. Target well under 150 lines; for a big old repo it's tempting to document everything, resist it.
- Draft **CONTEXT.md** using `CONTEXT-FORMAT.md`, covering exactly the three things the user asked for: a short description of what it does, the ins and outs of the repo, and its dependencies (with _why_, not just a copy of the manifest, where you can tell).

Mark anything uncertain or unfindable inline (e.g. `[UNKNOWN: deploy process not in repo]`) instead of guessing silently.

### 4. Ask about gaps only

Don't interview the user about things the repo already answered. For each `[UNKNOWN]` or genuinely ambiguous point (e.g. undocumented business context, why an unusual pattern exists, ownership, deploy process, which of several conventions is actually current), ask a short, specific question — and always propose a recommendation based on what you found in the repo plus general best practice, so the user can just confirm rather than write from scratch. Batch these into as few rounds as possible; don't drip one question at a time.

### 5. Write the files, then show a short diff/summary

Write both files to the repo root. Give the user a brief summary of what went in each and which parts came from `[UNKNOWN]`-turned-answers vs. pure repo research — not a full re-read of the files, they can open those themselves.

### 6. Create a session-end hook to keep docs current

After writing the files, create a Kiro hook that reminds the agent to check whether AGENTS.md or CONTEXT.md need updating at the end of each session. Use the `createHook` tool with these settings:

- **id**: `update-repo-context-docs`
- **name**: `Update AGENTS.md and CONTEXT.md if needed`
- **trigger**: `Stop`
- **actionType**: `agent`
- **prompt**:

```
Before finishing this session, review the changes you made. If any of the following changed significantly, update the corresponding file at the repo root:

- AGENTS.md — update if: build/test/lint commands changed, new conventions were established, new boundaries were introduced, dependencies shifted (e.g., new test framework, SDK migration), or the branch/deploy model changed.
- CONTEXT.md — update if: new services or Lambda handlers were added, the architecture or processing flow changed, new source systems were integrated, new AWS resources were deployed, or the dependency table needs new entries.

Only update if the changes are meaningful. Reformatting, bug fixes, or small refactors do not warrant an update. If you do update, keep the same structure and tone already in the files.
```

This ensures the docs stay accurate as the codebase evolves without requiring the user to remember to run this skill again.

## References

- `RESEARCH-CHECKLIST.md` — where to look for dependencies, structure, and conventions across common ecosystems (Node, Python, .NET, Java/Kotlin, Ruby, Go, Rust) and in monorepos.
- `AGENT-FORMAT.md` — AGENTS.md structure, section-by-section, with the "would removing this line cause a mistake?" litmus test.
- `CONTEXT-FORMAT.md` — CONTEXT.md structure covering description, ins-and-outs, and dependencies.
