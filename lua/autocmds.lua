require "nvchad.autocmds"

local function update_session_sidebar_state(force)
  if vim.g.session_sidebar_state_frozen and not force then
    return
  end

  local data = {
    nvim_tree_open = false,
  }

  local ok_tree, nvim_tree = pcall(require, "nvim-tree.api")
  if ok_tree then
    data.nvim_tree_open = nvim_tree.tree.is_visible()
  end

  vim.g.session_sidebar_state = data
end

vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    vim.g.session_sidebar_state_frozen = false
  end,
})

vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    vim.defer_fn(function()
      if vim.g.SessionLoad then
        return
      end

      local ok_as, auto_session = pcall(require, "auto-session")
      local ok_lib, lib = pcall(require, "auto-session.lib")
      if not ok_as or not ok_lib then
        return
      end

      local function find_nearest_session_dir()
        local dir = vim.fn.getcwd()
        local root = vim.fs.root(dir, { ".git", "compile_commands.json", "CMakeLists.txt", "SConstruct" })
        root = root or dir

        while dir and dir ~= "" do
          local session_path = auto_session.get_root_dir() .. lib.escape_session_name(dir) .. ".vim"
          local readable = vim.fn.filereadable(session_path) == 1
          if readable then
            return dir
          end
          if dir == root then
            break
          end
          local parent = vim.fn.fnamemodify(dir, ":h")
          if parent == dir then
            break
          end
          dir = parent
        end
      end

      local restore_dir = find_nearest_session_dir()
      if vim.fn.argc() > 0 and restore_dir then
        pcall(function()
          auto_session.restore_session(restore_dir)
        end)
      end
    end, 100)
  end,
})

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

-- 仅在 parser 可用时启用 treesitter 折叠，避免启动阶段 foldexpr 崩溃
vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter", "WinEnter" }, {
  callback = function()
    local bufnr = vim.api.nvim_get_current_buf()
    local ok = pcall(vim.treesitter.get_parser, bufnr)
    if not ok then
      vim.wo.foldmethod = "manual"
      vim.wo.foldexpr = "0"
      return
    end

    vim.wo.foldmethod = "expr"
    vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
    vim.wo.foldlevel = 99
    vim.wo.foldenable = true
  end,
})

vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter", "WinEnter", "WinClosed" }, {
  callback = function()
    update_session_sidebar_state()
  end,
})

vim.api.nvim_create_autocmd("VimLeavePre", {
  callback = function()
    update_session_sidebar_state(true)
    vim.g.session_sidebar_state_frozen = true
  end,
})
