#!/usr/bin/env bash
#
# test-abds-cli.sh - Smoke tests for ABDS CLI wrapper
#
# Tests basic functionality of the abds CLI wrapper to catch regressions.

set -euo pipefail

# Colors
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m'

# Test counter
TESTS_RUN=0
TESTS_PASSED=0

#
# test - Run a test
#
test() {
  local name="$1"
  TESTS_RUN=$((TESTS_RUN + 1))

  echo -n "Test $TESTS_RUN: $name... "
}

#
# pass - Mark test as passed
#
pass() {
  TESTS_PASSED=$((TESTS_PASSED + 1))
  echo -e "${GREEN}✓${NC}"
}

#
# fail - Mark test as failed and exit
#
fail() {
  local message="$1"
  echo -e "${RED}✗${NC}"
  echo "  Error: $message"
  exit 1
}

echo "Testing ABDS CLI wrapper..."
echo ""

# Test 1: CLI wrapper exists and is executable
test "CLI wrapper exists and is executable"
if [[ -x ./bin/abds ]]; then
  pass
else
  fail "bin/abds not found or not executable"
fi

# Test 2: Help flag works
test "Help flag works"
if ./bin/abds --help > /dev/null 2>&1; then
  pass
else
  fail "abds --help failed"
fi

# Test 3: Version flag works and shows correct version
test "Version flag shows correct version"
version=$(./bin/abds --version)
if [[ "$version" == "ABDS 1.0.0" ]]; then
  pass
else
  fail "Expected 'ABDS 1.0.0', got '$version'"
fi

# Test 4: Short help flag works
test "Short help flag (-h) works"
if ./bin/abds -h > /dev/null 2>&1; then
  pass
else
  fail "abds -h failed"
fi

# Test 5: Short version flag works
test "Short version flag (-V) works"
if ./bin/abds -V > /dev/null 2>&1; then
  pass
else
  fail "abds -V failed"
fi

# Test 6: No arguments shows help
test "No arguments shows help"
output=$(./bin/abds 2>&1)
if echo "$output" | grep -q "USAGE"; then
  pass
else
  fail "Expected help output, got: $output"
fi

# Test 7: Unknown command shows error
test "Unknown command shows error"
output=$(./bin/abds unknown-command 2>&1 || true)
if echo "$output" | grep -q "Unknown command"; then
  pass
else
  fail "Expected 'Unknown command' error"
fi

# Test 8: Unknown command suggests help
test "Unknown command suggests help"
output=$(./bin/abds foobar 2>&1 || true)
if echo "$output" | grep -q "abds --help"; then
  pass
else
  fail "Expected help suggestion in error message"
fi

# Test 9: Help shows all main commands
test "Help shows all main commands"
help_output=$(./bin/abds --help)
for cmd in init validate search catalog session; do
  if ! echo "$help_output" | grep -q "$cmd"; then
    fail "Command '$cmd' not found in help"
  fi
done
pass

# Test 10: Help shows short aliases
test "Help shows short aliases"
help_output=$(./bin/abds --help)
for alias in "i" "v" "s"; do
  if ! echo "$help_output" | grep -q "$alias"; then
    fail "Alias '$alias' not found in help"
  fi
done
pass

# Test 11: Help shows examples
test "Help shows examples"
if ./bin/abds --help | grep -q "EXAMPLES"; then
  pass
else
  fail "No EXAMPLES section in help"
fi

# Test 12: Help shows environment variables
test "Help shows environment variables"
if ./bin/abds --help | grep -q "ABDS_HOME"; then
  pass
else
  fail "ABDS_HOME not documented in help"
fi

# Summary
echo ""
echo "=============================="
if [[ $TESTS_PASSED -eq $TESTS_RUN ]]; then
  echo -e "${GREEN}All tests passed!${NC} ($TESTS_PASSED/$TESTS_RUN)"
  echo "=============================="
  exit 0
else
  echo -e "${RED}Some tests failed${NC} ($TESTS_PASSED/$TESTS_RUN passed)"
  echo "=============================="
  exit 1
fi
