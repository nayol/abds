# Project Documentation

**Last Updated**: YYYY-MM-DD

---

## Quick Navigation

- [Project Overview](./PROJECT-STATE.md) - Start here
- [Important Patterns](./IMPORTANT/CLAUDE.md) - Critical knowledge
- [Features](#features) - All features documented

---

## Features

### Authentication (`auth/`)
- [Current State](./auth/STATE.md)
- [Architecture](./auth/CLAUDE.md)
- [Work History](./auth/sessions/)

### Database (`database/`)
- [Current State](./database/STATE.md)
- [Architecture](./database/CLAUDE.md)
- [Work History](./database/sessions/)

### API (`api/`)
- [Current State](./api/STATE.md)
- [Architecture](./api/CLAUDE.md)
- [Work History](./api/sessions/)

<!-- Add more features as they're created -->

---

## Document Types

| File | Purpose | Update Frequency |
|------|---------|------------------|
| `PROJECT-STATE.md` | What's happening now | Daily/Weekly |
| `{feature}/STATE.md` | Current feature state | When feature changes |
| `{feature}/CLAUDE.md` | Architecture & "why" | When architecture changes |
| `{feature}/sessions/` | Work history | Never (immutable) |
| `IMPORTANT/` | Critical patterns | As discovered |

---

## Adding New Features

When documenting a new feature:

1. Create feature folder: `mkdir {feature}`
2. Create STATE.md: `cp ../TEMPLATES/STATE.md {feature}/STATE.md`
3. Create CLAUDE.md: `cp ../TEMPLATES/CLAUDE.md {feature}/CLAUDE.md`
4. Create sessions folder: `mkdir {feature}/sessions`
5. Update this README with new feature link

---

## Finding Information

**"What's the project doing right now?"**
→ [PROJECT-STATE.md](./PROJECT-STATE.md)

**"How does [feature] work?"**
→ `{feature}/CLAUDE.md`

**"What's the current state of [feature]?"**
→ `{feature}/STATE.md`

**"What did we do on [date]?"**
→ `{feature}/sessions/{description}_{date}/`

**"What are the critical patterns?"**
→ [IMPORTANT/CLAUDE.md](./IMPORTANT/CLAUDE.md)

---

## Folder Structure

```
docs/
├── README.md              ← You are here
├── PROJECT-STATE.md       ← Start here for overview
├── IMPORTANT/             ← Critical patterns (read first!)
│   ├── CLAUDE.md          ← Index of critical content
│   ├── GUIDES/            ← How-to guides
│   ├── MISTAKES/          ← Documented errors (don't repeat)
│   └── LEARNINGS/         ← Project-specific learnings
└── {feature}/             ← One folder per feature
    ├── STATE.md           ← Current state
    ├── CLAUDE.md          ← Architecture
    ├── IMPORTANT/         ← Feature-critical patterns (optional)
    └── sessions/          ← Work history
        └── {description}_{DATE}/
            ├── summary.md
            └── raw.md (optional)
```

---

**This follows ABDS (Agent Base Directory Specification)**
