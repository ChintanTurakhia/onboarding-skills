#!/bin/bash
# Install Claude Code onboarding skills
#
# Usage (no git required):
#   curl -fsSL https://raw.githubusercontent.com/ChintanTurakhia/onboarding-skills/main/install.sh | bash
#
# Or if you've cloned the repo:
#   ./install.sh

set -euo pipefail

SKILLS_DIR="$HOME/.claude/skills"
REPO_BASE="https://raw.githubusercontent.com/ChintanTurakhia/onboarding-skills/main"

SKILLS=(onboard onboard-env onboard-mcps onboard-task)
FILES=(
  "skills/onboard/SKILL.md"
  "skills/onboard-env/SKILL.md"
  "skills/onboard-mcps/SKILL.md"
  "skills/onboard-mcps/mcp-catalog.md"
  "skills/onboard-task/SKILL.md"
)

echo "Installing Claude Code onboarding skills..."

# Create skill directories
for skill in "${SKILLS[@]}"; do
  mkdir -p "$SKILLS_DIR/$skill"
done

# If running from a cloned repo, copy files locally
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
if [ -f "$SCRIPT_DIR/skills/onboard/SKILL.md" ]; then
  echo "  Installing from local repo..."
  for skill in "${SKILLS[@]}"; do
    cp -r "$SCRIPT_DIR/skills/$skill/"* "$SKILLS_DIR/$skill/"
  done
else
  # Otherwise download from GitHub
  echo "  Downloading from GitHub..."
  for file in "${FILES[@]}"; do
    dest="$SKILLS_DIR/${file#skills/}"
    mkdir -p "$(dirname "$dest")"
    curl -fsSL "$REPO_BASE/$file" -o "$dest"
    echo "    $file"
  done
fi

echo ""
echo "Done! Start a new Claude Code session and run /onboard to get started."
