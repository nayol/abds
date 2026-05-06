#!/bin/bash
# Setup global ~/.abds/ with recommended structure

set -e

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
mkdir -p ~/.abds/learnings/{database,ui,security,testing,deployment,performance}
echo "  ✓ Created domain categories:"
echo "    - database/         (PostgreSQL, RLS, migrations)"
echo "    - ui/               (React, scroll, animations)"
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

# Summary
echo ""
echo "=============================="
echo "Global ABDS Setup Complete! ✅"
echo ""
echo "Structure:"
echo "  ~/.abds/"
echo "    ├── bin/              (8 tools)"
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
echo "  1. Add learnings: Edit files in ~/.abds/learnings/{category}/"
echo "  2. Generate catalog: ~/.abds/bin/update-catalog"
echo "  3. Search learnings: ~/.abds/bin/search-learnings 'keyword'"
echo "  4. New project: cd project && ~/.abds/bin/init-abds"
echo ""
