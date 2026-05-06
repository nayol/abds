# ABDS as Filesystem Specification for Autonomous Agents - Discussion Documentation

**Date**: May 5, 2026, 23:59 (Zürich timezone)
**Participants**: Claude (Sonnet 4.5), Kaloyan Tanev
**Status**: Vision Documented - Architectural Direction Set

---

## Executive Summary

During ABDS development, we discovered the true purpose: **ABDS is not just a documentation system - it's the filesystem specification for autonomous agent systems**, analogous to how FHS (Filesystem Hierarchy Standard) defines the structure for Linux systems.

ABDS serves as the **local filesystem layer** beneath autonomous agent operating systems like `autonomousthinkingsystems`, providing standardized directory structure, documentation hierarchy, and knowledge organization that agents can reliably depend on.

---

## The Problem

### What We Were Trying to Solve

**Initial understanding**: "We're building a documentation system for AI agent projects"

**Actual realization**: "We're building the **filesystem standard** that autonomous agent systems should use"

### Why It Mattered

Without a standard filesystem structure:
- Every autonomous agent system invents its own directory layout
- No interoperability between different agent systems
- Knowledge cannot be shared across tools
- Developers must learn different structures for each tool

**Critical insight**: Just as Linux needs FHS to ensure `/usr/bin/` means the same thing across all distributions, autonomous agents need ABDS to ensure `~/.abds/learnings/` means the same thing across all agent systems.

### Constraints We Faced

1. **Existing ecosystem**: Tools like Claude Code, Cursor, Aider already have their own structures
2. **Backward compatibility**: Can't break existing `.claude/`, `.cursor/` setups
3. **Universal adoption**: Need to convince multiple tool developers to adopt
4. **Simplicity**: Must be simple enough for solo developers, robust enough for enterprises

---

## The Discussion

### Initial Thinking

**Where we started:**
- ABDS = "Agent Base Directory Specification"
- Purpose: Organize documentation for AI-assisted projects
- Scope: Project-level directory structure

**The question that changed everything:**
> "I am not sure but I am working towards `/Users/kaloyan.tanev/Documents/Tomedo/_CH/_Personal_Scripts/_PythonScripts/autonomousthinkingsystems`"

This revealed ABDS wasn't standalone - it was the **filesystem layer** for a larger autonomous agent operating system.

### Questions Raised

**Q1: "Should ABDS be a script package or a Linux-type system?"**
- Led to insight: It's neither - it's a **specification** (like FHS)
- The reference implementation is the script package
- But ABDS itself is the standard

**Q2: "What does 'Linux-type system' mean?"**
- Led to discovery: User is building `autonomousthinkingsystems`
- ABDS is the filesystem, autonomousthinkingsystems is the OS
- Just like ext4/FHS + Linux kernel

**Q3: "Where do specs go in Linux?"**
- Led to reorganization: Specs at root (like COPYING, README)
- Following actual Linux kernel structure
- Not in a "spec/" folder - they ARE the project

### Trade-offs Considered

| Approach | Pros | Cons | Verdict |
|----------|------|------|---------|
| **Pure Documentation System** | Simple, easy to adopt | Limited scope, doesn't solve agent integration | Rejected - too narrow |
| **Agent-Specific Tool** | Deep integration with one tool | Vendor lock-in, no interoperability | Rejected - wrong layer |
| **Filesystem Specification** | Universal, tool-agnostic, composable | Requires ecosystem adoption | **Selected** - right abstraction level |
| **Operating System** | Complete solution | Too heavyweight, reinventing wheel | Rejected - autonomousthinkingsystems does this |

### Key Insights

#### 1. **ABDS is the FHS for Agents**

**The realization**:
Just as Linux has FHS defining `/usr/bin/`, `/etc/`, `/var/lib/`, autonomous agents need a standard defining where knowledge lives.

**How we got there**:
- Started by mimicking Linux structure
- Realized we weren't just copying - we were **creating the standard**
- ABDS to agents = FHS to Linux distributions

**Why it matters**:
- Any agent system can adopt ABDS
- Learnings are portable across tools
- Developers learn once, use everywhere

#### 2. **Two-Layer Architecture: OS + Filesystem**

