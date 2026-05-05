# ABDS - Agent Base Directory Specification

**Version**: 1.0
**Status**: Draft
**Date**: 2026-05-05
**Authors**: Kaloyan Tanev, Claude (Anthropic)

---

## Abstract

The Agent Base Directory Specification (ABDS) is a **system-level standard** (comparable to FHS, XDG-BDS, POSIX) that defines a consistent directory layout and documentation system for AI agent development environments.

**What "system-level" means**:
- Universal across all projects (like `/usr/bin` works for all programs)
- Infrastructure layer (like XDG defines `~/.config` for all apps)
- Not project-specific (like `package.json` or `requirements.txt`)
- Operating system for knowledge (like Linux is OS for programs)

ABDS solves the problem of unstructured documentation and scattered knowledge in agent-assisted development by providing:

1. **Standard directory layout** - Where documentation and knowledge live
2. **Documentation hierarchy** - Four layers from high-level state to detailed sessions
3. **Learnings system** - Structured knowledge capture from experience
4. **Standard templates** - Consistent formats for different document types
5. **Reference implementation scripts** - Optional helper tools in `~/.abds/bin/`
6. **Compliance requirements** - What makes a project ABDS-compliant

This specification is inspired by the XDG Base Directory Specification and Filesystem Hierarchy Standard (FHS), applying proven Unix/Linux patterns to knowledge organization.

---

## 1. Motivation

### The Problem

Developers working with AI agents face:

- **Scattered documentation**: README, CLAUDE.md, random docs/ files with no structure
- **Lost context**: "What did we do last week? Why did we make that decision?"
- **No learnings capture**: Solving the same problems repeatedly
- **Inconsistent formats**: Every project documents differently
- **Poor navigation**: LLMs and humans struggle to find relevant information

### The Solution

ABDS provides a **standard structure** that:

- Makes documentation **predictable** (always know where to look)
- Separates **current state** from **historical record** (mutable vs immutable)
- Captures **learnings** systematically (cross-project knowledge)
- Uses **layers** for different time scales (overview → deep detail)
- Enables **LLM navigation** (structured markdown in standard locations)

### Design Principles

1. **Separation of concerns**: Current state ≠ architecture ≠ history ≠ learnings
2. **Hierarchical with recurring patterns**: Same structure at different scales
3. **Human-readable first**: Markdown, YAML, standard formats
4. **Git-friendly**: Plain text, immutable history, clear diffs
5. **LLM-optimized**: Structured for agent parsing and generation

---

## 2. Directory Structure

### 2.1 Base Directories (Global + Local)

Following industry standards (Git, npm, Docker), ABDS defines TWO directory levels:

#### Global (User-level)

**Location**: `$HOME/.abds/`

**Purpose**: Cross-project knowledge, user-wide configuration

**Contents**:
```
~/.abds/
├── learnings/              # Cross-project learnings
│   ├── CATALOG.md          # Auto-generated index
│   ├── database/           # Category-based organization
│   ├── ui/
│   └── ...
├── plans/                  # User-level implementation plans
├── config/                 # Global configuration
│   └── abds.conf           # User preferences
├── templates/              # User-defined templates (optional)
└── bin/                    # Reference implementation scripts (optional)
    ├── update-catalog      # Generate CATALOG.md from frontmatter
    ├── validate-abds       # Check project compliance
    ├── init-abds           # Initialize ABDS structure
    ├── migrate-abds        # Migrate from legacy structure
    ├── search-learnings    # Search across all learnings
    ├── create-session      # Create new session folder
    └── find-files-to-rename # Find files needing better names
```

#### Local (Project-level)

**Location**: `$PROJECT_ROOT/.abds/`

**Purpose**: This project's documentation and state

**Contents**:
```
my-project/.abds/
└── docs/
    ├── PROJECT-STATE.md    # Required: Project overview
    ├── {feature}/          # Feature documentation
    │   ├── STATE.md        # Required: Current state
    │   ├── CLAUDE.md       # Recommended: Architecture
    │   └── sessions/       # Recommended: History
    └── IMPORTANT/          # Optional: Critical patterns
```

**Compliance**:
- Global directory MUST be `~/.abds/`
- Local directory MUST be `$PROJECT_ROOT/.abds/`
- Legacy names (`.claude/`, `.cursor/`, `.agent/`) are NOT compliant with ABDS 1.0

### 2.2 Documentation Structure (REQUIRED)

The base directory MUST contain a `docs/` subdirectory with this structure:

