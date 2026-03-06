---
name: onboard-task
description: "Phase 3 of onboarding: guides you through cloning a repo, finding a ticket using your MCP integrations, creating a plan, and opening your first pull request."
user-invocable: true
---

# Phase 3: Guided First Task

You are an onboarding assistant running Phase 3. Walk the user through a complete task cycle: find a ticket, clone a repo, plan, implement, and open a draft PR. Adapt the flow based on the user's role and installed MCPs.

## Steps

### 1. Read State and Check Prerequisites

Read `~/.onboarding-state.md`.

- If Phase 1 is **not** completed: tell the user to run `/onboard-env` first. Stop.
- If Phase 2 is **not** completed: tell the user to run `/onboard-mcps` first. Stop.
- Read the user's **role** and **installed MCPs** from the state file.
- Update Phase 3 status to `in-progress`.

### 2. Choose a Repository

Ask the user: "What repo would you like to work in?"

Options:
- **Provide a repo URL**: User pastes a GitHub URL or `org/repo` identifier
- **Already cloned locally**: User provides a local path

If they provide a URL, clone it:
```bash
gh repo clone <org/repo> ~/src/<repo>
```

If they provide a local path, verify it exists and is a git repo.

Once in the repo:
- Run `git status` to verify it's clean
- Check for a `CLAUDE.md` file and read it if present (it may have project-specific instructions)
- Run `ls` to show the project structure

### 3. Find a Ticket

Based on which project management MCP is installed (from state file), browse available tickets:

**If Linear is installed:**
- Use Linear MCP tools to list issues
- Filter for: unassigned, status "Todo" or "Backlog", label "good-first-issue" if available
- Example: "Let me search Linear for available tickets..."

**If Jira is installed:**
- Use Jira MCP tools to search for issues
- Filter for: status "To Do" or "Open", unassigned
- Look for "good-first-issue" label

**If Asana is installed:**
- Use Asana MCP tools to list tasks
- Filter for: incomplete, unassigned

**If GitHub Issues (no MCP, use gh CLI):**
```bash
gh issue list --state open --label "good first issue" --limit 10
```

**If no project management tool is configured:**
- Ask the user to describe a task they'd like to work on, or
- Look at the repo's GitHub issues directly via `gh issue list`

Present **3-5 candidate tickets** with:
- ID/number
- Title
- Brief description
- Priority/labels if available

Let the user pick one. If none look good, let them describe their own task.

### 4. Understand the Task

Once a ticket is selected, get the full details:
- Read the complete ticket description
- If a knowledge base MCP is installed (Confluence, Notion), search for related documentation
- Summarize for the user:
  - **Problem:** What needs to be fixed/built
  - **Acceptance criteria:** What "done" looks like
  - **Related context:** Any docs or prior discussions found

Ask the user: "Does this summary look right? Anything to add?"

### 5. Create a Branch

Create a feature branch:
```bash
git checkout -b <username>/<ticket-id>-<short-description>
```

Where:
- `<username>` is derived from `git config user.name` (lowercased, no spaces)
- `<ticket-id>` is the ticket number/ID
- `<short-description>` is a 2-3 word slug from the title

### 6. Create a Plan

Generate an implementation plan that includes:
- Which files need to be modified or created
- What changes to make in each file
- How to test the changes
- Any dependencies or prerequisites

Present the plan to the user and ask: "Does this plan look good? Want me to adjust anything?"

**Do not proceed until the user approves the plan.**

### 7. Execute (Role-Adaptive)

**For Developers:**
- Implement the changes according to the plan
- After each significant change, briefly explain what was done
- Run any relevant tests if the project has them
- If you hit a blocker, explain it and ask the user how to proceed

**For Product Managers:**
- Instead of code changes, create a specification or PRD document
- Write it as a markdown file in the repo (e.g., `docs/spec-<ticket-id>.md`)
- Include: problem statement, proposed solution, acceptance criteria, open questions
- This demonstrates how PMs can use Claude Code for documentation tasks

### 8. Commit and Open a Draft PR

Stage and commit the changes:
```bash
git add <changed-files>
git commit -m "<type>: <description>

Ticket: <ticket-id>

Co-Authored-By: Claude <noreply@anthropic.com>"
```

Where `<type>` is `feat`, `fix`, `docs`, etc. based on the change.

Push and open a draft PR:
```bash
git push -u origin <branch-name>
gh pr create --draft \
  --title "<ticket-id>: <short description>" \
  --body "## Summary
<1-3 bullet points describing the change>

## Ticket
<link to ticket if available>

## Test Plan
<how to verify the changes>

---
Created during Claude Code onboarding"
```

Show the user the PR URL.

### 9. Update State

Update `~/.onboarding-state.md`:
- Set Phase 3 status to `completed`
- Record: repo path, ticket ID, branch name, PR URL

### 10. Celebration and Next Steps

```
Congratulations -- you've completed the Claude Code onboarding!

Your first PR: <PR_URL>

Here are some things to try next:

  Ask Claude anything:
    "Explain how the auth system works in this codebase"
    "Find and fix the bug in the payment flow"
    "Add unit tests for the user service"
    "Refactor this function to be more readable"

  Explore your MCP integrations:
    "Show me my Linear tickets for this sprint"
    "Search Confluence for the API design doc"
    "What issues are assigned to me?"

  Useful commands:
    /onboard status  -- See your onboarding progress
    /onboard reset   -- Start fresh

Happy coding!
```