**The realization**:
```
┌─────────────────────────────────────┐
│  autonomousthinkingsystems          │  ← Operating System Layer
│  (Agents, Orchestrator, Task Queue) │
└─────────────────────────────────────┘
              ↓
┌─────────────────────────────────────┐
│  ABDS                               │  ← Filesystem Layer
│  (Directory Structure, Docs Layers) │
└─────────────────────────────────────┘
```

**How we got there**:
- User mentioned autonomousthinkingsystems
- Read CLAUDE.md: "CLI-focused, self-learning autonomous coding tool"
- Saw it uses Supabase for knowledge + learning loop
- Realized: autonomousthinkingsystems is the OS, ABDS is the filesystem

**Why it matters**:
- Clear separation of concerns
- ABDS focuses on structure, not intelligence
- autonomousthinkingsystems focuses on agents, not files

#### 3. **Local + Remote Knowledge Architecture**

**The realization**:
```
LEARNING FLOW:
1. Task arrives
2. autonomousthinkingsystems queries Supabase (remote knowledge)
3. Injects learnings into agent context
4. Agent works on task (using ABDS local structure)
5. Extracts learnings
6. Saves to BOTH:
   - ~/.abds/var/lib/abds/learnings/  (local cache)
   - Supabase knowledge table          (searchable, team-shared)
```

**How we got there**:
- autonomousthinkingsystems already has learning system
- Uses Supabase + pgvector for semantic search
- But where do learnings live locally? → ABDS!

**Why it matters**:
- Local ABDS = fast access, offline work
- Supabase = search, sharing, team knowledge
- Best of both worlds

#### 4. **Not Just for One Tool - Universal Standard**

**The realization**:
ABDS should work with:
- autonomousthinkingsystems (primary)
- Claude Code (via skills)
- Cursor (future)
- Aider (future)
- Any LLM-based coding tool (future)

**How we got there**:
- Started with Claude Code-specific paths (`~/.claude/`)
- Changed to universal paths (`~/.abds/`)
- Realized: This is bigger than one tool

**Why it matters**:
- Developers can switch tools without losing knowledge
- Multiple tools can share same knowledge base
- Industry-wide standard emerges

---

## The Decision

### What We Decided

**ABDS is a filesystem specification for autonomous agent systems**, following the same model as:
- **FHS** (Filesystem Hierarchy Standard) - defines where files go in Linux
- **XDG Base Directory Spec** - defines `~/.config/`, `~/.cache/` locations
- **POSIX** - defines system call interfaces

**ABDS defines**:
- `~/.abds/` - Global user directory (like `~/.local/`)
- `.abds/` - Project directory (like `.git/`)
- Standard locations for learnings, plans, templates, docs
- Four-layer documentation hierarchy
- Frontmatter schema for knowledge files

### Why This Approach

#### 1. **Right Abstraction Level**

**Filesystem specification is the sweet spot:**
- Below: File formats (markdown, YAML) - too low-level
- At: Directory structure, documentation layers - **perfect**
- Above: Agent logic, task queues - too high-level

**ABDS focuses on "where things live", not "what agents do"**

#### 2. **Enables Interoperability**

Just as FHS allows:
- Ubuntu, Fedora, Arch to share package structure
- Developers to navigate any Linux system

ABDS allows:
- Claude Code, Cursor, Aider to share knowledge structure
- Developers to navigate any agent project

#### 3. **Composable Architecture**

```
Agent System = OS Layer + Filesystem Layer + Storage Layer

autonomousthinkingsystems = Orchestrator + ABDS + Supabase
Claude Code = Skills + ABDS + (local files only)
Future Tool = Custom Agent + ABDS + (PostgreSQL or other)
```

Each layer can be swapped independently.

#### 4. **Evolution Path is Clear**

**Phase 1 (Current)**: Reference implementation
- `install.sh` → copies to `~/.abds/`
- Manual adoption by developers

**Phase 2**: Tool integration
- Claude Code officially supports ABDS paths
- autonomousthinkingsystems uses ABDS as default
- Community tools emerge

**Phase 3**: Package managers
- `brew install abds`
- `apt install abds`
- System-wide adoption

**Phase 4**: Industry standard
- New agent tools ship with ABDS compliance
- Developers expect `~/.abds/learnings/` to exist
- Like how developers expect `~/.config/` today

