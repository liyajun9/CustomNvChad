require "nvchad.autocmds"

--关闭lua文件的tab
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "lua" },
  callback = function()
  vim.opt_local.expandtab = true
  vim.opt_local.tabstop = 2
  vim.opt_local.shiftwidth = 2
  vim.opt_local.softtabstop = 2
end,
})

--关闭markdown等文本文件的拼写检查
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "markdown", "txt", "log", "csv" },
  callback = function()
  vim.opt_local.spell = false
end,
})

--解决ctrl-d,ctrl-u滚动步距随着窗口大小改变而改变的问题
vim.api.nvim_create_autocmd({ "VimEnter", "WinEnter", "BufWinEnter", "WinResized" }, {
  callback = function()
    local cfg = vim.api.nvim_win_get_config(0)
    if cfg.relative ~= "" then
      return
    end

    vim.opt_local.scroll = 3
  end,
})

--使用treesitter折叠
vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter", "WinEnter" }, {
  callback = function()
    vim.wo.foldmethod = "expr"
    vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
    vim.wo.foldlevel = 99
    vim.wo.foldenable = true
  end,
})
