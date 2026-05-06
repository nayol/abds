# Documentation System - How We Structure Work

**Created:** 19/04/2026
**Status:** ABDS Specification Component
**Part of:** ABDS (Agent Base Directory Specification)

---

## Overview

This document defines the 4-layer documentation workflow for ABDS-compliant projects.

**After ABDS installation**, this file is available at:
- `~/.abds/share/doc/abds/DOCUMENTATION-SYSTEM.md`

**In projects**, copy this to:
- `{project}/.abds/docs/IMPORTANT/DOCUMENTATION-SYSTEM.md` (if you want local reference)

---

## The 4-Layer Documentation System

### Layer 1: PROJECT-STATE.md (Root Entry Point)
**Location:** `PROJECT-STATE.md` (root level - NOT docs/)
**Purpose:** 2-minute overview of entire project
**Update:** After significant changes (daily during active dev, weekly during maintenance)

**Why root?** Entry points belong at root (README.md, CLAUDE.md, PROJECT-STATE.md). docs/ is for detailed documentation (Layers 2-4).

**Contains:**
- Current sprint focus
- Critical warnings (what NOT to do)
- Top 3 active problems
- What's working/broken/in-progress
- Recent changes (last 7 days)
- Quick database facts
- Pointers to feature STATE.md files

### Layer 2: Feature STATE.md
**Location:** `docs/{feature}/STATE.md`
**Purpose:** Current state of specific feature area
**Update:** When feature changes (event-triggered)

**Contains:**
- What's deployed and working
- What's in progress
- Known issues and bugs
- Database tables/functions for this feature
- Key files and modules
- Links to CLAUDE.md (architecture)
- Links to sessions (recent work)

**Example locations:**
- `docs/knowledge-base/STATE.md`
- `docs/auth/STATE.md`
- `docs/chat/STATE.md`

### Layer 3: Feature CLAUDE.md
**Location:** `docs/{feature}/CLAUDE.md`
**Purpose:** Architecture, patterns, deep knowledge (rarely changes)
**Update:** When architecture changes (rare - quarterly or less)

**Contains:**
- Architecture decisions (the "why")
- Implementation patterns
- Key abstractions and interfaces
- Historical context
- Links to sessions (for deep dives)
- Critical file paths

**We have CLAUDE.md at these levels:**
1. Root (`CLAUDE.md` in project root) - Navigation + project overview
2. Major features (11 files): auth, chat, database, debugging, deployment, i18n, knowledge-base, organizations, realtime, tools, ui
3. Critical subfolders (~2-3 files): knowledge-base/architecture, etc.
4. **Total: ~15 strategic CLAUDE.md files** (not 103!)

### Layer 4: Session Folders (Chronological History)
**Location:** `docs/{feature}/sessions/{session-name}_{DD_MM_YYYY}/`
**Purpose:** Raw conversation logs, debugging journeys
**Update:** Created during work, never updated after

**KEY PRINCIPLE**: ONE folder per feature per day/sprint, MULTIPLE files inside.

**Naming convention:**
```
docs/knowledge-base/sessions/privacy-and-sharing-work_18_04_2026/
├── privacy-fix-implementation.md        # Chat 1
├── privacy-fix-implementation-raw.md
├── privacy-fix-testing.md               # Chat 2
├── privacy-fix-testing-raw.md
├── sharing-toggle-debug.md              # Chat 3
├── sharing-toggle-debug-raw.md
├── sharing-toggle-fix.md                # Chat 4
├── _INDEX.md                            # Optional index (if 5+ files)
├── screenshots/
└── artifacts/
```

**Important**:
- ❌ **NOT** `summary.md` - too generic when you have 10-20 files!
- ✅ **YES** descriptive names: `{topic}-{action}.md` (implementation, testing, debug, fix)
- **Multiple chats** on same feature → **same folder**, different filenames
- **One folder per day/sprint** - not one folder per chat!

**Files in session folders:**
- `{description}.md` - Main documentation (specific names!)
- `{description}-raw.md` - Full transcript (if exists)
- `_INDEX.md` - Session index (if 5+ files)
- `screenshots/` - Visual artifacts
- `artifacts/` - Code snippets, logs

---

## When to Update What

| Event | Update | How Often |
|-------|--------|-----------|
| Started new work session | Create session folder with timestamp | Every session |
| Completed feature/fix | Update feature STATE.md | After merge |
| Completed sprint/milestone | Update PROJECT-STATE.md | Weekly |
| Changed architecture | Update feature CLAUDE.md | Rarely (quarterly) |
| Migrated database | Update database/STATE.md | After migration |
| Created new feature area | Create folder + STATE.md + CLAUDE.md | Once |

---

## File Naming Conventions

### Session Folders
**Pattern:** `{description}_{DD_MM_YYYY}/`

**Note**: Date only (no hour/minute) - one folder per day per feature.