### What We're Trading Away

**Downsides accepted:**

1. **Requires ecosystem adoption**
   - ABDS only valuable if tools adopt it
   - Chicken-and-egg: tools wait for adoption, users wait for tools
   - **Mitigation**: Start with autonomousthinkingsystems + Claude Code

2. **Breaking changes from existing tools**
   - `.claude/` users must migrate to `.abds/`
   - Existing workflows need updates
   - **Mitigation**: Provide migration scripts, backward compat period

3. **Spec maintenance burden**
   - ABDS must evolve without breaking existing users
   - Versioning complexity (ABDS 1.0, 2.0, etc.)
   - **Mitigation**: Conservative spec evolution, clear deprecation policy

4. **Not "Linux-type" yet**
   - Current implementation is script package
   - Full Linux integration requires package managers
   - **Mitigation**: Phase 2-3 roadmap addresses this

### When to Revisit

**Conditions that would trigger reconsidering this decision:**

1. **If ecosystem adoption fails** (6-12 months)
   - No other tools adopt ABDS
   - autonomousthinkingsystems is the only user
   - → Consider: Fold ABDS into autonomousthinkingsystems directly

2. **If a competing standard emerges**
   - Major tool (e.g., Cursor) launches own standard
   - Gains more traction than ABDS
   - → Consider: Merge specs or adapt ABDS

3. **If filesystem approach proves wrong**
   - Agents need database-first, not file-first
   - File structure too limiting
   - → Consider: ABDS as database schema spec instead

4. **If scale requirements change dramatically**
   - Enterprise needs require different structure
   - Solo developer needs are too different from team needs
   - → Consider: ABDS variants (solo vs enterprise)

---

## Implementation Details

### What Was Done in This Session

1. **Reorganized ABDS to follow Linux FHS**
   - Moved specs to root (ABDS-1.0.md, FRONTMATTER-SCHEMA.md, DOCUMENTATION-SYSTEM.md)
   - Created `share/templates/` for file templates
   - Created `etc/abds/` for configuration
   - Created `bin/` for executables

2. **Updated all paths from Claude-specific to universal**
   - `~/.claude/` → `~/.abds/`
   - Made ABDS tool-agnostic

3. **Created reference implementation scripts**
   - `install.sh` - Install ABDS on user's machine
   - `update-catalog` - Generate learnings catalog
   - `search-learnings` - Search across learnings
   - `create-session` - Create session folders

4. **Verified Linux naming conventions**
   - Checked real Linux commands (`git-receive-pack`, `docker-compose`)
   - Confirmed our scripts follow kebab-case standard
   - All scripts use verb-noun pattern

### Code Written in This Session

```bash
# File: install.sh
# Purpose: Install ABDS following Linux FHS conventions

#!/bin/bash
set -euo pipefail

ABDS_HOME="${1:-$HOME/.abds}"

# Create directory structure (following Linux FHS)
mkdir -p "$ABDS_HOME"/{bin,etc/abds,share/{doc/abds,abds/{templates,examples}},var/lib/abds/{learnings,plans}}

# Install documentation
cp ABDS-1.0.md FRONTMATTER-SCHEMA.md DOCUMENTATION-SYSTEM.md LICENSE "$ABDS_HOME/share/doc/abds/"

# Install templates
cp -r share/templates/* "$ABDS_HOME/share/abds/templates/"

# Install binaries
cp -r bin/* "$ABDS_HOME/bin/"
chmod +x "$ABDS_HOME/bin/"*

# Install configuration
cp etc/abds/abds.conf.default "$ABDS_HOME/etc/abds/abds.conf"
cp etc/abds/categories.conf "$ABDS_HOME/etc/abds/"

# Initialize catalog
"$ABDS_HOME/bin/update-catalog"
```

```bash
# File: etc/abds/abds.conf.default
# Purpose: Default ABDS configuration

LEARNINGS_DIR="${ABDS_HOME:-$HOME/.abds}/var/lib/abds/learnings"
PLANS_DIR="${ABDS_HOME:-$HOME/.abds}/var/lib/abds/plans"
TEMPLATES_DIR="${ABDS_HOME:-$HOME/.abds}/share/abds/templates"
AUTO_UPDATE_CATALOG=true
EDITOR="${EDITOR:-vim}"
CATALOG_FORMAT="markdown"
```

