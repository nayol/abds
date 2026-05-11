#!/bin/bash
# Setup global ~/.abds/ with recommended structure
#
# Google-grade installation: Atomic with rollback on failure

set -euo pipefail

# Trap errors and rollback
BACKUP_DIR=""
cleanup_on_error() {
    local exit_code=$?
    if [ $exit_code -ne 0 ]; then
        echo ""
        echo "❌ Installation failed at step $(caller | awk '{print $1}'). Rolling back..."

        # Remove partial installation
        if [ -d ~/.abds ]; then
            rm -rf ~/.abds
            echo "  ✓ Removed partial installation"
        fi

        # Restore backup if exists
        if [ -n "$BACKUP_DIR" ] && [ -d "$BACKUP_DIR" ]; then
            mv "$BACKUP_DIR" ~/.abds
            echo "  ✓ Restored previous installation from backup"
        fi

        echo ""
        echo "Installation failed. No changes made to your system."
        exit $exit_code
    fi
}

trap cleanup_on_error EXIT

# Backup existing installation
if [ -d ~/.abds ]; then
    BACKUP_DIR="$HOME/.abds.backup.$(date +%s)"
    mv ~/.abds "$BACKUP_DIR"
    echo "⚠️  Found existing ~/.abds/ installation"
    echo "  ✓ Backed up to: $BACKUP_DIR"
    echo ""
fi

echo "Setting up global ~/.abds/ structure"
echo "====================================="
echo ""

# Create recommended learning categories (hybrid structure)
echo "Step 1: Creating learnings structure (hybrid organization)..."

# Special categories (cross-domain, high-priority)
mkdir -p ~/.abds/learnings/{mistakes,anti-patterns,guides,workflows,troubleshooting}
echo "  ✓ Created special categories:"
echo "    - mistakes/         (costly errors across all projects)"
echo "    - anti-patterns/    (known bad practices to avoid)"
echo "    - guides/           (how-to documentation and tutorials)"
echo "    - workflows/        (repeatable processes and checklists)"
echo "    - troubleshooting/  (debugging and problem-solving)"
echo ""

# Domain categories (technical/feature-specific)
mkdir -p ~/.abds/learnings/{database,ui,debugging,security,testing,deployment,performance}
echo "  ✓ Created domain categories:"
echo "    - database/         (PostgreSQL, RLS, migrations)"
echo "    - ui/               (React, scroll, animations)"
echo "    - debugging/        (systematic debugging, profiling)"
echo "    - security/         (auth, vulnerabilities)"
echo "    - testing/          (TDD, test patterns)"
echo "    - deployment/       (CI/CD, Docker)"
echo "    - performance/      (optimization patterns)"

# Create category README files
echo ""
echo "Step 2: Creating category README files..."

cat > ~/.abds/learnings/database/README.md << 'EOF'
# Database Learnings

Cross-project database patterns and knowledge.

## Categories
- PostgreSQL patterns
- RLS (Row Level Security)
- Migrations
- Schema design
- Query optimization
EOF

cat > ~/.abds/learnings/ui/README.md << 'EOF'
# UI Learnings

Cross-project UI patterns and knowledge.

## Categories
- React patterns
- Scroll behavior
- Animations
- Layout patterns
- Component design
EOF

cat > ~/.abds/learnings/debugging/README.md << 'EOF'
# Debugging Learnings

Cross-project debugging patterns and knowledge.

## Categories
- Systematic debugging
- Common bugs
- Browser DevTools
- Performance profiling
EOF

cat > ~/.abds/learnings/security/README.md << 'EOF'
# Security Learnings

Cross-project security patterns and knowledge.

## Categories
- Authentication
- Authorization
- Vulnerabilities
- Defense patterns
EOF

echo "  ✓ Created 4 category README files"

# Verify critical files were created
echo ""
echo "Step 2.5: Verifying installation..."
MISSING_FILES=0
for dir in database ui debugging security; do
    if [ ! -f ~/.abds/learnings/$dir/README.md ]; then
        echo "  ❌ Missing: ~/.abds/learnings/$dir/README.md"
        MISSING_FILES=$((MISSING_FILES + 1))
    fi
done

if [ $MISSING_FILES -gt 0 ]; then
    echo "  ❌ Installation verification failed ($MISSING_FILES missing files)"
    exit 1
fi
echo "  ✓ All critical files created successfully"

# Update catalog
echo ""
echo "Step 3: Updating CATALOG.md..."
if [ -x ~/.abds/bin/update-catalog ]; then
    ~/.abds/bin/update-catalog
    echo "  ✓ CATALOG.md updated"
else
    echo "  ⚠ update-catalog not found"
fi

# Create example plan
echo ""
echo "Step 4: Creating example implementation plan..."
mkdir -p ~/.abds/plans
cat > ~/.abds/plans/new-project-setup-checklist.md << 'EOF'
# New Project Setup Checklist

**Time**: ~75 minutes
**Last Updated**: 2026-05-06

---

## Prerequisites

- [ ] Git installed
- [ ] Development environment ready
- [ ] ABDS tools installed (`~/.abds/bin/`)

---

## Setup Steps

### 1. Project Initialization (10 min)
- [ ] Create project directory
- [ ] Initialize git repository
- [ ] Create `.gitignore`
- [ ] Initial commit

### 2. ABDS Structure (15 min)
- [ ] Create `.abds/docs/PROJECT-STATE.md`
- [ ] Create `.abds/docs/feature/STATE.md`
- [ ] Run `~/.abds/bin/validate-abds`

