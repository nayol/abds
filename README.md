# ABDS - Agent Base Directory Specification

**A standard for organizing documentation and knowledge in AI agent development environments.**

Like XDG for `~/.config/`, but for AI agent workspaces.

---

## What is ABDS?

ABDS is an **open specification** (not a tool) that defines:

- **Where** documentation lives (standard directory layout)
- **How** to organize knowledge (4-layer documentation system)
- **What** formats to use (markdown, YAML frontmatter, standard templates)

**Think**: XDG Base Directory Specification, but for AI agents.

---

## The Problem

Working with AI agents (Cursor, Aider, Windsurf, etc.) leads to:

- 📂 **Scattered documentation**: README, CLAUDE.md, random docs/ files
- 🤔 **Lost context**: "What did we do last week? Why that decision?"
- 🔄 **Repeated work**: Solving the same problems over and over
- 🎨 **Inconsistent formats**: Every project documents differently
- 🔍 **Poor navigation**: Hard for both humans and LLMs to find information

---

## The Solution

ABDS provides a **standard structure**:

```
Global (cross-project knowledge):
~/.abds/
├── learnings/              # Searchable knowledge base
│   ├── CATALOG.md          # Auto-generated index
│   ├── database/
│   ├── ui/
│   └── debugging/
└── plans/                  # Implementation plans

Local (project-specific):
my-project/.abds/
└── docs/
    ├── PROJECT-STATE.md    # 2-min project overview
    ├── auth/
    │   ├── STATE.md        # Current state
    │   ├── CLAUDE.md       # Architecture
    │   └── sessions/       # Work history
    └── database/
        ├── STATE.md
        └── sessions/
```

---

## Why ABDS?

### ✅ Universal
Works with **any** AI agent system:
- Cursor
- Aider
- Windsurf
- Gemini
- Custom tools
- Any LLM-based coding assistant

### ✅ Predictable
Always know where to find:
- Current project state → `.abds/docs/PROJECT-STATE.md`
- Feature architecture → `.abds/docs/{feature}/CLAUDE.md`
- Work history → `.abds/docs/{feature}/sessions/`
- Cross-project learnings → `~/.abds/learnings/`

### ✅ Separates Concerns
- **Current state** ≠ **Architecture** ≠ **History** ≠ **Learnings**
- Each layer has different update frequency and audience

### ✅ Git-Friendly
- Plain text (markdown)
- Clear diffs
- Immutable history (sessions never change)

### ✅ LLM-Optimized
- Structured for agent parsing
- Standard locations = predictable navigation
- Markdown = native format for LLMs

---

## Quick Start

### 1. Create Global Directory

```bash
mkdir -p ~/.abds/learnings
mkdir -p ~/.abds/plans
```

### 2. Create Project Structure

```bash
cd my-project
mkdir -p .abds/docs

# Create PROJECT-STATE.md
cat > .abds/docs/PROJECT-STATE.md << 'EOF'
# Project State

**Last Updated**: 2026-05-05

## Current Focus
- What you're working on right now

## What Works ✅
- Features that are deployed and working

## Active Problems ⚠️
- Issues being investigated

## Recent Changes (Last 7 Days)
- Recent updates
EOF
```

### 3. Add Feature Documentation

```bash
mkdir -p .abds/docs/database
cat > .abds/docs/database/STATE.md << 'EOF'
# Database State

## What's Working
- PostgreSQL with RLS policies
- User authentication tables

## Known Issues
- None currently

## Key Files
- `supabase/migrations/` - All migrations
- `src/lib/supabase.ts` - Supabase client
EOF
```

### 4. Capture Learnings

```bash
mkdir -p ~/.abds/learnings/database
cat > ~/.abds/learnings/database/rls-schema-qualification.md << 'EOF'
---
keywords: [database, rls, supabase, security]
category: database
confidence: verified
tldr: "Always qualify RPC calls with schema to prevent security issues"
---

# RLS Schema Qualification

## TL;DR
Always use `client.schema('public').rpc(...)` instead of `client.rpc(...)`

## Problem
RPC calls without schema qualification can fail or expose security issues.

## Solution
```typescript
// ✅ Correct
await client.schema('public').rpc('my_function', {...})

