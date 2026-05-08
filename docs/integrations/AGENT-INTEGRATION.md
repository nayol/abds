# Using ABDS with AI Agents

ABDS integrates with any system via **filesystem + CLI** - two universal interfaces that work with any tool.

---

## Quick Start

Any agent or tool can use ABDS through standard operations:

### Read the Catalog
```bash
cat ~/.abds/learnings/CATALOG.md
```

### Search Learnings
```bash
abds search "keywords"
abds search "database RLS"
abds s "oauth pkce"  # Short alias
```

### Create a Learning
```bash
# Write file to appropriate category
cat > ~/.abds/learnings/database/my-learning.md <<'EOF'
---
keywords: [postgres, rls, security]
category: database
tldr: "Your solution in one line"
---

# Learning Title

## TL;DR
Your solution

## Problem
What was wrong

## Solution
How to fix it
EOF

# Update catalog
abds catalog
```

### Initialize Project
```bash
cd your-project
abds init
```

### Check Compliance
```bash
abds validate
```

---

## Universal Interface

```
┌─────────────────────────────────────┐
│  Any Agent / Tool                   │
│  (Claude Code, Cursor, Aider, etc.) │
└─────────────────────────────────────┘
              ↓
      Uses standard interfaces
              ↓
┌─────────────────────────────────────┐
│  Filesystem: ~/.abds/               │
│  CLI: abds command                  │
└─────────────────────────────────────┘
              ↓
           Accesses
              ↓
┌─────────────────────────────────────┐
│  ABDS Tools & Data                  │
│  (learnings, plans, validation)     │
└─────────────────────────────────────┘
```

**Works with**: Claude Code, Cursor, Aider, Windsurf, custom scripts, any bash-capable system.

---

## Integration Examples

### Example 1: Claude Code Integration

**Create a skill**: `~/.claude/commands/search-learnings.md`

```markdown
# /search-learnings

Search the ABDS learnings catalog.

## Process

Run the ABDS search command:

```bash
abds search "$@"
```

Format the results for the user.

## Usage

```
/search-learnings database RLS
/search-learnings oauth pkce
```
```

**Usage**:
```
User: /search-learnings database RLS
Claude: [Executes: abds search "database RLS"]
        [Shows formatted results]
```

---

### Example 2: Generic Bash Script

```bash
#!/bin/bash
# custom-workflow.sh

# Search for relevant learnings
echo "Searching for OAuth patterns..."
results=$(abds search "oauth pkce")

# Process results
if echo "$results" | grep -q "tldr"; then
  echo "Found relevant learnings:"
  echo "$results" | grep "tldr"
else
  echo "No learnings found for 'oauth pkce'"
fi

# After solving problem, add learning
cat > ~/.abds/learnings/auth/oauth-pkce-pattern.md <<'EOF'
---
keywords: [oauth, pkce, security]
category: auth
tldr: "Always use PKCE for public clients (mobile, SPA)"
---

# OAuth PKCE Pattern

## TL;DR
Use PKCE (Proof Key for Code Exchange) for all public OAuth clients.

## Solution
```typescript
// Generate code verifier
const verifier = crypto.randomBytes(32).toString('base64url')
// Generate code challenge
const challenge = crypto.createHash('sha256')
  .update(verifier)
  .digest('base64url')
```
EOF

# Update catalog
abds catalog

echo "✅ Learning saved and catalog updated"
```

---

### Example 3: Cursor Integration

**In `.cursor/settings.json`** (hypothetical):

```json
{
  "abds.enabled": true,
  "abds.searchCommand": "abds search",
  "abds.catalogPath": "~/.abds/learnings/CATALOG.md"
}
```

**Or in custom Cursor extension**:

```javascript
// cursor-extension/abds.js
const { execSync } = require('child_process');

function searchLearnings(keywords) {
  const result = execSync(`abds search "${keywords}"`);
  return result.toString();
}

function updateCatalog() {
  execSync('abds catalog');
}
```

---

### Example 4: Aider Integration

**In `.aider.conf.yaml`** (hypothetical):

```yaml
commands:
  search-learnings: "abds search"
  init-abds: "abds init"

auto-catalog: true
catalog-command: "abds catalog"
```

---

## Why This Works

### Universal Interfaces

**Filesystem**:
- Any program can read files
- Any program can write files
- No protocol, no server, no dependencies

**CLI**:
- Any program can execute commands
- Standard input/output
- Works in scripts, agents, terminals

### No Coupling

