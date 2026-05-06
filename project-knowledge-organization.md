# Project-Specific Knowledge Organization

**Question**: Where should project-specific knowledge go?

**Answer**: Choose ONE of two patterns based on project scale.

---

## Two Valid Patterns

ABDS supports **two mutually exclusive** patterns for organizing project-specific knowledge:

### Pattern 1: `.abds/learnings/` (Domain-Heavy Projects)

**Use when:**
- 10+ project-specific learnings
- Domain knowledge with categories (database, integration, infrastructure)
- Project has significant domain complexity (medical, financial, legal)
- Want same structure as global `~/.abds/learnings/`

**Structure:**
```
.abds/
├── docs/
│   ├── PROJECT-STATE.md
│   └── {feature}/
│       ├── STATE.md
│       └── CLAUDE.md
└── learnings/                  # ← Project-specific domain knowledge
    ├── CATALOG.md              # Auto-generated
    ├── database/               # Domain category
    ├── integration/            # Domain category
    ├── infrastructure/         # Domain category
    └── workflows/              # Domain category
```

**Example: Medical software (tomedo)**
- `learnings/database/` - Tomedo schema patterns (kartendaten, karteieintrag)
- `learnings/integration/` - LDT, HL7, Mirth patterns
- `learnings/infrastructure/` - Server management, launchd patterns

**Benefits:**
- Organized by technical domain
- Scales well (20+ files)
- Mirrors global learnings structure
- Supports CATALOG.md generation

---

### Pattern 2: `.abds/docs/IMPORTANT/` (Simpler Projects)

**Use when:**
- < 10 project-specific items
- Mix of guides, mistakes, learnings
- Want everything in docs/ folder
- Project complexity is moderate

**Structure:**
```
.abds/
└── docs/
    ├── PROJECT-STATE.md
    ├── {feature}/
    │   ├── STATE.md
    │   └── CLAUDE.md
    └── IMPORTANT/              # ← All project knowledge here
        ├── CLAUDE.md           # Index
        ├── GUIDES/             # How-to guides
        ├── MISTAKES/           # Documented errors
        ├── LEARNINGS/          # Lessons learned
        └── ANTI-PATTERNS/      # Bad patterns to avoid
```

**Example: Tauri + Swift app (aqua-voice)**
- `IMPORTANT/GUIDES/` - Tauri Swift FFI debugging guide
- `IMPORTANT/MISTAKES/` - Build cache mistake (cost 2 hours)
- `IMPORTANT/LEARNINGS/` - Lessons from previous projects

**Benefits:**
- Everything in docs/ folder
- Organized by type (guides, mistakes, learnings)
- Good for smaller knowledge bases
- Simpler structure

---

## Decision Matrix

| Project Type | Size | Domain Complexity | Use |
|--------------|------|-------------------|-----|
| **Medical software** | 20+ files | High (Tomedo schema, LDT, HL7) | `.abds/learnings/` |
| **Financial software** | 15+ files | High (trading, regulations) | `.abds/learnings/` |
| **Standard web app** | 5 files | Low (React, PostgreSQL) | `.abds/docs/IMPORTANT/` |
| **Tauri desktop app** | 8 files | Medium (FFI, CoreML) | `.abds/docs/IMPORTANT/` |
| **Simple API** | 3 files | Low | `.abds/docs/IMPORTANT/` or skip |

---

## They Are Mutually Exclusive

**Don't use both!**

```
❌ WRONG - Don't create both:
.abds/
├── docs/IMPORTANT/LEARNINGS/    # Project learnings
└── learnings/                    # Project learnings
    ├── database/                 # Duplicate purpose!
```

```
✅ CORRECT - Pick one:
.abds/
└── learnings/                    # All project knowledge
    ├── database/
    ├── integration/
    └── infrastructure/
```

**OR**

```
✅ CORRECT - Pick one:
.abds/
└── docs/
    └── IMPORTANT/                # All project knowledge
        ├── GUIDES/
        ├── MISTAKES/
        └── LEARNINGS/
```

---

## What About Global Learnings?

**Global `~/.abds/learnings/`** is for **cross-project** knowledge:
- General programming patterns (React hooks, Git workflows)
- Database techniques (RLS patterns, migration strategies)
- UI patterns (scroll preservation, loading states)
- Debugging approaches (systematic debugging)

**Project-specific** means:
- Only applies to THIS project
- Tied to this domain (medical, financial)
- References this specific codebase
- Wouldn't be useful in other projects

---

## Migration Guide

### If You Currently Have Both

**Step 1: Identify what's truly project-specific**
```bash
# Check what's in each location
find .abds/docs/IMPORTANT -name "*.md"
find .abds/learnings -name "*.md"
```

**Step 2: Decide which pattern fits better**
- Large (10+ files) + domain categories? → Consolidate to `.abds/learnings/`
- Small (< 10 files) + mixed types? → Consolidate to `.abds/docs/IMPORTANT/`

**Step 3: Move files to chosen location**
```bash
# Option A: Consolidate to learnings/
mv .abds/docs/IMPORTANT/LEARNINGS/* .abds/learnings/domain/
rmdir .abds/docs/IMPORTANT

# Option B: Consolidate to IMPORTANT/
mv .abds/learnings/database/* .abds/docs/IMPORTANT/LEARNINGS/
rmdir .abds/learnings
```

**Step 4: Update CATALOG.md if using learnings/**
```bash
~/.abds/bin/update-catalog
```

---

## Real Examples

### tomedo (Medical Software)

**Pattern**: `.abds/learnings/` ✅

**Why:**
- 20+ learnings files
- Domain categories: database, integration, infrastructure
- Medical domain expertise (Tomedo schema, LDT imports)
- Mirrors global learnings structure

**Structure:**
```
tomedo/.abds/
└── learnings/
    ├── CATALOG.md
    ├── database/              # 13 Tomedo schema patterns
    ├── integration/           # LDT, HL7, Mirth
    ├── infrastructure/        # macOS server management
    └── workflows/
```

---

### aqua-voice (Tauri + Swift Desktop App)

**Pattern**: `.abds/docs/IMPORTANT/` ✅

**Why:**
- 5 critical files
- Mix of guides, mistakes, learnings
- Smaller knowledge base
- Everything in docs/ folder

**Structure:**
```
aqua-voice/.abds/
└── docs/
    └── IMPORTANT/
        ├── CLAUDE.md
        ├── GUIDES/
        │   ├── TAURI-SWIFT-FFI-DEBUGGING_27_04_2026.md
        │   └── TAURI-SWIFT-FFI-PRODUCTION-BUILD.md
        ├── MISTAKES/
        │   └── TAURI-SWIFT-BUILD-CACHE-MISTAKE_27_04_2026.md
        └── LEARNINGS/
            └── LESSONS-FROM-PREVIOUS-PROJECTS.md
```

---

## Summary

**Two patterns, choose one:**

1. **`.abds/learnings/`** - Domain-heavy, 10+ files, categorized by domain
2. **`.abds/docs/IMPORTANT/`** - Simpler, < 10 files, categorized by type

**Don't mix them** - they serve the same purpose at different scales.

**Global `~/.abds/learnings/`** is for cross-project knowledge only.

---

**This should be added to ABDS specification section 2.3.**
