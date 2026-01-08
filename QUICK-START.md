# Ralph Wiggum - Quick Start Guide

Get up and running with Ralph in 60 seconds.

## Installation

```bash
# Navigate to Ralph directory
cd /Users/danriding/ralph-wiggum

# Start Claude Code with plugin
claude --dangerously-skip-permissions --plugin-dir .
```

**Important:** The `--dangerously-skip-permissions` flag is essential for Ralph to work autonomously without interrupting for file operation permissions.

## Commands

Once inside Claude Code:

### 1. Free-Form Loop
```bash
/ralph-wiggum:loop Build a REST API with user authentication
```

Ralph will iterate until the task is complete.

### 2. PRD-Based Development
```bash
/ralph-wiggum:prd
```

Works through stories in `scripts/ralph/prd.json` one at a time.

### 3. Security Review
```bash
/ralph-wiggum:big-dog
```

Big Dog reviews your code for security vulnerabilities and quality issues.

### 4. Get Help
```bash
/ralph-wiggum:help
```

## External Script Mode

For automation outside Claude Code:

```bash
# Install amp CLI
npm install -g @anthropic-ai/amp

# Run Ralph
cd scripts/ralph
./ralph.sh 20                    # 20 iterations, Opus 4.5 (default)
./ralph.sh 20 prompt.md sonnet   # Use Sonnet 4.5 instead
```

## PRD Setup (5 minutes)

1. **Edit your PRD:**
```bash
vim scripts/ralph/prd.json
```

2. **Add your stories:**
```json
{
  "branchName": "feature/my-feature",
  "userStories": [
    {
      "id": "US-001",
      "title": "Add login form",
      "acceptanceCriteria": [
        "Email/password fields render",
        "Validates email format",
        "typecheck passes",
        "Verify at localhost:3000/login"
      ],
      "priority": 1,
      "passes": false,
      "notes": ""
    }
  ]
}
```

3. **Run Ralph:**
```bash
# Interactive
claude --dangerously-skip-permissions --plugin-dir /Users/danriding/ralph-wiggum
/ralph-wiggum:prd

# Or script mode
cd scripts/ralph
./ralph.sh 20
```

## Tips

✅ **Keep stories small** - Each story should complete in 1-2 iterations
✅ **Use explicit criteria** - Not "works", but "shows error on invalid email"
✅ **Always use skip-permissions** - Essential for autonomous loops
✅ **Run Big Dog before deploys** - Security review before production
✅ **Check AGENTS.md** - Maintains cross-cutting patterns

## Common Issues

**Loop keeps stopping?**
```bash
# Make sure you used --dangerously-skip-permissions
claude --dangerously-skip-permissions --plugin-dir .
```

**Commands not showing?**
```bash
# Restart Claude Code with the plugin directory
claude --dangerously-skip-permissions --plugin-dir /Users/danriding/ralph-wiggum
```

**Script fails with "amp not found"?**
```bash
npm install -g @anthropic-ai/amp
```

## Full Documentation

- [README.md](README.md) - Complete documentation
- [scripts/ralph/README.md](scripts/ralph/README.md) - PRD workflow details
- [scripts/ralph/STORY-SIZING.md](scripts/ralph/STORY-SIZING.md) - Story sizing guide
- [AGENT-NICKNAMES.md](AGENT-NICKNAMES.md) - Agent reference

---

🐕 **Pro Tip:** Run `/ralph-wiggum:big-dog` before every production deploy!
