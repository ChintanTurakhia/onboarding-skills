---
name: onboard-mcps
description: "Phase 2 of onboarding: interviews you about the tools you use (project management, CRM, knowledge base, design) and installs the corresponding MCP servers for Claude Code."
user-invocable: true
---

# Phase 2: MCP Discovery & Setup

You are an onboarding assistant running Phase 2. Interview the user about their tools, install the right MCP servers, and verify they work. This phase is role-aware and idempotent.

## Reference

Read the MCP catalog file at the path relative to this skill file: `mcp-catalog.md`. It contains the install commands, required credentials, and verification steps for each supported MCP.

## Steps

### 1. Read State and Check Prerequisites

Read `~/.onboarding-state.md`.

- If Phase 1 is **not** completed, tell the user: "Please run `/onboard-env` first to set up your environment." Then stop.
- Update Phase 2 status to `in-progress`.
- Read the user's role from the state file.

### 2. Check Existing MCPs

Run:
```bash
claude mcp list
```

Record what's already configured. Show the user: "You already have these MCP servers configured: [list]"

If they already have MCPs configured, ask: "Want to add more, or skip to the next phase?"

### 3. Tool Interview

Conduct the interview category by category. For each category, present the options and let the user pick one (or skip). Adapt suggestions based on role.

**Category 1: Project Management**

"What project management tool does your team use?"
- Linear
- Jira
- Asana
- GitHub Issues (no MCP needed -- uses gh CLI)
- Skip

**Category 2: Knowledge Base**

"What knowledge base or documentation tool do you use?"
- Confluence
- Notion
- Skip

**Category 3: CRM**

"Do you use a CRM?"
- Salesforce
- HubSpot
- Skip

**Category 4: Design**

"Do you use a design or diagramming tool?"
- Figma
- Excalidraw
- Skip

Record all selections.

### 4. Install Selected MCPs

For each selected tool:

1. **Check if already installed**: Look at the `claude mcp list` output from step 2. If the MCP is already there, say "Already configured" and skip.

2. **Look up install command**: Read the install command from `mcp-catalog.md`.

3. **Check for required credentials**: If the MCP needs an API key or token:
   - Tell the user **what** credential is needed
   - Tell them **where to get it** (provide the URL from the catalog)
   - Ask them to provide the value
   - **Never** write credentials to `~/.onboarding-state.md` or any other plain file
   - Pass credentials via environment variables in the `claude mcp add` command

4. **Run the install command**:
   ```bash
   claude mcp add --scope user <name> -- <command> [args...]
   ```
   Use `--scope user` so the MCP is available across all projects.

5. **Verify**: Tell the user the MCP should be available after restarting Claude Code, or in a new conversation.

### 5. Handle Failures

If an MCP installation fails:
- Show the error message
- Provide the manual install command so the user can try later
- Record as "failed" in state, continue with the next MCP
- Don't block the rest of the onboarding

### 6. Summary and Update State

Show a summary:

```
Phase 2 Complete!
=================
MCPs already configured: github (via gh CLI)
MCPs newly installed:    linear, confluence
MCPs skipped:            salesforce, excalidraw
MCPs failed:             (none)
```

Update `~/.onboarding-state.md`:
- Set Phase 2 status to `completed`
- Record which MCPs were installed, skipped, or failed
- Record credential status (configured / not configured) without storing the actual secrets

### 7. Next Steps

Tell the user: "Phase 2 complete! You now have [N] MCP servers ready. Run `/onboard-task` to use them on a real task -- clone a repo, pick a ticket, and open your first PR."
