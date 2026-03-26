require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set
local unmap = vim.keymap.del

-- map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

unmap("i", "<C-b>")
unmap("n", "<C-s>")
unmap("n", "<C-c>")
unmap("n", "<leader>h")
unmap("n", "<leader>v")
unmap({ "n", "t" }, "<A-v>")

map("i", "<C-a>", "<ESC>^i", { desc = "move beginning of line" })
-- Comment toggle (Ctrl+/)
map("n", "<C-/>", "gcc", { desc = "Toggle Comment", remap = true})
map("n", "<C-_>", "gcc", { desc = "Toggle Comment", remap = true})
map("v", "<C-/>", "gc", { desc = "Toggle Comment", remap = true})
map("v", "<C-_>", "gc", { desc = "Toggle Comment", remap = true})
map("n", "<leader>cp", "<cmd>Copilot panel open<cr>", { desc = "Copilot panel" })

-- auto copy to system clipboard while selection
--[[
vim.api.nvim_create_autocmd("ModeChanged", {
  pattern = "v:*",
  callback = function()
    vim.keymap.set("v", "<Esc>", "<cmd>normal! y<cr><Esc>", { silent = true, noremap = true })
  end,
})
--]]
