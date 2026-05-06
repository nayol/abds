# ABDS Learnings - Hybrid Organization

## The Rule: Mix Domain + Special Categories

**Domain-based** for most content + **Special top-level** for high-value cross-cutting content.

---

## Structure

```
.abds/learnings/
├── CATALOG.md
│
├── mistakes/              ← SPECIAL: Costly errors
├── anti-patterns/         ← SPECIAL: Bad practices to avoid
├── workflows/             ← SPECIAL: Process documentation
├── troubleshooting/       ← SPECIAL: Debugging guides
│
├── database/              ← DOMAIN: Database patterns
├── ui/                    ← DOMAIN: UI patterns
├── tauri-swift-ffi/       ← DOMAIN: Tauri + Swift
└── integration/           ← DOMAIN: Integration patterns
```

---

## When to Use Special Top-Level Folders

### mistakes/ - Costly Errors
**Use when:**
- Cost 2+ hours of debugging time
- Easy to repeat
- Critical to avoid

**Examples:**
- `mistakes/tauri-swift-build-cache-mistake.md`
- `mistakes/rls-parameter-trust-vulnerability.md`
- `mistakes/infinite-render-loop.md`

**Why top-level?**
- Want to see ALL mistakes across all domains
- Check before similar work: "Any mistakes about build caching?"
- High priority - deserve visibility

---

### workflows/ - Process Documentation
**Use when:**
- Repeatable process across projects
- Step-by-step procedures
- Best practices

**Examples:**
- `workflows/git-workflow.md`
- `workflows/deployment-checklist.md`
- `workflows/code-review-process.md`

**Why top-level?**
- Cross-domain (applies everywhere)
- Process-oriented (not technical domain)

---

### troubleshooting/ - Debugging Guides
**Use when:**
- Common debugging scenarios
- Cross-domain troubleshooting

**Examples:**
- `troubleshooting/performance-profiling.md`
- `troubleshooting/memory-leak-detection.md`

**Why top-level?**
- Debugging applies across domains
- Problem-solving patterns

---

## When to Use Domain Folders

**Use for:**
- Technical patterns specific to that domain
- How-to guides for that technology
- Architecture decisions

**Examples:**
```
database/
├── rls-patterns.md
├── migration-strategies.md
└── query-optimization.md

tauri-swift-ffi/
├── ffi-debugging-guide.md
├── coreml-integration.md
└── build-configuration.md
```

---

## Real Example: aqua-voice

### Current (Domain-only)
```
.abds/learnings/
└── tauri-swift-ffi/
    ├── tauri-swift-build-cache-mistake.md    ← Buried
    ├── tauri-swift-ffi-debugging-guide.md
    └── lessons-from-previous-projects.md
```

**Problem**: Have to remember mistake is in tauri-swift-ffi/ folder.

### Proposed (Hybrid)
```
.abds/learnings/
├── CATALOG.md
├── mistakes/                                  ← VISIBLE
│   └── tauri-swift-build-cache.md            ← Easy to find
├── workflows/
│   └── tauri-project-setup.md
└── tauri-swift-ffi/                          ← DOMAIN
    ├── ffi-debugging-guide.md
    ├── coreml-integration.md
    └── build-configuration.md
```

**Benefit**: "Show me all mistakes" → instantly visible.

---

## Real Example: tomedo

**Already uses hybrid!**

```
tomedo/.abds/learnings/
├── troubleshooting/       ← SPECIAL (cross-domain)
├── workflows/             ← SPECIAL (process)
├── database/              ← DOMAIN (Tomedo schema)
├── integration/           ← DOMAIN (LDT, HL7)
└── infrastructure/        ← DOMAIN (server management)
```

**It works!** tomedo already proved this pattern.

---

## Guidelines

### Use Special Top-Level When:
- ✅ Cross-domain (applies to multiple areas)
- ✅ High priority (mistakes, critical workflows)
- ✅ Problem-solving (troubleshooting, debugging)
- ✅ You want to see ALL of them at once

### Use Domain Folder When:
- ✅ Technology-specific (PostgreSQL, React, Tauri)
- ✅ Feature-specific (authentication, payments)
- ✅ Self-contained topic

---

## Migration: aqua-voice

Let's reorganize with hybrid approach:

```bash
.abds/learnings/
├── CATALOG.md
├── mistakes/
│   └── tauri-swift-build-cache.md           ← Moved from domain
├── workflows/
│   └── (empty - add as needed)
└── tauri-swift-ffi/
    ├── debugging-guide.md
    ├── production-build-guide.md
    ├── coreml-integration.md
    └── lessons-learned.md
```

---

## Benefits of Hybrid

1. **Mistakes visible** - Don't hide costly errors in domain folders
2. **Flexible** - Use domain OR special category as appropriate
3. **Proven** - tomedo already uses this successfully
4. **Intuitive** - "Show me mistakes" vs "Show me database patterns"

---

## Summary

**Two types of organization**:

1. **Special categories** (top-level):
   - mistakes/
   - workflows/
   - troubleshooting/

2. **Domain categories**:
   - database/
   - ui/
   - tauri-swift-ffi/
   - integration/

**Use both as appropriate. No strict rule - use what helps you find things.**

---

**Want me to reorganize aqua-voice with hybrid approach?**
