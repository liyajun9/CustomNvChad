require("nvchad.configs.lspconfig").defaults()

local servers = { "html", "cssls", "clangd", "cmake", "pyright", "lua_ls", "bashls", "marksman", "lemminx", "yamlls" }
vim.lsp.enable(servers)

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local opts = { buffer = args.buf }
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
  end,
})

-- read :h vim.lsp.config for changing options of lsp servers 
