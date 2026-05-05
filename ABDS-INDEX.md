# ABDS - Agent Base Directory Index

**Location**: `~/.abds/INDEX.md`

**Purpose**: System-level orientation - explain what `~/.abds/` is when you see it

---

## What is ABDS?

ABDS is a **system-level standard** for organizing documentation and knowledge in AI agent development environments.

Think of it as:
- **Like FHS for programs** (`/usr/bin`, `/etc`) → **ABDS for knowledge** (`~/.abds/`)
- **Like XDG for config** (`~/.config/`) → **ABDS for learnings** (`~/.abds/learnings/`)
- **Like POSIX for OS** (system interface) → **ABDS for docs** (documentation interface)

**System-level means**:
- Universal across ALL projects (not project-specific)
- Works with ANY AI agent (Cursor, Aider, Windsurf, custom)
- Infrastructure layer (like operating system for knowledge)
- Knowledge travels with you (copy `~/.abds/` to new machine, keep all learnings)

---

## Directory Structure

```
~/.abds/
  learnings/                 # Cross-project knowledge and patterns
    CATALOG.md               # Searchable index (auto-generated)
    database/                # Category-based organization
      rls-patterns.md
      migration-best-practices.md
    ui/
      scroll-preservation.md
    debugging/
    testing/
    sessions/                # Session-based learnings

  plans/                     # Implementation plans
    {description}_{YYYY-MM-DD}_{HH-MM}.md

  bin/                       # Helper scripts and tools
    generate-index           # Auto-generate INDEX.md (10x faster navigation)
    update-catalog           # Generate learnings index
    validate-abds            # Check project compliance
    init-abds                # Initialize ABDS in project
    search-learnings         # Search across all learnings
    create-session           # Create new session folder

  config/                    # Configuration files
    abds.conf                # User preferences

  templates/                 # Document templates
    PROJECT-STATE.md         # Project overview template
    STATE.md                 # Feature state template
    CLAUDE.md                # Architecture template
    session-summary.md       # Session documentation template
    learning.md              # Learning documentation template
    README.md                # Project docs index template

  INDEX.md                   # This file (orientation guide)
```

---

## What Lives Here

### learnings/ - Cross-Project Knowledge

**Purpose**: Knowledge that applies to MULTIPLE projects

**Examples**:
- "How to implement RLS in Supabase" (applies to ALL Supabase projects)
- "Scroll preservation pattern in React" (applies to ALL React projects)
- "Database migration best practices" (applies to ALL database projects)

**Organization**: By category (database/, ui/, debugging/, auth/, etc.)

**Searchable**: `CATALOG.md` provides quick keyword search

**When to add**: After solving hard problem that might recur

### plans/ - Implementation Plans

**Purpose**: User-level implementation plans from planning sessions

**Format**: `{description}_{YYYY-MM-DD}_{HH-MM}.md`

**Examples**:
- `cross-project-testing_2026-05-01_10-30.md`
- `automated-deployment_2026-04-28_15-00.md`

**Note**: Project-specific plans go in `{project}/.abds/plans/`

### bin/ - Helper Scripts

**Purpose**: Automation tools for ABDS workflows

**Status**: Optional (ABDS can be followed manually)

**Scripts**:
- `generate-index` - Auto-generate INDEX.md files for fast navigation (10-15x speed)
- `update-catalog` - Regenerate CATALOG.md from frontmatter
- `validate-abds` - Check compliance level (L1/L2/L3)
- `init-abds` - Set up ABDS in new project
- `search-learnings` - Full-text search across learnings
- `create-session` - Create properly named session folder

**Documentation**: See `bin/README.md`

### config/ - Configuration

**Purpose**: User preferences and settings

**Files**:
- `abds.conf` - Global ABDS configuration

**Example settings**:
- Default categories
- Preferred editor
- Custom templates location

### templates/ - Document Templates

**Purpose**: Standard templates for consistent documentation

**Templates**:
- `PROJECT-STATE.md` - Layer 1: Project overview
- `STATE.md` - Layer 2: Feature current state
- `CLAUDE.md` - Layer 3: Architecture and decisions
- `session-summary.md` - Layer 4: Work history
- `learning.md` - Learning documentation with frontmatter
- `README.md` - Documentation navigation