### 3. Development Environment (20 min)
- [ ] Install dependencies
- [ ] Configure linters
- [ ] Setup pre-commit hooks
- [ ] Verify build

### 4. Testing Setup (15 min)
- [ ] Install testing framework
- [ ] Create test structure
- [ ] Write first test
- [ ] Verify test runs

### 5. Documentation (15 min)
- [ ] Write README.md
- [ ] Document architecture in CLAUDE.md
- [ ] Add setup instructions
- [ ] Commit all docs

---

**Total**: ~75 minutes
EOF
echo "  ✓ Created example plan"

# Add to PATH suggestion
echo ""
echo "Step 5: PATH configuration..."
if ! grep -q '.abds/bin' ~/.zshrc 2>/dev/null; then
    echo ""
    echo "  ℹ  Optional: Add ABDS tools to PATH"
    echo "     Run: echo 'export PATH=\"\$HOME/.abds/bin:\$PATH\"' >> ~/.zshrc"
    echo "     Then: source ~/.zshrc"
else
    echo "  ✓ Already in PATH"
fi

# Install CLI wrapper and tools
echo ""
echo "Step 6: Installing ABDS tools and CLI wrapper..."

# Get the directory where this script lives
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Create ~/.abds/bin/ directory
mkdir -p "$HOME/.abds/bin"
echo "  ✓ Created ~/.abds/bin/ directory"

# Copy all tools from bin/
if [ -d "$SCRIPT_DIR" ]; then
    cp "$SCRIPT_DIR"/* "$HOME/.abds/bin/" 2>/dev/null || true
    chmod +x "$HOME/.abds/bin"/*
    echo "  ✓ Copied ABDS tools to ~/.abds/bin/"

    # Verify critical tools
    TOOLS_COUNT=$(ls "$HOME/.abds/bin" | wc -l | tr -d ' ')
    echo "  ✓ Installed $TOOLS_COUNT tools"
else
    echo "  ❌ Could not find bin directory at $SCRIPT_DIR"
    exit 1
fi

# Create symlink in ~/.local/bin/
mkdir -p "$HOME/.local/bin"
ln -sf "$HOME/.abds/bin/abds" "$HOME/.local/bin/abds"
echo "  ✓ Symlinked to ~/.local/bin/abds"

# Check if ~/.local/bin is in PATH
if ! echo "$PATH" | grep -q ".local/bin"; then
    echo ""
    echo "  ⚠️  ~/.local/bin not in PATH"
    echo "     Add to ~/.zshrc or ~/.bashrc:"
    echo '     export PATH="$HOME/.local/bin:$PATH"'
    echo "     Then: source ~/.zshrc (or ~/.bashrc)"
else
    echo "  ✓ ~/.local/bin is in PATH"
    echo "  ✓ You can now use: abds <command>"
fi

# Final verification
echo ""
echo "Step 7: Final verification..."
VERIFICATION_FAILED=0

# Check critical directories
for dir in learnings plans bin; do
    if [ ! -d ~/.abds/$dir ]; then
        echo "  ❌ Missing directory: ~/.abds/$dir"
        VERIFICATION_FAILED=1
    fi
done

# Check CLI wrapper and critical tools
CRITICAL_TOOLS="abds init-abds validate-abds search-learnings update-catalog"
for tool in $CRITICAL_TOOLS; do
    if [ ! -x ~/.abds/bin/$tool ]; then
        echo "  ❌ Tool missing or not executable: ~/.abds/bin/$tool"
        VERIFICATION_FAILED=1
    fi
done

if [ $VERIFICATION_FAILED -eq 0 ]; then
    echo "  ✓ All critical tools installed and executable"
fi

# Check symlink
if [ ! -L ~/.local/bin/abds ]; then
    echo "  ❌ Symlink not created: ~/.local/bin/abds"
    VERIFICATION_FAILED=1
fi

if [ $VERIFICATION_FAILED -eq 1 ]; then
    echo ""
    echo "❌ Installation verification failed"
    exit 1
fi

echo "  ✓ All components verified successfully"

# Summary
echo ""
echo "=============================="
echo "Global ABDS Setup Complete! ✅"
echo ""
echo "Structure:"
echo "  ~/.abds/"
echo "    ├── bin/"
echo "    │   ├── abds          (CLI wrapper)"
echo "    │   └── ...           (8 tools)"
echo "    ├── learnings/"
echo "    │   ├── CATALOG.md"
echo "    │   ├── database/"
echo "    │   ├── ui/"
echo "    │   ├── debugging/"
echo "    │   ├── security/"
echo "    │   ├── testing/"
echo "    │   ├── deployment/"
echo "    │   ├── performance/"
echo "    │   └── patterns/"
echo "    ├── plans/"
echo "    │   └── new-project-setup-checklist.md"
echo "    └── templates/        (complete set)"
echo ""
echo "Next steps:"
echo "  1. Try the CLI: abds search 'keyword'"
echo "  2. Initialize project: cd your-project && abds init"
echo "  3. Check compliance: abds validate"
echo "  4. Add learnings to: ~/.abds/learnings/{category}/"
echo ""
echo "CLI Commands:"
echo "  abds init              # Initialize ABDS in project"
echo "  abds search <keywords> # Search learnings"
echo "  abds catalog           # Update learnings catalog"
echo "  abds validate          # Check compliance level"
echo "  abds session <name>    # Create session folder"
echo ""
