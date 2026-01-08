# Story Sizing Guide

Keep stories small and focused. Each story should be completable in 1-2 iterations.

## ❌ Too Big

These stories are too large and will take many iterations:

```
"Build entire auth system"
"Implement user management"
"Create complete dashboard"
"Add all CRUD operations"
"Build payment system"
```

**Problems:**
- Takes 5+ iterations to complete
- Hard to track progress
- Difficult to test
- Creates large commits
- High chance of merge conflicts

## ✅ Right Size

These stories are focused and completable:

```
"Add login form"
"Add email validation"
"Add auth server action"
"Add password reset form"
"Add user profile page"
"Add delete user endpoint"
"Add email notification"
```

**Benefits:**
- Completes in 1-2 iterations
- Clear progress tracking
- Easy to test
- Small, focused commits
- Lower chance of conflicts

## Breaking Down Large Stories

### Example 1: Authentication System

**❌ Too big:** "Build auth system"

**✅ Break it down:**
1. `US-001` - Add login form
2. `US-002` - Add signup form
3. `US-003` - Add password reset flow
4. `US-004` - Add session management
5. `US-005` - Add auth middleware
6. `US-006` - Add protected routes

### Example 2: User Dashboard

**❌ Too big:** "Create user dashboard"

**✅ Break it down:**
1. `US-010` - Add dashboard layout
2. `US-011` - Add user stats widget
3. `US-012` - Add recent activity widget
4. `US-013` - Add settings panel
5. `US-014` - Add profile edit form

### Example 3: API Endpoints

**❌ Too big:** "Add all user CRUD operations"

**✅ Break it down:**
1. `US-020` - Add GET /users endpoint
2. `US-021` - Add POST /users endpoint
3. `US-022` - Add PUT /users/:id endpoint
4. `US-023` - Add DELETE /users/:id endpoint
5. `US-024` - Add user validation middleware

## Acceptance Criteria

Keep acceptance criteria explicit, specific, and verifiable:

### ❌ Vague & Untestable
```json
{
  "acceptanceCriteria": [
    "Users can log in",
    "Everything works",
    "UI looks good",
    "Code is clean"
  ]
}
```

**Problems:** Can't verify, subjective, no concrete steps

### ✅ Explicit & Verifiable
```json
{
  "acceptanceCriteria": [
    "Email/password fields render",
    "Validates email format (regex)",
    "Shows error on invalid email",
    "Shows error on empty fields",
    "typecheck passes",
    "Verify at localhost:$PORT/login (PORT defaults to 3000)"
  ]
}
```

**Benefits:** Clear verification steps, objective, testable

### Best Practices for Acceptance Criteria

1. **Be explicit** - State exactly what should exist/happen
2. **Include verification** - Add how to verify (URL, command, test)
3. **Specify behavior** - Not just "works", but exactly how
4. **Add technical checks** - typecheck, tests, linting
5. **Use defaults** - Specify default values (PORT=3000)

### More Examples

#### ❌ Vague
- "Users can log in"
- "Form works"
- "API endpoint exists"

#### ✅ Explicit
- "Email/password fields render"
- "Validates email format (regex)"
- "Shows error on invalid email"
- "Verify at localhost:3000/login"

#### ❌ Vague
- "Data is saved"
- "Database works"

#### ✅ Explicit
- "POST /api/users creates row in users table"
- "Returns 201 status on success"
- "Returns user object with id, email fields"
- "Verify with: curl -X POST localhost:3000/api/users -d '{...}'"

#### ❌ Vague
- "Error handling works"

#### ✅ Explicit
- "Shows 'Invalid email' on malformed email"
- "Shows 'Required field' on empty field"
- "Error message appears below input field"
- "Error message has red text (text-red-500)"

## Signs a Story is Too Big

- [ ] Title contains "entire", "complete", "all", "system"
- [ ] Would take more than 2-3 files to implement
- [ ] Acceptance criteria has 7+ items
- [ ] You can't clearly visualize the final state
- [ ] It combines multiple features

**If any are true → break it down!**

## Good Story Characteristics

- ✅ Single, focused feature
- ✅ 2-4 acceptance criteria
- ✅ Clear, testable outcomes
- ✅ Independent or minimal dependencies
- ✅ Completable in one sitting
- ✅ Creates a small, focused commit

## Template: Good Story

```json
{
  "id": "US-XXX",
  "title": "[Verb] [specific feature]",
  "acceptanceCriteria": [
    "[Specific thing] works/exists",
    "[Another specific thing] behaves correctly",
    "typecheck passes"
  ],
  "priority": 1,
  "passes": false,
  "notes": ""
}
```

## Examples by Feature

### Forms
- ✅ "Add login form"
- ✅ "Add form validation"
- ✅ "Add submit handler"
- ❌ "Build complete form system"

### API
- ✅ "Add GET /users endpoint"
- ✅ "Add request validation"
- ✅ "Add error handling"
- ❌ "Build REST API"

### UI Components
- ✅ "Add Button component"
- ✅ "Add loading state"
- ✅ "Add error state"
- ❌ "Build component library"

### Database
- ✅ "Add users table migration"
- ✅ "Add user queries"
- ✅ "Add indexes"
- ❌ "Set up entire database"

## Quick Reference

| Feature | ❌ Too Big | ✅ Right Size |
|---------|-----------|---------------|
| Auth | Build auth system | Add login form |
| API | Add all endpoints | Add GET /users |
| UI | Create dashboard | Add stats widget |
| DB | Set up database | Add users table |
| Tests | Add all tests | Test login form |

Remember: **Small stories = Fast progress = Better tracking**
