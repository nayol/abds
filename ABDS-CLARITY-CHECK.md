# ABDS Structure - Clarity Check

## The Question: Does having learnings in two places make sense?

```
~/.abds/learnings/              # Global
my-project/.abds/learnings/     # Local
```

---

## Real-World Test: Your Projects

### tomedo (Medical Software)

**Local learnings** (`.abds/learnings/`):
- `database/kartendaten-active-card-update-pattern.md` - **Tomedo-specific schema**
- `integration/ldt-import-troubleshooting.md` - **Medical software (LDT) only**
- `database/patient-karteieintrag-relationship-chain.md` - **Tomedo schema only**

**Would these help other projects?** NO - they're Tomedo-specific.

---

### aqua-voice (Tauri Desktop App)

**Local learnings** (`.abds/learnings/`):
- `guides/tauri-swift-ffi-debugging.md` - **Tauri + Swift FFI only**
- `mistakes/tauri-swift-build-cache-mistake.md` - **Tauri + Swift combo only**

**Would these help other projects?** NO - unless they also use Tauri + Swift.

---

### What SHOULD Go in Global?

**Global learnings** (`~/.abds/learnings/`):
- `ui/react-scroll-preservation-pattern.md` - **Works in ANY React project**
- `database/rls-parameter-trust.md` - **Works with ANY PostgreSQL project**
- `debugging/systematic-debugging-method.md` - **Works in ANY project**

**Would these help multiple projects?** YES - that's why they're global.

---

## The Distinction

| Type | Global `~/.abds/` | Local `project/.abds/` |
|------|-------------------|------------------------|
| **React scroll pattern** | ✅ YES (any React app) | ❌ NO |
| **PostgreSQL RLS pattern** | ✅ YES (any Postgres app) | ❌ NO |
| **Tomedo schema patterns** | ❌ NO | ✅ YES (tomedo only) |
| **Tauri Swift FFI debugging** | ❌ NO | ✅ YES (aqua-voice only) |
| **LDT import troubleshooting** | ❌ NO | ✅ YES (tomedo only) |

---

## Alternative: What if NO Local Learnings?

**Problem**: Where would Tomedo schema knowledge go?

```
❌ Option 1: Put in global ~/.abds/learnings/
Problem: Pollutes global catalog with Tomedo-specific stuff
Search for "database patterns" → gets Tomedo kartendaten (useless for other projects)

❌ Option 2: Put in docs/IMPORTANT/
Problem: Back to the old system we just simplified

✅ Option 3: Use .abds/learnings/ locally
Solution: Project-specific domain knowledge stays with project
```

---

## The Mental Model

Think of it like code modules:

```javascript
// Global library (reusable everywhere)
~/.abds/learnings/ui/scroll-pattern.md

// Project-specific module (only for this app)
tomedo/.abds/learnings/database/kartendaten-pattern.md
```

You wouldn't put Tomedo-specific code in a global npm package. Same concept here.

---

## Simpler Explanation

**Two types of knowledge:**

1. **General knowledge** (like "how to ride a bike")
   - Location: `~/.abds/learnings/`
   - Applies everywhere

2. **Domain knowledge** (like "how to operate THIS specific medical device")
   - Location: `project/.abds/learnings/`
   - Only applies to this project

---

## Does This Make Sense Now?

**If YES**: Structure is clear, use both as needed

**If NO**: Tell me what's confusing:
- Is the distinction unclear?
- Is it too complex?
- Would you prefer a different approach?

---

## Alternative: Single Location Only

**If you prefer**, we could eliminate local learnings entirely:

```
Only use: ~/.abds/learnings/

Organize by project:
~/.abds/learnings/
├── general/           # Cross-project
│   ├── react/
│   └── postgresql/
└── projects/          # Project-specific
    ├── tomedo/
    │   ├── database/
    │   └── integration/
    └── aqua-voice/
        └── tauri-swift/
```

**Pros**: One location for everything
**Cons**: Mixes general and project-specific knowledge

---

## My Recommendation

**Keep the two-location system** because:

1. ✅ Clean separation (general vs project-specific)
2. ✅ Project knowledge stays with project
3. ✅ Global search only finds relevant patterns
4. ✅ Matches how you already use it (tomedo learnings are local)

But if it's confusing, we can simplify further.

**What do you think?**
