return {
  {
    "rcarriga/nvim-dap-ui",
    dependencies = {
      "mfussenegger/nvim-dap",
      "mfussenegger/nvim-dap-python",
      'theHamsta/nvim-dap-virtual-text',
      "rcarriga/cmp-dap",
      "nvim-neotest/nvim-nio"
    },

    config = function()
      local dap = require("dap")
      local dapui = require("dapui")
      require("nvim-dap-virtual-text").setup()

      vim.fn.sign_define('DapBreakpoint', {text='🛑', texthl='', linehl='', numhl=''})
      vim.fn.sign_define('DapStopped', {text='🚏', texthl='', linehl='', numhl=''})

      local dappy = require("dap-python")
      dappy.setup()
      -- dappy.resolve_python = function()
      --   return venv_python_path()
      -- end
      dappy.test_runner = 'pytest'
      dappy.default_port = 7123

      dap.listeners.after.event_initialized["dapui_config"] = function()
        require('dapui').open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        require('dapui').close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        require('dapui').close()
      end

      dap.configurations.python = {
        {
          type = "python",
          request = "launch",
          name = "Launch file with default configuration",
          program = "${file}",
          -- pythonPath = venv_python_path()
        },
        {
          type = "python",
          request = "launch",
          name = "Launch pytest",
          program = "${env:VIRTUAL_ENV}/bin/pytest"
          -- program = "rye --env-file .env test"
        },
        {
          type = "python",
          request = "attach",
          name = "Attach to debug server",
          connect = function()
            return {
              host = "localhost",
              port = "7123"
            }
          end
        }
      }

      dap.adapters.python = {
        type = 'executable',
        command = "python",
        args = {'-m', 'debugpy.adapter'}
      }

      dap.adapters.pytest = {
        type = 'executable',
        command = "pytest", 
      }

      require("dapui").setup({
        layouts = {
          {
            elements = {
              {
                id = "scopes",
                size = 0.70
              },
              {
                id = "breakpoints",
                size = 0.10
              },
              {
                id = "stacks",
                size = 0.20
              }
            },
            position = "left",
            size = 50
          },
          {
            elements = {
              {
                id = "repl",
                size = 1
              }
            },
            position = "bottom",
            size = 10
          }
        },
      })

    end;
  },
}
