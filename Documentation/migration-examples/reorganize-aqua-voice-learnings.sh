#!/bin/bash
# Reorganize aqua-voice learnings from type-based to domain-based

set -e

PROJECT_DIR="/Users/kaloyan.tanev/Documents/Tomedo/_CH/_Personal_Scripts/_PythonScripts/aqua-voice"
cd "$PROJECT_DIR/.abds/learnings"

echo "Reorganizing aqua-voice learnings to domain-based"
echo "=================================================="
echo ""

# Step 1: Create domain-based structure
echo "Step 1: Creating domain-based structure..."
mkdir -p tauri-swift-ffi coreml

echo "  ✓ Created tauri-swift-ffi/"
echo "  ✓ Created coreml/"

# Step 2: Move files to appropriate domains
echo ""
echo "Step 2: Moving files to domains..."

# All guides and mistakes are about Tauri Swift FFI
if [ -d guides ]; then
    mv guides/* tauri-swift-ffi/ 2>/dev/null || true
    rmdir guides 2>/dev/null || true
    echo "  ✓ Moved guides/ → tauri-swift-ffi/"
fi

if [ -d mistakes ]; then
    mv mistakes/* tauri-swift-ffi/ 2>/dev/null || true
    rmdir mistakes 2>/dev/null || true
    echo "  ✓ Moved mistakes/ → tauri-swift-ffi/"
fi

# Move generic learnings to tauri-swift-ffi
if [ -d learnings ]; then
    mv learnings/* tauri-swift-ffi/ 2>/dev/null || true
    rmdir learnings 2>/dev/null || true
    echo "  ✓ Moved learnings/ → tauri-swift-ffi/"
fi

# swift-ffi folder content to tauri-swift-ffi
if [ -d swift-ffi ]; then
    mv swift-ffi/* tauri-swift-ffi/ 2>/dev/null || true
    rmdir swift-ffi 2>/dev/null || true
    echo "  ✓ Merged swift-ffi/ → tauri-swift-ffi/"
fi

# Step 3: Update CATALOG
echo ""
echo "Step 3: Regenerating CATALOG.md..."
if [ -x ../bin/update-catalog ]; then
    ../bin/update-catalog .
    echo "  ✓ CATALOG.md regenerated"
elif [ -x ~/.abds/bin/update-catalog ]; then
    ~/.abds/bin/update-catalog .
    echo "  ✓ CATALOG.md regenerated"
else
    cat > CATALOG.md << 'EOF'
# aqua-voice Learnings

**Organization**: Domain-based (what it's about, not how it's structured)

## Domains

- **tauri-swift-ffi/** - All Tauri + Swift FFI knowledge
- **coreml/** - CoreML integration patterns

Run `~/.abds/bin/update-catalog` to auto-generate detailed catalog.
EOF
    echo "  ✓ Created basic CATALOG.md"
fi

# Step 4: Verify
echo ""
echo "Step 4: Verifying new structure..."
file_count=$(find tauri-swift-ffi -name "*.md" 2>/dev/null | wc -l | tr -d ' ')
echo "  ✓ tauri-swift-ffi/: $file_count files"

echo ""
echo "=============================="
echo "Reorganization Complete! ✅"
echo ""
echo "New structure (domain-based):"
echo "  .abds/learnings/"
echo "    ├── CATALOG.md"
echo "    ├── tauri-swift-ffi/    ($file_count files)"
echo "    └── coreml/             (empty, ready for future)"
echo ""
echo "Matches tomedo pattern:"
echo "  tomedo/.abds/learnings/"
echo "    ├── database/"
echo "    ├── integration/"
echo "    └── infrastructure/"
echo ""
