return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },

  {
    "neovim/nvim-lspconfig",
    -- config = function()
      -- require "configs.lspconfig"
    -- end,
  },

  -- Direnv integration
  { "direnv/direnv.vim", lazy = false },

  -- Opening terminal session in a floating popup window
  { "voldikss/vim-floaterm", lazy = false },

  {
  	"nvim-treesitter/nvim-treesitter",
  	opts = {
  		ensure_installed = {
  			"vim", "lua", "vimdoc",
       "html", "css"
  		},
  	},
  },

  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "lua-language-server",
        -- "pylsp",
        "basedpyright",
        "yaml-language-server",
        "docker-language-server",
        "docker-compose-language-server",
        "bash-language-server"
      },
    },
  },
}
