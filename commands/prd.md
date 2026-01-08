---
description: Work on PRD-based development with structured story tracking
---

# Ralph Wiggum PRD Mode

You are now working in **PRD-based development mode** - a structured workflow for implementing stories from a Product Requirements Document.

## Your Task

Follow these steps in order:

1. **Read `scripts/ralph/prd.json`** - Contains all user stories and their status
2. **Read `scripts/ralph/progress.txt`** - Check Codebase Patterns section first for established patterns
3. **Check current branch** - Ensure you're on the correct branch (see `branchName` in prd.json)
4. **Pick highest priority user story** - Find the first story in `userStories` where `passes: false`
5. **Implement that ONE story** - Focus on one story at a time, complete it fully
6. **Run typecheck and tests** - Ensure everything passes
7. **Update AGENTS.md** - Document any learnings for future reference
8. **Commit changes** - Use format: `feat: [ID] - [Title]`
9. **Update prd.json** - Set `passes: true` for the completed story
10. **Append to progress.txt** - Document what was done and learnings

## Progress Format

When appending to progress.txt, use this format:

```
## [Date] - [Story ID]
- What was implemented
- Files changed
- **Learnings:**
  - Patterns discovered
  - Gotchas encountered
---
```

## Codebase Patterns

As you discover reusable patterns, add them to the TOP of progress.txt:

```
## Codebase Patterns
- Migrations: Use IF NOT EXISTS
- React: useRef<Timeout | null>(null)
- Error handling: Always validate at boundaries
```

These patterns will guide future implementations.

## Commit Message Format

Use conventional commits:
```
feat: [STORY-ID] - [Story Title]

- Bullet point of what was done
- Another key change
- Tests added/updated
```

Example:
```
feat: STORY-001 - Setup project structure

- Created package.json with TypeScript dependencies
- Added tsconfig.json with strict mode
- Set up src/ and tests/ directories
- Added initial test setup
```

## Important Guidelines

- **One story at a time**: Complete each story fully before moving to the next
- **Check patterns first**: Review progress.txt patterns before implementing
- **Test everything**: Run typecheck and tests before marking complete
- **Document learnings**: Add valuable patterns to progress.txt
- **Update AGENTS.md**: Add reusable patterns (see guidelines in prompt)
- **Update status**: Always update prd.json when story passes
- **Incremental commits**: Commit after each story completion

## AGENTS.md Guidelines

Update AGENTS.md with reusable patterns, not story-specific details.

### ✅ Add to AGENTS.md
- "When modifying X, also update Y"
- "This module uses pattern Z"
- "Tests require dev server running"

### ❌ Don't Add
- Story-specific details (use progress.txt)
- Temporary notes
- Info already in progress.txt

## Stop Condition

After completing a story, check prd.json:

**If ALL user stories in `userStories` have `passes: true`**, output:
```
<promise>COMPLETE</promise>
```

**If more stories remain**, end normally and the loop will continue with the next iteration.

**If blocked**, output:
```
<promise>BLOCKED</promise>
```
And explain what information or decision you need.

---

**Begin working on the next story now.**
