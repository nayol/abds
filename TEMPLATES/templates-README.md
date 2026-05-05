# ABDS Templates

**Location**: `~/.abds/templates/` (when installed)

**Purpose**: Standard templates for ABDS-compliant documentation

**Status**: These templates ensure consistent formatting across projects

---

## Overview

ABDS templates provide consistent structure for different document types. Copy these templates to your project and fill them in.

**Philosophy**: Templates are starting points, not rigid requirements. Adapt to your needs.

---

## Available Templates

### Core Templates (Required for Compliance)

#### PROJECT-STATE.md - Layer 1: Project Overview

**Purpose**: 2-minute overview of entire project

**Location**: `.abds/docs/PROJECT-STATE.md`

**Updated**: Daily or weekly

**Audience**: Anyone starting work on the project

**Contains**:
- Current sprint focus
- What's working / broken / in-progress
- Active problems
- Recent changes (last 7 days)
- Quick links to features

**Usage**:
```bash
cp ~/.abds/templates/PROJECT-STATE.md .abds/docs/PROJECT-STATE.md
# Edit to reflect current project state
```

**Why it matters**: First place agent looks when joining project

---

#### STATE.md - Layer 2: Feature State

**Purpose**: Current state of specific feature

**Location**: `.abds/docs/{feature}/STATE.md`

**Updated**: When feature changes

**Audience**: Anyone working on this feature

**Contains**:
- What's deployed and working
- Known issues and bugs
- Key files and modules
- Configuration
- Dependencies

**Usage**:
```bash
mkdir -p .abds/docs/authentication
cp ~/.abds/templates/STATE.md .abds/docs/authentication/STATE.md
# Edit to reflect feature state
```

**Why it matters**: Answers "what's the current state?" without digging through code

---

#### CLAUDE.md - Layer 3: Architecture

**Purpose**: Architecture and "why" decisions

**Location**: `.abds/docs/{feature}/CLAUDE.md`

**Updated**: Rarely (when architecture changes)

**Audience**: Understanding design decisions

**Contains**:
- Architecture overview
- Design decisions and trade-offs
- Implementation patterns
- Historical context ("why we chose X over Y")
- Future considerations

**Usage**:
```bash
cp ~/.abds/templates/CLAUDE.md .abds/docs/authentication/CLAUDE.md
# Document architecture and design decisions
```

**Why it matters**: Prevents "why did we do it this way?" questions 6 months later

---

#### session-summary.md - Layer 4: Work History

**Purpose**: Chronological work history

**Location**: `.abds/docs/{feature}/sessions/{description}_{DATE}/`

**Updated**: Never (frozen in time)

**Audience**: "What happened on April 19?"

**Contains**:
- What was done
- How we thought through problems
- What was tried (including failures)
- Debugging journeys
- Decisions made

**Usage**:
```bash
mkdir -p .abds/docs/auth/sessions/oauth-impl_16_01_2026
cp ~/.abds/templates/session-summary.md .abds/docs/auth/sessions/oauth-impl_16_01_2026/oauth-impl.md
# Document session work
```

**Why it matters**: Historical research - "when did we add JWT support?"

---

#### INDEX.md - Fast Navigation (Auto-Generated)

**Purpose**: Fast navigation for AI agents ( 10-15x speed improvement)

**Location**:
- `.abds/docs/INDEX.md` (root level)
- `.abds/docs/{feature}/INDEX.md` (feature level)
- `.abds/docs/{feature}/sessions/INDEX.md` (sessions level)

**Updated**: Auto-generated on demand

**Audience**: AI agents navigating documentation

**Contains**:
- **Root INDEX.md**: All features with status, file counts, quick answers
- **Feature INDEX.md**: Core docs, raw transcripts, sessions, file tree
- **Sessions INDEX.md**: Chronological session list with dates and summaries

**Recommended Approach - Auto-Generate**:
```bash
# Generate for entire project (recommended)
~/.abds/bin/generate-index --all .abds/docs/

# Generate for specific directory
~/.abds/bin/generate-index .abds/docs/auth/
```

**Manual Approach** (if no script available):
```bash
# Create basic INDEX.md manually
cat > .abds/docs/auth/INDEX.md << 'EOF'
# auth - Feature Index

**Last Updated**: 2026-05-05
**Status**: ✅ Working

## Quick Navigation

- [Current State](STATE.md)
- [Architecture](CLAUDE.md)
- [Sessions](sessions/)

## Documentation Files

- **STATE.md** - Current authentication state
- **CLAUDE.md** - OAuth architecture and decisions

## Sessions

- [oauth-impl_16_01_2026](sessions/oauth-impl_16_01_2026/)
EOF
```

