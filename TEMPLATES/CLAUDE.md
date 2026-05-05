# [Feature Name] - Architecture

**Created**: YYYY-MM-DD
**Last Updated**: YYYY-MM-DD

---

## Overview

High-level explanation of this feature:

What problem does it solve?
How does it fit into the larger system?

---

## Architecture

### System Diagram

```
┌──────────────┐
│  Component A │──────→ ┌──────────────┐
└──────────────┘        │  Component B │
                        └──────────────┘
                               ↓
                        ┌──────────────┐
                        │  Database    │
                        └──────────────┘
```

### Components

**Component A**:
- Purpose: [What it does]
- Location: `src/path/to/component-a/`
- Key files: `index.ts`, `types.ts`

**Component B**:
- Purpose: [What it does]
- Location: `src/path/to/component-b/`

---

## Design Decisions

### Decision 1: [Title]

**Problem**: What problem we needed to solve

**Options Considered**:

| Option | Pros | Cons | Verdict |
|--------|------|------|---------|
| Option A | Pro 1, Pro 2 | Con 1 | Rejected: [Reason] |
| Option B | Pro 1, Pro 2 | Con 1 | **Selected**: [Reason] |

**Trade-offs Accepted**:
- We traded X for Y because Z

**When to Revisit**:
- If [condition] changes
- If performance becomes an issue
- If requirements change to [specific case]

---

## Implementation Patterns

### Pattern 1: [Pattern Name]

**When to use**:
- Situation A
- Situation B

**Example**:
```typescript
// Code example showing the pattern
function example() {
  // Implementation
}
```

**Why this pattern**:
Explanation of benefits and reasoning.

---

## Data Flow

How data moves through the system:

```
User Input → Validation → Processing → Storage → Response
```

1. **User Input**: [How data enters]
2. **Validation**: [What checks happen]
3. **Processing**: [Business logic]
4. **Storage**: [Where/how it's stored]
5. **Response**: [What user sees]

---

## Security Considerations

- **Authentication**: How users are authenticated
- **Authorization**: What permissions are checked
- **Data Protection**: How sensitive data is protected
- **Input Validation**: What is validated and how

---

## Performance Considerations

- **Bottlenecks**: Known performance limitations
- **Optimizations**: What's been optimized
- **Scaling**: How this scales with load
- **Caching**: What is cached and where

---

## Dependencies

### Internal
- **Module A**: Why we depend on it
- **Module B**: Why we depend on it

### External
- **Library X** (v1.2.3): Purpose
- **Service Y**: Purpose and SLA

---

## Testing Strategy

- **Unit Tests**: What is unit tested
- **Integration Tests**: What integrations are tested
- **E2E Tests**: Critical user flows covered
- **Manual Testing**: What requires manual verification

---

## Deployment

- **Environment Variables**: Required config
- **Database Migrations**: Any schema changes
- **Feature Flags**: If applicable
- **Rollback Plan**: How to rollback if needed

---

## Future Considerations

- **Technical Debt**: Known issues to address later
- **Planned Improvements**: Features on the roadmap
- **Architectural Changes**: Potential refactoring
- **Questions to Resolve**: Open architectural questions

---

## Historical Context

Why was this feature built this way?

- **Original Problem**: [What we were solving]
- **Initial Implementation**: [How it started]
- **Evolution**: [How it changed over time]

---

## References

- [Related ADRs or decision docs]
- [External documentation]
- [API specs]
- [Design docs]
