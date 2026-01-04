# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a personal dotfiles repository for macOS and Linux, managed with GNU Stow. Each top-level directory is a "package" that mirrors the home directory structure for symlinking.

## Commands

### Install/Uninstall Packages

```bash
# macOS - install all packages
make mac_install

# macOS - uninstall all packages
make mac_uninstall

# Linux - install all packages
make install

# Linux - uninstall all packages
make uninstall

# Install a single package manually
stow -S -t $HOME -v <package-name>

# Uninstall a single package
stow -D -t $HOME -v <package-name>
```

### Homebrew (macOS)

```bash
# Install all brew packages from Brewfile
brew bundle --file=brew/.Brewfile
```

## Architecture

### Package Structure

Each directory is a stow package containing files that will be symlinked to `$HOME`:
- `<package>/.config/<app>/` → `~/.config/<app>/`
- `<package>/.<dotfile>` → `~/.<dotfile>`

### Key Packages

| Package | Description |
|---------|-------------|
| `nvim` | Neovim config with lazy.nvim, LSP, Copilot, Claude Code |
| `zsh` | Zsh with antigen plugin manager, fzf functions |
| `tmux` | Tmux config with smug templates |
| `git` | Git config with aliases, GPG signing, git-secrets |
| `brew` | Homebrew Brewfile (formulas, casks, mas apps) |
| `terraform` | Terraform tooling (tfenv, tflint, terragrunt) |
| `ghostty` | Ghostty terminal config |

### Platform Variants

- `gnupg/` - Linux GPG config
- `gnupg_mac/` - macOS GPG config (uses pinentry-mac)
- Makefile uses `pkgs` for Linux, `mac_pkgs` for macOS

### Neovim Setup

- Entry: `nvim/.config/nvim/init.lua`
- Plugin manager: lazy.nvim (`lua/plugins.lua`)
- LSP config: `lua/lsp_config.lua` (gopls configured)
- Keymaps: `lua/keymaps.lua`
- Leader key: `,`
- AI: Copilot (`<Tab>` accept, `<C-j/k>` cycle) + claudecode.nvim (`<leader>ac` toggle)

### Zsh Setup

- Main: `zsh/.zshrc` sources files from `zsh/.zsh/`
- Aliases and functions: `zsh/.zsh/aliases`
- Environment: `zsh/.zsh/env`
- Plugin manager: antigen (git submodule at `zsh/.zsh/antigen/`)

### Version Managers

Language versions are managed via:
- pyenv (Python)
- rbenv (Ruby)
- nodenv (Node.js)
- goenv (Go)
- tfenv (Terraform)

### Git Aliases

Common aliases defined in `git/.gitconfig`:
- `git st` - status with stash list
- `git ls` - graph log with colors
- `git di` / `dc` / `dn` / `ds` - diff variants
- `git fe` - fetch with prune
- `git pushf` - force push with lease
