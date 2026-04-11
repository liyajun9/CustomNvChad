-- This file needs to have same structure as nvconfig.lua 
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :( 

---@type ChadrcConfig
local M = {}

M.base46 = {
	theme = "catppuccin",

	-- hl_override = {
	-- 	Comment = { italic = true },
	-- 	["@comment"] = { italic = true },
	-- },
}

-- M.nvdash = { load_on_startup = true }
M.ui = {
  tabufline = {
    enabled = true,
    lazyload = false,
  },
  statusline = {
    order = { "mode", "file", "git", "%=", "lsp_msg", "%=", "diagnostics", "lsp", "cwd", "encoding", "cursor" },
    modules = {
      encoding = function()
        local fenc = vim.bo.fileencoding
        if fenc == nil or fenc == "" then
          fenc = vim.go.encoding
        end

        return (fenc and fenc ~= "") and (" " .. string.upper(fenc) .. " ") or ""
      end,
    },
  },
}

return M
