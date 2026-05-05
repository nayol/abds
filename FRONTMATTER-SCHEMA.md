# Learnings Frontmatter Schema

**Purpose**: Standardize metadata across all learning files for automated catalog generation and discovery.

**Location**: Add to the top of every learning `.md` file in `~/.abds/learnings/{category}/`

---

## Schema Definition

```yaml
---
keywords: [keyword1, keyword2, keyword3, keyword4, keyword5]
category: category-name
confidence: verified | hypothesis | deprecated
tldr: "One-line solution summary"
description: "One-line problem description"
related:
  - category/filename1.md
  - category/filename2.md
  - category/filename3.md
---
```

---

## Field Specifications

### Required Fields

| Field | Type | Description | Example |
|-------|------|-------------|---------|
| `keywords` | Array[String] | 3-7 keywords for search/discovery | `[RLS, security, parameter, trust]` |
| `category` | String | Category folder name | `security`, `database`, `ui` |
| `confidence` | Enum | Verification level (see below) | `verified` |
| `tldr` | String | One-line solution (< 100 chars) | `"Never trust client-passed org_id"` |
| `description` | String | One-line problem (< 100 chars) | `"RPC parameters for authorization decisions"` |

### Optional Fields

| Field | Type | Description | Example |
|-------|------|-------------|---------|
| `related` | Array[String] | 2-4 related learning paths | `- security/defense-in-depth.md` |
| `projects_applied` | Array[Object] | Usage tracking (see below) | See Projects Applied section |
| `severity` | Enum | P0, P1, P2 (for security/critical) | `P1` |
| `date_discovered` | Date | When learning was captured | `2026-03-02` |

---

## Confidence Levels

| Level | Symbol | Meaning | When to Use |
|-------|--------|---------|-------------|
| `verified` | ✅ | Battle-tested in 2+ projects | Applied successfully multiple times |
| `hypothesis` | ⚠️ | Theoretical or single-use | Not yet proven across projects |
| `deprecated` | ❌ | Superseded by better pattern | Replaced by newer learning |

**Display in file:**
```markdown
## Confidence
✅ Verified (3 projects)
```

**Progression:**
- New learning starts as `hypothesis`
- After 2+ successful applications → promote to `verified`
- If superseded or proven wrong → mark as `deprecated`

---

## Keywords Guidelines

**How to choose keywords:**

1. **Include the obvious** (1-2 keywords)
   - Technology: `PostgreSQL`, `React`, `Next.js`
   - Concept: `RLS`, `authentication`, `scroll`

2. **Include the symptom** (1-2 keywords)
   - What developer sees: `flashing`, `stale data`, `permission denied`
   - Error message: `PGRST200`, `42501`

3. **Include the solution** (1-2 keywords)
   - Fix type: `DEFINER`, `useRef`, `module cache`
   - Pattern name: `defense-in-depth`, `handover`

4. **Include searchable terms** (1-2 keywords)
   - What developer would search: `race condition`, `layout shift`
   - Alternative names: `CSRF` + `Cross-Site Request Forgery`

**Total: 5-7 keywords per learning**

**Examples:**

| Learning | Keywords |
|----------|----------|
| RPC Parameter Trust | `[RPC, parameter, trust, security, PostgREST, spoofing, auth]` |
| Scroll Handover | `[scroll, streaming, handover, user control, ResizeObserver]` |
| Button Flashing | `[button, flashing, loading state, useEffect, reflow, React]` |

---

## Related Links Format

**Purpose**: Help users discover connected learnings

**Guidelines:**
- Add 2-4 related links per learning
- Links should be **truly related** (not just same category)
- Use relative paths from `~/.abds/var/lib/abds/learnings/`
- No broken links (validate before commit)

**Format:**
```yaml
related:
  - security/defense-in-depth-pattern.md
  - database/database-function-security-patterns.md
  - security/authorization-setting-not-enforced.md
```

**Display in file:**
```markdown
## Related
- **security/defense-in-depth-pattern.md** - Multiple independent security controls
- **database/database-function-security-patterns.md** - When to use DEFINER vs INVOKER
- **security/authorization-setting-not-enforced.md** - Test enforcement, not just storage
```