```bash
# File: bin/search-learnings
# Purpose: Search across all ABDS learnings

#!/bin/bash
ABDS_HOME="${ABDS_HOME:-$HOME/.abds}"
LEARNINGS_DIR="$ABDS_HOME/var/lib/abds/learnings"

# Search by keyword in frontmatter or content
# Display with metadata (keywords, tldr, description)
# Support --category and --keyword filters
```

```bash
# File: bin/create-session
# Purpose: Create new ABDS session folder

#!/bin/bash
# Interactive session creation
# Lists existing features
# Creates folder: {description}_{DD_MM_YYYY}/
# Copies template
# Opens in $EDITOR
```

### Files Created/Modified

| File | Action | Purpose |
|------|--------|---------|
| `install.sh` | Created | Install ABDS on user's machine |
| `etc/abds/abds.conf.default` | Created | Default configuration |
| `etc/abds/categories.conf` | Created | Learning categories |
| `bin/search-learnings` | Created | Search learnings tool |
| `bin/create-session` | Created | Session folder creator |
| `bin/find-files-to-rename` | Copied | Find unorganized files |
| `FRONTMATTER-SCHEMA.md` | Updated paths | `~/.claude/` → `~/.abds/` |
| `DOCUMENTATION-SYSTEM.md` | Updated header | Marked as ABDS component |
| Directory structure | Reorganized | Moved to Linux FHS layout |

### Verification

**How we confirmed it works:**

1. ✅ Checked real Linux commands for naming conventions
2. ✅ Verified scripts follow kebab-case (verb-noun pattern)
3. ✅ Confirmed structure matches Linux FHS
4. ✅ All paths updated from `~/.claude/` to `~/.abds/`
5. ✅ Scripts are executable (`chmod +x`)

**Not yet tested** (requires full installation):
- [ ] Run `./install.sh` on clean system
- [ ] Verify directory structure created correctly
- [ ] Test `search-learnings` with real learnings
- [ ] Test `create-session` in ABDS project

---

## Lessons Learned

### What Worked Well

1. **Starting with Linux as the model**
   - Copying proven patterns (FHS, XDG) saved design time
   - Linux conventions (kebab-case, `bin/`, `share/`) are familiar
   - Standing on shoulders of giants

2. **Discovering the true purpose mid-development**
   - Building helped us understand what ABDS really is
   - User's mention of autonomousthinkingsystems was the key insight
   - Sometimes you don't know what you're building until you build it

3. **Tool-agnostic thinking**
   - Changing `~/.claude/` → `~/.abds/` early was crucial
   - Makes future adoption easier
   - Prevents vendor lock-in

### What We'd Do Differently

1. **Should have documented the vision earlier**
   - Spent session on structure before understanding purpose
   - Vision document should precede implementation
   - **Fix**: Writing this document now

2. **Migration path not fully thought through**
   - How do existing `.claude/` users migrate?
   - What about backward compatibility?
   - **Fix**: Need migration guide + scripts

3. **Ecosystem adoption strategy unclear**
   - How do we get Claude Code to adopt ABDS?
   - What about Cursor, Aider?
   - **Fix**: Need adoption roadmap

### Patterns to Reuse

1. **Follow established standards religiously**
   - Linux FHS, XDG-BDS → proven patterns
   - Don't reinvent, adapt

2. **Spec + Reference Implementation**
   - ABDS-1.0.md = the spec (what)
   - install.sh + bin/ = reference (how)
   - Others can implement differently

3. **Universal paths, not tool-specific**
   - `~/.abds/` not `~/.claude/` or `~/.cursor/`
   - `ABDS_HOME` environment variable for flexibility
   - Works with any tool

---

## Future Considerations

### Related Decisions Coming

1. **autonomousthinkingsystems + ABDS integration**
   - Decision needed: How does autonomousthinkingsystems use ABDS?
   - Does it install ABDS as dependency?
   - Does it ship with ABDS embedded?

2. **Claude Code official adoption**
   - Decision needed: Migrate `.claude/` to `.abds/`?
   - Backward compatibility period?
   - Timeline for deprecation?

