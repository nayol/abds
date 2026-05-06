# ABDS - Simplified (May 2026)

## The One System Rule

**All learnings use the same structure. Only the scope differs.**

```
Global (cross-project):          Local (project-specific):
~/.abds/learnings/              my-project/.abds/learnings/
├── CATALOG.md                  ├── CATALOG.md
├── database/                   ├── database/
├── ui/                         ├── guides/
└── debugging/                  └── mistakes/
```

---

## Complete ABDS Structure

### Minimum Required (Level 1 ⭐)

```bash
my-project/.abds/
└── docs/
    ├── PROJECT-STATE.md     # REQUIRED
    └── feature/
        └── STATE.md         # REQUIRED
```

**That's it!** Just 2 markdown files for ABDS compliance.

### Full Structure (Level 3 ⭐⭐⭐)

```bash
my-project/.abds/
├── docs/
│   ├── PROJECT-STATE.md          # Current state
│   └── feature/
│       ├── STATE.md              # Feature state
│       ├── CLAUDE.md             # Architecture
│       └── sessions/             # Work history
├── learnings/                    # Project knowledge (optional)
│   ├── CATALOG.md
│   ├── database/                # Domain patterns
│   ├── guides/                  # How-to guides
│   └── mistakes/                # Documented errors
└── plans/                        # Implementation plans (optional)
```

---

## What Goes Where

| Content | Location |
|---------|----------|
| **Current project state** | `.abds/docs/PROJECT-STATE.md` |
| **Feature current state** | `.abds/docs/feature/STATE.md` |
| **Architecture & why** | `.abds/docs/feature/CLAUDE.md` |
| **Work history** | `.abds/docs/feature/sessions/` |
| **Project-specific learnings** | `.abds/learnings/` |
| **Cross-project learnings** | `~/.abds/learnings/` |

---

## Key Principles

1. **docs/** = Current state and work history
2. **learnings/** = Accumulated knowledge
3. **Same structure** for global and local learnings
4. **No IMPORTANT/ folder** - use learnings/ instead

---

## Real Examples

### tomedo (Medical Software)

```
tomedo/.abds/
├── docs/
│   └── PROJECT-STATE.md
└── learnings/                    # 20+ files
    ├── CATALOG.md
    ├── database/                 # Tomedo schema patterns
    ├── integration/              # LDT, HL7, Mirth
    └── infrastructure/           # Server management
```

### aqua-voice (Desktop App)

```
aqua-voice/.abds/
├── docs/
│   ├── PROJECT-STATE.md
│   └── poc/
│       ├── STATE.md
│       └── sessions/
└── learnings/                    # 5-10 files
    ├── CATALOG.md
    ├── guides/                   # Tauri Swift FFI debugging
    ├── mistakes/                 # Build cache mistake
    └── swift-ffi/                # CoreML patterns
```

---

## Benefits

✅ **Simpler**: One location for all knowledge
✅ **Consistent**: Same structure everywhere
✅ **Scalable**: Add categories as needed
✅ **Tool-friendly**: Same catalog generation
✅ **Clear**: docs/ vs learnings/ separation

---

## Quick Start

```bash
# 1. Create global ABDS
~/.abds/bin/install-abds-global.sh

# 2. Create project structure
cd my-project
mkdir -p .abds/docs
cat > .abds/docs/PROJECT-STATE.md << 'EOF'
# Project State
## Current Focus
- Working on...
EOF

# 3. Add learnings when needed
mkdir -p .abds/learnings
~/.abds/bin/update-catalog

# Done! ✅ ABDS compliant
```

---

**See ABDS-SIMPLIFIED.md for complete details**
