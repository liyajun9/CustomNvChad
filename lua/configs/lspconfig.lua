require("nvchad.configs.lspconfig").defaults()

local servers = { "html", "cssls", "clangd", "cmake", "pyright", "lua_ls", "bashls", "marksman", "lemminx", "yamlls" }
vim.lsp.enable(servers)

-- read :h vim.lsp.config for changing options of lsp servers 
