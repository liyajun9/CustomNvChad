local cmp = require "cmp"
local opts = require "nvchad.configs.cmp"

opts.sources = cmp.config.sources({
  { name = "nvim_lsp" },
  { name = "luasnip" },
  { name = "buffer" },
  { name = "nvim_lua" },
})

return opts