3. **Package manager distribution**
   - Decision needed: Homebrew, apt, npm, pip?
   - Which platforms first?
   - Versioning strategy?

4. **Multi-user / enterprise support**
   - Decision needed: System-wide vs per-user installation?
   - `/etc/abds/` vs `~/.abds/etc/`?
   - Team knowledge sharing mechanism?

### Technical Debt Accepted

1. **No migration script from `.claude/` yet**
   - Accepted: Will create in Phase 2
   - Risk: Early adopters must migrate manually
   - Plan: `bin/migrate-from-claude` script

2. **No package manager support**
   - Accepted: Manual `install.sh` for now
   - Risk: Harder adoption, no version management
   - Plan: Homebrew formula in Phase 2

3. **Supabase integration not specified**
   - Accepted: autonomousthinkingsystems handles this
   - Risk: Other tools might implement differently
   - Plan: Add optional Supabase sync spec in ABDS 2.0

4. **No uninstall script**
   - Accepted: Low priority for now
   - Risk: Users can't cleanly remove ABDS
   - Plan: `uninstall.sh` in Phase 2

### Follow-up Tasks

- [ ] **Document autonomousthinkingsystems + ABDS architecture**
  - How they integrate
  - Learning flow (local ABDS ↔ Supabase)
  - Data sync strategy

- [ ] **Create migration guide**
  - `.claude/` → `.abds/`
  - `.cursor/` → `.abds/`
  - Step-by-step with scripts

- [ ] **Write ABDS adoption roadmap**
  - Phase 1: autonomousthinkingsystems + Claude Code
  - Phase 2: Package managers, tool integrations
  - Phase 3: Industry standard

- [ ] **Update README.md with vision**
  - ABDS as filesystem spec, not just docs
  - Comparison to FHS, XDG-BDS
  - Integration with agent systems

- [ ] **Create `Documentation/architecture/VISION.md`**
  - Long-term vision for ABDS
  - What success looks like
  - 1-year, 3-year, 5-year goals

- [ ] **Test full installation flow**
  - Fresh Ubuntu VM
  - Fresh macOS system
  - Document any issues

---

## Architecture Diagram

```
┌────────────────────────────────────────────────────────┐
│                    DEVELOPER                           │
└────────────────────────────────────────────────────────┘
                           ↓
┌────────────────────────────────────────────────────────┐
│              AUTONOMOUS AGENT SYSTEMS                  │
│  ┌──────────────────┐  ┌──────────────┐  ┌──────────┐ │
│  │ autonomous-      │  │ Claude Code  │  │  Cursor  │ │
│  │ thinkingsystems  │  │ (skills)     │  │  (AI)    │ │
│  └──────────────────┘  └──────────────┘  └──────────┘ │
│           ↓                    ↓                ↓      │
│  ┌────────────────────────────────────────────────┐   │
│  │         Task Execution & Agent Logic          │   │
│  └────────────────────────────────────────────────┘   │
└────────────────────────────────────────────────────────┘
                           ↓
┌────────────────────────────────────────────────────────┐
│                    ABDS LAYER                          │
│  ┌────────────────────────────────────────────────┐   │
│  │  Filesystem Structure (FHS-like)               │   │
│  │  - ~/.abds/var/lib/abds/learnings/            │   │
│  │  - ~/.abds/share/abds/templates/              │   │
│  │  - .abds/docs/ (4-layer hierarchy)            │   │
│  └────────────────────────────────────────────────┘   │
│  ┌────────────────────────────────────────────────┐   │
│  │  Tools & Scripts                               │   │
│  │  - update-catalog, search-learnings            │   │
│  │  - create-session, validate-abds               │   │
│  └────────────────────────────────────────────────┘   │
└────────────────────────────────────────────────────────┘
                           ↓
┌────────────────────────────────────────────────────────┐
│                  STORAGE LAYER                         │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐ │
│  │ Local Files  │  │  Supabase    │  │ PostgreSQL   │ │
│  │ (markdown)   │  │  (pgvector)  │  │ (team data)  │ │
│  └──────────────┘  └──────────────┘  └──────────────┘ │
└────────────────────────────────────────────────────────┘

LEARNING FLOW:
─────────────
1. Developer gives task to autonomous agent system
2. Agent queries Supabase (semantic search for relevant learnings)
3. Agent reads ABDS structure (docs, templates, existing learnings)
4. Agent executes task (writes to ABDS structure)
5. Agent extracts learnings from execution
6. Learning saved to:
   - ~/.abds/var/lib/abds/learnings/{category}/learning.md (local)
   - Supabase knowledge table (searchable, team-shared)
7. update-catalog regenerates CATALOG.md
```

