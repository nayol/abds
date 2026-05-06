#!/bin/bash
# Install global ~/.abds/ structure for testing
# NON-DESTRUCTIVE: Does NOT touch ~/.claude/

set -e

ABDS_SPEC_DIR="/Users/kaloyan.tanev/Documents/Tomedo/_CH/_Personal_Scripts/_PythonScripts/abds-spec"

echo "ABDS Global Installation"
echo "========================"
echo ""
echo "Installing: ~/.abds/"
echo "Preserving: ~/.claude/ (untouched)"
echo ""

# Check if ~/.abds already exists
if [ -d ~/.abds ]; then
    echo "⚠️  ~/.abds/ already exists!"
    echo ""
    echo "Options:"
    echo "  1. Backup and reinstall"
    echo "  2. Cancel"
    echo ""
    read -p "Choose (1/2): " choice

    if [ "$choice" = "1" ]; then
        backup_dir=~/.abds.backup.$(date +%Y%m%d_%H%M%S)
        echo "Creating backup: $backup_dir"
        mv ~/.abds "$backup_dir"
        echo "✓ Backup created"
    else
        echo "Installation cancelled"
        exit 0
    fi
fi

# Step 1: Create directory structure
echo "Step 1: Creating ~/.abds/ directory structure..."
mkdir -p ~/.abds/{learnings,plans,bin,config,templates}
echo "  ✓ Created ~/.abds/"
echo "  ✓ Created ~/.abds/learnings/"
echo "  ✓ Created ~/.abds/plans/"
echo "  ✓ Created ~/.abds/bin/"
echo "  ✓ Created ~/.abds/config/"
echo "  ✓ Created ~/.abds/templates/"

