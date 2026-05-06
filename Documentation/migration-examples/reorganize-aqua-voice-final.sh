#!/bin/bash
# Reorganize aqua-voice learnings to final hybrid structure
# 5 special categories + domain categories

set -e

PROJECT_DIR="/Users/kaloyan.tanev/Documents/Tomedo/_CH/_Personal_Scripts/_PythonScripts/aqua-voice"
cd "$PROJECT_DIR/.abds/learnings"

echo "Reorganizing aqua-voice to final ABDS structure"
echo "================================================"
echo ""
echo "5 Special Categories:"
echo "  1. mistakes/        - Costly errors"
echo "  2. anti-patterns/   - Bad practices"
echo "  3. guides/          - How-to docs"
echo "  4. workflows/       - Processes"
echo "  5. troubleshooting/ - Debugging"
echo ""

# Step 1: Create all special categories
echo "Step 1: Creating special categories..."
mkdir -p {mistakes,anti-patterns,guides,workflows,troubleshooting}
echo "  ✓ Created all 5 special categories"

# Step 2: Move files to appropriate categories
echo ""
echo "Step 2: Organizing files..."

# Mistake: Build cache issue
if [ -f tauri-swift-ffi/tauri-swift-build-cache-mistake-27-04-2026.md ]; then
    mv tauri-swift-ffi/tauri-swift-build-cache-mistake-27-04-2026.md mistakes/
    echo "  ✓ Moved build cache mistake → mistakes/"
fi

# Guides: Debugging and production build
if [ -f tauri-swift-ffi/tauri-swift-ffi-debugging-27-04-2026.md ]; then
    mv tauri-swift-ffi/tauri-swift-ffi-debugging-27-04-2026.md guides/
    echo "  ✓ Moved debugging guide → guides/"
fi

if [ -f tauri-swift-ffi/tauri-swift-ffi-production-build.md ]; then
    mv tauri-swift-ffi/tauri-swift-ffi-production-build.md guides/
    echo "  ✓ Moved production build guide → guides/"
fi

# Keep domain-specific lessons in tauri-swift-ffi/
echo "  ✓ Kept lessons-from-previous-projects in tauri-swift-ffi/ (domain-specific)"

# Step 3: Update frontmatter categories
echo ""
echo "Step 3: Updating frontmatter categories..."

# Update mistakes
for file in mistakes/*.md; do
    if [ -f "$file" ]; then
        sed -i.bak 's/^category: .*/category: mistakes/' "$file" 2>/dev/null || true
        rm -f "$file.bak"
        basename=$(basename "$file")
        echo "  ✓ Updated category: $basename → mistakes"
    fi
done

# Update guides
for file in guides/*.md; do
    if [ -f "$file" ]; then
        sed -i.bak 's/^category: .*/category: guides/' "$file" 2>/dev/null || true
        rm -f "$file.bak"
        basename=$(basename "$file")
        echo "  ✓ Updated category: $basename → guides"
    fi
done

# Step 4: Update CATALOG.md
echo ""
echo "Step 4: Updating CATALOG.md..."
cat > CATALOG.md << 'EOF'
<!-- GENERATED FILE - DO NOT EDIT MANUALLY -->
<!-- Run: ~/.abds/bin/update-catalog to regenerate -->

# aqua-voice Learnings Catalog

**Organization**: Hybrid (special categories + domain categories)

## Special Categories

- **mistakes/** - Costly errors (2+ hours debugging)
- **anti-patterns/** - Known bad practices to avoid
- **guides/** - How-to documentation and tutorials
- **workflows/** - Repeatable processes and checklists
- **troubleshooting/** - Debugging and problem-solving

## Domain Categories

- **tauri-swift-ffi/** - Tauri + Swift FFI domain knowledge
- **coreml/** - CoreML integration patterns

---

Run `~/.abds/bin/update-catalog` to auto-generate detailed catalog.
EOF
echo "  ✓ Updated CATALOG.md"

# Step 5: Regenerate catalog (if tool available)
echo ""
echo "Step 5: Regenerating catalog from frontmatter..."
if [ -x ../bin/update-catalog ]; then
    ../bin/update-catalog . 2>/dev/null || echo "  ℹ  Run ~/.abds/bin/update-catalog manually"
elif [ -x ~/.abds/bin/update-catalog ]; then
    ~/.abds/bin/update-catalog . 2>/dev/null || echo "  ℹ  Run ~/.abds/bin/update-catalog manually"
else
    echo "  ℹ  Run ~/.abds/bin/update-catalog to auto-generate detailed catalog"
fi

# Step 6: Show final structure
echo ""
echo "Step 6: Verifying structure..."
echo ""
echo "Final structure:"
tree -L 2 . 2>/dev/null || find . -maxdepth 2 -type d | sort

# Count files in each category
echo ""
echo "File counts:"
for dir in mistakes anti-patterns guides workflows troubleshooting tauri-swift-ffi coreml; do
    if [ -d "$dir" ]; then
        count=$(find "$dir" -name "*.md" 2>/dev/null | wc -l | tr -d ' ')
        echo "  - $dir/: $count files"
    fi
done

echo ""
echo "=============================="
echo "Reorganization Complete! ✅"
echo ""
echo "Structure now matches ABDS 1.0 hybrid organization:"
echo "  ✓ 5 special categories (mistakes, anti-patterns, guides, workflows, troubleshooting)"
echo "  ✓ Domain categories (tauri-swift-ffi, coreml)"
echo ""
echo "Next: Run ~/.abds/bin/update-catalog for detailed catalog"
echo ""
