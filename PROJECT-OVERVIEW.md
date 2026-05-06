# ABDS Project Overview

## What is This Project?

**ABDS (Agent Base Directory Specification)** is a **filesystem standard** for documentation in agent-assisted software development.

### ABDS is System-Level Infrastructure (Not Project-Level)

**Critical distinction**:

**Project-level standards** (NOT what ABDS is):
- `package.json` - Node.js projects only
- `requirements.txt` - Python projects only
- `Makefile` - Build configuration for one project
- `.gitignore` - Git-specific, project-specific

**System-level standards** (WHAT ABDS IS):
- **FHS** - Works for ALL programs on Linux (`/usr/bin`, `/etc`, `/var`)
- **XDG** - Works for ALL applications (`~/.config`, `~/.cache`)
- **POSIX** - Works across ALL Unix-like systems
- **ABDS** - Works for ALL AI agent projects (`~/.abds/`, `.abds/docs/`) ← **We are here**

### What This Means

**System-level** means:
1. **Universal**: Works with ANY AI agent (Cursor, Aider, Windsurf, custom)
2. **Infrastructure**: Foundation layer, not application layer
3. **Persistent**: Lives in `~/.abds/` (like `~/.config/`), not just in one project
4. **Cross-project**: One `~/.abds/learnings/` serves ALL projects
5. **OS-like**: Operating system for knowledge, not just docs

**It is NOT**:
- A tool or software
- A framework or library
- A product or service
- Project-specific templates

**It IS**:
- A system-level specification (like POSIX, XDG-BDS, FHS)
- Infrastructure standard for knowledge organization
- Universal conventions that work with any tool
- Templates and reference implementation scripts

---

## The Problem We're Solving

### Real-World Scenario

You're a developer working with AI coding assistants. After 3 months:

```
Your project looks like this:
project/
  README.md                  (out of date)
  CLAUDE.md                  (mixed architecture + current state)
  docs/
    old-notes.md
    meeting-notes-march.md
    database-stuff.md
    TODO.md
  random-learnings.txt
  src/
```

**Problems**:
1. 🤔 "What did we decide about authentication last month?"
2. 📂 "Where did I document that database fix?"
3. 🔄 "Didn't we solve this caching problem before?"
4. 🗂️ "Which docs are current? Which are outdated?"
5. AI agent asks: "Where's the architecture documentation?"

**Result**: Chaos. Lost context. Repeated work. Frustrated developers.

### The Core Problem

**Unstructured documentation = Lost knowledge**

- No standard location for different types of docs
- Current state mixed with historical decisions
- Learnings scattered or forgotten
- Every project organized differently
- AI agents can't find information reliably

---

## The Solution: ABDS

ABDS provides a **standard structure** that solves this:

```
Global (your personal knowledge):
~/.abds/
  INDEX.md                   # "What is ~/.abds/?"
  learnings/                 # "I solved RLS issue in 3 projects"
    database/
      rls-patterns.md
  bin/                       # Helper scripts
    generate-index           # Auto-generate INDEX.md (10x faster navigation)
  plans/                     # "My implementation plan template"

Local (this project):
my-project/.abds/
  docs/
    INDEX.md                 # Root navigation (10x faster for agents)
    PROJECT-STATE.md         # "What's happening NOW"
    auth/
      INDEX.md               # Feature navigation
      STATE.md               # "Auth current state"
      CLAUDE.md              # "Why we chose OAuth"
      sessions/              # "What we did March 15"
        INDEX.md             # Sessions list (chronological)
    database/
      INDEX.md               # Feature navigation
      STATE.md
```

**Now**:
- Always know where to look
- Current state separate from history
- Learnings captured systematically
- AI agents navigate predictably
- Knowledge compounds instead of getting lost

---

## Why Unix/Linux Inspiration?

### The Unix Philosophy Connection

ABDS follows proven Unix/Linux design principles:

#### 1. Separation of Concerns

**Unix Example**: `/bin` (executables) vs `/etc` (config) vs `/var` (variable data)
- Each directory has ONE purpose
- Different update frequencies
- Different backup needs

**ABDS Example**: `PROJECT-STATE.md` (current) vs `CLAUDE.md` (architecture) vs `sessions/` (history)
- Each layer has ONE purpose
- Different update frequencies (daily vs rarely vs never)
- Different audiences (overview vs design vs historical research)