---

## Comparison Table: ABDS vs Similar Standards

| Aspect | FHS (Linux) | XDG-BDS | POSIX | ABDS |
|--------|-------------|---------|-------|------|
| **Scope** | System-wide filesystem | User directories | OS interface | Agent knowledge |
| **Defines** | `/usr/`, `/etc/`, `/var/` | `~/.config/`, `~/.cache/` | System calls | `~/.abds/`, `.abds/` |
| **Level** | Filesystem layout | User data layout | API/ABI | Knowledge layout |
| **Adoption** | Universal (Linux) | Wide (desktop Linux) | Universal (Unix-like) | Emerging (agents) |
| **Versioning** | FHS 3.0 (2015) | XDG-BDS 0.8 (2010) | POSIX.1-2017 | ABDS 1.0 (2026) |
| **Target** | OS distributions | Desktop applications | System developers | Autonomous agents |
| **Compliance** | Mandatory (distros) | Recommended (apps) | Mandatory (Unix) | Recommended (agents) |

**Key parallel**:
- FHS ensures all Linux systems have `/usr/bin/`
- ABDS ensures all agent systems have `~/.abds/learnings/`

---

## The Vision: ABDS as Universal Standard

### What Success Looks Like (1 Year)

- autonomousthinkingsystems ships with ABDS as default filesystem
- Claude Code users can opt-in to migrate `.claude/` → `.abds/`
- 3+ other agent tools support ABDS
- Community creates ABDS-compliant templates and tools
- Developers start expecting `~/.abds/` to exist

### What Success Looks Like (3 Years)

- Major agent tools (Cursor, Aider, Copilot Workspace) support ABDS
- Package managers ship ABDS (Homebrew, apt, npm)
- `~/.abds/` is as common as `~/.config/`
- Learnings are portable across all agent tools
- ABDS 2.0 released with enterprise features

### What Success Looks Like (5 Years)

- ABDS is the de facto standard for agent filesystems
- New agent tools ship ABDS-compliant by default
- Enterprises use ABDS for team knowledge management
- ABDS certification program exists
- ABDS foundation manages the specification

### The Endgame

**ABDS becomes to autonomous agents what FHS is to Linux:**

- Every agent tool uses the same structure
- Knowledge is portable
- Developers learn once, use everywhere
- Innovation happens at agent logic level, not filesystem level

---

## References

- [autonomousthinkingsystems CLAUDE.md](../../../autonomousthinkingsystems/CLAUDE.md)
- [Linux FHS 3.0](https://refspecs.linuxfoundation.org/FHS_3.0/fhs-3.0.html)
- [XDG Base Directory Specification](https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html)
- [POSIX.1-2017](https://pubs.opengroup.org/onlinepubs/9699919799/)
- ABDS repository structure (current directory)

---

## Appendix: Real Linux Commands (Validation)

**Evidence that kebab-case is Linux standard:**

```bash
# From Git (universal tool)
git-receive-pack
git-upload-pack
git-shell

# From Docker (universal tool)
docker-compose
docker-credential-desktop

# From Debian/Ubuntu (if on Linux)
apt-get
apt-cache
add-apt-repository
update-alternatives

# From systemd (modern Linux)
systemd-analyze
systemd-resolve
hostnamectl

# Pattern: verb-noun, all lowercase, hyphens
```

**ABDS scripts follow same pattern:**
```bash
create-session
search-learnings
update-catalog
find-files-to-rename
validate-abds
```

✅ Confirmed: ABDS follows Linux naming conventions exactly.

---

**END OF DOCUMENTATION**

**Next Steps**:
1. Share with autonomousthinkingsystems team
2. Update ABDS README.md with vision
3. Create adoption roadmap
4. Document integration architecture
