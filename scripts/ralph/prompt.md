# Ralph Agent Instructions

## Your Task

1. Read `scripts/ralph/prd.json`
2. Read `scripts/ralph/progress.txt`
   (check Codebase Patterns first)
3. Check you're on the correct branch (see `branchName` in prd.json)
4. Pick highest priority user story from `userStories`
   where `passes: false`
5. Implement that ONE story
6. Run typecheck and tests
7. Update AGENTS.md files with learnings (see guidelines below)
8. Commit: `feat: [ID] - [Title]`
9. Update prd.json: set that story's `passes: true`
10. Append learnings to progress.txt

## AGENTS.md Guidelines

Update AGENTS.md with reusable patterns and gotchas.

### ✅ Good Additions
- "When modifying X, also update Y"
- "This module uses pattern Z"
- "Tests require dev server running"
- Cross-file dependencies
- Non-obvious patterns
- Setup requirements

### ❌ Don't Add
- Story-specific details (belongs in progress.txt)
- Temporary notes
- Info already in progress.txt
- One-time decisions

Think: "Will this help the next agent working on ANY story?"

## UI Testing with dev-browser

For UI changes, use the dev-browser skill (https://github.com/SawyerHood/dev-browser):

1. **Start the browser server:**
```bash
~/.config/amp/skills/dev-browser/server.sh &
# Wait for "Ready" message
```

2. **Write test script using heredoc:**
```bash
cd ~/.config/amp/skills/dev-browser && npx tsx <<'EOF'
import { connect, waitForPageLoad } from "@/client.js";

const client = await connect();
const page = await client.page("test");
await page.setViewportSize({ width: 1280, height: 900 });
const port = process.env.PORT || "3000";
await page.goto(`http://localhost:${port}/your-page`);
await waitForPageLoad(page);
await page.screenshot({ path: "tmp/screenshot.png" });
await client.disconnect();
EOF
```

3. **Verify the screenshot** to confirm UI renders correctly

Use this for acceptance criteria like "Verify at localhost:$PORT/login"

## Progress Format

APPEND to progress.txt:

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

Add reusable patterns to the TOP of progress.txt under "Codebase Patterns":

```
## Codebase Patterns
- Migrations: IF NOT EXISTS
- Types: Export from actions.ts
```

## Key Files

Add important files under "Key Files" section:

```
## Key Files
- db/schema.ts
- app/auth/actions.ts
```

## Stop Condition

If ALL stories pass, reply:
```
<promise>COMPLETE</promise>
```

Otherwise end normally.
