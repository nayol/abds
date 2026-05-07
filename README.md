# ABDS - Agent Base Directory Specification

**Version**: 1.0
**Status**: Complete and Tested
**Date**: 2026-05-06

A filesystem standard for organizing documentation and knowledge in AI agent-assisted software development.

---

## What is ABDS?

ABDS is to AI agent development what **FHS** is to `/usr/bin` and **XDG** is to `~/.config/`.

**Think of it like**:
- `/usr/bin` - Universal location for executables
- `~/.config/` - Universal location for app configs
- `~/.abds/` - Universal location for agent knowledge

**Purpose**: Consistent, predictable documentation structure across all projects.

---

## Quick Start

### Install Global ABDS

```bash
# Run setup script
cd abds-spec
./bin/setup-global-abds.sh

# Or manually
mkdir -p ~/.abds/{learnings,plans,bin,templates}
cp bin/* ~/.abds/bin/
chmod +x ~/.abds/bin/*
```

### Initialize New Project

```bash
cd my-project
~/.abds/bin/init-abds

# Creates:
# .abds/docs/PROJECT-STATE.md
# .abds/learnings/ (with 5 special categories)
# .abds/plans/
```

---

## Structure

### Minimum Required (Level 1 ⭐)

```
.abds/
└── docs/
    ├── PROJECT-STATE.md     # Current state
    └── feature/
        └── STATE.md         # Feature state
```

### Full Structure (Level 3 ⭐⭐⭐)

```
.abds/
├── docs/                    # Current state + history
│   ├── PROJECT-STATE.md
│   └── feature/
│       ├── STATE.md
│       ├── CLAUDE.md
│       └── sessions/
├── learnings/               # Accumulated knowledge
│   ├── CATALOG.md
│   ├── mistakes/           ← Special (5 categories)
│   ├── anti-patterns/
│   ├── guides/
│   ├── workflows/
│   ├── troubleshooting/
│   └── {domain}/           ← Domain (as needed)
└── plans/                   # Implementation plans
```

---

## Learnings Organization (Hybrid)

### Special Categories (Cross-Domain)

Always visible, high-priority knowledge:

- **mistakes/** - Costly errors (2+ hours debugging)
- **anti-patterns/** - Known bad practices to avoid
- **guides/** - How-to documentation and tutorials
- **workflows/** - Repeatable processes and checklists
- **troubleshooting/** - Debugging and problem-solving

### Domain Categories (Technology-Specific)

Organized by technical domain:

- **database/** - PostgreSQL, RLS, migrations
- **ui/** - React, animations, scroll patterns
- **security/** - Auth, vulnerabilities
- **{custom}/** - Project-specific domains

---

## Examples

### Medical Software (tomedo)

```
tomedo/.abds/learnings/
├── troubleshooting/     ← Special
├── workflows/           ← Special
├── database/            ← Domain (Tomedo schema)
├── integration/         ← Domain (LDT, HL7, Mirth)
└── infrastructure/      ← Domain (server management)
```

### Desktop App (aqua-voice)

```
aqua-voice/.abds/learnings/
├── mistakes/           ← Special (build cache mistake)
├── guides/             ← Special (FFI debugging)
├── tauri-swift-ffi/   ← Domain (Tauri + Swift)
└── coreml/            ← Domain (CoreML patterns)
```

---

## Tools

All tools available in `~/.abds/bin/`:

| Tool | Purpose |
|------|---------|
| `init-abds` | Initialize ABDS in project |
| `validate-abds` | Check project compliance |
| `update-catalog` | Generate CATALOG.md from frontmatter |
| `search-learnings` | Search across all learnings |
| `generate-index` | Auto-generate INDEX.md files |
| `create-session` | Create timestamped session folder |
| `find-files-to-rename` | Find unorganized files |

**Setup script** (in `bin/` of this repo):
- `setup-global-abds.sh` - Install ~/.abds/ structure with recommended categories
- Migration scripts for existing projects

### Add to PATH (Optional)

```bash
echo 'export PATH="$HOME/.abds/bin:$PATH"' >> ~/.zshrc
source ~/.zshrc
```

---

## File Specifications

### PROJECT-STATE.md

**Location**: `.abds/docs/PROJECT-STATE.md`
**Purpose**: 2-minute project overview
**Update**: After significant changes

### STATE.md

**Location**: `.abds/docs/{feature}/STATE.md`
**Purpose**: Current feature state
**Update**: When feature changes

### CLAUDE.md

**Location**: `.abds/docs/{feature}/CLAUDE.md`
**Purpose**: Architecture and "why" decisions
**Update**: Rarely (when architecture changes)

### Learning Files

**Location**: `.abds/learnings/{category}/file.md`
**Format**: Markdown with YAML frontmatter

```markdown
---
keywords: [keyword1, keyword2, keyword3]
category: mistakes
confidence: verified
tldr: "One-line solution"
description: "One-line problem description"
projects_applied:
  - name: project-name
    date: 2026-05-06
    notes: "Brief context"
---

# Learning Title

## TL;DR
[Quick solution]

## Problem
[What went wrong]

## Solution
[How to fix/avoid]
```

---

## Compliance Levels

### Level 1 ⭐ (Minimal)

- ✅ `.abds/docs/PROJECT-STATE.md`
- ✅ At least one `.abds/docs/{feature}/STATE.md`

### Level 2 ⭐⭐ (Standard)

- ✅ All Level 1 requirements
- ✅ CLAUDE.md for major features
- ✅ Session folders for work history
- ✅ Consistent naming conventions

### Level 3 ⭐⭐⭐ (Full)

- ✅ All Level 2 requirements
- ✅ Learnings system with CATALOG.md
- ✅ Plans directory
- ✅ ABDS tools installed

---

## Benefits

### For You
- ✅ Find knowledge instantly (search across all projects)
- ✅ Never solve the same problem twice
- ✅ Clear project state at a glance

### For AI Agents
- ✅ Predictable file locations
- ✅ Structured context
- ✅ Historical knowledge accessible

### For Teams
- ✅ Consistent structure across projects
- ✅ Onboarding simplified
- ✅ Knowledge sharing standardized

---

## Documentation

- **[ABDS-1.0.md](ABDS-1.0.md)** - Complete specification
- **[ABDS-SIMPLIFIED.md](ABDS-SIMPLIFIED.md)** - Quick reference
- **[ABDS-HYBRID-ORGANIZATION.md](ABDS-HYBRID-ORGANIZATION.md)** - Learnings organization
- **[FINAL-ABDS-STRUCTURE.md](FINAL-ABDS-STRUCTURE.md)** - Detailed structure guide
- **[FRONTMATTER-SCHEMA.md](FRONTMATTER-SCHEMA.md)** - Learning file format
- **[DOCUMENTATION-SYSTEM.md](DOCUMENTATION-SYSTEM.md)** - 4-layer doc workflow

---

## Projects Using ABDS

- ✅ **tomedo** - Medical software (20+ learnings, Level 3)
- ✅ **aqua-voice** - Tauri desktop app (5 learnings, Level 2)
- ✅ **abds-spec** - This project (dogfooding)

---

## Migration from Existing Structure

### From IMPORTANT/ Folder

```bash
# Use migration script
./bin/migrate-important-to-learnings.sh

# Or manually
mv .abds/docs/IMPORTANT/GUIDES/* .abds/learnings/guides/
mv .abds/docs/IMPORTANT/MISTAKES/* .abds/learnings/mistakes/
~/.abds/bin/update-catalog
rm -rf .abds/docs/IMPORTANT
```

### From ~/.claude/learnings/

```bash
# Copy project-specific learnings to local
cp -r ~/.claude/learnings/project-specific \
      my-project/.abds/learnings/

# Copy general learnings to global
cp -r ~/.claude/learnings/database ~/.abds/learnings/
cp -r ~/.claude/learnings/ui ~/.abds/learnings/

# Update catalogs
~/.abds/bin/update-catalog
```

---

## Testing

We've tested ABDS on:
- ✅ Medical software (domain-heavy, 20+ learnings)
- ✅ Desktop app (medium complexity, 5 learnings)
- ✅ Migration from IMPORTANT/ structure
- ✅ Migration from ~/.claude/ structure
- ✅ Parallel installation (doesn't affect existing systems)

---

## Design Principles

1. **Universal** - Works for any project type
2. **Simple** - Minimum 2 files for compliance
3. **Scalable** - Grows with project needs
4. **Predictable** - Agents know where to look
5. **Proven** - Based on real-world usage

---

## Relation to Other Standards

| Standard | Scope | ABDS Equivalent |
|----------|-------|-----------------|
| FHS | Filesystem layout | `.abds/` location |
| XDG-BDS | User directories | `~/.abds/` for user data |
| POSIX | OS interface | N/A (documentation only) |

---

## Contributing

This is a living specification. Feedback welcome!

**Areas for future development**:
- Auto-detection of learnings candidates
- IDE integrations
- Catalog search improvements
- Templates for more document types

---

## License

MIT License - See LICENSE file

---

## Contact

Created based on real-world needs across multiple production projects.

**Version**: 1.0
**Status**: Production-ready
**Last Updated**: 2026-05-06