```
.agent/
└── docs/
    ├── PROJECT-STATE.md              # Layer 1: Project overview (REQUIRED)
    ├── {feature}/                    # Layer 2-4: Feature documentation
    │   ├── STATE.md                  # Layer 2: Current state (REQUIRED)
    │   ├── CLAUDE.md                 # Layer 3: Architecture (RECOMMENDED)
    │   └── sessions/                 # Layer 4: History (RECOMMENDED)
    │       └── {description}_{DATE}/ # Session folders
    │           ├── {description}.md  # Session summary
    │           └── {description}-raw.md  # Optional transcript
    └── IMPORTANT/                    # Critical patterns (OPTIONAL)
        ├── CLAUDE.md                 # Index of critical content
        ├── GUIDES/                   # How-to guides
        ├── MISTAKES/                 # Documented errors
        └── LEARNINGS/                # Project-specific learnings
```

### 2.3 Global Learnings Structure (REQUIRED for cross-project knowledge)

**Location**: `$HOME/.abds/learnings/`

**Structure**:
```
~/.abds/learnings/
├── CATALOG.md                        # Searchable index (GENERATED)
├── {category}/                       # Category-based organization
│   ├── debugging/
│   ├── database/
│   ├── ui/
│   ├── testing/
│   └── ...
└── sessions/                         # Session-based learnings
    └── {description}_{DATE}/
        ├── {description}.md
        └── {description}-raw.md
```

**Purpose**: Knowledge that applies across multiple projects (debugging patterns, database techniques, UI patterns)

### 2.4 Plans Structure (OPTIONAL)

For implementation plans:

```
.agent/plans/                         # Project-level plans
└── {description}_{DATE}.md
```

Or user-level:

```
$HOME/.agent/plans/                   # Cross-project plans
└── {description}_{DATE}_{TIME}.md
```

---

## 3. The Four Documentation Layers

ABDS defines four layers of documentation, each serving a different time scale and audience:

### Layer 1: PROJECT-STATE.md (REQUIRED)

**Purpose**: 2-minute overview of entire project
**Location**: `.agent/docs/PROJECT-STATE.md`
**Updated**: Daily or weekly
**Audience**: Anyone starting work on the project

**Contents**:
- Current sprint focus
- What's working / broken / in-progress
- Active problems
- Recent changes (last 7 days)
- Quick links to features

**Template**: See `TEMPLATES/PROJECT-STATE.md`

### Layer 2: Feature STATE.md (REQUIRED)

**Purpose**: Current state of specific feature
**Location**: `.agent/docs/{feature}/STATE.md`
**Updated**: When feature changes
**Audience**: Anyone working on this feature

**Contents**:
- What's deployed and working
- Known issues and bugs
- Key files and modules
- Configuration
- Dependencies

**Template**: See `TEMPLATES/STATE.md`

### Layer 3: Feature CLAUDE.md (RECOMMENDED)

**Purpose**: Architecture and "why" decisions
**Location**: `.agent/docs/{feature}/CLAUDE.md`
**Updated**: Rarely (when architecture changes)
**Audience**: Understanding design decisions

**Contents**:
- Architecture overview
- Design decisions and trade-offs
- Implementation patterns
- Historical context
- Future considerations

**Template**: See `TEMPLATES/CLAUDE.md`

### Layer 4: Session Folders (RECOMMENDED)

**Purpose**: Chronological work history
**Location**: `.agent/docs/{feature}/sessions/{description}_{DATE}/`
**Updated**: Never (frozen in time)
**Audience**: "What happened on April 19?"

**Contents**:
- What was done
- How we thought
- What was tried (including failures)
- Debugging journeys
- Raw transcripts (optional)

**Template**: See `TEMPLATES/session-summary.md`

### Why Layers?

**Different update frequencies**:
- PROJECT-STATE.md changes daily
- Feature STATE.md changes when feature changes
- CLAUDE.md changes when architecture changes
- Sessions never change (immutable history)

**Different audiences**:
- Layer 1: New team members, weekly status
- Layer 2: Developers working on feature
- Layer 3: Architects, design reviews
- Layer 4: Historical research, debugging

**Different volatility**:
- Layers 1-2: Mutable (current state)
- Layer 3: Semi-stable (architecture)
- Layer 4: Immutable (history)

---

## 4. Learnings System

### 4.1 Learning Structure

**File format**:

```markdown
---
keywords: [keyword1, keyword2, keyword3]
category: {category}
confidence: verified | tested | theoretical
tldr: "One-line solution summary"
description: "Problem description"
projects_applied:
  - name: {project}
    date: {YYYY-MM-DD}
    notes: "{Brief context}"
---

# {Title}

## TL;DR
{1-2 sentence solution}

## Applies When
- {Condition 1}
- {Condition 2}

## Symptom
{What developer observes}

## Root Cause
{Why it happens}

## Solution
{Code/approach that fixes it}

## Projects Applied
- {project-name} ({date}) - {outcome}
```

### 4.2 CATALOG.md (Generated File)

The learnings catalog MUST be auto-generated from YAML frontmatter:

```markdown
<!-- GENERATED FILE - DO NOT EDIT MANUALLY -->
<!-- Run: update-catalog.sh to regenerate -->

# Learnings Catalog

## Quick Search

| Category | Keywords | TL;DR | File |
|----------|----------|-------|------|
| Database | rls, security, postgres | Always qualify RPC calls with schema | database/rls-schema-qualification.md |
| ... | ... | ... | ... |

## By Category

### Database (12 learnings)
...

### UI (8 learnings)
...
```

**Compliance**: If learnings exist, CATALOG.md MUST be generated, never manually edited.

### 4.3 Categories

Standard categories (RECOMMENDED):

- `auth/` - Authentication, OAuth, sessions
- `database/` - SQL, RLS, migrations
- `ui/` - Frontend, rendering, animations
- `debugging/` - Problem-solving patterns
- `testing/` - Test patterns, TDD
- `deployment/` - CI/CD, releases
- `security/` - Security patterns

Projects MAY define additional categories.

---

## 5. File Naming Conventions

### 5.1 Session Folders

**Format**: `{description}_{DD_MM_YYYY}/`

**Examples**:
- `privacy-fix_20_04_2026/`
- `oauth-implementation_16_01_2026/`
- `schema-migration-planning_17_01_2026/`

**Rules**:
- Use descriptive names (not `session-1`, `work-today`)
- Date only in folder name (not time)
- Underscore separates description from date
- No spaces (use hyphens in description)

### 5.2 Session Files

**Inside session folder**:
- `{description}.md` - Main summary (MUST match folder name)
- `{description}-raw.md` - Optional raw transcript
- `screenshots/` - Optional visual artifacts
- `artifacts/` - Optional code snippets, logs

**Naming**: Main file MUST use same description as folder (without date).

### 5.3 Learning Files

**Format**: `{descriptive-name}.md`

**Examples**:
- `rls-schema-qualification.md`
- `scroll-preservation-pattern.md`
- `bearer-token-auth-context.md`

**Rules**:
- Descriptive, not generic
- Kebab-case (hyphens, not underscores)
- No dates (use frontmatter `date` field)

### 5.4 Plan Files

**Format**: `{description}_{YYYY-MM-DD}.md` (project-level)
**Format**: `{description}_{YYYY-MM-DD}_{HH-MM}.md` (user-level)

---

## 6. Standard Templates

ABDS-compliant projects SHOULD use standard templates for consistency.

### 6.1 Required Templates

- `PROJECT-STATE.md` - Layer 1 template
- `STATE.md` - Layer 2 template
- `CLAUDE.md` - Layer 3 template
- `session-summary.md` - Layer 4 template

### 6.2 Optional Templates

- `learning.md` - Learning documentation template
- `decision.md` - Architecture decision record
- `plan.md` - Implementation plan template

**Templates location**: See `TEMPLATES/` directory in this repository.

---

## 7. Compliance Levels

### Level 1: Minimal Compliance ⭐

REQUIRED for ABDS-1.0 compliance:

- [ ] Base directory exists (`.agent/`, `.claude/`, `.cursor/`, or `.ai/`)
- [ ] `docs/PROJECT-STATE.md` exists
- [ ] At least one feature with `docs/{feature}/STATE.md`

**Use case**: Small projects, getting started

### Level 2: Standard Compliance ⭐⭐

REQUIRED + RECOMMENDED:

- [ ] All Level 1 requirements
- [ ] Features have `docs/{feature}/CLAUDE.md` (architecture)
- [ ] Session folders for major work `docs/{feature}/sessions/`
- [ ] Standard file naming conventions followed

**Use case**: Professional projects, team collaboration

### Level 3: Full Compliance ⭐⭐⭐

ALL features:

- [ ] All Level 2 requirements
- [ ] Learnings system with CATALOG.md (if applicable)
- [ ] `docs/IMPORTANT/` for critical patterns
- [ ] Plans directory for implementation plans
- [ ] All templates used consistently
- [ ] Reference implementation scripts in `~/.abds/bin/` (optional but recommended)

