#!/usr/bin/env bash
#
# test-installation.sh - Professional installation test suite
#
# Google-grade systematic testing with automated assertions

set -euo pipefail

# Colors
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m'

# Test counters
TESTS_RUN=0
TESTS_PASSED=0
TESTS_FAILED=0

# Cleanup
cleanup() {
    echo ""
    echo "=============================="
    if [ $TESTS_FAILED -eq 0 ]; then
        echo -e "${GREEN}All tests passed!${NC} ($TESTS_PASSED/$TESTS_RUN)"
        exit 0
    else
        echo -e "${RED}Some tests failed${NC} ($TESTS_PASSED/$TESTS_RUN passed, $TESTS_FAILED failed)"
        exit 1
    fi
}

trap cleanup EXIT

# Test helper
assert_true() {
    local description="$1"
    local command="$2"

    TESTS_RUN=$((TESTS_RUN + 1))
    echo -n "Test $TESTS_RUN: $description... "

    if eval "$command" >/dev/null 2>&1; then
        echo -e "${GREEN}✓${NC}"
        TESTS_PASSED=$((TESTS_PASSED + 1))
        return 0
    else
        echo -e "${RED}✗${NC}"
        TESTS_FAILED=$((TESTS_FAILED + 1))
        return 1
    fi
}

assert_false() {
    local description="$1"
    local command="$2"

    TESTS_RUN=$((TESTS_RUN + 1))
    echo -n "Test $TESTS_RUN: $description... "

    if eval "$command" >/dev/null 2>&1; then
        echo -e "${RED}✗${NC}"
        echo "  Expected command to fail, but it succeeded"
        TESTS_FAILED=$((TESTS_FAILED + 1))
        return 1
    else
        echo -e "${GREEN}✓${NC}"
        TESTS_PASSED=$((TESTS_PASSED + 1))
        return 0
    fi
}

assert_file_exists() {
    local description="$1"
    local file="$2"
    assert_true "$description" "[ -f '$file' ]"
}

assert_dir_exists() {
    local description="$1"
    local dir="$2"
    assert_true "$description" "[ -d '$dir' ]"
}

assert_executable() {
    local description="$1"
    local file="$2"
    assert_true "$description" "[ -x '$file' ]"
}

# Main test suite
main() {
    echo "=============================="
    echo "ABDS Installation Test Suite"
    echo "Professional Systematic Testing"
    echo "=============================="
    echo ""

    # TC1: Pre-installation state
    echo "=== TC1: Pre-Installation Verification ==="
    echo "Cleaning state for fresh test..."
    rm -rf ~/.abds ~/.local/bin/abds 2>/dev/null || true
    assert_false "~/.abds should not exist" "[ -d ~/.abds ]"
    assert_false "~/.local/bin/abds should not exist" "[ -L ~/.local/bin/abds ]"
    echo ""

    # TC2: Run installation
    echo "=== TC2: Installation Execution ==="
    echo "Running ./install.sh..."
    if ./install.sh >/dev/null 2>&1; then
        echo -e "${GREEN}✓${NC} Installation completed"
    else
        echo -e "${RED}✗${NC} Installation failed"
        TESTS_FAILED=$((TESTS_FAILED + 1))
        exit 1
    fi
    echo ""

    # TC3: Directory structure
    echo "=== TC3: Directory Structure ==="
    assert_dir_exists "~/.abds exists" "$HOME/.abds"
    assert_dir_exists "~/.abds/bin exists" "$HOME/.abds/bin"
    assert_dir_exists "~/.abds/learnings exists" "$HOME/.abds/learnings"
    assert_dir_exists "~/.abds/plans exists" "$HOME/.abds/plans"
    echo ""

    # TC4: Learning categories
    echo "=== TC4: Learning Categories ==="
    for category in database ui debugging security testing deployment performance; do
        assert_dir_exists "learnings/$category exists" "$HOME/.abds/learnings/$category"
    done
    echo ""

    # TC5: Special categories
    echo "=== TC5: Special Categories ==="
    for category in mistakes anti-patterns guides workflows troubleshooting; do
        assert_dir_exists "$category exists" "$HOME/.abds/learnings/$category"
    done
    echo ""

    # TC6: README files
    echo "=== TC6: Category README Files ==="
    for category in database ui debugging security; do
        assert_file_exists "$category/README.md exists" "$HOME/.abds/learnings/$category/README.md"
    done
    echo ""

    # TC7: Tools installation
    echo "=== TC7: ABDS Tools ==="
    CRITICAL_TOOLS="abds init-abds validate-abds search-learnings update-catalog create-session find-files-to-rename generate-index"
    for tool in $CRITICAL_TOOLS; do
        assert_executable "$tool is executable" "$HOME/.abds/bin/$tool"
    done
    echo ""

    # TC8: CLI wrapper symlink
    echo "=== TC8: CLI Wrapper Symlink ==="
    assert_true "~/.local/bin/abds symlink exists" "[ -L ~/.local/bin/abds ]"
    assert_true "Symlink points to correct target" "[ ~/.local/bin/abds -ef ~/.abds/bin/abds ]"
    echo ""

    # TC9: CLI commands
    echo "=== TC9: CLI Commands ==="
    assert_true "abds --help works" "~/.local/bin/abds --help"
    assert_true "abds --version works" "~/.local/bin/abds --version"
    assert_true "abds --version shows 1.0.0" "~/.local/bin/abds --version | grep -q '1.0.0'"
    echo ""

    # TC10: Example plan
    echo "=== TC10: Example Content ==="
    assert_file_exists "Example plan created" "$HOME/.abds/plans/new-project-setup-checklist.md"
    echo ""

    # TC11: Idempotency
    echo "=== TC11: Idempotency (run twice) ==="
    echo "Running installation again..."
    if ./install.sh >/dev/null 2>&1; then
        echo -e "${GREEN}✓${NC} Second installation completed"
    else
        echo -e "${RED}✗${NC} Second installation failed"
        TESTS_FAILED=$((TESTS_FAILED + 1))
    fi
    echo ""

    # TC12: Still works after second install
    echo "=== TC12: Post-Upgrade Verification ==="
    assert_executable "abds still executable" "$HOME/.abds/bin/abds"
    assert_true "CLI still works" "~/.local/bin/abds --version"
    echo ""
}

main "$@"
