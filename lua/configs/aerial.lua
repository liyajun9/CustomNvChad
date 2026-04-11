return {
  -- 侧边栏外观
  layout = {
    min_width = 28,
    max_width = 40,
    width = nil,
    placement = "edge",
    default_direction = "right",
  },

  -- 自动聚焦当前符号
  attach_mode = "global", -- or "local"
  close_on_select = false,

  -- 显示图标（需 Nerd Font）
  show_guides = true,
  guides = {
    mid_item = "├ ",
    last_item = "└ ",
    nested_top = "│ ",
    whitespace = "  ",
  },

  -- 过滤符号类型（可选）
  filter_kind = false, -- 设为 true 可隐藏变量等
}
