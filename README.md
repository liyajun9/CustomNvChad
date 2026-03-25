# Neovim Config Migration Guide

This repository is a personal Neovim config built on top of `NvChad`.

- `NvChad/NvChad` is used as a plugin by this repo.
- Default NvChad modules are imported with statements such as `require "nvchad.options"` and `require "nvchad.mappings"`.
- This repo contains the user config layer, plugin overrides, keymaps, and `lazy-lock.json` for pinned plugin versions.

## What This Repo Contains

- `init.lua`: Neovim entrypoint
- `lua/options.lua`: user editor options
- `lua/mappings.lua`: user keymaps
- `lua/autocmds.lua`: user autocommands
- `lua/plugins/init.lua`: plugin list and plugin overrides
- `lua/configs/*.lua`: plugin-specific config
- `lazy-lock.json`: pinned plugin commits for reproducible installs

## Migration Goal

To reproduce this setup on another machine, you usually only need to copy this repository to:

```bash
~/.config/nvim
```

Then let `lazy.nvim` reinstall plugins and let `mason.nvim` install external tools.

## Recommended Migration Steps

### 1. Install system dependencies

On macOS:

```bash
brew install neovim git ripgrep fd node python
```

Notes:

- `neovim`: editor itself
- `git`: required for plugin installation
- `ripgrep`: used by Telescope live grep
- `fd`: improves file finding in Telescope workflows
- `node`: required by several language servers installed by Mason
- `python`: required by Python tooling such as `black`

### 2. Install a Nerd Font

This config uses icon plugins such as `nvim-web-devicons`, so a Nerd Font is recommended.

Without a Nerd Font, icons may render incorrectly.

### 3. Clone this repo to the Neovim config directory

```bash
git clone <your-repo-url> ~/.config/nvim
```

If the target directory already exists:

```bash
mv ~/.config/nvim ~/.config/nvim.backup
git clone <your-repo-url> ~/.config/nvim
```

### 4. Start Neovim once

```bash
nvim
```

On first startup:

- `init.lua` bootstraps `lazy.nvim` automatically if missing
- plugins are installed under `~/.local/share/nvim/lazy`
- pinned versions from `lazy-lock.json` are used
- NvChad and user overrides are loaded together

### 5. Install Mason-managed tools

This config enables LSP servers and formatters that depend on external binaries.

Open Neovim and run:

```vim
:Mason
```

Install the tools used by this config:

- `bash-language-server`
- `clangd`
- `clang-format`
- `cmake-language-server`
- `lemminx`
- `lua-language-server`
- `marksman`
- `pyright`
- `stylua`
- `yaml-language-server`
- `vscode-json-language-server`

Optional, depending on your workflow:

- `html-lsp`
- `css-lsp`
- `python-lsp-server`
- `ansible-language-server`
- `dockerfile-language-server`
- `docker-compose-language-service`

### 6. Ensure formatters are available

Current formatter config includes:

- `stylua` for Lua
- `clang_format` for C/C++
- `black` for Python

If `black` is not installed through Mason, install it separately:

```bash
python3 -m pip install black
```

### 7. Re-authenticate Copilot if needed

This config includes `copilot.lua`.

On a new machine, GitHub Copilot usually needs a fresh login. Inside Neovim:

```vim
:Copilot auth
```

## What Should Be Copied

Required:

- `~/.config/nvim`

Usually do not copy:

- `~/.cache/nvim`
- `~/.local/state/nvim`

Optional:

- `~/.local/share/nvim/mason`

Why:

- `~/.config/nvim` contains the real configuration
- `~/.cache/nvim` is rebuildable cache
- `~/.local/state/nvim` contains logs, undo history, sessions, and runtime state
- `~/.local/share/nvim/mason` contains installed external tools and can save setup time on a similar machine

## What Gets Recreated Automatically

After cloning this repo and starting Neovim, these are recreated automatically:

- `~/.local/share/nvim/lazy`
- plugin installations
- compiled cache under `~/.cache/nvim`
- runtime state files under `~/.local/state/nvim`

## What Does Not Automatically Transfer

These need to be handled separately on a new machine:

- system packages installed with Homebrew
- Nerd Font configuration in the terminal app
- GitHub Copilot login state
- Mason-installed external tools, unless you copy `~/.local/share/nvim/mason`
- shell environment and PATH customizations outside Neovim

## Useful Paths

- Config: `~/.config/nvim`
- Plugins: `~/.local/share/nvim/lazy`
- Mason tools: `~/.local/share/nvim/mason`
- State: `~/.local/state/nvim`
- Cache: `~/.cache/nvim`

## Quick Setup Summary

```bash
brew install neovim git ripgrep fd node python
git clone <your-repo-url> ~/.config/nvim
nvim
```

Then inside Neovim:

```vim
:Mason
```

Install the required LSP servers and formatters, then run:

```vim
:checkhealth
```

## Notes About Reproducibility

- Plugin versions are pinned in `lazy-lock.json`
- External tools installed by Mason are not pinned by this repo
- For the closest reproduction, use the same Neovim major/minor version and similar OS architecture

## Credits

1. LazyVim starter: https://github.com/LazyVim/starter
   NvChad's starter was inspired by it and it simplifies the overall structure.