**Examples:**
```
privacy-and-sharing-work_18_04_2026/     ← 10-20 files inside
oauth-implementation_15_03_2026/         ← Multiple chats, one folder
realtime-sync-work_20_03_2026/
```

**Why date only (not time)?**
- Work on one feature across multiple chats
- All chats on same day go in same folder
- Reduces folder proliferation
- Multiple files with descriptive names inside

### Files in Sessions
**Pattern:** `{topic}-{action}.md` and `{topic}-{action}-raw.md`

**Actions**: implementation, testing, debugging, fix, analysis, verification

**Examples:**
```
docs/database/sessions/privacy-work_18_04_2026/
├── privacy-fix-implementation.md         ← Specific name (Chat 1)
├── privacy-fix-implementation-raw.md
├── privacy-fix-testing.md                ← Different name (Chat 2)
├── privacy-fix-testing-raw.md
├── sharing-toggle-debug.md               ← Different name (Chat 3)
├── sharing-toggle-debug-raw.md
├── sharing-toggle-fix.md                 ← Different name (Chat 4)
└── _INDEX.md                             ← Optional index
```

**Key Rule**: Each file must have **unique descriptive name** - never `summary.md` when you have multiple files!

---

## Where Things Go

### New Feature Implementation
```
1. Create session folder: docs/{feature}/sessions/{name}_{timestamp}/
2. Document work in session (raw + summary)
3. After completion: Update docs/{feature}/STATE.md
4. If architecture changed: Update docs/{feature}/CLAUDE.md
5. Update PROJECT-STATE.md (root level - top 3 changes)
```

### Bug Fix
```
1. Create session folder: docs/{feature}/sessions/{bug-name}_{timestamp}/
2. Document debugging journey
3. After fix: Update docs/{feature}/STATE.md (remove from known issues)
4. Update PROJECT-STATE.md (root level - remove from active problems)
```

### Database Migration
```
1. Create migration file: supabase/migrations/...
2. Update docs/database/STATE.md (new tables/functions)
3. Update PROJECT-STATE.md (root level - database quick facts)
4. Create session if complex: docs/database/sessions/{migration-name}_{timestamp}/
```

---

## CLAUDE.md Hierarchy (Target: 15 files)

### ✅ Keep These (15 files)

**Root (1 file):**
- `CLAUDE.md` - Navigation guide + project overview

**Major Features (11 files):**
- `docs/auth/CLAUDE.md`
- `docs/chat/CLAUDE.md`
- `docs/database/CLAUDE.md`
- `docs/debugging/CLAUDE.md`
- `docs/deployment/CLAUDE.md`
- `docs/i18n/CLAUDE.md`
- `docs/knowledge-base/CLAUDE.md`
- `docs/organizations/CLAUDE.md`
- `docs/realtime/CLAUDE.md`
- `docs/tools/CLAUDE.md`
- `docs/ui/CLAUDE.md`

**Critical Subfolders (2-3 files):**
- `docs/knowledge-base/architecture/CLAUDE.md` (if complex subsystem)
- `src-tauri/src/{module}/CLAUDE.md` (for Rust modules)
- `utufdbox-web/docs/IMPORTANT/CLAUDE.md` (critical patterns)

### ❌ Delete These (88 files to remove)

**Session folders - NO CLAUDE.md:**
- `docs/*/sessions/*/CLAUDE.md` - Delete all (sessions have summaries instead)

**Small features - NO CLAUDE.md:**
- Document in parent feature CLAUDE.md instead

**Empty/minimal CLAUDE.md:**
- Audit and delete if < 50 lines and no unique info

---

## Auto-Generation Strategy (Future)

**Automated updates:**
- `scripts/update-project-state.sh` - Daily cron (aggregates recent changes)
- `scripts/update-db-state.sh` - Post-migration hook (extracts schema)

**Manual updates:**
- Feature STATE.md - After feature work
- CLAUDE.md - When architecture changes (rare)

---

## Quick Reference

**Starting new session?**
```bash
# Create timestamped folder
mkdir -p "docs/{feature}/sessions/{description}_$(date +%d_%m_%Y_%H_%M)"
```

**Finishing feature work?**
```bash
# Update feature state
vim docs/{feature}/STATE.md

# Update project state (root level entry point)
vim PROJECT-STATE.md
```

**Need architecture info?**
```bash
# Read the layers (root → feature → architecture)
cat PROJECT-STATE.md                # 2 min overview (root level)
cat docs/{feature}/STATE.md         # Current state
cat docs/{feature}/CLAUDE.md        # Deep architecture
```

---

## Complete File Placement Guide

### STATE.md Files - Exactly Where They Go

**Rule:** STATE.md files ONLY at major feature roots (11 files total)