// ❌ Wrong
await client.rpc('my_function', {...})
```
EOF
```

**You're now ABDS-compliant! ⭐**

---

## The Four Documentation Layers

ABDS organizes documentation into 4 layers, each serving a different time scale:

| Layer | File | Purpose | Update Frequency | Audience |
|-------|------|---------|------------------|----------|
| **1** | `PROJECT-STATE.md` | Project overview | Daily/weekly | New team members |
| **2** | `{feature}/STATE.md` | Current feature state | When feature changes | Developers |
| **3** | `{feature}/CLAUDE.md` | Architecture & "why" | When architecture changes | Architects |
| **4** | `{feature}/sessions/` | Work history | Never (immutable) | Historical research |

**Why layers?**
- Different update frequencies
- Different volatility (mutable vs immutable)
- Different audiences (overview vs deep-dive)

---

## Compliance Levels

### ⭐ Level 1: Minimal
- Global: `~/.abds/learnings/` exists
- Local: `PROJECT-STATE.md` + at least one feature `STATE.md`

### ⭐⭐ Level 2: Standard
- Level 1 + `CLAUDE.md` for major features
- Session folders for significant work
- Standard naming conventions

### ⭐⭐⭐ Level 3: Full
- Level 2 + learnings system with `CATALOG.md`
- `docs/IMPORTANT/` for critical patterns
- Plans directory
- All templates used consistently

---

## Full Specification

See **[ABDS-1.0.md](ABDS-1.0.md)** for complete specification including:

- Directory structure requirements
- File naming conventions
- Template formats
- Learnings system with YAML frontmatter
- Compliance requirements
- Migration guide from existing setups

---

## Examples

### Minimal Project (Level 1 ⭐)

```
~/.abds/learnings/CATALOG.md

my-project/.abds/
└── docs/
    ├── PROJECT-STATE.md
    └── api/
        └── STATE.md
```

### Standard Project (Level 2 ⭐⭐)

```
~/.abds/
├── learnings/{category}/
└── plans/

my-project/.abds/
└── docs/
    ├── PROJECT-STATE.md
    ├── auth/
    │   ├── STATE.md
    │   ├── CLAUDE.md
    │   └── sessions/oauth-impl_16_01_2026/
    └── database/
        ├── STATE.md
        └── CLAUDE.md
```

### Full Project (Level 3 ⭐⭐⭐)

```
~/.abds/
├── learnings/
│   ├── CATALOG.md
│   ├── database/
│   ├── ui/
│   └── sessions/
├── plans/
└── config/abds.conf

my-project/.abds/
├── docs/
│   ├── PROJECT-STATE.md
│   ├── IMPORTANT/
│   │   ├── GUIDES/
│   │   ├── MISTAKES/
│   │   └── LEARNINGS/
│   ├── auth/
│   │   ├── STATE.md
│   │   ├── CLAUDE.md
│   │   └── sessions/
│   └── database/
│       ├── STATE.md
│       ├── CLAUDE.md
│       └── sessions/
└── plans/
```

---

## Why `.abds/`?

Following industry standards (Git, npm, Docker):

| Tool | Global | Local |
|------|--------|-------|
| **Git** | `~/.gitconfig` | `project/.git/` |
| **npm** | `~/.npm/` | `project/node_modules/` |
| **Docker** | `~/.docker/` | - |
| **ABDS** | `~/.abds/` | `project/.abds/` |

**Clean separation**:
- `~/.{tool}/` - Tool-specific internal data
- `~/.abds/` - ABDS standard (your docs & knowledge)

---

## Migration from Legacy Structure

If you already use tool-specific directories (`.claude/`, `.cursor/`, etc.) for documentation:

```bash
# 1. Create ABDS structure
mkdir -p ~/.abds/learnings

# 2. Copy existing documentation/learnings
cp -r ~/.{tool}/learnings/* ~/.abds/learnings/ 2>/dev/null || true
cp -r ~/.{tool}/plans/* ~/.abds/plans/ 2>/dev/null || true

# 3. In each project
cd my-project
mkdir -p .abds/docs
# Manually migrate documentation from old location
```

