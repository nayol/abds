# ABDS Reference Implementation Scripts

This directory contains optional helper scripts for working with ABDS.

**Location**: `~/.abds/bin/` (following Unix convention: `~/.local/bin/`)

**Status**: Optional - not required for ABDS compliance

**Philosophy**: ABDS is a specification. You can follow it manually. These scripts automate common workflows.

---

## Scripts

### Core Tools

#### generate-index

**Purpose**: Auto-generate INDEX.md files for fast agent navigation (⚡ 10-15x speed improvement)

**Usage**:
```bash
# Auto-detect directory type and generate appropriate INDEX.md
~/.abds/bin/generate-index [directory]

# Force specific type
~/.abds/bin/generate-index --type=root .abds/docs/
~/.abds/bin/generate-index --type=feature .abds/docs/auth/
~/.abds/bin/generate-index --type=sessions .abds/docs/auth/sessions/

# Generate for all subdirectories
~/.abds/bin/generate-index --all .abds/docs/
```

**What it does**:
1. Detects directory type (root, feature, or sessions)
2. Scans all files and subdirectories
3. Generates structured INDEX.md with:
   - Quick navigation links
   - File organization overview
   - Status indicators (✅/⚠️/🔄)
   - Chronological ordering (for sessions)

**Why it matters**: Without INDEX.md, agents take 40-50 seconds to scan 50+ files randomly. With INDEX.md, agents read structured index in 2-3 seconds.

**Real-world example**:
```bash
# Project with 52 folders, auth/ with 40 files
$ generate-index --all ~/my-project/.abds/docs/

✓ Generated: docs/INDEX.md (root - 52 features)
✓ Generated: docs/auth/INDEX.md (feature - 40 files)
✓ Generated: docs/auth/sessions/INDEX.md (sessions - 23 sessions)
✓ Generated: docs/database/INDEX.md (feature - 18 files)

Agent navigation time: 40s → 3s (13x faster)
```

**Three INDEX.md Types**:

1. **Root INDEX.md** (`.abds/docs/INDEX.md`)
   - Lists all features with status, file counts
   - Quick answers section
   - Complexity ratings

2. **Feature INDEX.md** (`.abds/docs/{feature}/INDEX.md`)
   - Core documentation files
   - Raw transcripts
   - Sessions folder link
   - File organization tree

3. **Sessions INDEX.md** (`.abds/docs/{feature}/sessions/INDEX.md`)
   - Chronological session list
   - Date extraction and formatting
   - Summary links

**Idempotent**: Safe to run multiple times (overwrites INDEX.md)

**Auto-detection Logic**:
- Has `PROJECT-STATE.md` → root type
- Has `STATE.md` or `CLAUDE.md` → feature type
- Folder name ends with `_DD_MM_YYYY` → sessions type

---

#### update-catalog

**Purpose**: Generate CATALOG.md from YAML frontmatter

**Usage**:
```bash
~/.abds/bin/update-catalog
```

**What it does**:
1. Scans all `.md` files in `~/.abds/learnings/{category}/`
2. Extracts YAML frontmatter (keywords, description, tldr)
3. Generates `~/.abds/learnings/CATALOG.md`
4. Sorts by category, formats as searchable index

**Requirements**: bash, sed, grep

**Idempotent**: Safe to run multiple times

**Example output**:
```markdown
# Learnings Catalog

## Quick Search

| Category | Keywords | TL;DR | File |
|----------|----------|-------|------|
| Database | rls, security | Always qualify RPC calls | database/rls-schema.md |
```

---

#### validate-abds

**Purpose**: Check ABDS compliance level

**Usage**:
```bash
~/.abds/bin/validate-abds [project-path]
```

**What it checks**:
- ⭐ Level 1: PROJECT-STATE.md + feature STATE.md
- ⭐⭐ Level 2: + CLAUDE.md + sessions/
- ⭐⭐⭐ Level 3: + learnings + CATALOG.md + IMPORTANT/

