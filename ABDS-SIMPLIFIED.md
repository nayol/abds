# ABDS Simplified Structure (2026-05-06)

## The Single System for Learnings

**Rule**: ALL learnings use the same structure, different scope:

```
Global (cross-project):          Local (project-specific):
~/.abds/learnings/              my-project/.abds/learnings/
├── CATALOG.md                  ├── CATALOG.md
├── database/                   ├── database/
├── ui/                         ├── guides/
├── debugging/                  ├── mistakes/
└── security/                   └── integration/
```

---

## Complete ABDS Structure

### Minimum (Level 1 ⭐)

```
.abds/
└── docs/
    ├── PROJECT-STATE.md        # REQUIRED
    └── feature/
        └── STATE.md            # REQUIRED
```

### Standard (Level 2 ⭐⭐)

```
.abds/
└── docs/
    ├── PROJECT-STATE.md
    └── feature/
        ├── STATE.md
        ├── CLAUDE.md           # Architecture
        └── sessions/           # Work history
```

### Full (Level 3 ⭐⭐⭐)

```
.abds/
├── docs/
│   ├── PROJECT-STATE.md
│   └── feature/
│       ├── STATE.md
│       ├── CLAUDE.md
│       └── sessions/
├── learnings/                  # Project-specific knowledge
│   ├── CATALOG.md
│   └── {category}/
├── plans/                      # Implementation plans
└── bin/                        # ABDS tools (optional)
```

---

## What Goes Where

| Type | Local `.abds/` | Global `~/.abds/` |
|------|----------------|-------------------|
| **Current state** | `docs/PROJECT-STATE.md` | N/A |
| **Feature state** | `docs/feature/STATE.md` | N/A |
| **Architecture** | `docs/feature/CLAUDE.md` | N/A |
| **Work history** | `docs/feature/sessions/` | N/A |
| **Project learnings** | `learnings/{category}/` | N/A |
| **Cross-project learnings** | N/A | `learnings/{category}/` |
| **Implementation plans** | `plans/` (optional) | `plans/` (optional) |
| **Tools** | `bin/` (optional copy) | `bin/` (reference impl) |

---

## Categories for Learnings

**Organize by domain/type**, not by IMPORTANT/GUIDES/MISTAKES structure:

### Technical Categories
- `database/` - Database patterns, RLS, migrations
- `ui/` - UI patterns, components, animations
- `debugging/` - Debugging patterns, troubleshooting
- `security/` - Security patterns, vulnerabilities
- `testing/` - Test patterns, TDD workflows
- `deployment/` - CI/CD, releases, infrastructure

### Knowledge Types (as categories)
- `guides/` - How-to guides
- `mistakes/` - Documented errors
- `troubleshooting/` - Problem-solving patterns
- `workflows/` - Process documentation

**Choose what makes sense for your project.**

---

## Examples

### Medical Software (tomedo)

```
tomedo/.abds/
├── docs/
│   └── PROJECT-STATE.md
└── learnings/                  # 20+ files
    ├── CATALOG.md
    ├── database/               # Tomedo schema (kartendaten, etc.)
    ├── integration/            # LDT, HL7, Mirth
    ├── infrastructure/         # macOS server management
    └── workflows/
```

### Desktop App (aqua-voice) - After Migration

```
aqua-voice/.abds/
├── docs/
│   ├── PROJECT-STATE.md
│   └── poc/
│       ├── STATE.md
│       └── sessions/
└── learnings/                  # 5-10 files
    ├── CATALOG.md
    ├── guides/                 # Tauri Swift FFI debugging
    ├── mistakes/               # Build cache mistake
    └── swift-ffi/              # CoreML patterns
```

---

## Migration from IMPORTANT/

If you have `.abds/docs/IMPORTANT/`:

```bash
# Create learnings structure
mkdir -p .abds/learnings

# Move content to appropriate categories
mv .abds/docs/IMPORTANT/GUIDES/* .abds/learnings/guides/
mv .abds/docs/IMPORTANT/MISTAKES/* .abds/learnings/mistakes/
mv .abds/docs/IMPORTANT/LEARNINGS/* .abds/learnings/domain/

# Generate catalog
~/.abds/bin/update-catalog

# Remove IMPORTANT/
rm -rf .abds/docs/IMPORTANT
```

---

## Benefits of Single System

1. **Simpler**: One location for all knowledge
2. **Consistent**: Same structure local and global
3. **Scalable**: Add categories as needed
4. **Tool-friendly**: Same catalog generation everywhere
5. **Clear separation**: docs/ = current, learnings/ = knowledge

---

## Summary

**Docs** = Current state and work history
- PROJECT-STATE.md
- feature/STATE.md
- feature/CLAUDE.md
- feature/sessions/

**Learnings** = Accumulated knowledge
- Project-specific: `.abds/learnings/`
- Cross-project: `~/.abds/learnings/`

**Both use**: CATALOG.md + category organization

---

**No more IMPORTANT/ folder - everything in learnings/**