**Note**: Keep tool-specific internal files (debug logs, caches, history) in their original locations!

---

## Tools & Helpers

ABDS is a **specification**, not a toolkit.

However, reference implementations may provide optional helpers:

- `validate-abds` - Check project compliance
- `update-catalog` - Generate `CATALOG.md` from frontmatter
- `init-abds` - Initialize ABDS structure
- `migrate-abds` - Migrate from legacy `.claude/` structure

**Philosophy**: Specification is primary. Tools are secondary.

You can follow ABDS **manually** - no tools required.

---

## Who Should Use ABDS?

### ✅ Perfect For:
- Developers working with AI coding assistants
- Teams sharing knowledge across projects
- Long-running projects needing organized docs
- Anyone solving the same problems repeatedly
- Projects with architectural decisions to document

### ⚠️ Maybe Not For:
- Throwaway prototypes (< 1 week lifespan)
- Projects with zero documentation needs
- Solo scripts with no complexity

---

## Contributing

ABDS is an **open specification**. Contributions welcome:

- 🐛 **Issues**: Suggest improvements, report ambiguities
- 📝 **Pull Requests**: Clarifications, examples, templates
- 🎯 **Implementations**: Share ABDS-compliant projects
- 💬 **Discussions**: Propose extensions, share use cases

**Repository**: https://github.com/abds-spec/abds

---

## Comparison with Related Projects

| Project | Approach | Storage | Scope |
|---------|----------|---------|-------|
| **ABDS** | Specification (like XDG, FHS) | Markdown files | System-level standard |
| **Agent OS** | Project templates + conventions | Markdown files | Project-level templates |
| **GBrain** | Full system | PostgreSQL + pgvector | Heavy infrastructure |
| **autonomousthinkingsystems** | Orchestration system | PostgreSQL + embeddings | Complete agent platform |

**ABDS complements these** - you can use ABDS structure with any backend (markdown files, databases, etc.)

---

## Inspiration

ABDS is inspired by proven standards:

- **[XDG Base Directory Specification](https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html)** - Config/cache/data separation
- **[Filesystem Hierarchy Standard (FHS)](https://refspecs.linuxfoundation.org/FHS_3.0/fhs-3.0.html)** - Unix directory layout
- **[POSIX](https://pubs.opengroup.org/onlinepubs/9699919799/)** - Portable interface standards

**Like these standards**, ABDS:
- Defines structure, not implementation
- Enables interoperability
- Grows through open collaboration
- Prioritizes simplicity and clarity

---

## License

**CC0 1.0 Universal (Public Domain)**

To the extent possible under law, the authors have waived all copyright and related rights to this specification.

You can copy, modify, distribute and use the specification, even for commercial purposes, all without asking permission.

---

## FAQ

**Q: Is this tool-specific?**
A: No. ABDS works with any AI coding assistant (Cursor, Aider, Windsurf, Gemini, custom tools).

**Q: Do I need special tools?**
A: No. ABDS is just a directory structure. Follow it manually or use optional helpers.

**Q: Can I use it with my database-backed knowledge system?**
A: Yes! ABDS defines structure, not storage. Use markdown files, PostgreSQL, or anything else.

**Q: What if my project doesn't have "features"?**
A: Use modules, domains, or areas (e.g., `frontend/`, `backend/`, `api/`). Same concept.

**Q: Can I extend ABDS?**
A: Yes. ABDS defines minimum requirements. Add custom directories as needed.

---

## Status

**Version**: 1.0 (Draft)
**Date**: 2026-05-05
**Status**: Open for community feedback

**Next**:
- Community review
- Reference implementation
- Real-world testing
- Template library

---

## Get Started

1. Read **[ABDS-1.0.md](ABDS-1.0.md)** (full specification)
2. Create `~/.abds/learnings/` (global)
3. Create `my-project/.abds/docs/` (local)
4. Add `PROJECT-STATE.md`
5. Start documenting!

**Questions? Issues? Feedback?**
→ https://github.com/abds-spec/abds/issues

---

**ABDS** - Because documentation shouldn't be chaos.
