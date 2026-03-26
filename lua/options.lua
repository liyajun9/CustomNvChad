require "nvchad.options"

-- add yours here!
local opt = vim.opt
opt.expandtab = true
opt.tabstop = 4
opt.shiftwidth = 4
opt.softtabstop = 4
opt.shiftround = true
opt.shiftwidth = 4
opt.autoindent = true
opt.smartindent = true

opt.mouse = "a"
opt.clipboard = "unnamedplus"
opt.selection = "exclusive"

opt.scrolloff = 8
-- local o = vim.o
-- o.cursorlineopt ='both' -- to enable cursorline!

opt.foldmethod = "expr"
opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
opt.foldlevel = 99
opt.foldenable = true
opt.foldlevelstart = 99

