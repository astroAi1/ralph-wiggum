# Agent Nicknames - Quick Reference

Memorable nicknames for Ralph Wiggum agents.

## Security & Code Review

### 🐕 Big Dog
**Command:** `/ralph-wiggum:big-dog`

**Specialty:** Code review and security auditing

**Use when:**
- Before deploying to production
- After implementing auth/security features
- When adding user input handling
- Regular security audits
- Code quality review

**Examples:**
```bash
# Full codebase review
/ralph-wiggum:big-dog

# Review specific files
/ralph-wiggum:big-dog src/auth/* app/api/*

# Review recent changes
/ralph-wiggum:big-dog Check the last commit for security issues
```

**What Big Dog checks:**
- Security vulnerabilities (XSS, SQL injection, CSRF, etc.)
- Code quality and best practices
- Performance issues (N+1 queries, memory leaks)
- Architecture problems

---

## Development Workflow

### 🔄 Ralph (Core Loop)
**Command:** `/ralph-wiggum:loop`

**Specialty:** Iterative development loop

**Use when:** General development tasks

---

### 📋 Ralph PRD
**Command:** `/ralph-wiggum:prd`

**Specialty:** Story-based development

**Use when:** Working through a PRD with multiple user stories

---

## Adding Your Own Nicknames

Create new agent commands in `commands/` directory:

```markdown
---
description: Your agent description
---

# Agent Name

Instructions here...
```

Then add the nickname to this file!

---

**Pro Tip:** Call Big Dog before every deploy. He's got your back! 🐕🛡️
