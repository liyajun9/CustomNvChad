return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    event = { "BufReadPre", "BufNewFile" },
    opts = require "configs.conform",
  },

  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  {
    "hrsh7th/nvim-cmp",
    opts = function()
      return require "configs.cmp"
    end,
  },

  {
    "https://codeberg.org/FelipeLema/cmp-async-path.git",
    enabled = false,
  },

  {
    "stevearc/aerial.nvim",
    cmd = { "AerialOpen", "AerialOpenAll", "AerialToggle", "AerialNavToggle" },
    opts = require("configs.aerial"),
    keys = {
      { "<C-\\>", "<cmd>AerialToggle<cr>", desc = "Toggle Symbol Outline" },
    },
  },

  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    opts = require("configs.copilot"),
  },

  {
    "CopilotC-Nvim/CopilotChat.nvim",
    branch = "main",
    build = "make tiktoken",
    cmd = {
      "CopilotChat",
      "CopilotChatOpen",
      "CopilotChatClose",
      "CopilotChatToggle",
      "CopilotChatExplain",
      "CopilotChatReview",
      "CopilotChatFix",
      "CopilotChatOptimize",
      "CopilotChatDocs",
      "CopilotChatTests",
    },
    dependencies = {
      { "zbirenbaum/copilot.lua" },
      { "nvim-lua/plenary.nvim" },
    },
    opts = require("configs.copilotchat"),
  },

  {
    "rmagatti/auto-session",
    lazy = false,
    event = "VimEnter",
    opts = require("configs.session"),
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      return require("configs.treesitter").setup(opts)
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
  },

  --{
    --"akinsho/toggleterm.nvim",
    --version = "*",
    --opts = require("configs.toggleterm"),
  --},

  -- test new blink
  -- { import = "nvchad.blink.lazyspec" },

  -- {
  -- 	"nvim-treesitter/nvim-treesitter",
  -- 	opts = {
  -- 		ensure_installed = {
  -- 			"vim", "lua", "vimdoc",
  --      "html", "css"
  -- 		},
  -- 	},
  -- },
}
