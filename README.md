# Claude Code Onboarding

Interactive onboarding for new [Claude Code](https://docs.anthropic.com/en/docs/claude-code) users. Guides you from zero to your first pull request in 3 phases.

## What It Does

| Phase | Skill | Description |
|-------|-------|-------------|
| - | `/onboard` | Entry point. Shows progress, tells you what to do next |
| 1 | `/onboard-env` | Installs dev tools (brew, git, gh, node), configures git, sets up GitHub auth |
| 2 | `/onboard-mcps` | Interviews you about your tools (Linear, Jira, Confluence, etc.) and installs MCP servers |
| 3 | `/onboard-task` | Clones a repo, helps you pick a ticket, plan the work, and open a draft PR |

## Install

```bash
git clone https://github.com/ChintanTurakhia/onboarding-skills.git
cd onboarding-skills
./install.sh
```

This copies the skills into `~/.claude/skills/`. Then start a new Claude Code session.

## Usage

```
/onboard          # See progress, get guided to the next step
/onboard-env      # Phase 1: Set up your dev environment
/onboard-mcps     # Phase 2: Configure MCP integrations
/onboard-task     # Phase 3: Complete your first task and open a PR
/onboard reset    # Clear progress and start over
/onboard status   # Just show progress without routing
```

## Supported MCPs

The MCP catalog (`skills/onboard-mcps/mcp-catalog.md`) includes:

| Category | Tools |
|----------|-------|
| Project Management | Linear, Jira, Asana, GitHub Issues |
| Knowledge Base | Confluence, Notion |
| CRM | Salesforce, HubSpot |
| Design | Excalidraw |

To add a new MCP, edit `skills/onboard-mcps/mcp-catalog.md` with the install command, required credentials, and verification steps.

## How It Works

- Each phase is a standalone Claude Code skill (slash command)
- Progress is tracked in `~/.onboarding-state.md` (created on first run)
- Every phase is **idempotent** -- safe to re-run without breaking anything
- The flow is **role-aware** -- developers and PMs get different tool suggestions and task types
- Credentials are passed via `claude mcp add -e` and never stored in plain text

## Customizing for Your Team

Fork this repo and customize:

1. **Default tools** -- Edit `skills/onboard-env/SKILL.md` to add/remove tools for your stack
2. **MCP catalog** -- Edit `skills/onboard-mcps/mcp-catalog.md` to add your company's MCPs
3. **Default repo** -- Edit `skills/onboard-task/SKILL.md` to suggest your team's repo
4. **Add a CLAUDE.md** to your repos with project-specific instructions that Phase 3 will pick up automatically

## Contributing

1. Fork this repo
2. Add your changes
3. Test by running `./install.sh` and going through the onboarding flow
4. Open a PR

## License

MIT
