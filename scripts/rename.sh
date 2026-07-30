#!/usr/bin/env bash
# scripts/rename.sh — rename the template to a new plugin name.
# Usage: make rename NAME=your-name/your-plugin.nvim
set -euo pipefail

NEW="${1:-}"
if [ -z "$NEW" ]; then
  echo "usage: $0 <owner>/<repo>.nvim   (e.g. you/foo.nvim)"; exit 1
fi

OLD="marco-souza/plugin.nvim"
REPO_NAME="$(basename "$NEW")"
LUAMOD="${REPO_NAME%.nvim}"
# nvim user commands must start uppercase: coollib -> Coollib
CMD="$(printf '%s' "${LUAMOD:0:1}" | tr '[:lower:]' '[:upper:]')${LUAMOD:1}"

echo "===> Renaming $OLD -> $NEW (lua module: $LUAMOD, command: $CMD)"

# lua module dir
git mv "lua/plugin" "lua/$LUAMOD" 2>/dev/null || mv "lua/plugin" "lua/$LUAMOD"

# perl -i is portable across macOS/linux, unlike sed -i
sub() { perl -i -pe "$1" "$2"; }

grep -rl 'require("plugin")' --include='*.lua' tests lua 2>/dev/null | while read -r f; do
  sub "s/\brequire\(\"plugin\"\)/require(\"$LUAMOD\")/g" "$f"
done

sub "s|\Q$OLD\E|$NEW|g" README.md
sub "s|\Q$OLD\E|$NEW|g" plugin.json
sub "s/M.command = \"Plugin\"/M.command = \"$CMD\"/g" "lua/$LUAMOD/init.lua"

echo "===> Done. Review with: git status && git diff"