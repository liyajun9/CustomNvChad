local M = {}

M.setup = function(opts)
  local extra = {
    "c", "cpp", "python", "markdown", "markdown_inline", "cmake", "make",
    "bash", "javascript", "typescript", "html", "css", "json",
    "go", "rust", "ruby", "php", "sql", "yaml", "toml", "dockerfile",
    "graphql", "vue", "svelte",
  }

  -- 1) 追加 ensure_installed，不覆盖默认值
  opts.ensure_installed = opts.ensure_installed or {}

  for _, lang in ipairs(extra) do
    if not vim.tbl_contains(opts.ensure_installed, lang) then
      table.insert(opts.ensure_installed, lang)
    end
  end

  -- 2) 增量选择
  opts.incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "<leader>ss",
      node_incremental = "<leader>si",
      scope_incremental = "<leader>sc",
      node_decremental = "<leader>sd",
    },
  }

  -- 3) 文本对象（需要 nvim-treesitter-textobjects 插件）
  opts.textobjects = {
    select = {
      enable = true,
      lookahead = true,
      keymaps = {
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
        ["aa"] = "@parameter.outer",
        ["ia"] = "@parameter.inner",
      },
    },
    move = {
      enable = true,
      set_jumps = true,
      goto_next_start = {
        ["]f"] = "@function.outer",
        ["]c"] = "@class.outer",
      },
      goto_previous_start = {
        ["[f"] = "@function.outer",
        ["[c"] = "@class.outer",
      },
    },
    swap = {
      enable = true,
      swap_next = {
        ["<leader>a"] = "@parameter.inner",
      },
      swap_previous = {
        ["<leader>A"] = "@parameter.inner",
      },
    },
  }
  return opts
end

return M
