require "nvchad.autocmds"

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "lua" },
  callback = function()
  vim.opt_local.expandtab = true
  vim.opt_local.tabstop = 2
  vim.opt_local.shiftwidth = 2
  vim.opt_local.softtabstop = 2
end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "markdown", "txt", "log", "csv" },
  callback = function()
  vim.opt_local.spell = false
end,
})

vim.api.nvim_create_autocmd({ "VimEnter", "WinEnter", "BufWinEnter", "WinResized" }, {
  callback = function()
    vim.opt_local.scroll = 3
  end,
})