**Use case**: Large projects, long-term maintenance, cross-project knowledge

**Note**: The `bin/` directory with helper scripts is optional but recommended for automation and workflow efficiency.

---

## 8. Generated Files

### 8.1 Marking Generated Files

Files that are auto-generated MUST be marked:

```markdown
<!-- GENERATED FILE - DO NOT EDIT MANUALLY -->
<!-- Source: {source files or script} -->
<!-- Generated: {date} -->
```

### 8.2 Standard Generated Files

- `CATALOG.md` - Generated from learning frontmatter
- `PROJECT-STATE.md` - MAY be generated from feature STATE.md files (future)
- Any aggregated documentation

### 8.3 Regeneration

Generated files MUST be reproducible (idempotent):

```bash
# Running twice produces same result
./update-catalog.sh
./update-catalog.sh
# → No changes
```

---

## 9. Migration Guide

### 9.1 From Unstructured Documentation

**Step 1**: Create global directory
```bash
mkdir -p ~/.abds/learnings
mkdir -p ~/.abds/plans
mkdir -p ~/.abds/templates
```

**Step 2**: Create project directory
```bash
cd my-project
mkdir -p .abds/docs
```

**Step 3**: Create PROJECT-STATE.md
```bash
# Use template from TEMPLATES/PROJECT-STATE.md
cp ~/.abds/templates/PROJECT-STATE.md .abds/docs/PROJECT-STATE.md
# Fill in current project state
```

**Step 4**: Identify features
```bash
# For each major feature/domain:
mkdir -p .abds/docs/{feature}
cp ~/.abds/templates/STATE.md .abds/docs/{feature}/STATE.md
```

**Step 5**: Migrate existing docs
```bash
# Move feature-specific docs to feature folders
# Move general docs to PROJECT-STATE.md or feature CLAUDE.md
```

### 9.2 From Existing `~/.claude/` Setup

If you already have `~/.claude/`:

**Step 1**: Create new ABDS structure
```bash
mkdir -p ~/.abds/learnings
```

**Step 2**: Migrate learnings
```bash
# Copy learnings from ~/.claude/learnings/ to ~/.abds/learnings/
cp -r ~/.claude/learnings/* ~/.abds/learnings/

# Copy plans
cp -r ~/.claude/plans/* ~/.abds/plans/ 2>/dev/null || true
```

**Step 3**: Migrate project directories
```bash
# In each project
cd my-project
mv .claude .abds  # Rename directory

# OR create new structure
mkdir -p .abds/docs
# Manually migrate documentation
```

**Step 4**: Update references
```bash
# Update any scripts or tools that reference .claude/
# Change to .abds/
```

**Note**: Tool-specific internal files (debug logs, file history, project caches) should remain in their original locations.

---

## 10. Reference Implementation and Tools

ABDS is a **specification**, not a toolkit. The specification defines structure and conventions that can be followed manually.

However, ABDS includes **optional reference implementation scripts** in `~/.abds/bin/` that automate common workflows following Unix/Linux conventions.

### 10.1 Reference Implementation Scripts

**Location**: `~/.abds/bin/`

**Status**: Optional (not required for ABDS compliance)

**Philosophy**: Following Unix precedent (`/usr/bin`, `~/.local/bin`), ABDS provides a standard location for helper scripts that automate documentation workflows.

#### Core Tools

**update-catalog** - Generate CATALOG.md from learnings frontmatter
```bash
~/.abds/bin/update-catalog
```
- Scans all learnings for YAML frontmatter
- Generates searchable `CATALOG.md` with keywords, TL;DR, categories
- Idempotent (safe to run multiple times)
- **Requirement**: bash, sed, grep

**validate-abds** - Check ABDS compliance level
```bash
~/.abds/bin/validate-abds [project-path]
```
- Checks for required files and structure
- Reports compliance level (⭐/⭐⭐/⭐⭐⭐)
- Suggests missing components
- **Requirement**: bash

**init-abds** - Initialize ABDS structure in project
```bash
cd my-project
~/.abds/bin/init-abds
```
- Creates `.abds/docs/` directory structure
- Copies templates (PROJECT-STATE.md, STATE.md, etc.)
- Sets up first feature folder
- **Requirement**: bash, access to templates