```
docs/
├── PROJECT-STATE.md              ← ✅ Entry point (Layer 1)
│
├── auth/STATE.md                 ← ✅ Authentication state
├── chat/STATE.md                 ← ✅ Chat system state
├── database/STATE.md             ← ✅ Database state
├── debugging/STATE.md            ← ✅ Debugging tools/patterns state
├── deployment/STATE.md           ← ✅ Deployment/build state
├── i18n/STATE.md                 ← ✅ Internationalization state
├── knowledge-base/STATE.md       ← ✅ Knowledge system state
├── organizations/STATE.md        ← ✅ Organization management state
├── realtime/STATE.md             ← ✅ Realtime sync state
├── tools/STATE.md                ← ✅ Tool system state
└── ui/STATE.md                   ← ✅ UI components state
```

**Total:** 1 PROJECT-STATE.md + 11 feature STATE.md = **12 STATE files**

**❌ NO STATE.md in:**
- Subfolders (`docs/auth/implementation/` - NO)
- Session folders (`docs/auth/sessions/` - NO)
- Small topics (`docs/IMPORTANT/` - NO)
- Architecture folders (`docs/knowledge-base/architecture/` - NO)

**Why 11 features?**
These are the major consolidated feature areas after reorganization. Each represents a distinct system with:
- Multiple files/modules
- Active development
- Need to track current state

---

### CLAUDE.md Files - Complete Hierarchy

**Target:** ~15 strategic CLAUDE.md files (currently 103, needs audit)

#### ✅ Level 1: Root (1 file)

```
CLAUDE.md                         ← Project overview + navigation
```

**Contains:**
- Read PROJECT-STATE.md first instruction
- High-level project overview
- Technology stack
- Port allocation
- Commands reference
- Critical patterns (DO NOT rules)

---

#### ✅ Level 2: Major Features (11 files)

```
docs/
├── auth/CLAUDE.md                ← Authentication architecture
├── chat/CLAUDE.md                ← Chat system architecture
├── database/CLAUDE.md            ← Database patterns & RLS
├── debugging/CLAUDE.md           ← Debugging tools & patterns
├── deployment/CLAUDE.md          ← Deployment processes
├── i18n/CLAUDE.md                ← i18n implementation
├── knowledge-base/CLAUDE.md      ← Knowledge system architecture
├── organizations/CLAUDE.md       ← Org management architecture
├── realtime/CLAUDE.md            ← Realtime sync patterns
├── tools/CLAUDE.md               ← Tool system architecture
└── ui/CLAUDE.md                  ← UI component patterns
```

**Each feature CLAUDE.md contains:**
- Architecture decisions (the "why")
- Implementation patterns
- Key abstractions/interfaces
- Critical file paths
- Links to STATE.md (current state)
- Links to sessions (for deep dives)
- Historical context

**Update frequency:** Rarely (quarterly or when architecture changes)

---

#### ✅ Level 3: Critical Subfolders (2-3 files)

**Only when subsystem is complex enough to warrant separate documentation:**

```
docs/
├── IMPORTANT/CLAUDE.md           ← Critical patterns (anti-patterns, learnings)
├── knowledge-base/
│   └── architecture/CLAUDE.md    ← Complex subsystem (hierarchical KB, RAG)
│
src-tauri/src/
├── auth/CLAUDE.md                ← PKCE flow, token handling (optional)
├── chat/CLAUDE.md                ← Supabase realtime (optional)
└── knowledge/CLAUDE.md           ← Knowledge Rust module (optional)
```

**Criteria for subfolder CLAUDE.md:**
- ✅ Complex subsystem with multiple modules
- ✅ Unique architectural decisions
- ✅ Would be > 500 lines if merged into parent
- ✅ Referenced frequently across codebase

**Total subfolder CLAUDE.md:** ~3 files

---

#### ❌ NO CLAUDE.md In These Locations

**Session folders:**
```
❌ docs/auth/sessions/oauth-fix_10_03_2026/CLAUDE.md
❌ docs/knowledge-base/sessions/privacy-fix_18_04_2026/CLAUDE.md
```
**Why:** Sessions have summary.md instead. CLAUDE.md is for architecture, not chronological logs.

**Implementation subfolders:**
```
❌ docs/auth/implementation/CLAUDE.md
❌ docs/knowledge-base/implementation/CLAUDE.md
```
**Why:** Document in parent `docs/auth/CLAUDE.md` instead. Avoids fragmentation.

**Small topics (< 10 files):**
```
❌ docs/icons/CLAUDE.md
❌ docs/logging/CLAUDE.md
❌ docs/refactoring/CLAUDE.md
```
**Why:** Create a `docs/misc/CLAUDE.md` or document in related feature CLAUDE.md.

**Empty/minimal files:**
```
❌ Any CLAUDE.md with < 50 lines and no unique info
```
**Why:** Wasted navigation step. Delete and merge into parent.

---