#### 2. Standard Locations

**Unix Example**: FHS (Filesystem Hierarchy Standard)
- Configuration ALWAYS in `/etc`
- Executables ALWAYS in `/bin` or `/usr/bin`
- Logs ALWAYS in `/var/log`

**ABDS Example**:
- Project overview ALWAYS in `.abds/docs/PROJECT-STATE.md`
- Feature state ALWAYS in `.abds/docs/{feature}/STATE.md`
- Learnings ALWAYS in `~/.abds/learnings/`

**Why this matters**: Predictability. Humans and AI agents know where to look.

#### 3. Hierarchical with Recurring Patterns

**Unix Example**: Directory structure repeats at different scales
```
/usr/
├── bin/
├── lib/
└── share/

/usr/local/
├── bin/      ← Same pattern!
├── lib/      ← Same pattern!
└── share/    ← Same pattern!
```

**ABDS Example**: Same documentation pattern at different scales
```
Root:
├── PROJECT-STATE.md    ← Overview
└── feature/
    ├── STATE.md         ← Current state (same pattern!)
    ├── CLAUDE.md        ← Architecture
    └── sessions/        ← History
```

**Why this matters**: Learn the pattern once, apply everywhere.

#### 4. Immutability Where Appropriate

**Unix Example**: `/usr` can be read-only (code doesn't change during runtime)

**ABDS Example**: `sessions/` folders are immutable (history doesn't change)
- `PROJECT-STATE.md` - Mutable (changes daily)
- `STATE.md` - Mutable (changes when feature changes)
- `CLAUDE.md` - Semi-stable (changes when architecture changes)
- `sessions/` - **Immutable** (frozen history)

**Why this matters**: Safe to reference historical sessions - they'll never change.

#### 5. Universal Standard (Like POSIX)

**POSIX**: Defined standard interfaces so software works on any Unix-like system
- Linux implements POSIX
- macOS implements POSIX
- BSD implements POSIX
- Write once, runs anywhere

**ABDS**: Defined standard structure so documentation works with any AI agent
- Cursor can use ABDS
- Aider can use ABDS
- Windsurf can use ABDS
- Any agent can use ABDS

**Why this matters**: Not locked into one tool.

---

## What Unix/Linux Standards Inspired ABDS?

### 1. XDG Base Directory Specification

**What XDG did**:
```
Before XDG: ~/.app1, ~/.app2, ~/.app3 (50+ dot-files in home directory)
After XDG:  ~/.config/ (all config in one place)
            ~/.cache/  (all cache in one place)
            ~/.local/share/ (all data in one place)
```

**ABDS does the same**:
```
Before ABDS: Project docs scattered everywhere
After ABDS:  .abds/docs/ (all docs in one place, structured)
             ~/.abds/learnings/ (all learnings in one place)
```

### 2. Filesystem Hierarchy Standard (FHS)

**What FHS did**:
- Defined where EVERY type of file goes on Linux
- `/etc` = config, `/var` = variable data, `/usr` = programs
- Enabled Linux distributions to be compatible

**ABDS does the same**:
- Defines where EVERY type of doc goes
- `PROJECT-STATE.md` = overview, `STATE.md` = current, `sessions/` = history
- Enables AI agents to be compatible

### 3. POSIX

**What POSIX did**:
- Defined standard interfaces for operating systems
- Programs written to POSIX work on any compliant OS
- Created ecosystem of compatible tools

**ABDS does the same**:
- Defines standard structure for documentation
- AI agents following ABDS work with any compliant project
- Creates ecosystem of compatible tools

---

## Why Was This Created?

### The Historical Context

**The Git Analogy**:

Before Git (2005):
- Everyone had different version control (SVN, CVS, Perforce)
- No standard way to track changes
- Difficult collaboration

After Git:
- Standard way to version code
- Everyone uses same structure (`.git/`)
- Ecosystem of tools emerged (GitHub, GitLab, etc.)

**ABDS is Git for Documentation**:

Before ABDS (now):
- Everyone has different doc structures
- No standard way to organize knowledge
- AI agents struggle to find information

After ABDS:
- Standard way to structure docs
- Everyone uses same structure (`.abds/`)
- Ecosystem of tools can emerge

### The Specific Problem (May 2026)

**User's original problem**:
> "My system is not structured well, have bad docs, need to keep track of why what happened, need to extract learnings and patterns. I want a standard for documenting and collecting knowledge from experience."

**Existing solutions weren't enough**:
- README.md - Too high-level, mixes everything
- CLAUDE.md - Mixed architecture + current state
- Scattered docs/ - No consistent structure
- Learnings lost - No systematic capture

**What was needed**:
- **Separation**: Current state ≠ architecture ≠ history
- **Standard locations**: Always know where to look
- **Learnings system**: Capture knowledge systematically
- **Universal**: Works with any AI agent

---

## Unix Principles in ABDS Design

| Unix Principle | How ABDS Applies It |
|----------------|---------------------|
| **Everything is a file** | Everything is a document (markdown) |
| **Separation of concerns** | 4 layers (overview/state/architecture/history) |
| **Standard locations** | INDEX.md, PROJECT-STATE.md, STATE.md, CLAUDE.md, `~/.abds/bin/` |
| **Fast navigation** | INDEX.md in every subfolder (like `ls` output, but structured) |
| **User executables** | `~/.local/bin/` (XDG) → `~/.abds/bin/` (ABDS) |
| **Composability** | Templates compose into complete system, scripts pipe together |
| **Simplicity** | Plain text, no database, no complexity |
| **Portability** | Works on any OS, any agent, any project |
| **Immutability** | Sessions never change (like `/usr` read-only) |
| **Idempotency** | Operations safe to repeat (like `mkdir -p`) |
| **Tool conventions** | Lowercase hyphenated names (update-catalog, like apt-get) |

---

## What ABDS Is NOT

To clarify:

| ABDS Is | ABDS Is NOT |
|---------|-------------|
| A specification (like FHS) | A tool (like Git) |
| A standard (like POSIX) | A framework (like React) |
| A convention (like XDG) | A product (like GitHub) |
| A directory layout | A database |
| Templates and examples | Required software |
| Open and free | Proprietary or paid |

**Think of it like**:
- HTTP specification (not a web server)
- HTML specification (not a browser)
- POSIX specification (not Linux itself)

---

## Success Criteria

ABDS succeeds if:

1. **Adoption**: Multiple AI agent systems support it
2. **Ecosystem**: Tools emerge that leverage ABDS structure
3. **Simplicity**: Developers can adopt it manually in 10 minutes
4. **Universality**: Works across different agents, languages, projects
5. **Durability**: Still useful 5-10 years from now

ABDS fails if:
- Too complex to adopt
- Tool-specific (only works with one agent)
- Requires heavy infrastructure
- Over-engineered
- Solves problems that don't exist

---

## How This Relates to Other Projects

### ABDS Position in the Ecosystem

```
Heavy Infrastructure:
├── GBrain (PostgreSQL + pgvector + MCP server)
├── autonomousthinkingsystems (Full agent orchestration)
│
Mid-Level:
├── Agent OS (Project templates + conventions)
│
Lightweight (ABDS):
└── ABDS (Directory structure + markdown files)
```

**ABDS is the lightest option**:
- No database required
- No server required
- No compilation required
- Just files and conventions

**But others can build on it**:
- GBrain could store docs in ABDS structure
- Agent OS could use ABDS as base layer
- Tools could implement ABDS compliance

**They're complementary, not competing.**

---

## Timeline

**May 4-5, 2026**: ABDS created

**Problem identified**:
- User: "My system is not structured well, have bad docs"
- User: "Need to keep track of why what happened"
- User: "Want standard for collecting knowledge from experience"

**Solution designed**:
- Analyzed Unix/Linux standards (FHS, XDG, POSIX)
- Created 4-layer documentation system
- Defined global + local structure
- Created specification v1.0

**Status**: Draft specification, ready for community feedback

---

## Next Steps

1. **Publish**: Push to GitHub, make public
2. **Iterate**: Gather feedback from real users
3. **Refine**: Update spec based on real-world usage
4. **Tools**: Build optional reference implementations
5. **Ecosystem**: See what tools emerge

---

## Summary

**What**: Open specification for organizing docs and learnings

**Why**: Unstructured documentation = lost knowledge

**How**: Unix-inspired directory structure + templates

**Who**: Any developer using AI coding assistants

**When**: Available now (v1.0 draft)

**Where**: `~/.abds/` (global) + `project/.abds/` (local)

---

**ABDS**: Because documentation shouldn't be chaos.

**Inspired by Unix. Built for AI agents. Made for developers.**
