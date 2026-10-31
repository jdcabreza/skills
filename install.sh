#!/usr/bin/env bash
# Link nstack skills and nathan-agent into ~/.claude, which Cursor and Claude Code both read. Install the discipline rule. Idempotent.
set -euo pipefail
repo="$(cd "$(dirname "$0")" && pwd)"
home=~/.claude

case "$repo" in
  "$HOME"/.cursor/skills*|"$HOME"/.claude/skills*) echo "warn: $repo is a skills directory. move the clone elsewhere or Cursor loads each skill twice." ;;
esac

link() { # link <source> <target>
  # a real directory is either this repo itself (cloned into place) or someone else's skill. leave it.
  if [ -d "$2" ] && [ ! -L "$2" ]; then
    [ "$(cd "$2" && pwd -P)" = "$(cd "$1" && pwd -P)" ] || echo "skip: $2 is a directory not owned by nstack"
    return
  fi
  ln -sfn "$1" "$2"
}

mkdir -p "$home/skills" "$home/agents"
for d in "$repo"/*/; do
  [ -f "$d/SKILL.md" ] && link "${d%/}" "$home/skills/$(basename "$d")"
done
link "$repo/agents/nathan-agent.md" "$home/agents/nathan-agent.md"

# always-on rule. copied, not linked: Claude Code may skip rule symlinks that point outside the project.
# Cursor does not read ~/.claude/rules, so it gets its own copy.
mkdir -p "$home/rules"
cp "$repo/templates/nstack-discipline.md" "$home/rules/nstack-discipline.md"
if [ -d ~/.cursor ]; then
  mkdir -p ~/.cursor/rules
  cp "$repo/templates/nstack-discipline.md" ~/.cursor/rules/nstack-discipline.mdc
fi
echo "linked into $home. restart Cursor / Claude Code, then run /setup-nstack."
