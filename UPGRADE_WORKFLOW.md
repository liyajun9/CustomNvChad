# Safe Upgrade Workflow for NvChad and Plugins

This document describes a practical and low-risk workflow for upgrading:

- `NvChad`
- plugins managed by `lazy.nvim`
- plugin lock file `lazy-lock.json`

It is written for this repository layout, where:

- this repo is the user config in `~/.config/nvim`
- `NvChad` is installed as a plugin by `lazy.nvim`
- actual plugin code lives under `~/.local/share/nvim/lazy`

## Core Principles

1. Do not track upstream by Git remote in this config repo.
2. Treat `NvChad` as a plugin upgrade, not as a Git merge operation in this repo.
3. Make upgrades in small steps.
4. Commit config changes and `lazy-lock.json` together.
5. Test before pushing.

## What Actually Changes During Upgrade

When you upgrade plugins, the important file in this repo is:

- `lazy-lock.json`

When you change behavior or add/remove plugins, the important files are usually:

- `init.lua`
- `lua/plugins/init.lua`
- `lua/configs/*.lua`
- `lua/options.lua`
- `lua/mappings.lua`
- `lua/autocmds.lua`
- `lazy-lock.json`

## Recommended Upgrade Types

### 1. Upgrade only one plugin

Use this when:

- you want to test a single plugin update
- you suspect a regression source
- you want minimal risk

Inside Neovim:

```vim
:Lazy update <plugin-name>
```

Examples:

```vim
:Lazy update NvChad
:Lazy update nvim-treesitter
:Lazy update telescope.nvim
```

Then:

1. restart Neovim
2. run checks
3. commit the updated `lazy-lock.json`

### 2. Upgrade all plugins

Use this when:

- you have not updated for a while
- you want to refresh the whole environment

Inside Neovim:

```vim
:Lazy sync
```

or:

```vim
:Lazy update
```

Then:

1. restart Neovim
2. run checks
3. commit `lazy-lock.json`

### 3. Upgrade config and plugins together

Use this when:

- you changed plugin config
- you added or removed plugins
- you changed plugin-specific keymaps or behavior

Workflow:

1. edit config
2. run `:Lazy sync`
3. verify behavior
4. commit config files and `lazy-lock.json` together

## Safe Daily Upgrade Workflow

### Step 1. Start from a clean view of your repo

In shell:

```bash
cd ~/.config/nvim
git status
```

If there are uncommitted changes, decide first:

- commit them
- stash them
- or keep them intentionally, but know what belongs to the upgrade

Do not mix unrelated edits with plugin upgrades if possible.

### Step 2. Create a checkpoint commit before upgrading

This makes rollback easy.

```bash
git add -A
git commit -m "checkpoint before plugin upgrade"
```

If you do not want a permanent commit, at least make sure current changes are stashed or committed.

### Step 3. Upgrade in Neovim

For a targeted upgrade:

```vim
:Lazy update NvChad
```

For a broader upgrade:

```vim
:Lazy sync
```

### Step 4. Restart Neovim

Do a full restart after upgrade.

This matters because:

- some plugins only fully reinitialize on fresh start
- lazy loading state may hide issues until restart

### Step 5. Run health checks

Inside Neovim:

```vim
:checkhealth
```

Pay attention to:

- missing external tools
- provider warnings
- Treesitter issues
- clipboard issues
- Python / Node provider warnings that actually affect your workflow

### Step 6. Test the main workflow manually

At minimum verify:

- startup succeeds with no obvious errors
- file tree works: `nvim-tree`
- search works: `Telescope`
- LSP attaches in a real code file
- completion works: `nvim-cmp`
- snippets work: `LuaSnip`
- formatting works: `conform.nvim`
- terminal works: `toggleterm.nvim`
- symbol outline works: `aerial.nvim`
- Copilot still works if you use it

Recommended quick checks:

1. open a Lua file
2. open a Python or C/C++ file you actually use
3. trigger format
4. trigger definition jump
5. trigger Telescope find files
6. open file tree
7. open terminal

### Step 7. Inspect repo changes

In shell:

```bash
git status
git diff -- lazy-lock.json
```