**Output**: Compliance report with recommendations

**Example**:
```bash
$ ~/.abds/bin/validate-abds ~/my-project

ABDS Compliance Check
=====================

Checking: /Users/me/my-project

✓ Level 1 (Minimal) ⭐
  ✓ .abds/docs/ exists
  ✓ PROJECT-STATE.md found
  ✓ Feature STATE.md found (2 features)

✓ Level 2 (Standard) ⭐⭐
  ✓ Features have CLAUDE.md
  ✓ Session folders exist
  ✓ Naming conventions followed

✗ Level 3 (Full) ⭐⭐⭐
  ✗ ~/.abds/learnings/CATALOG.md not found
  ✗ docs/IMPORTANT/ not found

Compliance Level: ⭐⭐ (Standard)

Missing for ⭐⭐⭐:
  - Run: mkdir -p ~/.abds/learnings
  - Run: ~/.abds/bin/update-catalog
  - Run: mkdir -p .abds/docs/IMPORTANT/{GUIDES,MISTAKES,LEARNINGS}
```

---

#### init-abds

**Purpose**: Initialize ABDS structure in project

**Usage**:
```bash
cd my-project
~/.abds/bin/init-abds
```

**What it creates**:
- `.abds/docs/` directory
- `PROJECT-STATE.md` from template
- First feature folder with `STATE.md`
- `README.md` with navigation

**Interactive**: Prompts for feature name

**Example session**:
```bash
$ cd my-project
$ ~/.abds/bin/init-abds

Initializing ABDS structure...

✓ Creating .abds/docs/
✓ Copying PROJECT-STATE.md template

First feature name (or 'skip'): authentication
✓ Creating .abds/docs/authentication/
✓ Creating authentication/STATE.md
✓ Creating authentication/sessions/

✓ ABDS structure created

Next steps:
  1. Edit .abds/docs/PROJECT-STATE.md
  2. Edit .abds/docs/authentication/STATE.md
  3. Start documenting!

Compliance Level: ⭐ (Minimal)
```

---

#### migrate-abds

**Purpose**: Migrate from legacy structure to ABDS

**Usage**:
```bash
~/.abds/bin/migrate-abds --from ~/.claude --to ~/.abds
```

**What it migrates**:
- `learnings/` directory
- `plans/` directory
- Documentation files
- Preserves git history

**Safety**: Creates backup before migration

**Example**:
```bash
$ ~/.abds/bin/migrate-abds --from ~/.claude --to ~/.abds

ABDS Migration Tool
===================

Source: /Users/me/.claude
Target: /Users/me/.abds

Creating backup...
✓ Backup: ~/.abds-migration-backup-20260505-143022.tar.gz

Migrating learnings...
✓ Copied 47 learning files

Migrating plans...
✓ Copied 12 plan files

Updating CATALOG...
✓ Generated CATALOG.md

Migration complete!

Backup: ~/.abds-migration-backup-20260505-143022.tar.gz
Source: ~/.claude/ (unchanged - delete manually if desired)
Target: ~/.abds/
```

---

### Documentation Helpers

#### search-learnings

**Purpose**: Full-text search across all learnings

**Usage**:
```bash
~/.abds/bin/search-learnings "database RLS"
~/.abds/bin/search-learnings --category database "postgres"
~/.abds/bin/search-learnings --keyword security
```

**What it does**:
- Searches all `.md` files in `~/.abds/learnings/`
- Returns matching files with context
- Highlights keywords in output

**Requirements**: bash, grep (or ripgrep if available)

