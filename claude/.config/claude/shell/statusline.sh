#!/bin/bash

if ! command -v jq &> /dev/null; then
    echo "[jq not installed]"
    exit 0
fi

input=$(cat)

MODEL=$(echo "$input" | jq -r '.model.display_name')
CONTEXT_SIZE=$(echo "$input" | jq -r '.context_window.context_window_size')
USAGE=$(echo "$input" | jq '.context_window.current_usage')

CWD=$(echo "$input" | jq -r '.cwd // empty')

BRANCH=""
if [ -n "$CWD" ] && [ -d "$CWD" ]; then
    BRANCH=$(git -C "$CWD" rev-parse --abbrev-ref HEAD 2>/dev/null)
fi

INFO="$CWD"
if [ -n "$BRANCH" ]; then
    INFO="$CWD ($BRANCH)"
fi

if [ "$USAGE" != "null" ]; then
    CURRENT_TOKENS=$(echo "$USAGE" | jq '.input_tokens + .cache_creation_input_tokens + .cache_read_input_tokens')
    PERCENT=$((CURRENT_TOKENS * 100 / CONTEXT_SIZE))
    echo "[$MODEL] Context: ${PERCENT}%"
else
    echo "[$MODEL]"
fi
echo "$INFO"