**Why it matters**:
- Without INDEX.md: Agent scans 50+ files randomly (40-50 seconds)
- With INDEX.md: Agent reads structured index (2-3 seconds)
- **Result**: 10-15x faster navigation

**When to regenerate**:
- After adding new documentation files
- After creating new sessions
- When reorganizing directory structure
- Recommended: Run `generate-index --all` before committing docs

**Note**: INDEX.md files are typically auto-generated and should not be manually edited (changes will be overwritten on next generation).

---

### Optional Templates

#### learning.md - Learning Documentation

**Purpose**: Capture cross-project learnings

**Location**: `~/.abds/learnings/{category}/{descriptive-name}.md`

**Contains**:
- YAML frontmatter (keywords, category, tldr)
- TL;DR section
- Applies When
- Symptom
- Root Cause
- Solution
- Projects Applied

**Usage**:
```bash
cp ~/.abds/templates/learning.md ~/.abds/learnings/database/new-learning.md
# Document learning
# Run: ~/.abds/bin/update-catalog
```

**Why it matters**: Prevents solving same problem multiple times

---

#### README.md - Documentation Index

**Purpose**: Navigation and orientation within project documentation

**Location**: `.abds/docs/README.md`

**Contains**:
- Project overview
- Links to features
- Documentation structure explanation
- Quick reference

**Usage**:
```bash
cp ~/.abds/templates/README.md .abds/docs/README.md
# Customize for your project
```

**Why it matters**: Central navigation hub for project docs

---

## The Four Layers Explained

ABDS templates implement a 4-layer documentation system:

```
Layer 1: PROJECT-STATE.md (Project overview)
  ↓ Different update frequency, different audience
Layer 2: {feature}/STATE.md (Current state)
  ↓ Different volatility, different purpose
Layer 3: {feature}/CLAUDE.md (Architecture)
  ↓ Semi-stable, design decisions
Layer 4: {feature}/sessions/ (History)
  ↓ Immutable, chronological record
```

**Why layers?**

| Layer | Updates | Volatility | Audience | Purpose |
|-------|---------|------------|----------|---------|
| 1 | Daily | High | Quick overview | What's happening NOW |
| 2 | Weekly | Medium | Feature work | What's the current state |
| 3 | Rarely | Low | Architecture | Why we made these decisions |
| 4 | Never | Immutable | Research | What happened historically |

**Separation of concerns**: Current state ≠ architecture ≠ history

---

## Using Templates

### Manual Approach

```bash
# 1. Copy template
cp ~/.abds/templates/STATE.md .abds/docs/myfeature/STATE.md

# 2. Edit file
vim .abds/docs/myfeature/STATE.md

# 3. Commit
git add .abds/docs/myfeature/STATE.md
git commit -m "Add STATE.md for myfeature"
```

### Automated Approach (using init-abds)

```bash
# Initialize ABDS structure (copies templates automatically)
cd my-project
~/.abds/bin/init-abds
```

### Custom Templates

You can create custom templates in `~/.abds/templates/`:

```bash
# Create custom template
cat > ~/.abds/templates/api-endpoint.md << 'EOF'
# API Endpoint: {name}

## Endpoint
`{METHOD} /api/{path}`

## Purpose
{What this endpoint does}

## Authentication
{Required auth}

## Request
{Request format}

## Response
{Response format}

## Examples
{Usage examples}
EOF
```

---

## Template Customization

**Templates are starting points**. Adapt them to your needs:

**Sections**:
- Add project-specific sections
- Remove sections that don't apply
- Reorder to match your workflow

**Formatting**:
- Adjust markdown style
- Add tables, diagrams, code blocks
- Use your preferred heading structure

**Content**:
- Use language that fits your team
- Add examples relevant to your domain
- Include project-specific conventions

**The rule**: Consistency within project > perfect adherence to template

---

## Best Practices

### When to Use Each Template

**PROJECT-STATE.md**: Always (required for ABDS compliance)
- Every project needs one
- Update regularly (daily/weekly)
- Keep it short (2 minutes to read)

**STATE.md**: For each feature/domain (required)
- At least one per project
- One per major feature or domain
- Examples: `auth/STATE.md`, `database/STATE.md`, `api/STATE.md`

**CLAUDE.md**: For complex features (recommended)
- When architecture is non-trivial
- When design decisions need explanation
- When "why" matters for future maintenance

**session-summary.md**: For significant work (recommended)
- Major features
- Complex debugging sessions
- Architecture changes
- When you want to remember "how we thought"

