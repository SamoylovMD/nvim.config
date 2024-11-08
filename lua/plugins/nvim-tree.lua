return {
  "nvim-tree/nvim-tree.lua",
  lazy = false,
  config = function ()
    require("nvim-tree").setup({
      view = {
        width = 35
      },
      root_dirs = {
        "~/wrike/code"
      },
      git = {
        enable = true,
        timeout = 2000,
      },
      modified = {
        enable = true,
      },
      filters = {
        enable = true,
        git_ignored = false,
        custom = {
          ".git",
          ".pytest_cache",
          "__pycache__"
        }
      },
      renderer = {
        group_empty = true
      },
      live_filter = {
        always_show_folders = false
      },
      filesystem_watchers = {
        ignore_dirs = {
          "__pycache__",
          ".pytest_cache",
          "build",
        }
      },
      actions = {
        expand_all = {
          exclude = {
            "__pycache__",
            ".pytest_cache",
            ".git"
          }
        }
      }
    })
  end
}