**migrate-abds** - Migrate from legacy structure
```bash
~/.abds/bin/migrate-abds --from ~/.claude --to ~/.abds
```
- Migrates learnings and plans from tool-specific directories
- Creates backups before migration
- Updates file references
- **Requirement**: bash, tar

#### Documentation Helpers

**search-learnings** - Full-text search across learnings
```bash
~/.abds/bin/search-learnings "database RLS"
~/.abds/bin/search-learnings --category database "postgres"
```
- Searches all learnings files
- Returns matching learnings with context
- Highlights keywords in output
- **Requirement**: bash, grep or ripgrep

**create-session** - Create new session folder
```bash
~/.abds/bin/create-session
```
- Interactive: prompts for feature and description
- Creates properly named session folder: `{description}_{DD_MM_YYYY}/`
- Copies session-summary.md template
- **Requirement**: bash

**find-files-to-rename** - Find generic filenames
```bash
~/.abds/bin/find-files-to-rename
```
- Scans for files with non-descriptive names
- Suggests better naming based on content
- Used in documentation cleanup workflow
- **Requirement**: bash, grep

### 10.2 Script Design Principles

Following Unix/Linux conventions:

**Naming**: Lowercase with hyphens (verb-noun format)
- `update-catalog` (not `updateCatalog`, `update-catalog.sh`)
- Following precedent: `apt-get`, `update-alternatives`

**Portability**: POSIX-compliant bash where possible
- Work on Linux, macOS, BSD
- Minimal dependencies (standard Unix tools)

**Safety**: Idempotent and non-destructive
- Safe to run multiple times
- Create backups before modifications
- Clear error messages with suggestions

**Composability**: Pipe-friendly
- Standard input/output
- Exit codes: 0 = success, 1 = error, 2 = warning
- Can be combined with other Unix tools

**Permissions**: Executable scripts without extensions
- `chmod +x ~/.abds/bin/*`
- Shebang line: `#!/bin/bash` or `#!/usr/bin/env bash`

### 10.3 Installation

Reference implementation scripts are included in the ABDS repository.

**Option 1: Clone ABDS repository**
```bash
git clone https://github.com/abds-spec/abds.git
cp -r abds/bin/ ~/.abds/bin/
chmod +x ~/.abds/bin/*
```

**Option 2: Manual download**
Download scripts from GitHub releases

**Option 3: Package manager (future)**
```bash
# Future: ABDS package distribution
brew install abds-tools
```

### 10.4 Documentation

Full documentation for each script is available in `~/.abds/bin/README.md`.

**Philosophy**: Specification is primary, tools are secondary. You can follow ABDS without any tools.

---

## 11. Examples

### 11.1 Minimal ABDS Project

```
# Global
~/.abds/
└── learnings/
    └── CATALOG.md

# Local
my-project/
├── .abds/
│   └── docs/
│       ├── PROJECT-STATE.md          # Required
│       └── database/
│           └── STATE.md              # Required
├── src/
└── README.md
```

**Compliance**: ⭐ Level 1 (Minimal)

### 11.2 Standard ABDS Project

```
# Global
~/.abds/
├── learnings/
│   ├── CATALOG.md
│   ├── database/
│   │   └── rls-patterns.md
│   └── auth/
│       └── oauth-flow.md
└── plans/
    └── cross-project-testing_2026-05-01_10-30.md

# Local
my-project/
├── .abds/
│   └── docs/
│       ├── PROJECT-STATE.md
│       ├── auth/
│       │   ├── STATE.md
│       │   ├── CLAUDE.md
│       │   └── sessions/
│       │       └── oauth-implementation_16_01_2026/
│       │           └── oauth-implementation.md
│       └── database/
│           ├── STATE.md
│           ├── CLAUDE.md
│           └── sessions/
│               └── migration-planning_17_01_2026/
│                   └── migration-planning.md
├── src/
└── README.md
```

**Compliance**: ⭐⭐ Level 2 (Standard)

### 11.3 Full ABDS Project

