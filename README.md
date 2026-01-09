# Ralph Wiggum Plugin

Implementation of the Ralph Wiggum technique - continuous self-referential AI loops for interactive iterative development.

**🚀 New here? See [QUICK-START.md](QUICK-START.md) for a 60-second guide!**

## What is this?

The Ralph Wiggum technique enables Claude to work in a persistent loop, continuously iterating on a task until completion. Instead of single-shot responses, Claude assesses the current state, plans the next step, executes it, evaluates progress, and loops - all autonomously.

**Two ways to use it:**
1. **Interactive Plugin** - Inside Claude Code with `/ralph-wiggum:*` commands
2. **Automated Script** - External bash script using the `amp` CLI

## Installation

### Development/Testing

```bash
# Standard mode (with permission prompts)
claude --plugin-dir /Users/danriding/ralph-wiggum

# Skip permission prompts (for automation)
claude --dangerously-skip-permissions --plugin-dir /Users/danriding/ralph-wiggum
```

**Note:** Use `--dangerously-skip-permissions` when you want Ralph to work autonomously without interruption. This skips all permission prompts for file operations.

### Production

1. Create a local marketplace:
```bash
mkdir -p my-marketplace/.claude-plugin
```

2. Create `my-marketplace/.claude-plugin/marketplace.json`:
```json
{
  "name": "my-plugins",
  "owner": {
    "name": "Your Name"
  },
  "plugins": [
    {
      "name": "ralph-wiggum",
      "source": "./ralph-wiggum",
      "description": "Continuous self-referential AI loops for iterative development",
      "version": "1.0.0"
    }
  ]
}
```

3. Install:
```bash
/plugin marketplace add ./my-marketplace
/plugin install ralph-wiggum@my-plugins
```

## Usage: Interactive Plugin Mode

Perfect for exploratory development inside Claude Code.

**Recommended:** Start Claude Code with `--dangerously-skip-permissions` for uninterrupted loops:
```bash
claude --dangerously-skip-permissions --plugin-dir /Users/danriding/ralph-wiggum
```

### Start a Loop

```bash
/ralph-wiggum:loop Build a REST API with user authentication
```

Claude will continuously work on the task, iterating until complete without permission prompts.

### Continue a Loop

```bash
/ralph-wiggum:continue Add rate limiting to the API endpoints
```

Adds new context or instructions to the current loop.

### PRD-Based Development

Work through structured stories from a Product Requirements Document:

```bash
/ralph-wiggum:prd
```

