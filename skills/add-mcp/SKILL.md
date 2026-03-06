---
name: add-mcp
description: Add a new MCP server to the onboarding catalog. Interviews you about the MCP, looks up install details, and appends a properly formatted entry to the catalog.
user-invocable: true
---

# Add MCP to Catalog

You are a helper that adds new MCP server entries to the onboarding catalog. You'll interview the user, research the MCP if needed, and append a properly formatted entry.

## Catalog Location

The catalog file is at: `~/.claude/skills/onboard-mcps/mcp-catalog.md`

Read it first to understand the existing format and categories.

## Steps

### 1. Read the Current Catalog

Read `~/.claude/skills/onboard-mcps/mcp-catalog.md` to see existing entries and categories.

### 2. Ask What MCP to Add

If `$ARGUMENTS` is provided, use that as the MCP name/description. Otherwise ask:

"What MCP server would you like to add to the catalog? (e.g., a tool name like 'Slack', 'Datadog', or a specific npm package name)"

### 3. Research the MCP

Try to find the correct install details:

- Search the web for `"<name> mcp server" claude` or `"<name> mcp server" npm` to find the official package
- Look for the npm package name (e.g., `@company/mcp-server-name`)
- Identify required credentials and where to get them
- Figure out the transport type (stdio is most common)

If you can't find an official MCP server for the tool, tell the user and ask if they have the package name or install command.

### 4. Confirm Details with the User

Present what you found and confirm:

- **Name:** The short name for the MCP (e.g., `slack`, `datadog`)
- **Category:** Which section it belongs in (Project Management, Knowledge Base, CRM, Design & Diagramming, or a new category)
- **Install command:** The `claude mcp add` command
- **Credentials:** What API keys/tokens are needed and where to get them
- **Verification prompt:** A simple question to test it works
- **What it enables:** 1-line description of capabilities

Ask: "Does this look right? Anything to change?"

### 5. Determine Placement

Based on the category:
- If the category already exists in the catalog, the entry goes under that heading
- If it's a new category, create a new `## Category Name` section before the `## Adding New MCPs` section at the bottom

### 6. Append to Catalog

Use the Edit tool to add the new entry to `~/.claude/skills/onboard-mcps/mcp-catalog.md` in the correct category section, following this exact format:

```markdown
### <Name>

- **Category:** <Category>
- **Install:**
  ```bash
  claude mcp add --scope user <name> -- <command>
  ```
- **Credentials:**
  - `ENV_VAR_NAME` -- Description
  - Get it from: [Where to get it](https://url)
- **Environment setup:**
  ```bash
  claude mcp add --scope user -e ENV_VAR=<value> <name> -- <command>
  ```
- **Verification:** After restart, ask Claude: "<test prompt>"
- **What it enables:** <Brief description of capabilities>
```

If no credentials are required, use:
```markdown
- **Credentials:** None required.
```
and omit the **Environment setup** field.

### 7. Update the Install Script

Read `~/.claude/skills/add-mcp/SKILL.md` -- that's this file, no changes needed.

But do check if `~/Development/claude-onboarding/` exists (the source repo). If it does, also update the catalog there at `~/Development/claude-onboarding/skills/onboard-mcps/mcp-catalog.md` so the change can be committed and shared.

### 8. Update the Onboard-MCPs Skill

Read `~/.claude/skills/onboard-mcps/SKILL.md` and check if the new MCP's category is already covered in the interview questions (Step 3 of that skill). If the MCP fits a new category not yet in the interview, tell the user:

"Note: The `/onboard-mcps` interview doesn't currently ask about <category> tools. You may want to edit `~/.claude/skills/onboard-mcps/SKILL.md` to add a question for this category."

### 9. Confirm

Tell the user:

"Added **<Name>** to the MCP catalog under **<Category>**."

Then show them the entry you added so they can verify it.
