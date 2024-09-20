return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  -- Direnv integration
  { "direnv/direnv.vim", lazy = false },

  -- Opening terminal session in a floating popup window
  { "voldikss/vim-floaterm", lazy = false },

  -- Debug adapter protocol
  { "mfussenegger/nvim-dap", lazy = false },

  -- UI for nvim-dap 
  {
    "rcarriga/nvim-dap-ui", 
    dependencies = {"mfussenegger/nvim-dap", "nvim-neotest/nvim-nio"},
    lazy = false
  },

  {
  	"nvim-treesitter/nvim-treesitter",
  	opts = {
  		ensure_installed = {
  			"vim", "lua", "vimdoc",
       "html", "css"
  		},
  	},
  },
}