This reads from `scripts/ralph/prd.json`, implements stories one at a time, and tracks progress. See [PRD Workflow](#prd-workflow) below for details.

### Security & Code Review

🐕 **Big Dog** - Your security specialist:

```bash
/ralph-wiggum:big-dog
```

Performs comprehensive security audits and code quality reviews. Checks for:
- Security vulnerabilities (XSS, SQL injection, CSRF, etc.)
- Code quality issues
- Performance problems
- Architecture concerns

**Use Big Dog:**
- Before deploying to production
- After implementing auth/security features
- Regular security audits

See [AGENT-NICKNAMES.md](AGENT-NICKNAMES.md) for quick reference.

### Skills Integration

🔧 **Supercharge Ralph with Claude Skills!**

Ralph integrates with skills from [awesome-claude-skills](https://github.com/astroAi1/awesome-claude-skills):

**Recommended Skills:**
- **git-pushing** - Automated git commits and pushes
- **test-fixing** - Auto-fix failing tests
- **review-implementing** - Apply Big Dog's security fixes automatically
- **playwright** - Enhanced UI testing

**Quick Setup:**
```bash
# Install skills
mkdir -p ~/.config/claude-code/skills
cd ~/.config/claude-code/skills
# Clone skills you want (see SKILLS-INTEGRATION.md)
```

Ralph automatically uses installed skills during workflows!

See [SKILLS-INTEGRATION.md](SKILLS-INTEGRATION.md) for complete guide.

### Get Help

```bash
/ralph-wiggum:help
/ralph-wiggum:script  # Learn about script mode
/ralph-wiggum:prd     # PRD-based workflow
```

## PRD Workflow

Perfect for structured, story-based development with progress tracking.

### Setup

1. **Edit your PRD**:
```bash
vim scripts/ralph/prd.json
```

Example PRD:
```json
{
  "branchName": "ralph/feature",
  "userStories": [
    {
      "id": "US-001",
      "title": "Add login form",
      "acceptanceCriteria": [
        "Email/password fields render",
        "Validates email format (regex)",
        "Shows error on invalid email",
        "typecheck passes",
        "Verify at localhost:$PORT/login (PORT defaults to 3000)"
      ],
      "priority": 1,
      "passes": false,
      "notes": ""
    }
  ]
}
```

2. **Run the PRD workflow**:

**Interactive (Claude Code):**
```bash
# First, start Claude Code with skip-permissions flag
claude --dangerously-skip-permissions --plugin-dir /Users/danriding/ralph-wiggum

# Then run the PRD workflow
/ralph-wiggum:prd
```

**Script (External):**
```bash
cd scripts/ralph
./ralph.sh 20
```

Ralph will:
- Read prd.json and progress.txt
- Pick highest priority story where `passes: false`
- Implement that story
- Run tests
- Commit: `feat: [ID] - [Title]`
- Update prd.json: `passes: true`
- Append learnings to progress.txt
- Repeat for next story

### Story Sizing Tips

**Keep stories small!** Each should complete in 1-2 iterations.

❌ **Too big:** "Build entire auth system"

✅ **Right size:**
- "Add login form"
- "Add email validation"
- "Add auth server action"

See `scripts/ralph/README.md` for detailed sizing guidelines.

### Progress Tracking

Ralph maintains `scripts/ralph/progress.txt`:

```
## Codebase Patterns
- Database: Use IF NOT EXISTS in migrations
- React: useRef<Timeout | null>(null)

---

## 2026-01-08 - STORY-001
- Implemented project setup
- Files changed: package.json, tsconfig.json
- **Learnings:**
  - TypeScript strict mode catches more bugs
---
```

### Completion

When all stories have `passes: true`, Ralph outputs:
```
<promise>COMPLETE</promise>
```

See `scripts/ralph/README.md` for full PRD workflow documentation.

## Usage: Automated Script Mode

Perfect for batch processing, automation, and CI/CD.

### Prerequisites

Install the Anthropic `amp` CLI:
```bash
npm install -g @anthropic-ai/amp
```

### Quick Start

1. **Edit the prompt file**:
```bash
cd /Users/danriding/ralph-wiggum
vim prompt.md  # Describe your task
```

2. **Run the loop**:
```bash
./scripts/ralph/ralph.sh
```

3. **Or use an example**:
```bash
./scripts/ralph/ralph.sh 10 examples/example-api.md
```

### Script Options

```bash
# Default: 10 iterations, prompt.md, Opus 4.5
./scripts/ralph/ralph.sh

# Custom iterations
./scripts/ralph/ralph.sh 20

# Custom prompt file
./scripts/ralph/ralph.sh 15 my-custom-prompt.md

# Specify model (opus, sonnet, haiku)
./scripts/ralph/ralph.sh 20 prompt.md opus    # Opus 4.5 (default, most powerful)
./scripts/ralph/ralph.sh 20 prompt.md sonnet  # Sonnet 4.5 (faster, cheaper)
./scripts/ralph/ralph.sh 20 prompt.md haiku   # Haiku 3.5 (fastest, cheapest)
```

**Model Selection:**
- **opus** (default) - Claude Opus 4.5 - Most capable, best for complex tasks
- **sonnet** - Claude Sonnet 4.5 - Balanced performance and speed
- **haiku** - Claude Haiku 3.5 - Fast and cost-effective for simple tasks

### Completion Markers

In your prompt file, instruct Claude to output:
- `<promise>COMPLETE</promise>` - When task is fully done
- `<promise>BLOCKED</promise>` - When needs user input

The script automatically detects these markers.

## How It Works

1. **Assess**: Understand current state and what's been done
2. **Plan**: Identify the most valuable next step
3. **Execute**: Complete that step using available tools
4. **Evaluate**: Check if complete or if another iteration needed
5. **Loop**: If not complete, go back to step 1

## Comparison: Plugin vs Script

| Feature | Interactive Plugin | Automated Script |
|---------|-------------------|------------------|
| **Environment** | Inside Claude Code | External terminal |
| **Command** | `/ralph-wiggum:loop` | `./scripts/ralph/ralph.sh` |
| **Interaction** | Conversational | File-based |
| **Use Case** | Exploratory development | Batch processing |
| **Continuity** | Session-based | Stateless iterations |
| **Best For** | Active coding sessions | Automation, CI/CD |

## Project Structure

```
ralph-wiggum/
├── .claude-plugin/
│   └── plugin.json          # Plugin manifest
├── commands/
│   ├── loop.md              # Interactive loop command
│   ├── continue.md          # Continue command
│   ├── prd.md               # PRD-based workflow command
│   ├── big-dog.md           # 🐕 Security & code review agent
│   ├── help.md              # Plugin help
│   └── script.md            # Script mode help
├── scripts/
│   └── ralph/               # PRD workflow files
│       ├── ralph.sh         # Automated loop script
│       ├── prompt.md        # PRD workflow instructions
│       ├── prd.json         # Product Requirements Document
│       ├── progress.txt     # Development log & patterns
│       ├── AGENTS.md        # Agent knowledge base
│       ├── README.md        # PRD workflow docs
│       └── STORY-SIZING.md  # Story sizing guide
├── examples/
│   ├── example-api.md       # REST API example
│   └── example-simple.md    # Simple task example
├── AGENT-NICKNAMES.md       # Quick reference for agent nicknames
├── QUICK-START.md           # 60-second getting started guide
├── SKILLS-INTEGRATION.md    # Claude Skills integration guide
├── GITHUB-SETUP.md          # GitHub setup instructions
├── LICENSE                  # MIT License
├── prompt.md                # General prompt template
├── package.json             # Package metadata
└── README.md                # This file
```

## Examples

### Interactive Mode

```bash
# Inside Claude Code
/ralph-wiggum:loop Create a Python calculator with tests

# Claude will iterate:
# Iteration 1: Create calculator.py
# Iteration 2: Add test_calculator.py
# Iteration 3: Run tests
# Iteration 4: Fix any issues
# LOOP COMPLETE ✅
```

### Script Mode

```bash
# From terminal (uses Opus 4.5 by default)
./scripts/ralph/ralph.sh 10 examples/example-simple.md

# Or specify a different model
./scripts/ralph/ralph.sh 10 examples/example-simple.md sonnet

# Output:
# 🚀 Starting Ralph Wiggum Loop
# 📄 Prompt file: examples/example-simple.md
# 🔄 Max iterations: 10
# 🤖 Model: opus (claude-opus-4-5-20251101)
#
# ═══ Iteration 1 of 10 ═══
# [Claude creates calculator.py]
# ═══ Iteration 2 of 10 ═══
# [Claude creates tests]
# ═══ Iteration 3 of 10 ═══
# [Claude runs tests]
# ✅ Loop completed successfully!
```

### Security Review with Big Dog

```bash
# Inside Claude Code
/ralph-wiggum:big-dog

# Big Dog will review:
# 🔒 Security vulnerabilities
# 💎 Code quality issues
# ⚡ Performance problems
# 🏗️ Architecture concerns

# Output includes:
# 🚨 Critical Issues (Fix Immediately)
# ⚠️ High Priority (Fix Soon)
# 💡 Improvements (Consider)
# ✅ Good Practices Found

# Review specific files:
/ralph-wiggum:big-dog src/auth/* app/api/*
```

## Loop Behavior

### Loop Stops When

- Task is fully complete
- Blocker requiring user input encountered
- User provides new instructions (interactive mode)
- Max iterations reached (script mode)

### Best Practices

1. **Be specific**: Provide clear task descriptions
2. **Let it run**: Allow multiple iterations before interrupting
3. **Track progress**: The plugin uses TodoWrite for visibility
4. **Provide feedback**: Use `/ralph-wiggum:continue` or refine prompts
5. **Trust the process**: The loop will continue until completion

## Advanced: CI/CD Integration

```bash
#!/bin/bash
# .github/workflows/auto-task.sh

TASK_FILE="tasks/current.md"
MAX_ITER=20

./ralph-wiggum/scripts/ralph/ralph.sh $MAX_ITER $TASK_FILE

if [ $? -eq 0 ]; then
  echo "✅ Task completed"
  git add .
  git commit -m "Auto: Task completed by Ralph Wiggum"
  git push
else
  echo "❌ Task failed or blocked"
  exit 1
fi
```

## Benefits

- **Autonomous progress**: Claude works without constant prompting
- **Incremental development**: Steady progress through iterations
- **Transparent tracking**: Uses TodoWrite for visibility (plugin mode)
- **Natural flow**: More conversation-like development process
- **Automation-ready**: Script mode enables CI/CD integration
- **Flexible**: Choose interactive or automated based on needs
- **Uninterrupted loops**: Use `--dangerously-skip-permissions` for fully autonomous execution

## Permission Handling

### Understanding `--dangerously-skip-permissions`

**What it does:**
- Skips all file operation permission prompts
- Allows Ralph to work autonomously without interruption
- Essential for true iterative loops

**When to use it:**
- ✅ Running Ralph loops (recommended)
- ✅ PRD-based development
- ✅ Automated workflows
- ✅ When you trust Ralph to make file changes

**When NOT to use it:**
- ❌ First time exploring a new codebase
- ❌ When you want to review each change
- ❌ Working with sensitive/production code you're unfamiliar with

**Example:**
```bash
# With permissions (Ralph will ask before each file operation)
claude --plugin-dir /Users/danriding/ralph-wiggum

# Without permissions (Ralph works autonomously)
claude --dangerously-skip-permissions --plugin-dir /Users/danriding/ralph-wiggum
```

## Troubleshooting

### Script mode: "amp not found"
```bash
npm install -g @anthropic-ai/amp
```

### Script mode: "Prompt file not found"
```bash
# Use absolute path or correct relative path
./scripts/ralph/ralph.sh 10 /full/path/to/prompt.md
```

### Interactive mode: Commands not showing
```bash
# Restart Claude Code with plugin
claude --plugin-dir /Users/danriding/ralph-wiggum
```

### Interactive mode: Loops keep stopping for permissions
```bash
# Use --dangerously-skip-permissions flag
claude --dangerously-skip-permissions --plugin-dir /Users/danriding/ralph-wiggum
```

This allows Ralph to work autonomously without asking for permission on each file operation.

## Author

Daniel Riding (danriding29@gmail.com)

## Version

1.0.0

## License

MIT