# Step 2: Install ABDS tools
echo ""
echo "Step 2: Installing ABDS reference tools..."
cp -r "$ABDS_SPEC_DIR/bin/"* ~/.abds/bin/
chmod +x ~/.abds/bin/*
tool_count=$(ls -1 ~/.abds/bin/ | grep -v README | wc -l | tr -d ' ')
echo "  ✓ Installed $tool_count tools to ~/.abds/bin/"

# Step 3: Create INDEX.md
echo ""
echo "Step 3: Creating ~/.abds/INDEX.md..."
cat > ~/.abds/INDEX.md << 'EOF'
# ~/.abds - Agent Base Directory System

**Purpose**: Global cross-project knowledge and tools following ABDS specification

**Last Updated**: $(date +%Y-%m-%d)

---

## What is ~/.abds/?

This is your personal **Agent Base Directory** - a system-level location for:
- Cross-project learnings and patterns
- Implementation plans and templates
- ABDS reference tools

Think of it like:
- `~/.config/` for application configs
- `~/.abds/` for AI agent knowledge

---

## Structure

```
~/.abds/
  INDEX.md                   # This file
  learnings/                 # Cross-project knowledge
    CATALOG.md               # Auto-generated index
    database/                # Category-based organization
    ui/
    debugging/
  plans/                     # Implementation plans
  bin/                       # ABDS tools
  config/                    # Global configuration
  templates/                 # Document templates
```

---

## Quick Start

### Search Learnings
```bash
~/.abds/bin/search-learnings "database RLS"
```

### Create New Project with ABDS
```bash
cd my-project
~/.abds/bin/init-abds
```

### Validate Project Compliance
```bash
~/.abds/bin/validate-abds /path/to/project
```

### Generate Documentation Index
```bash
~/.abds/bin/generate-index .abds/docs
```

---

## Tools Available

Run `ls ~/.abds/bin/` to see all tools.

See `~/.abds/bin/README.md` for complete documentation.

---

## Relation to ~/.claude/

**~/.claude/**: Tool-specific internal data (history, debug logs, caches)
**~/.abds/**: ABDS standard documentation and knowledge

These are **separate and complementary**:
- Claude Code uses ~/.claude/ for its internals
- ABDS uses ~/.abds/ for your documentation
- Both can coexist peacefully

---

## ABDS Specification

For complete specification, see:
https://github.com/abds-spec/abds

---

**Version**: ABDS 1.0
**Installed**: $(date +%Y-%m-%d)
EOF

echo "  ✓ Created ~/.abds/INDEX.md"

# Step 4: Create empty CATALOG.md
echo ""
echo "Step 4: Creating learnings/CATALOG.md..."
cat > ~/.abds/learnings/CATALOG.md << 'EOF'
<!-- GENERATED FILE - DO NOT EDIT MANUALLY -->
<!-- Run: ~/.abds/bin/update-catalog to regenerate -->

# Learnings Catalog

**Last Updated**: $(date +%Y-%m-%d)
**Total Learnings**: 0

---

## Quick Search

No learnings yet. Start capturing knowledge!

---

## How to Add Learnings

Create markdown files in `~/.abds/learnings/{category}/` with YAML frontmatter:

```markdown
---
keywords: [keyword1, keyword2]
category: database
confidence: verified
tldr: "One-line solution"
---

# Learning Title

## TL;DR
...
```

Then run:
```bash
~/.abds/bin/update-catalog
```

---

For complete format, see ABDS specification.
EOF

echo "  ✓ Created empty CATALOG.md"

# Step 5: Create test learning (example)
echo ""
echo "Step 5: Creating example learning..."
mkdir -p ~/.abds/learnings/abds
cat > ~/.abds/learnings/abds/what-is-abds.md << 'EOF'
---
keywords: [abds, specification, documentation, filesystem]
category: abds
confidence: verified
tldr: "ABDS is a filesystem standard for organizing docs in AI agent development"
description: "Introduction to ABDS specification and purpose"
projects_applied:
  - name: abds-spec
    date: 2026-05-06
    notes: "Created specification"
---

# What is ABDS?

## TL;DR
ABDS (Agent Base Directory Specification) is a filesystem standard for organizing documentation and knowledge in AI agent-assisted development, similar to how FHS defines /usr/bin and XDG defines ~/.config.

## Applies When
- Working with AI coding assistants (Cursor, Aider, Windsurf, etc.)
- Need to organize project documentation systematically
- Want cross-project learnings system
- Require predictable documentation structure for LLMs

## Problem
Without ABDS:
- Documentation scattered (README, CLAUDE.md, random docs/)
- No separation of current state vs history
- Learnings lost across projects
- Every project documents differently

## Solution
ABDS provides:
- Standard directory layout (~/.abds/ global, .abds/docs/ local)
- 4-layer documentation system (overview → state → architecture → sessions)
- Learnings system with YAML frontmatter
- Reference implementation tools

## Projects Applied
- abds-spec (2026-05-06) - Created specification
EOF

echo "  ✓ Created example learning"

# Step 6: Update catalog
echo ""
echo "Step 6: Generating catalog from example learning..."
if [ -x ~/.abds/bin/update-catalog ]; then
    ~/.abds/bin/update-catalog
    echo "  ✓ Catalog generated"
else
    echo "  ⚠ update-catalog not executable (skipping)"
fi

# Step 7: Verify installation
echo ""
echo "Step 7: Verifying installation..."
echo ""

if [ -d ~/.abds ] && \
   [ -d ~/.abds/learnings ] && \
   [ -d ~/.abds/bin ] && \
   [ -f ~/.abds/INDEX.md ]; then
    echo "✅ Global ABDS installation successful!"
else
    echo "❌ Installation incomplete"
    exit 1
fi

echo ""
echo "=============================="
echo "Installation Complete!"
echo ""
echo "Structure created:"
echo "  ~/.abds/INDEX.md          - System orientation"
echo "  ~/.abds/learnings/        - Cross-project knowledge (1 example)"
echo "  ~/.abds/bin/              - ABDS tools ($tool_count tools)"
echo "  ~/.abds/plans/            - Implementation plans"
echo ""
echo "Your ~/.claude/ directory: UNTOUCHED ✓"
echo ""
echo "Quick test:"
echo "  cat ~/.abds/INDEX.md"
echo "  ~/.abds/bin/search-learnings abds"
echo "  ~/.abds/bin/validate-abds /path/to/project"
echo ""
echo "Next: Add this to your shell PATH (optional):"
echo "  export PATH=\"\$HOME/.abds/bin:\$PATH\""
echo ""
