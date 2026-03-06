---
name: onboard-env
description: "Phase 1 of onboarding: checks and installs development tools (Homebrew, gh CLI, git, node), configures git credentials, and verifies GitHub authentication. Safe to re-run."
user-invocable: true
---

# Phase 1: Environment Setup

You are an onboarding assistant running Phase 1. Check for required tools, install anything missing, and configure credentials. This phase is idempotent -- re-running skips already-installed tools.

## Steps

### 1. Read State

Read `~/.onboarding-state.md`. If it doesn't exist, create it with all phases as `pending` (same as `/onboard` would).

Update Phase 1 status to `in-progress` in the state file.

### 2. Ask Role (if not set)

Check the state file for the user's role. If it says "(not set)" or is missing, ask:

"What's your role?"
- Developer
- Product Manager
- Designer
- Other

Record the answer in the User Profile section of the state file.

### 3. Detect Operating System

Run `uname -s` to detect the OS. This onboarding currently supports **macOS**. If the user is on Linux, adapt install commands accordingly (use apt/yum instead of brew). If on Windows, note that they should use WSL.

### 4. Check and Install Tools

For each tool below, check if it's installed using `command -v <cmd>`. Track results in two lists: "already installed" and "newly installed".

**For all roles:**

| Tool | Check | Install (macOS) | Why |
|------|-------|-----------------|-----|
| Homebrew | `command -v brew` | `/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"` | Package manager for macOS |
| git | `command -v git` | `brew install git` | Version control |
| gh CLI | `command -v gh` | `brew install gh` | GitHub from the terminal |
| jq | `command -v jq` | `brew install jq` | JSON processing |

**For developers only** (skip if role is PM/Designer):

| Tool | Check | Install (macOS) | Why |
|------|-------|-----------------|-----|
| node | `command -v node` | `brew install node` | JavaScript runtime |
| bun | `command -v bun` | `brew install oven-sh/bun/bun` | Fast JS runtime & package manager |

**Important rules:**
- Before installing anything, show the user what's missing and ask: "I'd like to install the following tools: [list]. OK to proceed?"
- Only install after confirmation.
- If brew is missing, install it first since other tools depend on it.
- Show the version of each tool after checking/installing: `<tool> --version`

### 5. Configure Git

Check `git config --global user.name` and `git config --global user.email`.

If either is not set:
- Ask the user for their **full name** and **email address**
- Run:
  ```bash
  git config --global user.name "Their Name"
  git config --global user.email "their@email.com"
  ```

If both are already set, show the current values and ask if they're correct.

### 6. GitHub Authentication

Check GitHub auth status:
```bash
gh auth status
```

If not authenticated, guide the user through login:
```bash
gh auth login
```

Tell the user:
- Select "GitHub.com" (or their enterprise host)
- Select "HTTPS" for protocol
- Authenticate via browser

If the user works with GitHub Enterprise, ask for their GHE hostname and run:
```bash
GH_HOST=<hostname> gh auth login
```

### 7. SSH Key Check

Check for existing SSH keys:
```bash
ls -la ~/.ssh/id_ed25519.pub 2>/dev/null || ls -la ~/.ssh/id_rsa.pub 2>/dev/null
```

If no SSH key exists:
- Ask: "Would you like to generate an SSH key for GitHub?"
- If yes:
  ```bash
  ssh-keygen -t ed25519 -C "<their email>"
  ```
  (Let user accept defaults or choose a passphrase)
- Show the public key: `cat ~/.ssh/id_ed25519.pub`
- Tell them: "Copy this key and add it at: https://github.com/settings/keys (or your GitHub Enterprise SSH settings page)"

If an SSH key already exists, show it and confirm it's added to GitHub.

### 8. Summary and Update State

Show a summary:

```
Phase 1 Complete!
=================
Tools already installed: git (2.43.0), node (20.11.0)
Tools newly installed:   gh (2.44.0), bun (1.0.25)
Git configured:          Jane Doe <jane@example.com>
GitHub authenticated:    yes (github.com)
SSH key:                 ~/.ssh/id_ed25519 (exists)
```

Update `~/.onboarding-state.md`:
- Set Phase 1 status to `completed`
- Record which tools were installed vs already present
- Record git config status, GitHub auth status, SSH key status

### 9. Next Steps

Tell the user: "Phase 1 complete! Run `/onboard-mcps` to set up your project management and knowledge base integrations."
