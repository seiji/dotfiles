#!/bin/bash

if [[ "$(uname)" != "Darwin" ]]; then
    exit 0
fi

MESSAGE="${1:-Claude Code}"
osascript -e "display notification \"$MESSAGE\" with title \"Claude Code\""
