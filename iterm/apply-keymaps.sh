#!/usr/bin/env bash
set -euo pipefail

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
plist="$HOME/Library/Preferences/com.googlecode.iterm2.plist"
keymap_preset="$script_dir/keymaps/my-keymap.plist"

for key in \
  "0x68-0x100000-0x4" \
  "0x6a-0x100000-0x26" \
  "0x6b-0x100000-0x28" \
  "0x6c-0x100000-0x25"
do
  /usr/libexec/PlistBuddy -c "Delete :GlobalKeyMap:$key" "$plist" 2>/dev/null || true
done

plutil -lint "$keymap_preset" >/dev/null

/usr/libexec/PlistBuddy -c "Delete :NSUserKeyEquivalents" "$plist" 2>/dev/null || true
/usr/libexec/PlistBuddy -c "Add :NSUserKeyEquivalents dict" "$plist"
/usr/libexec/PlistBuddy -c "Merge $keymap_preset :NSUserKeyEquivalents" "$plist"

echo "iTerm keymaps updated. Restart iTerm."
