#!/bin/bash
# Migrate aqua-voice from IMPORTANT/ to learnings/ structure

set -e

PROJECT_DIR="/Users/kaloyan.tanev/Documents/Tomedo/_CH/_Personal_Scripts/_PythonScripts/aqua-voice"

cd "$PROJECT_DIR"

echo "ABDS Migration: IMPORTANT/ → learnings/"
echo "========================================"
echo ""

# Step 1: Create learnings structure
echo "Step 1: Creating .abds/learnings/ structure..."
mkdir -p .abds/learnings/{guides,mistakes,learnings,swift-ffi}
echo "  ✓ Created learnings/ with categories"

# Step 2: Move files from IMPORTANT/
echo ""
echo "Step 2: Migrating files from IMPORTANT/..."

# Move GUIDES
if [ -d .abds/docs/IMPORTANT/IMPORTANT/GUIDES ]; then
    for file in .abds/docs/IMPORTANT/IMPORTANT/GUIDES/*.md; do
        if [ -f "$file" ]; then
            basename=$(basename "$file")
            # Convert to lowercase with hyphens
            newname=$(echo "$basename" | tr '[:upper:]' '[:lower:]' | sed 's/_/-/g')
            cp "$file" ".abds/learnings/guides/$newname"
            echo "  ✓ Copied $basename → guides/$newname"
        fi
    done
fi

# Move MISTAKES
if [ -d .abds/docs/IMPORTANT/IMPORTANT/MISTAKES ]; then
    for file in .abds/docs/IMPORTANT/IMPORTANT/MISTAKES/*.md; do
        if [ -f "$file" ]; then
            basename=$(basename "$file")
            newname=$(echo "$basename" | tr '[:upper:]' '[:lower:]' | sed 's/_/-/g')
            cp "$file" ".abds/learnings/mistakes/$newname"
            echo "  ✓ Copied $basename → mistakes/$newname"
        fi
    done
fi

# Move LEARNINGS
if [ -d .abds/docs/IMPORTANT/IMPORTANT/LEARNINGS ]; then
    for file in .abds/docs/IMPORTANT/IMPORTANT/LEARNINGS/*.md; do
        if [ -f "$file" ]; then
            basename=$(basename "$file")
            newname=$(echo "$basename" | tr '[:upper:]' '[:lower:]' | sed 's/_/-/g')
            cp "$file" ".abds/learnings/learnings/$newname"
            echo "  ✓ Copied $basename → learnings/$newname"
        fi
    done
fi

# Step 3: Add frontmatter to learning files
echo ""
echo "Step 3: Adding YAML frontmatter to learning files..."

# Add frontmatter to guides
for file in .abds/learnings/guides/*.md; do
    if [ -f "$file" ]; then
        # Check if already has frontmatter
        if ! head -1 "$file" | grep -q "^---$"; then
            basename=$(basename "$file" .md)
            # Create temp file with frontmatter
            cat > "$file.tmp" << EOF
---
keywords: [tauri, swift, ffi, debugging, coreml]
category: guides
confidence: verified
tldr: "How to debug Tauri Swift FFI integration"
description: "Step-by-step guide for debugging Tauri + Swift bridge"
projects_applied:
  - name: aqua-voice
    date: 2026-04-27
    notes: "Created during CoreML integration"
---

EOF
            # Append original content
            cat "$file" >> "$file.tmp"
            mv "$file.tmp" "$file"
            echo "  ✓ Added frontmatter to guides/$basename.md"
        fi
    fi
done

# Add frontmatter to mistakes
for file in .abds/learnings/mistakes/*.md; do
    if [ -f "$file" ]; then
        if ! head -1 "$file" | grep -q "^---$"; then
            basename=$(basename "$file" .md)
            cat > "$file.tmp" << EOF
---
keywords: [tauri, swift, build, cache, debugging]
category: mistakes
confidence: verified
tldr: "Tauri caches Swift dylibs even on failed compilation - always cargo clean"
description: "Build cache causing stale dylib to be loaded"
projects_applied:
  - name: aqua-voice
    date: 2026-04-27
    notes: "Cost 2+ hours debugging"
---

EOF
            cat "$file" >> "$file.tmp"
            mv "$file.tmp" "$file"
            echo "  ✓ Added frontmatter to mistakes/$basename.md"
        fi
    fi
done

# Add frontmatter to learnings
for file in .abds/learnings/learnings/*.md; do
    if [ -f "$file" ]; then
        if ! head -1 "$file" | grep -q "^---$"; then
            basename=$(basename "$file" .md)
            cat > "$file.tmp" << EOF
---
keywords: [lessons, retrospective, project-management]
category: learnings
confidence: verified
tldr: "Lessons learned from previous projects"
description: "Retrospective learnings applied to aqua-voice"
projects_applied:
  - name: aqua-voice
    date: 2026-04-27
    notes: "Applied lessons from past projects"
---

EOF
            cat "$file" >> "$file.tmp"
            mv "$file.tmp" "$file"
            echo "  ✓ Added frontmatter to learnings/$basename.md"
        fi
    fi
done

# Step 4: Generate CATALOG.md
echo ""
echo "Step 4: Generating CATALOG.md..."
if [ -x .abds/bin/update-catalog ]; then
    .abds/bin/update-catalog .abds/learnings
    echo "  ✓ CATALOG.md generated"
else
    # Create basic CATALOG.md
    cat > .abds/learnings/CATALOG.md << 'EOF'
<!-- GENERATED FILE - DO NOT EDIT MANUALLY -->
<!-- Run: ~/.abds/bin/update-catalog to regenerate -->

# aqua-voice Learnings Catalog

**Purpose**: Project-specific knowledge for aqua-voice development.

---

## Categories

- **guides/** - How-to guides for development
- **mistakes/** - Documented errors and fixes
- **learnings/** - Lessons learned

---

Run `~/.abds/bin/update-catalog` to auto-generate detailed catalog.
EOF
    echo "  ✓ Created placeholder CATALOG.md"
fi

# Step 5: Verify migration
echo ""
echo "Step 5: Verifying migration..."
guides_count=$(find .abds/learnings/guides -name "*.md" 2>/dev/null | wc -l | tr -d ' ')
mistakes_count=$(find .abds/learnings/mistakes -name "*.md" 2>/dev/null | wc -l | tr -d ' ')
learnings_count=$(find .abds/learnings/learnings -name "*.md" 2>/dev/null | wc -l | tr -d ' ')
total=$((guides_count + mistakes_count + learnings_count))

echo "  ✓ Migrated files:"
echo "    - Guides: $guides_count"
echo "    - Mistakes: $mistakes_count"
echo "    - Learnings: $learnings_count"
echo "    - Total: $total files"

# Step 6: Backup IMPORTANT/ (don't delete yet)
echo ""
echo "Step 6: Backing up IMPORTANT/ folder..."
if [ -d .abds/docs/IMPORTANT ]; then
    backup_dir=".abds/docs/IMPORTANT.backup.$(date +%Y%m%d_%H%M%S)"
    mv .abds/docs/IMPORTANT "$backup_dir"
    echo "  ✓ Moved to: $backup_dir"
    echo "  ℹ  Review migration, then manually delete backup if satisfied"
fi

echo ""
echo "=============================="
echo "Migration Complete! ✅"
echo ""
echo "New structure:"
echo "  .abds/learnings/"
echo "    ├── CATALOG.md"
echo "    ├── guides/ ($guides_count files)"
echo "    ├── mistakes/ ($mistakes_count files)"
echo "    └── learnings/ ($learnings_count files)"
echo ""
echo "Old IMPORTANT/ backed up to:"
echo "  $backup_dir"
echo ""
echo "Next steps:"
echo "  1. Review .abds/learnings/ structure"
echo "  2. Run: ~/.abds/bin/update-catalog .abds/learnings"
echo "  3. Delete backup when satisfied: rm -rf $backup_dir"
echo ""
