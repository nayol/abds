# Final ABDS Structure (With Anti-Patterns)

**Version**: ABDS 1.0 (Hybrid Organization)
**Date**: 2026-05-06

---

## Complete Learnings Structure

### Special Categories (4 types - cross-domain, high-priority)

```
.abds/learnings/
├── mistakes/              # Costly errors (2+ hours debugging)
├── anti-patterns/         # Known bad practices to avoid
├── workflows/             # Repeatable processes
└── troubleshooting/       # Debugging guides
```

**Why special categories?**
- Want to see ALL of them across all domains
- Check before similar work
- High priority - deserve visibility

---

## When to Use Each Special Category

### 1. mistakes/
**Costly errors that happened**

**Use when:**
- Cost 2+ hours of debugging time
- Easy to repeat
- Clear fix documented

**Examples:**
- `tauri-swift-build-cache.md` - Build cache causing stale code (2h lost)
- `rls-parameter-trust.md` - Security vulnerability (6h to find)
- `infinite-render-loop.md` - React state mutation (3h debugging)

**Format:**
```markdown
---
keywords: [tauri, swift, build, cache]
category: mistakes
confidence: verified
tldr: "Always cargo clean - Tauri caches dylibs even on failed compilation"
---

# Tauri Swift Build Cache Mistake

**Date**: 2026-04-27
**Time Lost**: 2 hours
**Severity**: High

## What Happened
[Description]

## Root Cause
[Why it happened]

## Fix
[How to prevent]
```

---

### 2. anti-patterns/
**Known bad practices to avoid**

**Use when:**
- Pattern looks reasonable but causes problems
- Seen multiple times in codebase
- Need to warn future developers

**Examples:**
- `god-objects.md` - Classes with too many responsibilities
- `premature-optimization.md` - Optimizing before profiling
- `magic-numbers.md` - Hardcoded values without constants
- `deep-nesting.md` - Callbacks 5+ levels deep

**Format:**
```markdown
---
keywords: [react, context, nesting, performance]
category: anti-patterns
confidence: verified
tldr: "Don't nest 5+ Context.Providers - causes render performance issues"
---

# Deep Context Provider Nesting

**Severity**: Medium
**Seen in**: [Files/components]

## The Bad Pattern
[Code example showing anti-pattern]

## Why It's Bad
[Specific problems this causes]

## The Right Pattern
[Code showing correct approach]

## How to Detect
[Linting rules, code review checks]
```

---

### 3. workflows/
**Repeatable processes**

**Use when:**
- Multi-step process
- Repeatable across features
- Checklist format

**Examples:**
- `deployment-checklist.md` - Steps to deploy
- `feature-implementation.md` - TDD workflow
- `code-review-process.md` - Review checklist
- `git-workflow.md` - Branch/merge strategy

**Format:**
```markdown
---
keywords: [deployment, checklist, production]
category: workflows
confidence: verified
tldr: "20-step deployment checklist with verification points"
---

# Production Deployment Workflow

**Time**: ~30 minutes
**Frequency**: Weekly

## Prerequisites
- [ ] All tests passing
- [ ] Code review approved

## Steps
1. Run full test suite
2. Build production bundle
3. ...

## Verification
- [ ] App loads
- [ ] Core features work
```

---

### 4. troubleshooting/
**Debugging guides**

**Use when:**
- Cross-domain debugging process
- Problem-solving methodology
- Not domain-specific

**Examples:**
- `performance-profiling.md` - How to find bottlenecks
- `memory-leak-detection.md` - Debug memory issues
- `network-debugging.md` - Debug API calls
- `systematic-debugging.md` - General debugging method

**Format:**
```markdown
---
keywords: [performance, profiling, debugging, chrome-devtools]
category: troubleshooting
confidence: verified
tldr: "Step-by-step performance profiling with Chrome DevTools"
---

# Performance Profiling Guide

**Applies to**: Any web application
**Tools**: Chrome DevTools

## Steps
1. Open Performance tab
2. Record interaction
3. Analyze flame graph
4. ...

## Common Issues
- Long tasks
- Layout thrashing
- ...
```

---

## Domain Categories

### When to Use Domain Folders

**Use for technology/feature-specific knowledge**:

```
.abds/learnings/
├── database/              # PostgreSQL, RLS, migrations
├── ui/                    # React, animations, scroll
├── security/              # Auth, vulnerabilities
├── tauri-swift-ffi/       # Tauri + Swift (project-specific)
└── coreml/                # CoreML integration (project-specific)
```

**Examples:**
- `database/rls-patterns.md` - RLS implementation patterns
- `ui/scroll-preservation.md` - Preserve scroll on navigation
- `security/auth-flow.md` - OAuth implementation details

---

## Decision Tree

```
Is this knowledge...

├─ A costly mistake? → mistakes/
├─ A bad practice to avoid? → anti-patterns/
├─ A repeatable process? → workflows/
├─ A debugging guide? → troubleshooting/
└─ Technology-specific knowledge? → {domain}/
```

---

## Complete Example Structure

### Global ~/.abds/learnings/

```
~/.abds/learnings/
├── CATALOG.md
│
├── mistakes/
│   ├── rls-parameter-trust-vulnerability.md
│   ├── infinite-render-loop-state-mutation.md
│   └── docker-cache-stale-build.md
│
├── anti-patterns/
│   ├── god-objects.md
│   ├── premature-optimization.md
│   └── deep-nesting.md
│
├── workflows/
│   ├── deployment-checklist.md
│   ├── feature-tdd-workflow.md
│   └── git-workflow.md
│
├── troubleshooting/
│   ├── performance-profiling-guide.md
│   ├── memory-leak-detection.md
│   └── systematic-debugging-method.md
│
├── database/
│   ├── rls-patterns.md
│   ├── migration-strategies.md
│   └── query-optimization.md
│
├── ui/
│   ├── scroll-preservation.md
│   ├── animation-patterns.md
│   └── responsive-design.md
│
└── security/
    ├── oauth-implementation.md
    ├── csrf-protection.md
    └── input-validation.md
```

### Project-Specific (aqua-voice)

```
aqua-voice/.abds/learnings/
├── CATALOG.md
│
├── mistakes/
│   └── tauri-swift-build-cache.md
│
├── anti-patterns/
│   └── (empty - add as discovered)
│
├── workflows/
│   └── (empty - add as needed)
│
├── troubleshooting/
│   └── (empty - add as needed)
│
└── tauri-swift-ffi/
    ├── debugging-guide.md
    ├── production-build-guide.md
    ├── coreml-integration.md
    └── lessons-learned.md
```

---

## Benefits of 4 Special Categories

1. **mistakes/** - Learn from errors
2. **anti-patterns/** - Avoid bad practices
3. **workflows/** - Standardize processes
4. **troubleshooting/** - Systematic problem-solving

All cross-domain, all high-priority, all easily discoverable.

---

## Tools Updated

### init-abds
Creates all 4 special categories automatically:
```bash
~/.abds/bin/init-abds
# Creates: mistakes/, anti-patterns/, workflows/, troubleshooting/
```

### setup-global-abds.sh
Sets up global learnings with all categories:
```bash
./setup-global-abds.sh
# Creates both special and domain categories
```

---

**Ready to use! 🎉**