Expected after a plugin-only upgrade:

- mostly `lazy-lock.json` changes

Expected after config + upgrade:

- config file changes
- `lazy-lock.json` changes

### Step 8. Commit only what should be part of the upgrade

Examples:

```bash
git add lazy-lock.json
git commit -m "chore(nvim): update plugins"
```

or:

```bash
git add lua/plugins/init.lua lua/configs lazy-lock.json
git commit -m "feat(nvim): adjust plugin config after upgrade"
```

### Step 9. Push after validation

```bash
git push
```

## Safe NvChad Upgrade Strategy

`NvChad` in this setup is just another plugin managed by `lazy.nvim`.

That means the safe way to upgrade it is:

```vim
:Lazy update NvChad
```

Not:

- pulling `NvChad` by Git remote in this repo
- merging upstream into `~/.config/nvim`

### When upgrading NvChad specifically

Check these areas carefully afterward:

- `nvchad.options`
- `nvchad.mappings`
- `nvchad.autocmds`
- `nvchad.configs.lspconfig`
- `nvchad.configs.cmp`
- UI changes from `base46` and `ui`

Why:

- your config imports and overrides NvChad defaults
- upstream changes can affect behavior even if your own files did not change

## When to Upgrade One Plugin at a Time

Prefer one-by-one upgrades if:

- Neovim is already stable and you only want one fix
- upstream changed a major plugin like `NvChad`, `nvim-cmp`, `nvim-treesitter`, or `nvim-lspconfig`
- you recently had regressions

This makes debugging much easier.

## When to Upgrade Everything

Upgrade all plugins together only when:

- you are comfortable troubleshooting breakage
- you have time to test
- you want to refresh the whole setup intentionally

If you do this, expect more than one plugin to change behavior at once.

## How to Handle Mason Tools

Plugin upgrades and Mason tools are separate concerns.

Plugin upgrades change:

- `lazy-lock.json`

Mason tool installs change:

- `~/.local/share/nvim/mason`

This repo does not automatically record Mason state.

So when a plugin/config upgrade starts requiring a new external tool:

1. install it with `:Mason`
2. update `README.md` if it is now required for migration
3. verify the tool is available in real usage

Examples:

- adding a new formatter in `conform.nvim`
- enabling a new LSP server in `lspconfig`

## Rollback Strategy

If something breaks after upgrade:

### Fast rollback

In shell:

```bash
cd ~/.config/nvim
git log --oneline
git checkout <last-good-commit> -- lazy-lock.json
```

Or revert the whole repo to the last known good state:

```bash
git checkout <last-good-commit> -- .
```

Use the second form carefully if you had other intended changes.

Then restart Neovim and run:

```vim
:Lazy sync
```

This will reinstall versions matching the restored lock file.

### Better rollback habit

Keep a clean commit before each upgrade.

That gives you:

- a known-good point
- easy diff
- easy rollback

## Suggested Commit Patterns

Examples:

```bash
git commit -m "chore(nvim): update NvChad"
git commit -m "chore(nvim): update plugins"
git commit -m "fix(nvim): adapt config to latest NvChad"
git commit -m "feat(nvim): add aerial plugin"
```

## Practical Rules

- Do not upgrade everything blindly right before important work.
- Do not mix plugin upgrade commits with unrelated edits.
- Do not assume Mason tools are synced just because plugins are synced.
- Do not treat upstream NvChad as a Git remote maintenance problem in this repo.
- Prefer small, testable upgrades.

## Minimal Safe Checklist

Before upgrade:

- `git status` is understood
- current config is committed

Upgrade:

- run `:Lazy update <plugin>` or `:Lazy sync`

After upgrade:

- restart Neovim
- run `:checkhealth`
- test file tree, Telescope, LSP, format, terminal, Copilot
- inspect `git diff`
- commit `lazy-lock.json` and related config changes

## Local Paths Reference

- Config repo: `~/.config/nvim`
- Plugins: `~/.local/share/nvim/lazy`
- Mason tools: `~/.local/share/nvim/mason`
- State: `~/.local/state/nvim`
- Cache: `~/.cache/nvim`