**learning.md**: When solving hard problems (optional)
- Problem applies to multiple projects
- Solution non-obvious
- Likely to forget without documentation

### Keeping Templates Updated

**Don't let docs get stale**:

PROJECT-STATE.md:
- Review weekly
- Update after major changes
- Remove completed items

STATE.md:
- Update when feature changes
- Mark "last updated" date
- Remove outdated information

CLAUDE.md:
- Update when architecture changes
- Add new design decisions
- Keep "why" explanations current

sessions/:
- NEVER update (immutable history)
- Create new session for new work

---

## Template Format Standards

### Markdown Standards

**Headings**: Use ATX-style (`#` not `===`)
```markdown
# Level 1
## Level 2
### Level 3
```

**Lists**: Consistent bullet style
```markdown
- Item 1
- Item 2
  - Nested item
```

**Code blocks**: Always specify language
```markdown
```bash
command here
```
```

**Links**: Use reference-style for clarity
```markdown
See [documentation][1] for details.

[1]: https://example.com/docs
```

### YAML Frontmatter (for learnings)

**Required fields**:
```yaml
---
keywords: [keyword1, keyword2]
category: database
confidence: verified | tested | theoretical
tldr: "One-line summary"
description: "Problem description"
projects_applied:
  - name: project-name
    date: YYYY-MM-DD
    notes: "Context"
---
```

**Keywords**: 3-7 keywords, lowercase, searchable
**TL;DR**: Under 100 characters, actionable
**Confidence**:
- `verified` - Used in production successfully
- `tested` - Tested but not deployed
- `theoretical` - Not yet tested

---

## Installation

Templates are included in the ABDS specification repository.

### Install to ~/.abds/templates/

```bash
# Clone ABDS repository
git clone https://github.com/abds-spec/abds.git

# Copy templates
mkdir -p ~/.abds/templates
cp -r abds/TEMPLATES/* ~/.abds/templates/

# Verify installation
ls ~/.abds/templates/
```

### Update Templates

```bash
# Pull latest changes
cd abds
git pull

# Update templates
cp -r TEMPLATES/* ~/.abds/templates/
```

---

## Examples

### Example PROJECT-STATE.md

```markdown
# MyApp Project State

**Last Updated**: 2026-05-05

## Current Focus
- Implementing OAuth2 authentication
- Migration to Supabase RLS

## What Works - User registration and login
- Basic CRUD operations
- Database migrations

## Active Problems - OAuth refresh token rotation (investigating)
- RLS policies for admin users (blocked on Supabase support)

## Recent Changes (Last 7 Days)
- 2026-05-04: Added JWT token validation
- 2026-05-03: Migrated sessions table to Supabase
- 2026-05-01: Refactored auth context

## Features
- [Authentication](auth/STATE.md) - In progress
- [Database](database/STATE.md) - Working
- [API](api/STATE.md) - Stable
```

### Example STATE.md (Feature)

```markdown
# Authentication State

**Last Updated**: 2026-05-05

## What's Working
- User registration with email/password
- Login with JWT tokens
- Token refresh mechanism
- Protected routes

## Known Issues
- OAuth refresh token rotation not implemented yet
- Social login (Google) in progress

## Key Files
- `src/auth/AuthContext.tsx` - React auth context
- `src/auth/api.ts` - Auth API calls
- `supabase/migrations/20260501_auth_tables.sql` - Database schema

## Configuration
- JWT expires: 1 hour
- Refresh token expires: 7 days
- Session stored in: httpOnly cookies

## Dependencies
- Supabase Auth
- jose (JWT library)
```

---

## FAQ

**Q: Can I modify templates?**
A: Yes! Templates are starting points. Customize for your project.

**Q: Do I need all templates?**
A: Minimum: PROJECT-STATE.md + at least one STATE.md. Others are optional.

**Q: What if template doesn't fit?**
A: Adapt it. Keep the spirit (separation of layers) but change structure.

**Q: Can I create custom templates?**
A: Absolutely. Add them to `~/.abds/templates/`.

**Q: How do I keep templates synced?**
A: Pull latest ABDS repo, copy new templates to `~/.abds/templates/`.

---

## Contributing

Found a better template structure? Share it!

1. Fork ABDS repository
2. Improve templates in `TEMPLATES/`
3. Submit pull request

See `CONTRIBUTING.md` in main repository.

---

## License

**CC0 1.0 Universal (Public Domain)**

Templates are released into the public domain. Use them freely.

---

## Learn More

**Full specification**: See ABDS-1.0.md

**Repository**: https://github.com/abds-spec/abds

**Examples**: See `examples/` directory in repository

---

**ABDS Templates** - Consistent structure for documentation across projects