- ABDS doesn't know about Claude Code
- Claude Code doesn't know about ABDS internals
- Integration via standard interfaces
- Clean separation of concerns

### Future-Proof

- New agents can integrate immediately (no code changes)
- ABDS can evolve independently
- Agents can evolve independently
- No version coupling

---

## Available Commands

```bash
# Initialize
abds init              # Initialize ABDS in project
abds i                 # Short alias

# Search & Discovery
abds search <keywords> # Search learnings
abds s <keywords>      # Short alias

# Maintenance
abds catalog           # Update learnings catalog (CATALOG.md)
abds validate          # Check ABDS compliance level
abds v                 # Short alias

# Project Management
abds session <name>    # Create new session folder
abds find-files        # Find files needing better names
abds generate-index    # Generate ABDS-INDEX.md

# Help
abds --help            # Show all commands
abds --version         # Show ABDS version
```

---

## Integration Patterns

### Pattern 1: Read-Only (Query)

Agent reads ABDS data but doesn't modify it.

```bash
# Read catalog
cat ~/.abds/learnings/CATALOG.md

# Search learnings
abds search "pattern"

# Check compliance
abds validate
```

**Use case**: Agent searches learnings before suggesting solutions.

### Pattern 2: Write (Contribute)

Agent adds new learnings to ABDS.

```bash
# Create learning file
cat > ~/.abds/learnings/category/file.md <<EOF
---
keywords: [...]
tldr: "..."
---
# Content
EOF

# Update catalog
abds catalog
```

**Use case**: After solving problem, agent saves solution to learnings.

### Pattern 3: Full Integration

Agent uses ABDS for project structure and knowledge.

```bash
# Initialize project with ABDS
abds init

# During work: search relevant patterns
abds search "relevant keywords"

# After work: save learnings
# (create learning file)
abds catalog

# Before commit: validate compliance
abds validate
```

**Use case**: Agent fully adopts ABDS for project organization.

---

## Best Practices

### For Agent Developers

1. **Don't reinvent**: Use `abds` commands, don't reimplement
2. **Respect filesystem**: Read/write through standard paths
3. **Update catalog**: Always run `abds catalog` after creating learnings
4. **Handle errors**: Check exit codes, show helpful messages
5. **Document integration**: Show users how to connect your agent

### For Users

1. **Choose integration level**: Read-only, write, or full
2. **Customize workflows**: Adapt examples to your needs
3. **Keep it simple**: Use filesystem + CLI (don't overcomplicate)
4. **Share patterns**: If you build integration, document it
5. **Request features**: If you need MCP or other features, ask

---

## Future: MCP Integration (v2.0+)

**When needed**, ABDS may provide an MCP (Model Context Protocol) server.

**Why defer to v2.0**:
- Filesystem + CLI sufficient for v1.0 (YAGNI)
- Simple > complex
- Universal > specific protocol
- Can add later without breaking existing integrations

**What MCP would provide**:
```typescript
// MCP Tools
{
  "tools": [
    {
      "name": "abds.search",
      "description": "Search ABDS learnings",
      "inputSchema": {
        "type": "object",
        "properties": {
          "keywords": { "type": "string" }
        }
      }
    },
    {
      "name": "abds.catalog",
      "description": "Update learnings catalog"
    }
  ]
}
```

**When to build**: When 3+ agent systems request structured protocol.

**Path forward**:
- v1.0: Filesystem + CLI (universal)
- v2.0: Add MCP server (optional, additive)
- Both coexist (non-breaking)

---

## Community Integrations

Have you built an integration? Share it!

### Potential Packages (Community-Maintained)

- `abds-claude-skills` - Claude Code skills collection
- `abds-cursor-extension` - Cursor editor extension
- `abds-aider-config` - Aider configuration templates
- `abds-vscode-extension` - VS Code extension
- `abds-vim-plugin` - Vim/Neovim plugin

**ABDS core**: Filesystem + CLI (universal foundation)
**Community**: Agent-specific packages (specific integrations)

---

## Support

**Questions**: GitHub Issues
**Documentation**: https://github.com/nayol/abds
**Spec**: `~/.abds/share/abds/ABDS-1.0.md` (if installed)

---

## Summary

**ABDS provides universal interfaces**: Filesystem + CLI

**Any agent can integrate**: Read files, execute commands

**No coupling**: Clean separation, independent evolution

**Future-proof**: MCP possible later, non-breaking

**Get started**: `abds init` in your project

---

**The principle**: Build on standard interfaces. Let the ecosystem extend.
