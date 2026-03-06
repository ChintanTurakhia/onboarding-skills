#!/bin/bash
# Install Claude Code onboarding skills
# Usage: ./install.sh

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
SKILLS_DIR="$HOME/.claude/skills"

echo "Installing Claude Code onboarding skills..."

# Create skills directory if it doesn't exist
mkdir -p "$SKILLS_DIR"

# Copy each skill
for skill in onboard onboard-env onboard-mcps onboard-task; do
  if [ -d "$SKILLS_DIR/$skill" ]; then
    echo "  Updating $skill..."
  else
    echo "  Installing $skill..."
  fi
  cp -r "$SCRIPT_DIR/skills/$skill" "$SKILLS_DIR/"
done

echo ""
echo "Done! Start a new Claude Code session and run /onboard to get started."
