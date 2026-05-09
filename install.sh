#!/usr/bin/env bash
#
# install.sh - ABDS global installation
#
# Simple bootstrap script that delegates to bin/setup-global-abds.sh
#
# Usage:
#   ./install.sh
#
# This is the recommended way to install ABDS globally.
# It creates:
#   - ~/.abds/ directory structure
#   - ~/.local/bin/abds symlink (CLI wrapper)
#

set -euo pipefail

# Get the directory where this script lives
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Delegate to the actual setup script
exec "$SCRIPT_DIR/bin/setup-global-abds.sh" "$@"
