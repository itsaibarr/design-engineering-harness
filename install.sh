#!/usr/bin/env bash
# install.sh — idempotent installer for the design-engineering harness.
# Copies de-* skills and commands into ~/.claude/{skills,commands} (read by
# Claude Code and OpenCode). Never overwrites existing installs unless --force.
# Usage: ./install.sh [--force]
set -euo pipefail

SRC="$(cd "$(dirname "$0")" && pwd)"
DEST_SKILLS="$HOME/.claude/skills"
DEST_CMDS="$HOME/.claude/commands"
FORCE=0
[ "${1:-}" = "--force" ] && FORCE=1

mkdir -p "$DEST_SKILLS" "$DEST_CMDS"

install_dir() {
  local src="$1" dest="$2" name
  name="$(basename "$src")"
  if [ -d "$dest/$name" ] && [ "$FORCE" -eq 0 ]; then
    echo "skip  $name (exists; use --force to replace)"
  else
    rm -rf "$dest/$name"
    cp -R "$src" "$dest/$name"
    echo "install  $name"
  fi
}

for d in "$SRC"/agent/core/framework/skills/de-*/; do
  install_dir "$d" "$DEST_SKILLS"
done
for f in "$SRC"/agent/core/framework/commands/de-*.md; do
  name="$(basename "$f")"
  if [ -f "$DEST_CMDS/$name" ] && [ "$FORCE" -eq 0 ]; then
    echo "skip  $name (exists; use --force to replace)"
  else
    cp "$f" "$DEST_CMDS/$name"
    echo "install  $name"
  fi
done

echo "done. module references live in $SRC/agent/modules/design-engineering/ (copied per-project on demand)."
