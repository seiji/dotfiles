#!/bin/bash
# Wrapper script for launchd (avoids hardcoded paths in plist)

exec /usr/bin/python3 "$HOME/.config/obsidian/scripts/claude-session-to-obsidian.py" "$@"