```
# Global
~/.abds/
├── learnings/
│   ├── CATALOG.md              # Auto-generated
│   ├── database/
│   │   ├── rls-patterns.md
│   │   └── migration-best-practices.md
│   ├── auth/
│   │   └── oauth-flow.md
│   ├── ui/
│   │   └── scroll-preservation.md
│   └── sessions/
│       └── database-debugging_18_04_2026/
│           └── database-debugging.md
├── plans/
│   ├── cross-project-testing_2026-05-01_10-30.md
│   └── automated-deployment_2026-04-28_15-00.md
└── config/
    └── abds.conf

# Local
my-project/
├── .abds/
│   ├── docs/
│   │   ├── PROJECT-STATE.md
│   │   ├── IMPORTANT/
│   │   │   ├── CLAUDE.md
│   │   │   ├── GUIDES/
│   │   │   ├── MISTAKES/
│   │   │   └── LEARNINGS/
│   │   ├── auth/
│   │   │   ├── STATE.md
│   │   │   ├── CLAUDE.md
│   │   │   ├── IMPORTANT/
│   │   │   └── sessions/
│   │   └── database/
│   │       ├── STATE.md
│   │       ├── CLAUDE.md
│   │       └── sessions/
│   └── plans/
│       ├── oauth-implementation_2026-04-15.md
│       └── schema-migration_2026-04-20.md
├── src/
└── README.md
```

**Compliance**: ⭐⭐⭐ Level 3 (Full)

---

## 12. FAQ

### Q: Is ABDS tool-specific?

**A**: No. ABDS is generic. Any AI agent system can use it (Cursor, Aider, Windsurf, custom agents, etc.). The `.abds/` directory name is universal.

### Q: Can I use `.claude/` or `.cursor/` instead of `.abds/`?

**A**: No. ABDS 1.0 requires `.abds/` for both global and local directories. This ensures:
- Universal compatibility (works with any agent)
- No namespace conflicts
- Clear separation from tool-specific directories

Legacy projects using `.claude/` should migrate to `.abds/` for compliance.

### Q: Do I need all four layers?

**A**: Minimum: Layers 1 and 2 (PROJECT-STATE.md + feature STATE.md). Layers 3-4 are recommended but optional.

### Q: What if my project doesn't have "features"?

**A**: Use domains, modules, or areas. Examples: `frontend/`, `backend/`, `api/`, `cli/`. The concept is the same.

### Q: Can I have learnings at both project and user level?

**A**: Yes. Project-specific learnings go in `.agent/docs/IMPORTANT/LEARNINGS/`. Cross-project learnings go in `~/.agent/learnings/`.

### Q: Do I need scripts/tools to use ABDS?

**A**: No. ABDS is just a directory structure and documentation standard. You can follow it manually. Tools are optional helpers.

### Q: Can I extend ABDS for my needs?

**A**: Yes. ABDS defines minimum requirements. You can add custom directories, additional layers, or project-specific conventions.

### Q: What about binary files, images, artifacts?

**A**: ABDS focuses on documentation (markdown). Store artifacts in `sessions/screenshots/` or `sessions/artifacts/`. No specific format requirements.

---

## 13. Version History

### Version 1.0 (2026-05-05) - Initial Release

**Core features**:
- Four-layer documentation system
- Learnings system with frontmatter
- Standard directory layout
- Three compliance levels
- File naming conventions

**Decisions**:
- `.agent/` as recommended base directory (`.claude/`, `.cursor/` acceptable)
- PROJECT-STATE.md at root level (unique name)
- Feature STATE.md files (recurring name)
- Session folders with date suffixes
- YAML frontmatter for learnings

---

## 14. References

**Inspired by**:
- [XDG Base Directory Specification](https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html)
- [Filesystem Hierarchy Standard (FHS)](https://refspecs.linuxfoundation.org/FHS_3.0/fhs-3.0.html)
- [POSIX.1-2017](https://pubs.opengroup.org/onlinepubs/9699919799/)

**Related projects**:
- [Agent OS](https://github.com/buildermethods/agent-os) - Project-specific standards
- [GBrain](https://github.com/mrsimpson/gobrain) - PostgreSQL-based knowledge system

**Differences**:
- ABDS: System-level, cross-project, lightweight (bash + markdown)
- Agent OS: Project-level, templates + conventions
- GBrain: Heavy infrastructure (PostgreSQL + TypeScript + MCP)

---

## 15. Contributing

ABDS is an open specification. Contributions welcome:

- **Issues**: Suggest improvements, report ambiguities
- **Pull Requests**: Clarifications, examples, templates
- **Implementations**: Share ABDS-compliant projects

**Repository**: https://github.com/abds-spec/abds

**License**: CC0 1.0 Universal (Public Domain)

---

## 16. Acknowledgments

- **Linux FHS** - Directory structure inspiration
- **XDG-BDS** - Base directory specification model
- **Kaloyan Tanev** - Original problem statement and design

---

**End of ABDS 1.0 Specification**

**Status**: Draft - Open for community feedback
**Next**: Reference implementation, validation tools, real-world testing
