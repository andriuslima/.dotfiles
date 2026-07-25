## Summary

[In few sentences, describe the feature being developed from a technical perspective]

### Goals

- [List of goals that we want to achieve with the architecture]
- [e.g., Allow users to process payments asynchronously without page lock.]
- [e.g., Ensure Lambda execution times remain under 500ms for P99 requests.]

### Non-Goals

- [List of things we are not going to consider for this architecture]
- [e.g., Migrating historical transactional data is out of scope for this phase.]
- [e.g., Updating the legacy internal reporting dashboard view.]

## Solution

[Provide a high-level description of how components interact]

[Optionally, add a high level diagram of the solution]

[e.g The workflow typically originates from the Angular app inside the Nx Monorepo, passes through AWS API Gateway, triggers C#/.NET or Node.js Lambdas, and interfaces with RDS MySQL or event streams (EventBirdge)]

### Architectural Decision

[Table to keep records of the architectural decision during the design]

## Backend

### Services

[Specify here the new services/API’s]

[If no new service is needed, remove this section]

### Events

[Specify is any new type os EventBridge events are required]

[Event Name]

- Source: [service]
- Type: [e.g OrderCreated]
- Details: [Event payload]
- Consumers: [service]

### Endpoints

[Define the REST endpoints or event contracts. Specify HTTP methods, request headers, and payload boundaries.]

```
POST /api/v1/resource
Request Body:
{
"id": "string (uuid)",
"name": "string",
"status": "string"
}

Response (202 Accepted):
{
"ticketId": "string (uuid)",
"message": "Processing started"
}
```

## Databases

### New Data Models

[Detail a list of new tables]

[If no new table is needed, remove this section]

[Table name] at [Database]
[table]

### Schema Migrations

[List the changes necessary on existing tables]
[table]

### Frontend

Pages and Routes

[Specify new pages and routes required, as well as changes to any existing page]
