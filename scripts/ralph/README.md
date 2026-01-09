# Ralph PRD Workflow

Structured story-based development using the Ralph Wiggum technique.

## Overview

This workflow uses a PRD (Product Requirements Document) to track stories and their implementation status. Ralph iteratively works through stories, one at a time, until all are complete.

## Files

- **`prd.json`** - Product Requirements Document with all stories
- **`progress.txt`** - Development log and codebase patterns
- **`prompt.md`** - Instructions for Ralph agent
- **`ralph.sh`** - Execution script

## Quick Start

### 1. Setup Your PRD

Edit `prd.json` with your stories:

```json
{
  "branchName": "ralph/feature",
  "userStories": [
    {
      "id": "US-001",
      "title": "Add login form",
      "acceptanceCriteria": [
        "Email/password fields",
        "Validates email format",
        "typecheck passes"
      ],
      "priority": 1,
      "passes": false,
      "notes": ""
    }
  ]
}
```

**Important:** Keep stories small! See [Story Sizing Best Practices](#story-sizing-best-practices) below.

### 2. Run Ralph

```bash
cd /Users/danriding/ralph-wiggum/scripts/ralph

# Default (Opus 4.5 - most powerful)
./ralph.sh 20

# Specify model explicitly
./ralph.sh 20 prompt.md opus    # Opus 4.5 (recommended)
./ralph.sh 20 prompt.md sonnet  # Sonnet 4.5 (faster, cheaper)
./ralph.sh 20 prompt.md haiku   # Haiku 3.5 (fastest, cheapest)
```

**Model Selection:**
- **opus** (default) - Most capable, best for complex tasks
- **sonnet** - Balanced performance and speed
- **haiku** - Fast and cost-effective for simple tasks

Ralph will:
1. Read prd.json and progress.txt
2. Pick the highest priority story where `passes: false`
3. Implement that story
4. Run tests (uses **test-fixing** skill if available)
5. Commit the changes (uses **git-pushing** skill if available)
6. Update prd.json to `passes: true`
7. Append learnings to progress.txt
8. Repeat until all stories pass

**Skills Integration:**
Ralph can leverage Claude Skills for automation. See [SKILLS-INTEGRATION.md](../../SKILLS-INTEGRATION.md) for setup.

### 3. Monitor Progress

Watch the console output for each iteration. Ralph will show:
- Which story is being worked on
- Files being created/modified
- Test results
- Commit messages

## PRD Structure

### Story Fields

- **`id`** - Unique identifier (e.g., "US-001")
- **`title`** - Short, focused description
- **`acceptanceCriteria`** - List of testable requirements
- **`priority`** - Numeric priority (1 = highest)
- **`passes`** - Boolean status (false = pending, true = complete)
- **`notes`** - Optional notes or context

### Example Story

```json
{
  "id": "US-001",
  "title": "Add login form",
  "priority": 1,
  "acceptanceCriteria": [
    "Email/password fields render",
    "Validates email format (regex)",
    "Shows error on invalid email",
    "Shows error on empty fields",
    "typecheck passes",
    "Verify at localhost:$PORT/login (PORT defaults to 3000)"
  ],
  "passes": false,
  "notes": ""
}
```

## Story Sizing Best Practices

**Keep stories small and focused.** Each story should be completable in one iteration.

### ❌ Too Big
```
"Build entire auth system"
"Implement user management"
"Create complete dashboard"
```

These are too large and will take many iterations, making progress hard to track.

### ✅ Right Size
```
"Add login form"
"Add email validation"
"Add auth server action"
"Add password reset form"
"Add user profile page"
```

Each story is:
- **Focused** on one specific feature
- **Testable** with clear acceptance criteria
- **Completable** in 1-2 iterations
- **Independent** or has minimal dependencies

### Breaking Down Large Stories

If you have a large feature, break it into smaller stories:

**Instead of:** "Build auth system"

**Use:**
1. `US-001` - Add login form
2. `US-002` - Add signup form
3. `US-003` - Add password reset flow
4. `US-004` - Add session management
5. `US-005` - Add auth middleware

## Progress Tracking

Ralph appends to `progress.txt` after each story:

```
## 2026-01-08 - STORY-001
- Implemented user authentication service
- Files changed: src/auth.ts, tests/auth.test.ts
- **Learnings:**
  - JWT secret should be in environment variables
  - bcrypt rounds should be 10 for good security/performance balance
---
```

### Codebase Patterns

Add discovered patterns to the top of `progress.txt`:

```
## Codebase Patterns
- Database: Always use IF NOT EXISTS in migrations
- React: Use useRef<Timeout | null>(null) for timers
- API: Validate input at route handlers
- Testing: Mock external services in unit tests
```

Ralph reads these patterns before starting each story.

## Interactive Mode

You can also use the plugin command inside Claude Code:

```bash
# First, start Claude Code with skip-permissions flag
claude --dangerously-skip-permissions --plugin-dir /Users/danriding/ralph-wiggum

# Then run the PRD workflow
/ralph-wiggum:prd
```

**Important:** Use `--dangerously-skip-permissions` to allow Ralph to work autonomously without interruption. Without this flag, Claude Code will prompt for permission on each file operation, breaking the iterative loop.

## Completion

When all stories in prd.json have `passes: true`, Ralph outputs:

```
<promise>COMPLETE</promise>
```

And exits successfully.

## AGENTS.md Knowledge Base

Ralph maintains an `AGENTS.md` file with reusable patterns and gotchas.

### ✅ Add to AGENTS.md
- "When modifying X, also update Y"
- "This module uses pattern Z"
- "Tests require dev server running"
- Cross-file dependencies
- Non-obvious patterns
- Setup requirements

### ❌ Don't Add
- Story-specific details (use progress.txt)
- Temporary notes
- Info already in progress.txt

**Purpose:** Help future agents (and Ralph iterations) avoid repeated mistakes.

## UI Testing with dev-browser

For stories with UI verification, Ralph can use [dev-browser](https://github.com/SawyerHood/dev-browser):

```bash
# 1. Start browser server
~/.config/amp/skills/dev-browser/server.sh &

# 2. Run test script
cd ~/.config/amp/skills/dev-browser && npx tsx <<'EOF'
import { connect, waitForPageLoad } from "@/client.js";

const client = await connect();
const page = await client.page("test");
await page.setViewportSize({ width: 1280, height: 900 });
await page.goto(`http://localhost:3000/login`);
await waitForPageLoad(page);
await page.screenshot({ path: "tmp/screenshot.png" });
await client.disconnect();
EOF
```

Use for acceptance criteria like "Verify at localhost:$PORT/login"

## Tips

1. **Start small**: Begin with 3-5 well-defined stories
2. **Be specific**: Clear acceptance criteria lead to better implementation
3. **Review patterns**: Check progress.txt and AGENTS.md before adding stories
4. **Iterate on PRD**: Refine stories based on what Ralph produces
5. **Monitor early**: Watch the first few iterations closely
6. **Adjust max iterations**: Complex stories may need more iterations

## Example Workflow

```bash
# 1. Create your PRD
vim prd.json

# 2. Initialize progress tracking
echo "## Codebase Patterns\n\n---\n" > progress.txt

# 3. Run Ralph
./ralph.sh 30

# 4. Review results
git log --oneline  # See commits
cat progress.txt   # Review learnings
cat prd.json       # Check story status

# 5. Add more stories if needed
vim prd.json
./ralph.sh 20
```

## Troubleshooting

### "No stories with passes: false"
All stories are complete! Ralph will output `<promise>COMPLETE</promise>`.

### "Tests failing"
Ralph will keep working on the story until tests pass. Increase max iterations if needed.

### "Max iterations reached"
The story may be too complex. Break it into smaller stories in prd.json.

## Integration with Plugin

The PRD workflow works in both modes:

| Mode | Command | Use Case |
|------|---------|----------|
| Script | `./ralph.sh` | Automated, batch processing |
| Interactive | `/ralph-wiggum:prd` | Exploratory, one story at a time |

Choose based on your needs!
