return {
  auto_restore = true,
  auto_save = true,
  auto_restore_last_session = false,
  git_use_branch_name = false,
  suppressed_dirs = {
    vim.fn.expand "~",
    vim.fn.expand "~/Downloads",
    vim.fn.expand "~/Desktop",
  },
  session_lens = {
    load_on_setup = false,
  },
}
