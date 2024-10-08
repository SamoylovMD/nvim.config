return {
  "nvim-neotest/neotest-python",
  dependencies = {
    "nvim-neotest/neotest",
    "mfussenegger/nvim-dap",
    "mfussenegger/nvim-dap-python",
    "nvim-treesitter/nvim-treesitter"
  },
  config = function ()
    require("neotest").setup({
      adapters = {
        require("neotest-python")({
          dap = { justMyCode = false },
          args = {"--log-level", "DEBUG"},
          runner = "${VIRTUAL_ENV}/bin/pytest",
          python = "${VIRTUAL_ENV}/bin/python"
        })
      }
    })
  end
}
