#!/bin/bash

if [[ "$(uname)" != "Darwin" ]]; then
    exit 0
fi

MESSAGE="${1:-Claude Code}"
osascript - "$MESSAGE" <<'EOF'
on run argv
    display notification (item 1 of argv) with title "Claude Code"
end run
EOF
