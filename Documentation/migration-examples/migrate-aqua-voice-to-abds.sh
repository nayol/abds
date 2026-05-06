#!/bin/bash
# Safe migration of aqua-voice to ABDS structure
# NON-DESTRUCTIVE: Creates .abds/, keeps original docs/ for comparison

set -e

PROJECT_DIR="/Users/kaloyan.tanev/Documents/Tomedo/_CH/_Personal_Scripts/_PythonScripts/aqua-voice"
ABDS_SPEC_DIR="/Users/kaloyan.tanev/Documents/Tomedo/_CH/_Personal_Scripts/_PythonScripts/abds-spec"

echo "ABDS Migration for aqua-voice"
echo "=============================="
echo ""
echo "Mode: NON-DESTRUCTIVE (keeps original docs/ for comparison)"
echo ""

cd "$PROJECT_DIR"

# Step 1: Create ABDS structure
echo "Step 1: Creating .abds/ structure..."
mkdir -p .abds/docs
mkdir -p .abds/docs/IMPORTANT
echo "  ✓ Created .abds/docs/"

# Step 2: Copy ABDS tools
echo ""
echo "Step 2: Installing ABDS tools..."
mkdir -p .abds/bin
cp -r "$ABDS_SPEC_DIR/bin/"* .abds/bin/
chmod +x .abds/bin/*
echo "  ✓ Installed 8 ABDS tools to .abds/bin/"

# Step 3: Migrate core docs (COPY, don't move)
echo ""
echo "Step 3: Migrating core documentation..."

# Copy PROJECT-STATE.md
if [ -f docs/PROJECT-STATE.md ]; then
    cp docs/PROJECT-STATE.md .abds/docs/PROJECT-STATE.md
    echo "  ✓ Copied PROJECT-STATE.md"
fi

# Copy CLAUDE.md if exists
if [ -f docs/CLAUDE.md ]; then
    cp docs/CLAUDE.md .abds/docs/CLAUDE.md
    echo "  ✓ Copied CLAUDE.md"
fi

# Step 4: Migrate feature folders
echo ""
echo "Step 4: Migrating feature folders..."

# POC feature
if [ -d docs/poc ]; then
    cp -r docs/poc .abds/docs/poc
    echo "  ✓ Copied poc/ (with STATE.md and sessions/)"
fi

# SST improvement feature
if [ -d docs/sst-improvement ]; then
    cp -r docs/sst-improvement .abds/docs/sst-improvement
    echo "  ✓ Copied sst-improvement/"
fi

# Architecture docs
if [ -d docs/architecture ]; then
    cp -r docs/architecture .abds/docs/architecture
    echo "  ✓ Copied architecture/"
fi

# Implementation docs
if [ -d docs/implementation ]; then
    cp -r docs/implementation .abds/docs/implementation
    echo "  ✓ Copied implementation/"
fi

# Step 5: Copy IMPORTANT folder
echo ""
echo "Step 5: Migrating IMPORTANT/ folder..."
if [ -d docs/IMPORTANT ]; then
    cp -r docs/IMPORTANT .abds/docs/IMPORTANT
    echo "  ✓ Copied IMPORTANT/ (guides, mistakes, learnings)"
fi

# Step 6: Organize loose files into session folder
echo ""
echo "Step 6: Organizing loose raw files..."
mkdir -p .abds/docs/sessions/development-work_may_2026

# Move raw transcripts to session folder
raw_count=0
for file in docs/raw*.md; do
    if [ -f "$file" ]; then
        basename=$(basename "$file")
        cp "$file" ".abds/docs/sessions/development-work_may_2026/$basename"
        ((raw_count++))
    fi
done
echo "  ✓ Organized $raw_count raw transcript files"

# Move bug files to session folder
bug_count=0
for file in docs/bug*.md; do
    if [ -f "$file" ]; then
        basename=$(basename "$file")
        cp "$file" ".abds/docs/sessions/development-work_may_2026/$basename"
        ((bug_count++))
    fi
done
echo "  ✓ Organized $bug_count bug analysis files"

# Step 7: Copy existing sessions
echo ""
echo "Step 7: Migrating existing sessions..."
if [ -d docs/sessions ]; then
    mkdir -p .abds/docs/sessions
    cp -r docs/sessions/* .abds/docs/sessions/
    session_count=$(ls -1d docs/sessions/*/ 2>/dev/null | wc -l | tr -d ' ')
    echo "  ✓ Copied $session_count session folders"
fi

# Step 8: Generate INDEX.md files
echo ""
echo "Step 8: Generating INDEX.md navigation files..."
if [ -x .abds/bin/generate-index ]; then
    .abds/bin/generate-index .abds/docs >/dev/null 2>&1 || echo "  ⚠ generate-index had warnings (expected for first run)"
    echo "  ✓ Generated INDEX.md files"
else
    echo "  ⚠ Skipping (generate-index not executable)"
fi

# Step 9: Validate ABDS compliance
echo ""
echo "Step 9: Validating ABDS compliance..."
if [ -x .abds/bin/validate-abds ]; then
    .abds/bin/validate-abds "$PROJECT_DIR" || true
else
    echo "  ⚠ Skipping validation (validate-abds not found)"
fi

echo ""
echo "=============================="
echo "Migration Complete!"
echo ""
echo "Structure created:"
echo "  .abds/docs/               - ABDS-compliant documentation"
echo "  .abds/docs/poc/           - POC feature (STATE.md + sessions)"
echo "  .abds/docs/IMPORTANT/     - Critical patterns"
echo "  .abds/docs/sessions/      - Work history"
echo "  .abds/bin/                - ABDS tools"
echo ""
echo "Original docs/ folder preserved for comparison"
echo ""
echo "Next steps:"
echo "  1. Review .abds/docs/ structure"
echo "  2. Compare with original docs/"
echo "  3. When satisfied, optionally remove docs/"
echo "  4. Commit .abds/ to git"
echo ""
