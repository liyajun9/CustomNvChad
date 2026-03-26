return {
  suggestion = {
    enabled = true,
    auto_trigger = true,
    keymap = {
      accept = "<leader><leader>",
      --dismiss = "<C-]>",
      dismiss = "<C-c>",
      next = "<M-]>",
      prev = "<M-[>",
    },
  },
  panel = {
    enabled = true,
    auto_refresh = false,
    keymap = {
      open = "<M-p>",
    },
  },
  filetypes = {
    ["*"] = true,
    markdown = false,
    help = false,
    yaml = false,
    gitcommit = false
  },
}
