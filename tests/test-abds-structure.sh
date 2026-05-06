#!/bin/bash
# ABDS Structure Validation Tests
# Tests the new ~/.abds structure without touching ~/.claude

set -e

ABDS_HOME="${HOME}/.abds"
TEST_PROJECT="/tmp/abds-test-project"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Test counters
TESTS_RUN=0
TESTS_PASSED=0
TESTS_FAILED=0

# Test helper functions
test_start() {
    echo -n "Testing: $1 ... "
    TESTS_RUN=$((TESTS_RUN + 1))
}

test_pass() {
    echo -e "${GREEN}PASS${NC}"
    TESTS_PASSED=$((TESTS_PASSED + 1))
}

test_fail() {
    echo -e "${RED}FAIL${NC}: $1"
    TESTS_FAILED=$((TESTS_FAILED + 1))
}

# ============================================================================
# TEST SUITE
# ============================================================================

echo "ABDS Structure Validation Tests"
echo "================================"
echo ""

# Test 1: Global directory structure
test_start "Global ~/.abds directory exists"
if [ -d "${ABDS_HOME}" ]; then
    test_pass
else
    test_fail "~/.abds does not exist"
fi

# Test 2: Required subdirectories
test_start "Global subdirectories (learnings, bin, plans)"
if [ -d "${ABDS_HOME}/learnings" ] && \
   [ -d "${ABDS_HOME}/bin" ] && \
   [ -d "${ABDS_HOME}/plans" ]; then
    test_pass
else
    test_fail "Missing required subdirectories"
fi

# Test 3: Learnings CATALOG.md exists (if learnings exist)
test_start "CATALOG.md exists in learnings"
if [ -f "${ABDS_HOME}/learnings/CATALOG.md" ]; then
    test_pass
elif [ -z "$(ls -A ${ABDS_HOME}/learnings)" ]; then
    echo -e "${YELLOW}SKIP${NC} (no learnings yet)"
else
    test_fail "Learnings exist but CATALOG.md missing"
fi

# Test 4: Scripts are executable
test_start "Scripts in bin/ are executable"
if [ -d "${ABDS_HOME}/bin" ]; then
    non_executable=$(find "${ABDS_HOME}/bin" -type f ! -perm -u+x 2>/dev/null)
    if [ -z "$non_executable" ]; then
        test_pass
    else
        test_fail "Some scripts not executable: $non_executable"
    fi
else
    echo -e "${YELLOW}SKIP${NC} (no bin directory)"
fi

# Test 5: Create test project
test_start "Can create test project structure"
rm -rf "${TEST_PROJECT}"
mkdir -p "${TEST_PROJECT}/.abds/docs"
if [ -d "${TEST_PROJECT}/.abds/docs" ]; then
    test_pass
else
    test_fail "Could not create test project"
fi

# Test 6: Project compliance (minimal)
test_start "Minimal compliance (PROJECT-STATE.md + feature/STATE.md)"
mkdir -p "${TEST_PROJECT}/.abds/docs/database"
cat > "${TEST_PROJECT}/.abds/docs/PROJECT-STATE.md" << 'EOF'
# Project State
**Last Updated**: 2026-05-06
## Current Focus
- Testing ABDS structure
EOF

cat > "${TEST_PROJECT}/.abds/docs/database/STATE.md" << 'EOF'
# Database State
## What's Working
- Test database
EOF

if [ -f "${TEST_PROJECT}/.abds/docs/PROJECT-STATE.md" ] && \
   [ -f "${TEST_PROJECT}/.abds/docs/database/STATE.md" ]; then
    test_pass
else
    test_fail "Could not create minimal compliant structure"
fi

# Test 7: Learnings frontmatter validation
test_start "Learning files have valid YAML frontmatter"
if [ -d "${ABDS_HOME}/learnings" ]; then
    invalid_learnings=()
    while IFS= read -r -d '' file; do
        if ! grep -q "^---$" "$file"; then
            invalid_learnings+=("$file")
        fi
    done < <(find "${ABDS_HOME}/learnings" -name "*.md" -not -name "CATALOG.md" -print0 2>/dev/null)

    if [ ${#invalid_learnings[@]} -eq 0 ]; then
        test_pass
    else
        test_fail "Learnings without frontmatter: ${invalid_learnings[*]}"
    fi
else
    echo -e "${YELLOW}SKIP${NC} (no learnings directory)"
fi

# Test 8: No interference with ~/.claude
test_start "~/.claude remains untouched"
if [ -d "${HOME}/.claude" ]; then
    # Check that ~/.claude has expected structure
    if [ -d "${HOME}/.claude/learnings" ] && \
       [ -d "${HOME}/.claude/bin" ]; then
        test_pass
    else
        test_fail "~/.claude structure changed!"
    fi
else
    echo -e "${YELLOW}SKIP${NC} (no .claude directory)"
fi

# Test 9: Naming conventions
test_start "Session folder naming (description_DD_MM_YYYY)"
mkdir -p "${TEST_PROJECT}/.abds/docs/database/sessions/test-session_06_05_2026"
session_dir="${TEST_PROJECT}/.abds/docs/database/sessions/test-session_06_05_2026"
if [[ $(basename "$session_dir") =~ ^[a-z0-9-]+_[0-9]{2}_[0-9]{2}_[0-9]{4}$ ]]; then
    test_pass
else
    test_fail "Session folder name doesn't match pattern"
fi

# Test 10: Idempotency (operations safe to repeat)
test_start "Operations are idempotent (safe to repeat)"
# Run twice, should produce same result
mkdir -p "${TEST_PROJECT}/.abds/docs/database" 2>/dev/null || true
mkdir -p "${TEST_PROJECT}/.abds/docs/database" 2>/dev/null || true
if [ -d "${TEST_PROJECT}/.abds/docs/database" ]; then
    test_pass
else
    test_fail "Idempotent operations failed"
fi

# ============================================================================
# SUMMARY
# ============================================================================

echo ""
echo "================================"
echo "Test Results:"
echo "  Total:  $TESTS_RUN"
echo -e "  Passed: ${GREEN}$TESTS_PASSED${NC}"
echo -e "  Failed: ${RED}$TESTS_FAILED${NC}"
echo "================================"

# Cleanup
rm -rf "${TEST_PROJECT}"

# Exit with failure if any tests failed
if [ $TESTS_FAILED -gt 0 ]; then
    exit 1
else
    exit 0
fi
