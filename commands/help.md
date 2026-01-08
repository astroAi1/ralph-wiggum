---
description: Learn about the Ralph Wiggum technique and available commands
---

# Ralph Wiggum Plugin Help

## What is the Ralph Wiggum Technique?

The **Ralph Wiggum technique** is a methodology for continuous self-referential AI loops in interactive iterative development. Instead of one-shot task completion, Claude works in a persistent loop, continuously assessing, planning, executing, and evaluating until a task is fully complete.

## Why "Ralph Wiggum"?

Named after the lovably persistent Simpsons character, this technique embraces continuous iteration and self-referential learning - keeping at it until the job is done.

## Available Commands

### `/ralph-wiggum:loop [task description]`
Start a new iterative development loop for the specified task. Claude will continuously work on the task, making incremental progress through multiple iterations until completion or a blocker is encountered.

**Example:**
```
/ralph-wiggum:loop Build a user authentication system with login, signup, and password reset
```

### `/ralph-wiggum:continue [additional context]`
Continue the current loop with additional instructions or context. Use this when you want to provide more information or adjust the direction without starting over.

**Example:**
```
/ralph-wiggum:continue Use JWT tokens instead of sessions
```

### `/ralph-wiggum:prd`
Work through a Product Requirements Document (PRD) with structured story tracking. Reads from `scripts/ralph/prd.json`, implements stories one at a time, and tracks progress in `scripts/ralph/progress.txt`.

**Example:**
```
/ralph-wiggum:prd
```

### `/ralph-wiggum:script`
Learn about using the automated bash script for external loop execution.

### `/ralph-wiggum:big-dog`
🐕 **Big Dog** - Your code review and security specialist. Run comprehensive security audits, find vulnerabilities, and get code quality feedback.

**Example:**
```
/ralph-wiggum:big-dog
/ralph-wiggum:big-dog src/auth/* app/api/*
```

### `/ralph-wiggum:help`
Display this help information.

## Best Practices

1. **Be specific**: Provide clear task descriptions when starting a loop
2. **Let it run**: Allow multiple iterations before interrupting
3. **Track progress**: The plugin uses TodoWrite to maintain visibility
4. **Provide feedback**: Use `/ralph-wiggum:continue` to guide the iterations
5. **Trust the process**: The loop will continue until completion or a genuine blocker

## Loop Behavior

The loop will automatically stop when:
- The task is fully complete
- A blocker requiring user input is encountered
- The user provides new instructions

Otherwise, Claude will continue iterating autonomously.

---

**Created by:** daniel riding (danriding29@gmail.com)
**Version:** 1.0.0
