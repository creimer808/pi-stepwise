#!/usr/bin/env bash
# Install the Stepwise skills into Cursor (or any Agent Skills harness).
#
# Cursor and Pi both auto-discover the Agent Skills standard, so the SKILL.md
# folders under ./skills work as-is. This script just copies them to the
# location you choose.
#
# Usage:
#   ./install-cursor.sh                # global Cursor:   ~/.cursor/skills
#   ./install-cursor.sh --project      # this project:    .cursor/skills
#   ./install-cursor.sh --agents       # shared, global:  ~/.agents/skills   (Pi + Cursor)
#   ./install-cursor.sh --agents --project   # shared, project: .agents/skills
#
# Re-running overwrites the four stepwise skills and leaves any others alone.

set -euo pipefail

SRC="$(cd "$(dirname "${BASH_SOURCE[0]}")/skills" && pwd)"

scope="global"
root="cursor"
for arg in "$@"; do
  case "$arg" in
    --project) scope="project" ;;
    --global)  scope="global" ;;
    --agents)  root="agents" ;;
    --cursor)  root="cursor" ;;
    -h|--help)
      sed -n '2,18p' "${BASH_SOURCE[0]}" | sed 's/^# \{0,1\}//'
      exit 0 ;;
    *) echo "Unknown argument: $arg" >&2; exit 1 ;;
  esac
done

case "$scope:$root" in
  global:cursor)  dest="$HOME/.cursor/skills" ;;
  project:cursor) dest=".cursor/skills" ;;
  global:agents)  dest="$HOME/.agents/skills" ;;
  project:agents) dest=".agents/skills" ;;
esac

mkdir -p "$dest"
for skill in "$SRC"/*/; do
  name="$(basename "$skill")"
  rm -rf "${dest:?}/$name"
  cp -r "$skill" "$dest/$name"
  echo "  installed $name -> $dest/$name"
done

echo
echo "Done. Open Cursor's Agent chat and type /stepwise-kickoff to start."
[ "$scope" = "project" ] && echo "Tip: commit $dest so your team gets the workflow too."
true