### Complete Documentation Tree (Ideal State)

```
/
├── CLAUDE.md                                    ← Layer 1: Root navigation
│
docs/
├── PROJECT-STATE.md                             ← Layer 1: Entry point (2 min)
├── DOCUMENTATION-SYSTEM.md                      ← This file (system guide)
│
├── auth/                                        ← Feature: Authentication
│   ├── STATE.md                                 ← Layer 2: Current state
│   ├── CLAUDE.md                                ← Layer 3: Architecture
│   └── sessions/                                ← Layer 4: History
│       └── oauth-fix_10_03_2026/
│           ├── summary.md
│           └── summary-raw.md
│
├── chat/                                        ← Feature: Chat
│   ├── STATE.md
│   ├── CLAUDE.md
│   ├── architecture/                            ← Subfolder (no CLAUDE.md)
│   ├── implementation/                          ← Subfolder (no CLAUDE.md)
│   └── sessions/
│
├── database/                                    ← Feature: Database
│   ├── STATE.md
│   ├── CLAUDE.md
│   ├── debugging-sessions/                      ← Subfolder (no CLAUDE.md)
│   └── sessions/
│
├── knowledge-base/                              ← Feature: Knowledge
│   ├── STATE.md
│   ├── CLAUDE.md
│   ├── architecture/
│   │   └── CLAUDE.md                            ← ✅ Exception: Complex subsystem
│   ├── implementation/
│   └── sessions/
│
├── organizations/                               ← Feature: Organizations
│   ├── STATE.md
│   ├── CLAUDE.md
│   ├── implementation/
│   ├── bugs/
│   └── sessions/
│
├── tools/                                       ← Feature: Tools
│   ├── STATE.md
│   ├── CLAUDE.md
│   ├── implementation/
│   └── sessions/
│
├── ui/                                          ← Feature: UI
│   ├── STATE.md
│   ├── CLAUDE.md
│   ├── scroll-behavior/                         ← Subfolder (no CLAUDE.md)
│   ├── components/
│   └── sessions/
│
├── IMPORTANT/                                   ← Critical patterns
│   ├── CLAUDE.md                                ← ✅ Critical reference index
│   ├── GUIDES/                                  ← How-to guides
│   ├── MISTAKES/                                ← Documented errors
│   ├── LEARNINGS/                               ← Project-specific learnings
│   └── ANTI-PATTERNS/                           ← Known bad practices
│
└── meta/                                        ← Meta documentation
    └── documentation-reorganization_19_04_2026_14_00/
        ├── DOCUMENTATION-SYSTEM.md              ← This file
        └── ...
```

**File counts in ideal state:**
- CLAUDE.md files: ~15 (1 root + 11 features + 3 critical)
- STATE.md files: 12 (1 PROJECT + 11 features)
- Session folders: Unlimited (grows over time)

---

### Decision Matrix: Do I Need a CLAUDE.md Here?

| Question | Answer | Action |
|----------|--------|--------|
| Is this a major feature root? | Yes | ✅ Create CLAUDE.md |
| Is this a subfolder of a feature? | Yes | ❌ Document in parent CLAUDE.md |
| Is this a session folder? | Yes | ❌ Use summary.md instead |
| Is this < 10 files total? | Yes | ❌ Document in related feature |
| Does it have unique architecture? | Yes | ✅ Maybe (if complex subsystem) |
| Is the parent CLAUDE.md > 500 lines? | Yes | ✅ Consider splitting |
| Does it duplicate parent info? | Yes | ❌ Delete, keep parent only |

---

### Decision Matrix: Do I Need a STATE.md Here?

| Question | Answer | Action |
|----------|--------|--------|
| Is this a major feature root? | Yes | ✅ Create STATE.md |
| Is this PROJECT-STATE.md? | Yes | ✅ Entry point |
| Is this a subfolder? | Yes | ❌ Use parent STATE.md |
| Is this a session folder? | Yes | ❌ Sessions track history, not state |
| Does state change weekly/monthly? | No | ❌ Use CLAUDE.md instead |
| Is this in the 11 feature list? | Yes | ✅ Create STATE.md |

**The 11 feature list:**
auth, chat, database, debugging, deployment, i18n, knowledge-base, organizations, realtime, tools, ui

---

### Audit Script (Future)

**Check for incorrectly placed files:**

```bash
# Find CLAUDE.md in session folders (should be 0)
find docs -path "*/sessions/*/CLAUDE.md"

# Find CLAUDE.md in implementation folders (should be 0)
find docs -path "*/implementation/*/CLAUDE.md"

# Count all CLAUDE.md files (target: ~15)
find . -name "CLAUDE.md" | wc -l

# Find STATE.md files (target: 12)
find docs -name "STATE.md"
```

---

**Last Updated:** 26/04/2026 (Updated PROJECT-STATE.md location to root level)
