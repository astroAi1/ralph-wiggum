---
description: Learn how to use the Ralph Wiggum bash script for automated loops
---

# Ralph Wiggum Script Mode

The Ralph Wiggum plugin includes a **bash script** for running automated loops outside of Claude Code using the `amp` CLI.

## Two Approaches

### 1. Interactive Plugin (Inside Claude Code)
- Use `/ralph-wiggum:loop` commands
- Interactive, conversational
- Great for exploratory work

### 2. Automated Script (External)
- Run `./scripts/ralph.sh` from terminal
- Automated, repeatable
- Great for batch processing and CI/CD

---

## Using the Script Approach

### Prerequisites

Install the Anthropic `amp` CLI:
```bash
npm install -g @anthropic-ai/amp
```

### Basic Usage

1. **Create or edit your prompt file** (default: `prompt.md`):
```bash
# Copy the template
cp prompt.md my-task.md

# Edit it with your task
vim my-task.md
```

2. **Run the loop**:
```bash
# Default: 10 iterations, prompt.md
./scripts/ralph.sh

# Custom iterations
./scripts/ralph.sh 20

# Custom prompt file
./scripts/ralph.sh 10 my-task.md
```

### How It Works

1. The script reads your prompt file
2. Sends it to Claude via `amp`
3. Checks the output for completion markers:
   - `<promise>COMPLETE</promise>` - Task done! ✅
   - `<promise>BLOCKED</promise>` - Needs input ⚠️
4. Repeats until complete or max iterations reached

### Prompt File Format

Your prompt file should:
- Describe the task clearly
- Include completion criteria
- Instruct Claude to output `<promise>COMPLETE</promise>` when done
- Instruct Claude to output `<promise>BLOCKED</promise>` if stuck

**Template:** See `prompt.md` in the plugin root
**Examples:** See `examples/` directory

### Examples

```bash
# Build a REST API
cp examples/example-api.md my-api-task.md
./scripts/ralph.sh 15 my-api-task.md

# Simple calculator
./scripts/ralph.sh 5 examples/example-simple.md
```

### Exit Codes

- `0` - Success (task completed)
- `1` - Max iterations reached without completion
- `2` - Blocked (needs user input)

### Tips

- **Start small**: Test with 5 iterations first
- **Be specific**: Clear prompts get better results
- **Check progress**: The script shows all output in real-time
- **Iterate on prompts**: Refine your prompt.md based on results
- **Version control**: Track your prompt files in git

---

## Comparison: Plugin vs Script

| Feature | Plugin Commands | Bash Script |
|---------|----------------|-------------|
| **Environment** | Inside Claude Code | External terminal |
| **Interaction** | Interactive | Automated |
| **Use Case** | Exploratory work | Batch processing |
| **Continuity** | Conversational | File-based |
| **Best For** | Development | CI/CD, automation |

---

## Advanced: CI/CD Integration

```bash
#!/bin/bash
# In your CI pipeline
cd /path/to/project
cp templates/task.md current-task.md
./ralph-wiggum/scripts/ralph.sh 20 current-task.md
if [ $? -eq 0 ]; then
  echo "Task completed successfully"
  # Continue with build, test, deploy, etc.
else
  echo "Task failed or needs input"
  exit 1
fi
```

---

**See also:**
- `/ralph-wiggum:help` - Interactive plugin commands
- `README.md` - Full documentation
- `examples/` - Sample prompt files