**Usage**: Copy to project when initializing ABDS

---

## Quick Start

### Initialize ABDS in a New Project

```bash
cd my-project
~/.abds/bin/init-abds
```

### Search Learnings

```bash
~/.abds/bin/search-learnings "database RLS"
```

### Update Catalog (After Adding Learnings)

```bash
~/.abds/bin/update-catalog
```

### Create New Session

```bash
cd my-project
~/.abds/bin/create-session
```

### Check Project Compliance

```bash
~/.abds/bin/validate-abds ~/my-project
```

---

## Project-Level vs System-Level

**System-level** (`~/.abds/`):
- Cross-project learnings
- User-wide configuration
- Helper scripts
- Templates

**Project-level** (`{project}/.abds/`):
- Project-specific documentation
- Feature STATE.md files
- Session history
- Project plans

**Relationship**: System-level serves ALL projects, project-level serves ONE project

**Example**:
```
System:  ~/.abds/learnings/database/rls-patterns.md
         ↓ (knowledge applies to multiple projects)
Projects:
         ~/project1/.abds/docs/database/STATE.md
         ~/project2/.abds/docs/auth/STATE.md
         ~/project3/.abds/docs/api/STATE.md
```

---

## The Four Documentation Layers

ABDS defines 4 layers of documentation (in each project):

| Layer | File | Purpose | Update Frequency |
|-------|------|---------|------------------|
| **1** | `PROJECT-STATE.md` | 2-minute project overview | Daily/weekly |
| **2** | `{feature}/STATE.md` | Current feature state | When feature changes |
| **3** | `{feature}/CLAUDE.md` | Architecture & "why" | When architecture changes |
| **4** | `{feature}/sessions/` | Work history | Never (immutable) |

**Why layers?**
- Different update frequencies (daily → never)
- Different audiences (overview → deep-dive)
- Separation of concerns (current state ≠ history)

---

## Learnings System

### CATALOG.md - Searchable Index

**Auto-generated** from YAML frontmatter in all learning files.

**Format**:
```markdown
| Category | Keywords | TL;DR | File |
|----------|----------|-------|------|
| Database | rls, security | Always qualify RPC calls | database/rls-schema.md |
```

**Usage**: Search by keyword, get TL;DR, read full file if needed

**Update**: Run `~/.abds/bin/update-catalog`

### Learning File Format

**Location**: `~/.abds/learnings/{category}/{descriptive-name}.md`

**Structure**:
```markdown
---
keywords: [keyword1, keyword2, keyword3]
category: database
confidence: verified
tldr: "One-line solution summary"
description: "Problem description"
projects_applied:
  - name: project-name
    date: 2026-05-05
    notes: "Brief context"
---

# Title

## TL;DR
{1-2 sentence solution}

## Applies When
{Conditions where this learning is relevant}

## Symptom
{What developer observes}

## Root Cause
{Why it happens}

## Solution
{Code/approach that fixes it}

## Projects Applied
- project1 (2026-05-05) - Outcome
```

---

## Learn More

**Full specification**: See ABDS-1.0.md in specification repository

**Repository**: https://github.com/abds-spec/abds

**Community**: GitHub issues and discussions

**Documentation**: Each subdirectory has a README.md with details

---

## FAQ

**Q: What if I use multiple machines?**
A: Copy `~/.abds/` to new machine. All learnings travel with you.

**Q: What if I switch from Cursor to Aider?**
A: ABDS is universal. Both tools can use same `~/.abds/` structure.

**Q: Do I need scripts?**
A: No. ABDS is a directory structure. Scripts are optional helpers.

**Q: Can I customize categories?**
A: Yes. Create any categories that fit your work (security/, devops/, etc.)

**Q: Where do project-specific docs go?**
A: In `{project}/.abds/docs/`, not in `~/.abds/`

---

## Version

**ABDS Version**: 1.0
**Compliance**: This directory follows ABDS standard

---

**Note**: This is INDEX.md (system orientation), not README.md (project documentation).

**Purpose**: Help you understand what `~/.abds/` is and how to use it.

---

**ABDS** - System-level infrastructure for knowledge management in AI agent development

**Inspired by Unix. Built for AI agents. Made for developers.**
