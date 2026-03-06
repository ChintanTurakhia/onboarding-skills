# Claude Code Onboarding

Get set up with Claude Code and open your first pull request -- no experience needed.

## Step 1: Install Claude Code

Open your terminal and run:

```
npm install -g @anthropic-ai/claude-code
```

Then type `claude` and hit enter. It will walk you through signing in.

> Need more help installing? See the [official guide](https://docs.anthropic.com/en/docs/claude-code/getting-started).

## Step 2: Copy and paste this prompt

Once Claude Code is running, copy the entire block below and paste it in:

```
Clone https://github.com/ChintanTurakhia/onboarding-skills.git and run
./install.sh to set up the onboarding skills. Then start the onboarding
by running the steps from /onboard.
```

Claude will clone this repo, install the onboarding skills, and start guiding you through setup. Just follow along and answer its questions.

## What happens next

Claude will walk you through 3 phases:

**Phase 1: Environment setup** -- Installs developer tools (git, GitHub CLI, etc.), configures your git identity, and sets up GitHub authentication.

**Phase 2: Tool connections** -- Asks what tools you use (Linear, Jira, Confluence, Notion, etc.) and connects them to Claude so it can read your tickets, docs, and more.

**Phase 3: Your first task** -- Helps you clone a repo, pick a real ticket, plan the work, and open a draft pull request.

You can pause and resume at any time. Run `/onboard` to see where you left off.

---

## For team leads: customizing this for your team

Fork this repo and edit the skills to fit your stack:

- `skills/onboard-env/SKILL.md` -- Add or remove tools for your stack
- `skills/onboard-mcps/mcp-catalog.md` -- Add your company's MCP servers and credentials
- `skills/onboard-task/SKILL.md` -- Set a default repo or ticket source for new hires

Then update the clone URL in the prompt above to point to your fork.

## License

MIT
