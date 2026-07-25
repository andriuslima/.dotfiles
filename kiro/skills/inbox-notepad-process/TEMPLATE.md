# Notepad Processing Output Template

## JSON Schema

The output MUST be a single valid JSON object with the following structure:

```json
{
  "items": [
    {
      "type": "task",
      "category": "work | personal",
      "title": "Actionable task title with #Person and #context tags",
      "description": "Optional additional context"
    },
    {
      "type": "note",
      "category": "work | personal",
      "title": "Concise note title",
      "description": "Optional details or context to remember"
    }
  ]
}
```

## Field Definitions

| Field | Required | Type | Description |
|-------|----------|------|-------------|
| `type` | Yes | `"task"` or `"note"` | Whether this is an actionable task or a reference note |
| `category` | Yes | `"work"` or `"personal"` | Whether this belongs to work or personal life |
| `title` | Yes | string | Concise, descriptive title. For tasks, should be actionable (start with a verb). Include `#Person` tags and context tags here. |
| `description` | No | string | Additional context, background, or details. Omit if the title is self-sufficient. |

## Context Tags Reference

Embed these naturally in the `title` or `description` fields:

| Tag | Usage | Example |
|-----|-------|---------|
| `#Name` | Person involved | "Follow up with #Sean on deliverables" |
| `#deadline [DATE]` | Task has a due date | "Submit report #deadline 2024-10-15" |
| `#delegate #Name` | Ask someone to do something | "Ask #Maria to review the PR #delegate #Maria" |
| `#waiting` | Blocked on someone else | "PR review from #Carlos #waiting" |
| `#someday` | Not urgent / aspirational | "Learn Kubernetes #someday" |

## Rules

- Output MUST be valid, parseable JSON
- The root object MUST contain an `items` array
- Each item MUST have `type`, `category`, and `title`
- `description` is optional — omit the field entirely if not needed (do not include it as null or empty string)
- Tags go inside the `title` or `description` strings, not as separate fields
- One task = one physical action (split multi-action items)
