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
# Clone and install (Cargo-like pattern)
git clone https://github.com/nayol/abds.git
cd abds
./install.sh

# That's it! Now use `abds` globally
```

**What it does:**
- Creates `~/.abds/` directory structure
- Installs CLI wrapper to `~/.local/bin/abds`
- Sets up learnings, plans, templates

**Advanced:** See `./bin/setup-global-abds.sh` for manual installation

### Initialize New Project

```bash
cd my-project
abds init

# Creates:
# .abds/docs/PROJECT-STATE.md
# .abds/docs/feature/STATE.md (with feature name prompt)
# README.md with quick links
```

---

## Usage

### CLI Commands

The `abds` command provides a unified interface to all ABDS tools:

```bash
# Initialize project
abds init              # Initialize ABDS in current project
abds i                 # Short alias

# Search & Discovery
abds search <keywords> # Search learnings across all categories
abds s <keywords>      # Short alias

# Maintenance
abds catalog           # Update learnings catalog (CATALOG.md)
abds validate          # Check ABDS compliance level (⭐/⭐⭐/⭐⭐⭐)
abds v                 # Short alias

# Project Management
abds session <name>    # Create new session folder with timestamp
abds find-files        # Find documentation files needing better names
abds generate-index    # Generate ABDS-INDEX.md for navigation

# Help
abds --help            # Show all commands
abds --version         # Show ABDS version
```

### Examples

```bash
# Search for RLS patterns
abds search "database RLS"

# Quick search with alias
abds s "oauth pkce"

# Initialize in new project
cd my-new-project
abds init

# Check what compliance level you've achieved
abds validate

# Create a work session
abds session "implement-auth-feature"

# Update catalog after adding learnings
abds catalog
```

### Using with AI Agents

ABDS works with **any agent** via filesystem + CLI:

```bash
# In Claude Code skill
abds search "keywords"

# In Cursor extension
abds catalog

# In custom script
results=$(abds search "pattern")
```

**See**: [Agent Integration Guide](docs/integrations/AGENT-INTEGRATION.md)

**Works with**: Claude Code, Cursor, Aider, Windsurf, custom scripts, any bash-capable tool.

**Why it works**: Filesystem + CLI are universal interfaces. No agent-specific code needed.

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

### CLI Wrapper (Recommended)

The `abds` command provides a unified interface:

```bash
abds init         # Instead of: ~/.abds/bin/init-abds
abds search       # Instead of: ~/.abds/bin/search-learnings
abds catalog      # Instead of: ~/.abds/bin/update-catalog
abds validate     # Instead of: ~/.abds/bin/validate-abds
# ... and more
```

**Automatically installed** by `setup-global-abds.sh` to `~/.local/bin/abds`

### Individual Tools

All tools also available directly in `~/.abds/bin/`:

| Tool | Purpose | CLI Alias |
|------|---------|-----------|
| `init-abds` | Initialize ABDS in project | `abds init` |
| `validate-abds` | Check project compliance | `abds validate` |
| `update-catalog` | Generate CATALOG.md from frontmatter | `abds catalog` |
| `search-learnings` | Search across all learnings | `abds search` |
| `create-session` | Create timestamped session folder | `abds session` |
| `find-files-to-rename` | Find unorganized files | `abds find-files` |
| `generate-index` | Auto-generate INDEX.md files | `abds generate-index` |

**Setup script** (in `bin/` of this repo):
- `setup-global-abds.sh` - Install ~/.abds/ structure with CLI wrapper
- Migration scripts for existing projects

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