**Relationship types:**
- **Same problem, different context**: `ui/scroll-handover-pattern.md` ↔ `ui/scroll-handover-implementation-guide.md`
- **Prerequisite knowledge**: `database/rls-patterns.md` → `security/rls-security-definer.md`
- **Common co-occurrence**: `auth/service-role-pattern.md` ↔ `database/rpc-schema-qualification.md`
- **Alternative approach**: `react/module-cache.md` ↔ `react/context-persistence.md`

---

## Projects Applied Format

**Purpose**: Track where learning was successfully applied

**Format:**
```yaml
projects_applied:
  - name: thoughtsessions
    date: 2026-03-02
    notes: Fixed expert search functions
  - name: utufdbox
    date: 2026-03-15
    notes: Applied to all RPC functions
```

**Display in file:**
```markdown
## Projects Applied
- **thoughtsessions** (2026-03-02) - Fixed expert search functions
- **utufdbox** (2026-03-15) - Applied to all RPC functions
- **te-app** (2026-04-01) - Prevented parameter trust vulnerability
```

**When to add:**
1. After successfully applying learning to fix a problem
2. After implementing pattern in a new project
3. When learning saves time (document time saved)

**Confidence promotion:**
- 1 project: `hypothesis`
- 2+ projects: eligible for `verified`
- 3+ projects: strong `verified`

---

## Complete Example

```yaml
---
keywords: [RPC, parameter, trust, security, PostgREST, spoofing, auth]
category: security
confidence: verified
tldr: "Never trust client-passed org_id. Derive from auth.uid()."
description: "RPC parameters for authorization decisions."
related:
  - security/defense-in-depth-pattern.md
  - database/database-function-security-patterns.md
  - security/authorization-setting-not-enforced.md
projects_applied:
  - name: thoughtsessions
    date: 2026-03-02
    notes: Fixed expert search functions
  - name: utufdbox
    date: 2026-03-15
    notes: Applied to all RPC functions
severity: P1
date_discovered: 2026-03-02
---

# RPC Parameter Trust Vulnerability

**Severity**: P1 HIGH
**Date Discovered**: March 2, 2026
**Status**: PATTERN ESTABLISHED

## TL;DR
Never trust client-passed org_id. Derive from auth.uid().

## Confidence
✅ Verified (2 projects)

## Applies When
- RPC function makes authorization decisions
- Parameters filter by access level
- User could benefit from changing parameters

## Symptom
User can access data they shouldn't see

## Root Cause
RPC functions trust caller-provided parameters for authorization

## Solution
Look up access from database using auth.uid(), ignore caller parameters

## Related
- **security/defense-in-depth-pattern.md** - Multiple independent security controls
- **database/database-function-security-patterns.md** - When to use DEFINER vs INVOKER
- **security/authorization-setting-not-enforced.md** - Test enforcement, not just storage

## Projects Applied
- **thoughtsessions** (2026-03-02) - Fixed expert search functions
- **utufdbox** (2026-03-15) - Applied to all RPC functions
```

---

## Migration Checklist

**For each learning file:**

1. [ ] Add YAML frontmatter at top of file
2. [ ] Fill required fields: keywords, category, confidence, tldr, description
3. [ ] Add 2-4 related links (if high-value learning)
4. [ ] Add Confidence section in body
5. [ ] Add Related section in body
6. [ ] Expand Projects Applied section (if applicable)
7. [ ] Validate YAML syntax
8. [ ] Verify no broken links

---

## Validation

**Before committing:**

```bash
# Check YAML syntax (should show frontmatter)
head -20 ~/.abds/var/lib/abds/learnings/security/rpc-parameter-trust.md

# Verify no broken related links
for file in ~/.abds/var/lib/abds/learnings/*/*.md; do
  grep "^  - " "$file" | while read line; do
    link=$(echo $line | sed 's/.*- //')
    if [[ ! -f "~/.abds/var/lib/abds/learnings/$link" ]]; then
      echo "Broken link in $file: $link"
    fi
  done
done
```

---

## Benefits

| Before Frontmatter | After Frontmatter |
|-------------------|-------------------|
| Manual CATALOG.md updates → stale | Auto-generated → always current |
| No confidence tracking → trust unclear | Confidence levels → know what's proven |
| Isolated learnings → hard to discover | Related links → easy discovery |
| No usage tracking → value unknown | Projects Applied → show impact |
| Search by filename only | Search by keywords/symptoms/solutions |

---

**Last Updated**: 2026-05-01
**Status**: Schema finalized, ready for implementation
