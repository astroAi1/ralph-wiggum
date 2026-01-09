# Skills Integration Guide

Ralph Wiggum works seamlessly with Claude Skills from the [awesome-claude-skills](https://github.com/astroAi1/awesome-claude-skills) repository.

## Overview

Ralph can leverage external skills during iterative loops to enhance automation and capabilities. These skills are particularly useful in PRD workflows and security reviews.

## Recommended Skills for Ralph

### 🔄 Development Workflow Skills

#### **git-pushing** (Highly Recommended)
Automates git operations during PRD workflows.

**Use with Ralph:**
```bash
# In PRD workflow, Ralph can automatically:
# 1. Stage changes
# 2. Create semantic commits
# 3. Push to remote
# 4. Handle merge conflicts

# Installation:
# Place in ~/.config/claude-code/skills/git-pushing/
```

**Integration Point:** Step 8 of PRD workflow (Commit changes)

#### **review-implementing**
Implements code review feedback automatically.

**Use with Ralph:**
```bash
# After Big Dog security review:
# 1. Big Dog identifies issues
# 2. review-implementing applies fixes
# 3. Ralph verifies changes

# Workflow:
/ralph-wiggum:big-dog          # Security review
# Then use review-implementing skill to apply fixes
/ralph-wiggum:prd              # Continue with next story
```

**Integration Point:** After Big Dog reviews, before marking story complete

#### **test-fixing**
Automatically fixes failing tests.

**Use with Ralph:**
```bash
# In PRD workflow:
# 1. Ralph runs tests
# 2. If tests fail, invoke test-fixing skill
# 3. Re-run tests
# 4. Mark story complete if passing

# Installation:
# Place in ~/.config/claude-code/skills/test-fixing/
```

**Integration Point:** Step 6 of PRD workflow (Run typecheck and tests)

### 🧪 Testing & Quality Skills

#### **playwright** (Browser Automation)
Complements dev-browser for UI testing.

**Use with Ralph:**
```bash
# For acceptance criteria like:
# "Verify at localhost:3000/login"

# Ralph can:
# 1. Start dev server
# 2. Run playwright tests
# 3. Take screenshots
# 4. Verify UI behavior
```

**Integration Point:** UI story verification in PRD workflow

#### **Changelog Generator**
Auto-generates release notes from commits.

**Use with Ralph:**
```bash
# After completing all PRD stories:
# 1. Ralph marks all stories complete
# 2. Invoke changelog-generator
# 3. Create CHANGELOG.md entry
# 4. Commit and push
```

**Integration Point:** PRD workflow completion

### 🔒 Security Skills

#### **FFUF Web Fuzzing**
Security testing for web endpoints.

**Use with Ralph:**
```bash
# After Big Dog review:
# 1. Big Dog identifies API endpoints
# 2. Run FFUF for vulnerability testing
# 3. Document findings in AGENTS.md
```

**Integration Point:** Big Dog security review enhancement

#### **threat-hunting-with-sigma-rules**
Security event analysis.

**Use with Ralph:**
```bash
# For security-focused stories:
# 1. Implement auth features
# 2. Run threat-hunting analysis
# 3. Document security patterns
```

**Integration Point:** Security story implementation

## Installation

### Step 1: Install Claude Skills

```bash
# Create skills directory
mkdir -p ~/.config/claude-code/skills

# Clone recommended skills
cd ~/.config/claude-code/skills

# Example: Install git-pushing
git clone https://github.com/anthropics/git-pushing.git

# Example: Install review-implementing
git clone https://github.com/anthropics/review-implementing.git
```

### Step 2: Verify Skills in Claude Code

```bash
# Start Claude Code
claude --dangerously-skip-permissions --plugin-dir /Users/danriding/ralph-wiggum

# Skills should auto-load
# Check available skills with /skills command (if available)
```

### Step 3: Use with Ralph

Skills are automatically available in Ralph loops. Ralph will invoke them when appropriate.

## Enhanced PRD Workflow with Skills

### Updated Workflow Steps

1. Read `scripts/ralph/prd.json`
2. Read `scripts/ralph/progress.txt` (check Codebase Patterns)
3. Check branch (see `branchName` in prd.json)
4. Pick highest priority story where `passes: false`
5. Implement that ONE story
6. **Run typecheck and tests** → Use **test-fixing** skill if needed
7. Update AGENTS.md with learnings
8. **Commit changes** → Use **git-pushing** skill for automated commits
9. Update prd.json: `passes: true`
10. Append learnings to progress.txt

### After Big Dog Review

```bash
# 1. Run Big Dog
/ralph-wiggum:big-dog

# 2. Big Dog outputs findings
# 🚨 Critical Issues
# ⚠️ High Priority

# 3. Use review-implementing skill
# Claude automatically applies fixes for identified issues

# 4. Verify fixes
/ralph-wiggum:big-dog

# 5. Continue with PRD
/ralph-wiggum:prd
```

## Skill Configuration for Ralph

### Add to `scripts/ralph/AGENTS.md`

```markdown
## Skills Integration

### Automated Git Operations
- Use **git-pushing** skill for commits in PRD workflow
- Semantic commit messages: `feat: [ID] - [Title]`
- Auto-push after story completion

### Code Review Implementation
- After Big Dog review, use **review-implementing**
- Automatically applies security fixes
- Re-runs Big Dog to verify

### Test Automation
- Use **test-fixing** for failing tests
- Iterates until all tests pass
- Documents patterns in AGENTS.md
```

## Advanced: Custom Skill for Ralph

You can create a custom Ralph skill for the marketplace:

```markdown
---
name: ralph-wiggum-prd
description: PRD-based iterative development with story tracking
triggers:
  - "work through prd"
  - "implement stories"
  - "run ralph workflow"
---

# Ralph Wiggum PRD Workflow

[Instructions from scripts/ralph/prompt.md]
```

See [Skill Creator](https://github.com/astroAi1/awesome-claude-skills/tree/main/skill-creator) for guidance.

## Troubleshooting

### Skills Not Loading

```bash
# Check skills directory
ls ~/.config/claude-code/skills/

# Verify SKILL.md exists in each skill folder
# Restart Claude Code
```

### Skill Conflicts

If skills conflict with Ralph commands:
1. Check skill triggers in SKILL.md
2. Rename conflicting triggers
3. Restart Claude Code

### Permission Issues

Always start Claude Code with skip-permissions:
```bash
claude --dangerously-skip-permissions --plugin-dir /Users/danriding/ralph-wiggum
```

## Best Practices

1. **Install skills before starting Ralph loops** - Ensures smooth automation
2. **Test skills individually first** - Verify each skill works before integration
3. **Document skill usage in AGENTS.md** - Track which skills work well together
4. **Update progress.txt** - Note when skills are used successfully
5. **Version control skills directory** - Keep skills synced across machines

## Recommended Skills Setup

### Minimal Setup (Core Development)
```bash
~/.config/claude-code/skills/
├── git-pushing/
└── test-fixing/
```

### Enhanced Setup (With Security)
```bash
~/.config/claude-code/skills/
├── git-pushing/
├── test-fixing/
├── review-implementing/
└── playwright/
```

### Full Setup (All Features)
```bash
~/.config/claude-code/skills/
├── git-pushing/
├── test-fixing/
├── review-implementing/
├── playwright/
├── ffuf-web-fuzzing/
├── changelog-generator/
└── skill-creator/
```

## Resources

- **Skills Repository:** https://github.com/astroAi1/awesome-claude-skills
- **Skills Documentation:** https://support.claude.com/skills
- **Ralph Wiggum:** https://github.com/astroAi1/ralph-wiggum

---

💡 **Pro Tip:** Start with git-pushing and test-fixing for the biggest productivity boost!
