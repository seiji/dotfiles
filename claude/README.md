# Claude Code Settings

## Install

```bash
stow -S -t $HOME -v claude
```

## MCP Servers Setup

```bash
# GitHub MCP server
claude mcp add github --transport http --scope user https://api.githubcopilot.com/mcp/
```

### Required Environment Variables

Set in `~/.zshrc` or `~/.zsh/env`:

```bash
export GITHUB_PERSONAL_ACCESS_TOKEN="ghp_xxxxxxxxxxxx"
```

## Verify

```bash
# List configured MCP servers
claude mcp list

# Check in Claude Code
/mcp
```
