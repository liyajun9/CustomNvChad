return {
  auto_restore = true,
  auto_save = true,
  auto_restore_last_session = false,
  close_unsupported_windows = false,
  git_use_branch_name = false,
  suppressed_dirs = {
    vim.fn.expand "~",
    vim.fn.expand "~/Downloads",
    vim.fn.expand "~/Desktop",
  },
  session_lens = {
    load_on_setup = false,
  },
  save_extra_data = function()
    local data = {
      nvim_tree_open = false,
      aerial_open = false,
    }

    local ok_tree, nvim_tree = pcall(require, "nvim-tree.api")
    if ok_tree then
      data.nvim_tree_open = nvim_tree.tree.is_visible()
    end

    local ok_aerial, aerial = pcall(require, "aerial")
    if ok_aerial then
      data.aerial_open = aerial.is_open()
    end

    return vim.json.encode(data)
  end,
  restore_extra_data = function(_, extra_data)
    local ok_decode, data = pcall(vim.json.decode, extra_data)
    if not ok_decode or type(data) ~= "table" then
      return
    end

    vim.defer_fn(function()
      if data.nvim_tree_open then
        local ok_tree, nvim_tree = pcall(require, "nvim-tree.api")
        if ok_tree and not nvim_tree.tree.is_visible() then
          nvim_tree.tree.open()
        end
      end

      if data.aerial_open then
        local ok_aerial, aerial = pcall(require, "aerial")
        if ok_aerial and not aerial.is_open() then
          vim.cmd("AerialOpen right")
        end
      end
    end, 200)
  end,
}
