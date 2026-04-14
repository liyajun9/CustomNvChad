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
    order = { "mode", "file", "git", "symbol", "%=", "lsp_msg", "%=", "diagnostics", "lsp", "cwd", "encoding", "cursor" },
    modules = {
      encoding = function()
        local fenc = vim.bo.fileencoding
        if fenc == nil or fenc == "" then
          fenc = vim.go.encoding
        end

        return (fenc and fenc ~= "") and (" " .. string.upper(fenc) .. " ") or ""
      end,
      symbol = function()
        local ft = vim.bo.filetype
        local enabled = {
          c = true,
          cpp = true,
          python = true,
        }

        if not enabled[ft] then
          return ""
        end

        local ok, aerial = pcall(require, "aerial")
        if not ok then
          return ""
        end

        local symbols = aerial.get_location(true)
        if type(symbols) ~= "table" or vim.tbl_isempty(symbols) then
          return ""
        end

        local names = {}
        for _, symbol in ipairs(symbols) do
          if symbol and symbol.name and symbol.name ~= "" then
            table.insert(names, symbol.name)
          end
        end

        if vim.tbl_isempty(names) then
          return ""
        end

        return " [" .. table.concat(names, " > ") .. "]"
      end,
    },
  },
}

return M