**Example**:
```bash
$ ~/.abds/bin/search-learnings "RLS security"

🔍 Searching learnings for: "RLS security"

Found 3 matches:

📄 database/rls-schema-qualification.md
   Keywords: rls, security, postgres
   TL;DR: Always qualify RPC calls with schema to prevent security issues

   Context:
   > RLS policies must be properly qualified with schema names to ensure
   > security boundaries are correctly enforced...

📄 database/rls-testing-patterns.md
   Keywords: rls, testing, security
   TL;DR: Test RLS policies with different user contexts

   Context:
   > Testing RLS requires switching between different user security contexts...

📄 security/bearer-token-storage.md
   Keywords: auth, security, tokens
   TL;DR: Store tokens in httpOnly cookies, not localStorage
```

---

#### create-session

**Purpose**: Create new session folder with proper naming

**Usage**:
```bash
~/.abds/bin/create-session
```

**Interactive**: Asks for feature and description

**What it does**:
1. Lists existing features in `.abds/docs/`
2. Prompts for feature selection
3. Prompts for session description
4. Creates folder: `{description}_{DD_MM_YYYY}/`
5. Copies `session-summary.md` template
6. Opens in editor (if `$EDITOR` set)

**Example session**:
```bash
$ cd my-project
$ ~/.abds/bin/create-session

Create New Session
==================

Existing features:
  1. authentication
  2. database
  3. api

Select feature (1-3) or enter new name: 2

Feature: database

Session description (e.g., 'migration-planning'): query-optimization

Creating session...
✓ Created: .abds/docs/database/sessions/query-optimization_05_05_2026/
✓ Copied template: session-summary.md

Opening in editor...
```

---

#### find-files-to-rename

**Purpose**: Find documentation files with generic names

**Usage**:
```bash
~/.abds/bin/find-files-to-rename
```

**What it finds**:
- Files with generic names (doc.md, notes.md, temp.md)
- Files missing date information
- Session folders with poor descriptions
- Files that should be renamed for clarity

**Output**: List of files with suggestions

**Example**:
```bash
$ ~/.abds/bin/find-files-to-rename

Finding files to rename...

Generic names found:
  ⚠️  docs/notes.md
      Suggestion: Rename to describe content (e.g., 'auth-implementation-notes.md')

  ⚠️  docs/temp.md
      Suggestion: Rename or delete if no longer needed

Sessions needing better names:
  ⚠️  docs/api/sessions/work_05_05_2026/
      Suggestion: Rename to describe what was done (e.g., 'endpoint-refactoring_05_05_2026')

Unnamed session files:
  ⚠️  docs/auth/sessions/oauth-impl_16_01_2026/summary.md
      Suggestion: Rename to match folder (e.g., 'oauth-impl.md')

Total files to review: 4
```

---

## Installation

These scripts are part of the ABDS reference implementation.

### Option 1: Clone ABDS repository

```bash
git clone https://github.com/abds-spec/abds.git
cp -r abds/bin/ ~/.abds/bin/
chmod +x ~/.abds/bin/*
```

### Option 2: Manual download

Download scripts from GitHub releases:
```bash
mkdir -p ~/.abds/bin
cd ~/.abds/bin
curl -O https://github.com/abds-spec/abds/releases/download/v1.0/update-catalog
curl -O https://github.com/abds-spec/abds/releases/download/v1.0/validate-abds
# ... etc
chmod +x *
```

### Option 3: Package manager (future)

```bash
# Future: ABDS package distribution
brew install abds-tools
# or
apt-get install abds-tools
```

---

## Requirements

**Minimum**:
- bash 4.0+
- Standard Unix tools: sed, grep, find, tar
- Git (for some operations)

**Optional**:
- ripgrep (faster searching)
- jq (for JSON processing, future features)

**Compatibility**:
- ✅ Linux
- ✅ macOS
- ✅ BSD
- ✅ WSL (Windows Subsystem for Linux)

---

## Unix/Linux Naming Conventions

These scripts follow Unix/Linux patterns from `/usr/bin/`:

**Naming style**:
- Lowercase with hyphens: `update-catalog` (not `updateCatalog`)
- Verb-noun format: `find-files`, `create-session`
- No file extensions: `update-catalog` (not `update-catalog.sh`)

