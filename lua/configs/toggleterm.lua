return {
  size = function(term)
    if term.direction == "horizontal" then
      return 15
    elseif term.direction == "vertical" then
      return vim.o.columns * 0.4
    end
  end,

  on_open = function(term)
    local cwd = vim.fn.expand("%:p:h")
    if vim.fn.isdirectory(cwd) == 1 then
      vim.api.nvim_chan_send(term.jobid, "cd " .. vim.fn.fnameescape(cwd) .. "\n")
    end
  end,

  open_mapping = [[<leader>t]],
  hide_numbers = true,
  --shade_filetypes = {},
  --shade_terminals = true,
  --shading_factor = 2, -- 背景透明度(0=不透明)

    -- 启动目录:项目根目录
  start_in_insert = true,
  persist_size = true,

  persist_mode = true, -- 记住终端模式
  shell = "/bin/zsh" -- 自定义shell
}
