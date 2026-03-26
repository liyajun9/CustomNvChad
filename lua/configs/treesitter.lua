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

  return opts
end

return M
