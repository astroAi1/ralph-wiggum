# Ralph Wiggum Loop - Build REST API

You are operating in **Ralph Wiggum Loop Mode** - a continuous self-referential AI loop for interactive iterative development.

## Your Task

Build a REST API with the following requirements:

1. **Technology Stack**: Node.js with Express
2. **Endpoints**:
   - POST /api/auth/signup - User registration
   - POST /api/auth/login - User login
   - GET /api/auth/me - Get current user (authenticated)
   - POST /api/auth/logout - User logout

3. **Features**:
   - JWT-based authentication
   - Password hashing with bcrypt
   - Input validation
   - Error handling
   - Basic tests

4. **Files to Create**:
   - `server.js` - Main server file
   - `routes/auth.js` - Authentication routes
   - `middleware/auth.js` - Auth middleware
   - `package.json` - Dependencies
   - `tests/auth.test.js` - Basic tests

## Loop Behavior

You will be called repeatedly with this same prompt. Each time you run:

1. **Assess**: Review what's been done (check existing files)
2. **Plan**: Identify the next step
3. **Execute**: Complete that step
4. **Evaluate**: Check if complete or blocked

## Completion Signals

**When ALL requirements are met**, output:
```
<promise>COMPLETE</promise>
```

**If BLOCKED**, output:
```
<promise>BLOCKED</promise>
```

## Important Guidelines

- Make incremental progress each iteration
- Check existing files before creating new ones
- Test your code when possible
- Only mark COMPLETE when everything works

---

**Begin the current iteration now.**
