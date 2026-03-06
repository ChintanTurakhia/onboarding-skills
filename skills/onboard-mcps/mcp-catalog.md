# MCP Catalog

Reference catalog of MCP servers available for onboarding. Each entry includes the install command, required credentials, and verification steps.

> **Note:** MCP install commands and package names may change over time. Check the official MCP server documentation if an install fails.

---

## Project Management

### Linear

- **Category:** Project Management
- **Install:**
  ```bash
  claude mcp add --scope user linear -- npx -y @linear/mcp-server
  ```
- **Credentials:**
  - `LINEAR_API_KEY` -- Personal API key
  - Get it from: [Linear Settings > API > Personal API Keys](https://linear.app/settings/api)
- **Environment setup:**
  ```bash
  claude mcp add --scope user -e LINEAR_API_KEY=<key> linear -- npx -y @linear/mcp-server
  ```
- **Verification:** After restart, ask Claude: "List my Linear teams" -- it should use the Linear MCP tools.
- **What it enables:** List/create/update issues, search projects, manage cycles, browse teams.

### Jira

- **Category:** Project Management
- **Install:**
  ```bash
  claude mcp add --scope user jira -- npx -y @anthropic/jira-mcp-server
  ```
- **Credentials:**
  - `JIRA_API_TOKEN` -- API token
  - `JIRA_EMAIL` -- Your Jira account email
  - `JIRA_BASE_URL` -- Your Jira instance URL (e.g., `https://yourcompany.atlassian.net`)
  - Get token from: [Atlassian API Tokens](https://id.atlassian.net/manage-profile/security/api-tokens)
- **Environment setup:**
  ```bash
  claude mcp add --scope user \
    -e JIRA_API_TOKEN=<token> \
    -e JIRA_EMAIL=<email> \
    -e JIRA_BASE_URL=<url> \
    jira -- npx -y @anthropic/jira-mcp-server
  ```
- **Verification:** After restart, ask Claude: "List my Jira projects."
- **What it enables:** Search/create/update issues, browse projects, manage sprints.

### Asana

- **Category:** Project Management
- **Install:**
  ```bash
  claude mcp add --scope user asana -- npx -y @anthropic/asana-mcp-server
  ```
- **Credentials:**
  - `ASANA_ACCESS_TOKEN` -- Personal access token
  - Get it from: [Asana Developer Console](https://app.asana.com/0/developer-console)
- **Environment setup:**
  ```bash
  claude mcp add --scope user -e ASANA_ACCESS_TOKEN=<token> asana -- npx -y @anthropic/asana-mcp-server
  ```
- **Verification:** After restart, ask Claude: "List my Asana workspaces."
- **What it enables:** List/create/update tasks, browse projects, manage sections.

### GitHub Issues

- **Category:** Project Management
- **Install:** No MCP needed -- GitHub Issues are accessible via the `gh` CLI which is set up in Phase 1.
- **Usage:** Ask Claude: "List open issues in owner/repo" and it will use `gh issue list`.

---

## Knowledge Base

### Confluence

- **Category:** Knowledge Base
- **Install:**
  ```bash
  claude mcp add --scope user confluence -- npx -y @anthropic/confluence-mcp-server
  ```
- **Credentials:**
  - `CONFLUENCE_API_TOKEN` -- API token
  - `CONFLUENCE_BASE_URL` -- Your Confluence URL (e.g., `https://yourcompany.atlassian.net/wiki`)
  - `CONFLUENCE_EMAIL` -- Your account email
  - Get token from: [Atlassian API Tokens](https://id.atlassian.net/manage-profile/security/api-tokens) (same as Jira)
- **Environment setup:**
  ```bash
  claude mcp add --scope user \
    -e CONFLUENCE_API_TOKEN=<token> \
    -e CONFLUENCE_BASE_URL=<url> \
    -e CONFLUENCE_EMAIL=<email> \
    confluence -- npx -y @anthropic/confluence-mcp-server
  ```
- **Verification:** After restart, ask Claude: "Search Confluence for onboarding docs."
- **What it enables:** Search pages, read content, create/update pages.

### Notion

- **Category:** Knowledge Base
- **Install:**
  ```bash
  claude mcp add --scope user notion -- npx -y @notionhq/notion-mcp-server
  ```
- **Credentials:**
  - `OPENAPI_MCP_HEADERS` -- JSON string with Notion API key and version
  - Get integration token from: [Notion Integrations](https://www.notion.so/my-integrations)
  - You must also share specific pages/databases with your integration
- **Environment setup:**
  ```bash
  claude mcp add --scope user \
    -e 'OPENAPI_MCP_HEADERS={"Authorization":"Bearer <token>","Notion-Version":"2022-06-28"}' \
    notion -- npx -y @notionhq/notion-mcp-server
  ```
- **Verification:** After restart, ask Claude: "Search my Notion workspace."
- **What it enables:** Search, read, create, and update pages and databases.

---

## CRM

### Salesforce

- **Category:** CRM
- **Install:**
  ```bash
  claude mcp add --scope user salesforce -- npx -y @anthropic/salesforce-mcp-server
  ```
- **Credentials:**
  - `SALESFORCE_ACCESS_TOKEN` -- OAuth access token or session ID
  - `SALESFORCE_INSTANCE_URL` -- Your Salesforce instance URL (e.g., `https://yourcompany.my.salesforce.com`)
  - Get access via: Salesforce Setup > Apps > Connected Apps or use `sf org login web`
- **Environment setup:**
  ```bash
  claude mcp add --scope user \
    -e SALESFORCE_ACCESS_TOKEN=<token> \
    -e SALESFORCE_INSTANCE_URL=<url> \
    salesforce -- npx -y @anthropic/salesforce-mcp-server
  ```
- **Verification:** After restart, ask Claude: "List recent Salesforce accounts."
- **What it enables:** Query records, create/update objects, run SOQL queries.

### HubSpot

- **Category:** CRM
- **Install:**
  ```bash
  claude mcp add --scope user hubspot -- npx -y @anthropic/hubspot-mcp-server
  ```
- **Credentials:**
  - `HUBSPOT_ACCESS_TOKEN` -- Private app access token
  - Get it from: [HubSpot Developer > Private Apps](https://developers.hubspot.com/docs/api/private-apps)
- **Environment setup:**
  ```bash
  claude mcp add --scope user \
    -e HUBSPOT_ACCESS_TOKEN=<token> \
    hubspot -- npx -y @anthropic/hubspot-mcp-server
  ```
- **Verification:** After restart, ask Claude: "List recent HubSpot contacts."
- **What it enables:** Manage contacts, companies, deals, tickets.

---

## Design & Diagramming

### Excalidraw

- **Category:** Design / Diagramming
- **Install:**
  ```bash
  claude mcp add --scope user excalidraw -- npx -y @anthropic/excalidraw-mcp-server
  ```
- **Credentials:** None required.
- **Verification:** After restart, ask Claude: "Create a simple diagram."
- **What it enables:** Create and edit Excalidraw diagrams, export as images.

---

## Adding New MCPs

To add a new MCP to this catalog, include:

1. **Name** and **category**
2. **Install command** using `claude mcp add`
3. **Required credentials** with links to where users can generate them
4. **Environment setup** command showing how to pass credentials
5. **Verification** step -- a simple prompt to test the MCP works
6. **What it enables** -- brief description of capabilities
