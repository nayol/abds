# ABDS System Updated - Hybrid Organization

**Date**: 2026-05-06
**Version**: ABDS 1.0 (Hybrid)

---

## What Changed

### ✅ Specification Updated

**File**: `ABDS-1.0.md`

**Changes**:
- Section 2.3: Now defines hybrid learnings structure
- Added FAQ about when to use special vs domain categories
- Removed sessions/ subfolder (not used in practice)

**New structure**:
```
.abds/learnings/
├── CATALOG.md
├── mistakes/              ← SPECIAL (cross-domain)
├── workflows/             ← SPECIAL (processes)
├── troubleshooting/       ← SPECIAL (debugging)
├── database/              ← DOMAIN
├── ui/                    ← DOMAIN
└── {custom-domain}/       ← DOMAIN
```

---

### ✅ Tools Updated

**`bin/init-abds`**:
- Now creates `mistakes/`, `workflows/`, `troubleshooting/` automatically
- Creates basic CATALOG.md with hybrid organization
- Shows hint to add domain categories

**Creates**:
```
project/.abds/
├── docs/
│   ├── PROJECT-STATE.md
│   └── README.md
├── learnings/
│   ├── CATALOG.md
│   ├── mistakes/
│   ├── workflows/
│   └── troubleshooting/
└── plans/
```

---

### ✅ Global Setup Script

**`setup-global-abds.sh`**:
- Creates hybrid structure for `~/.abds/learnings/`
- Both special categories (mistakes/, workflows/, troubleshooting/)
- AND domain categories (database/, ui/, security/, testing/, deployment/, performance/)

---

## How to Use

### For New Projects

```bash
cd my-project
~/.abds/bin/init-abds

# Creates:
# .abds/learnings/mistakes/          (for costly errors)
# .abds/learnings/workflows/         (for processes)
# .abds/learnings/troubleshooting/   (for debugging)

# Add domain categories as needed:
mkdir -p .abds/learnings/database
mkdir -p .abds/learnings/ui
mkdir -p .abds/learnings/react-native
```

### For Global Learnings

```bash
# Run setup (if not done yet)
./setup-global-abds.sh

# Creates:
# ~/.abds/learnings/mistakes/          (special)
# ~/.abds/learnings/workflows/         (special)
# ~/.abds/learnings/troubleshooting/   (special)
# ~/.abds/learnings/database/          (domain)
# ~/.abds/learnings/ui/                (domain)
# ~/.abds/learnings/security/          (domain)
# etc.
```

---

## When to Use Each Category

### Special Categories (Top-Level)

**mistakes/**
- Cost 2+ hours of debugging
- Want to check before similar work
- Example: `tauri-swift-build-cache.md`

**workflows/**
- Repeatable processes
- Checklists
- Example: `deployment-checklist.md`

**troubleshooting/**
- Cross-domain debugging guides
- Problem-solving patterns
- Example: `performance-profiling-guide.md`

### Domain Categories

**database/**
- PostgreSQL-specific
- RLS patterns
- Migration strategies

**ui/**
- React patterns
- Scroll behavior
- Component design

**tauri-swift-ffi/** (project-specific domain)
- Tauri + Swift integration
- CoreML patterns
- FFI debugging

---

## Migration Path

### Existing Projects

If you have `.abds/learnings/` with only domain folders:

```bash
# Add special categories
mkdir -p .abds/learnings/{mistakes,workflows,troubleshooting}

# Move files if appropriate
# Example: costly error → mistakes/
mv .abds/learnings/database/expensive-mistake.md \
   .abds/learnings/mistakes/

# Regenerate catalog
~/.abds/bin/update-catalog
```

### If Using IMPORTANT/ (deprecated)

Already migrated aqua-voice:
- IMPORTANT/GUIDES/ → learnings/tauri-swift-ffi/
- IMPORTANT/MISTAKES/ → learnings/mistakes/
- IMPORTANT/LEARNINGS/ → learnings/tauri-swift-ffi/

---

## Real Examples

### tomedo (Already Using Hybrid!)

```
tomedo/.abds/learnings/
├── troubleshooting/     ← SPECIAL
├── workflows/           ← SPECIAL
├── database/            ← DOMAIN (Tomedo schema)
├── integration/         ← DOMAIN (LDT, HL7)
└── infrastructure/      ← DOMAIN (server mgmt)
```

### aqua-voice (After Migration)

```
aqua-voice/.abds/learnings/
├── mistakes/                           ← SPECIAL
│   └── tauri-swift-build-cache.md
├── workflows/                          ← SPECIAL (empty)
├── troubleshooting/                    ← SPECIAL (empty)
└── tauri-swift-ffi/                   ← DOMAIN
    ├── debugging-guide.md
    ├── production-build-guide.md
    └── lessons-learned.md
```

---

## Benefits

✅ **Flexibility**: Use special OR domain categories as needed
✅ **Discoverability**: "Show me all mistakes" works across all domains
✅ **Proven**: tomedo already uses this pattern successfully
✅ **Consistent**: Same structure local and global
✅ **Scalable**: Add categories as needed

---

## Next Steps

1. ✅ Spec updated (ABDS-1.0.md)
2. ✅ Tools updated (init-abds, setup-global-abds.sh)
3. ⏳ Reorganize aqua-voice to hybrid structure
4. ⏳ Run setup-global-abds.sh to create ~/.abds/ hybrid structure

---

**ABDS now supports hybrid organization! 🎉**
