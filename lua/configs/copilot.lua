return {
  suggestion = {
    enabled = true,
    auto_trigger = true,
    keymap = {
      --accept = "<Tab>",
      accept = "<M-l>",
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
      open = "<M-CR>",  -- Alt+Enter to open the panel
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