**Unix precedents**:
```
/usr/bin/
├── apt-get          ← verb-noun (we follow this)
├── update-alternatives  ← verb-noun
├── find-file        ← verb-noun
└── systemctl        ← compound name

~/.abds/bin/         ← ABDS follows same pattern
├── update-catalog   ← verb-noun
├── validate-abds    ← verb-noun
├── search-learnings ← verb-noun
└── create-session   ← verb-noun
```

**Executable permissions**:
- All scripts: `chmod +x`
- Shebang line: `#!/bin/bash` or `#!/usr/bin/env bash`
- No `.sh` extension (Unix convention)

---

## Script Design Principles

Following Unix/Linux best practices:

### 1. Simple & Composable (Unix philosophy: do one thing well)
- Do one thing well (like grep, sed, awk)
- Pipe-friendly output (stdin/stdout, not interactive unless necessary)
- Exit codes: 0 = success, 1 = error, 2 = warning
- Combine with pipes: `search-learnings foo | grep bar`

### 2. Safe & Idempotent (Unix principle: least surprise)
- Never destructive without confirmation (like `rm -i`)
- Can run multiple times safely (like `mkdir -p`)
- Create backups when modifying files (like `.bak` pattern)
- Fail gracefully with clear error messages

### 3. Helpful & Clear (Unix convention: helpful output)
- Colored output for visibility (like `ls --color`)
- Progress indicators for long operations (like `wget`)
- Clear error messages with suggestions (like `git`)
- `--help` flag (standard Unix: show usage)

### 4. Universal & Generic (Unix principle: portability)
- Work with any project using ABDS
- No project-specific assumptions
- POSIX-compliant where possible
- Bash for scripting (portable, like `/bin/sh`)

---

## Environment Variables

Scripts respect these environment variables:

- `ABDS_HOME` - Override default `~/.abds/` location
  ```bash
  export ABDS_HOME=/custom/path
  ~/.abds/bin/update-catalog  # Uses /custom/path/learnings
  ```

- `EDITOR` - Used by `create-session` to open files
  ```bash
  export EDITOR=vim
  ~/.abds/bin/create-session  # Opens in vim
  ```

- `NO_COLOR` - Disable colored output
  ```bash
  NO_COLOR=1 ~/.abds/bin/validate-abds
  ```

---

## Contributing

These are reference implementations. Improvements welcome!

**How to contribute**:
1. Fork the ABDS repository
2. Make improvements to scripts
3. Test on Linux, macOS, BSD
4. Submit pull request

**Guidelines**:
- Follow Unix conventions
- Keep scripts simple and readable
- Add comments for complex logic
- Test on multiple platforms
- Update this README with changes

See `CONTRIBUTING.md` in the main ABDS repository.

---

## Future Scripts (Planned)

Additional scripts under consideration:

**Quality Tools**:
- `check-frontmatter` - Validate YAML frontmatter
- `lint-docs` - Check documentation for common issues
- `verify-links` - Check for broken internal links

**Reporting Tools**:
- `learnings-stats` - Statistics on learnings usage
- `project-health` - ABDS compliance report with metrics
- `timeline` - Show project activity from sessions

**Advanced Tools**:
- `rollup-state` - Generate PROJECT-STATE.md from features
- `add-learning` - Interactive learning creation wizard
- `apply-learning` - Mark learning as applied to project

**Feedback welcome**: Open an issue to suggest new scripts!

---

## License

**CC0 1.0 Universal (Public Domain)**

These scripts are released into the public domain. Use them freely.

---

## Support

**Questions?**: Open an issue at https://github.com/abds-spec/abds/issues

**Documentation**: See full ABDS specification at ABDS-1.0.md

**Community**: Join discussions at https://github.com/abds-spec/abds/discussions

---

**ABDS Reference Implementation** - Optional tools for the ABDS specification
