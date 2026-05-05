#!/bin/bash
#
# ABDS Installation Script
# Installs ABDS following Linux FHS conventions
#
# Usage: ./install.sh [INSTALL_DIR]
#
# Default install location: $HOME/.abds

set -euo pipefail

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Installation directory
ABDS_HOME="${1:-$HOME/.abds}"

echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${BLUE}  ABDS Installation${NC}"
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
echo "Installing to: $ABDS_HOME"
echo ""

# Create directory structure (following Linux FHS)
echo -e "${YELLOW}Creating directory structure...${NC}"
mkdir -p "$ABDS_HOME"/{bin,etc/abds,share/{doc/abds,abds/{templates,examples}},var/lib/abds/{learnings,plans}}

# Install documentation
echo -e "${YELLOW}Installing documentation...${NC}"
cp ABDS-1.0.md FRONTMATTER-SCHEMA.md DOCUMENTATION-SYSTEM.md LICENSE "$ABDS_HOME/share/doc/abds/"
if [ -d "Documentation" ] && [ "$(ls -A Documentation)" ]; then
    cp -r Documentation/* "$ABDS_HOME/share/doc/abds/" 2>/dev/null || true
fi

# Install shared files
echo -e "${YELLOW}Installing templates and examples...${NC}"
cp -r share/templates/* "$ABDS_HOME/share/abds/templates/"
if [ -d "share/examples" ] && [ "$(ls -A share/examples)" ]; then
    cp -r share/examples/* "$ABDS_HOME/share/abds/examples/" 2>/dev/null || true
fi

# Install binaries
echo -e "${YELLOW}Installing executables...${NC}"
cp -r bin/* "$ABDS_HOME/bin/"
chmod +x "$ABDS_HOME/bin/"* 2>/dev/null || true

# Install configuration (don't overwrite existing)
echo -e "${YELLOW}Installing configuration...${NC}"
if [ ! -f "$ABDS_HOME/etc/abds/abds.conf" ]; then
    cp etc/abds/abds.conf.default "$ABDS_HOME/etc/abds/abds.conf"
    echo "  ✓ Created abds.conf"
else
    echo "  ⚠ abds.conf exists, not overwriting"
fi

if [ ! -f "$ABDS_HOME/etc/abds/categories.conf" ]; then
    cp etc/abds/categories.conf "$ABDS_HOME/etc/abds/"
    echo "  ✓ Created categories.conf"
fi

# Update paths in scripts
echo -e "${YELLOW}Updating script paths...${NC}"
if command -v sed >/dev/null 2>&1; then
    # Update ~/.claude/ to ~/.abds/ in scripts
    for script in "$ABDS_HOME/bin/"*; do
        if [ -f "$script" ]; then
            sed -i.bak 's|~/.claude|~/.abds|g' "$script" 2>/dev/null || true
            sed -i.bak 's|\$HOME/.claude|\$HOME/.abds|g' "$script" 2>/dev/null || true
            rm -f "$script.bak"
        fi
    done
fi

# Initialize catalog (if update-catalog exists)
if [ -x "$ABDS_HOME/bin/update-catalog" ]; then
    echo -e "${YELLOW}Initializing catalog...${NC}"
    LEARNINGS_DIR="$ABDS_HOME/var/lib/abds/learnings"

    # Create default categories
    while IFS= read -r category; do
        [ -z "$category" ] && continue
        [ "${category:0:1}" = "#" ] && continue
        mkdir -p "$LEARNINGS_DIR/$category"
    done < "$ABDS_HOME/etc/abds/categories.conf"

    # Generate initial CATALOG.md
    cd "$LEARNINGS_DIR"
    "$ABDS_HOME/bin/update-catalog" 2>/dev/null || echo "  ⚠ Catalog generation skipped (will be created on first learning)"
fi

echo ""
echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${GREEN}  ✓ ABDS installed successfully!${NC}"
echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
echo "Installation location: $ABDS_HOME"
echo ""
echo "Next steps:"
echo ""
echo "  1. Add ABDS binaries to your PATH:"
echo "     ${BLUE}export PATH=\"\$HOME/.abds/bin:\$PATH\"${NC}"
echo "     ${BLUE}echo 'export PATH=\"\$HOME/.abds/bin:\$PATH\"' >> ~/.bashrc${NC}"
echo ""
echo "  2. Read the documentation:"
echo "     ${BLUE}cat $ABDS_HOME/share/doc/abds/ABDS-1.0.md${NC}"
echo ""
echo "  3. Initialize a project with ABDS:"
echo "     ${BLUE}cd your-project${NC}"
echo "     ${BLUE}init-abds${NC}"
echo ""
echo "  4. Create your first learning:"
echo "     ${BLUE}# (After solving a problem, save it to learnings)${NC}"
echo ""
echo "Documentation: $ABDS_HOME/share/doc/abds/"
echo "Templates:     $ABDS_HOME/share/abds/templates/"
echo "Configuration: $ABDS_HOME/etc/abds/abds.conf"
echo ""
