#!/bin/bash
# Organize loose raw session files in ~/.claude/learnings/sessions
# Based on content analysis

set -e

SESSIONS_DIR="$HOME/.claude/learnings/sessions"
cd "$SESSIONS_DIR"

echo "Organizing loose session files..."
echo "================================"

# Create session folders and move files
# Based on reading the content:

# 1. what-are-we-solving series - The core ABDS naming and spec design discussions
echo "1. Creating abds-specification-design_05_05_2026..."
mkdir -p abds-specification-design_05_05_2026
mv what-are-we-solving-raw.md abds-specification-design_05_05_2026/abds-naming-decision-raw.md 2>/dev/null || true
mv what-are-we-solving-2-raw.md abds-specification-design_05_05_2026/abds-naming-decision-2-raw.md 2>/dev/null || true
mv what-are-we-solving-3-raw.md abds-specification-design_05_05_2026/abds-naming-decision-3-raw.md 2>/dev/null || true
mv what-are-we-solving-4-raw.md abds-specification-design_05_05_2026/abds-naming-decision-4-raw.md 2>/dev/null || true
mv what-are-we-solving-5-raw.md abds-specification-design_05_05_2026/abds-naming-decision-5-raw.md 2>/dev/null || true
mv what-are-we-solving-6-raw.md abds-specification-design_05_05_2026/abds-naming-decision-6-raw.md 2>/dev/null || true
mv what-are-we-solving-7-raw.md abds-specification-design_05_05_2026/abds-naming-decision-7-raw.md 2>/dev/null || true

# 2. ade-agentOS series - Comparing ABDS with Agent OS
echo "2. Creating abds-vs-agentos-comparison_05_05_2026..."
mkdir -p abds-vs-agentos-comparison_05_05_2026
mv ade-agentOS-raw.md abds-vs-agentos-comparison_05_05_2026/ecosystem-comparison-raw.md 2>/dev/null || true
mv ade-agentOS-2-raw.md abds-vs-agentos-comparison_05_05_2026/ecosystem-comparison-2-raw.md 2>/dev/null || true
mv ade-agentOS-3-raw.md abds-vs-agentos-comparison_05_05_2026/ecosystem-comparison-3-raw.md 2>/dev/null || true

# 3. modern-linux-concepts - Unix/Linux philosophy research for ABDS design
echo "3. Creating unix-linux-philosophy-research_05_05_2026..."
mkdir -p unix-linux-philosophy-research_05_05_2026
mv modern-linux-concepts-raw.md unix-linux-philosophy-research_05_05_2026/modern-linux-improvements-raw.md 2>/dev/null || true
mv modern-linux-concepts-2-raw.md unix-linux-philosophy-research_05_05_2026/modern-linux-improvements-2-raw.md 2>/dev/null || true

echo ""
echo "✓ Organization complete!"
echo ""
echo "New session folders created:"
echo "  - abds-specification-design_05_05_2026/ (7 iterations of naming decision)"
echo "  - abds-vs-agentos-comparison_05_05_2026/ (3 iterations comparing ecosystems)"
echo "  - unix-linux-philosophy-research_05_05_2026/ (2 conversations about Unix/Linux design)"
echo ""
echo "All files organized by topic with descriptive names."
