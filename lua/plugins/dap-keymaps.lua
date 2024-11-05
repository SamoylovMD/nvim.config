return {
    "nvimtools/hydra.nvim",
    enabled = false,
    lazy = false,
    dependencies = {
      "mfussenegger/nvim-dap",
      "nvim-neotest/nvim-nio",
      "rcarriga/nvim-dap-ui",
      "nvim-lualine/lualine.nvim",
    },
    config = function()
      local dap = require("dap")
    --
      -- Run last: https://github.com/mfussenegger/nvim-dap/issues/1025
      local last_config = nil
      ---@param session Session
      dap.listeners.after.event_initialized["store_config"] = function(session)
        last_config = session.config
      end

      local function debug_run_last()
        if last_config then
          dap.run(last_config)
        else
          dap.continue()
        end
      end

    local Hydra = require('hydra')

    local hint = [[
         ^ ^Step^ ^ ^      ^ ^     Action
     ----^-^-^-^--^-^----  ^-^-------------------  
         ^ ^back^ ^ ^      _b_: toggle breakpoint 
         ^ ^ _k_^ ^         _B_: Set conditional breakpoint 
     out _h_ ^ ^ _l_ into   _c_: Run or Continue
         ^ ^ _j_ ^ ^        _x_: Terminate
         ^ ^over ^ ^      ^^_s_: open scope
                      _u_: UI toggle
                      _?_: Hydra hint
                      _gl_: Run last configuration
                      _L_: List breakpoints
                      _P_: Purge breakpoints

         ^ ^  _<Esc>_: Normal mode
    ]]

      DapHydra = Hydra({
         name = "DEBUG",
         hint = hint,
         config = {
            color = 'pink',
            desc = "Debug mode",
            invoke_on_body = true,
            hint = {
              float_opts = {
            border = "rounded",
          },
              hide_on_load = true,
              show_name = true,
            },
         },

         mode = 'n',
         body = '<leader>x',
         heads = {
           { "x", function() require("dap").restart() end, { desc = "Restart session" }},
           { "b", function() require("dap").toggle_breakpoint() end, { desc = "Toggle Breakpoints" }},
           { "B", function() require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, { desc = "Conditional Breakpoint" }},
           { "c", function() require("dap").continue() end, { desc = "Continue" }},
           { "h", function() require("dap").step_out() end, { desc = "Step Out" }},
           { "j", function() require("dap").step_over() end, { desc = "Step Over" }},
           { "k", function() require("dap").step_back() end, { desc = "Step Back" }},
           { "l", function() require("dap").step_into() end, { desc = "Step Into" }},
           { "L", function() require("dapui").float_element "breakpoints" end, { desc = "List Breakpoints" }},
           { "P", function() require("dap").clear_breakpoints() end, { desc = "Clear Breakpoints" }},
           { "q", function() require("dap").terminate() end, { desc = "Terminate Session" }},
           { "Q", function()
              dap.terminate()
              dap.close()
              require("dapui").close()
            end, { desc = "Terminate and Exit Debug" }},
           { "r", function() require("dap").repl.toggle() end, { desc = "REPL" }},
           { "s", function() require("dapui").float_element "scopes" end, { desc = "Scopes" }},
           { "t", function() require("dapui").float_element "stacks" end, { desc = "Threads" }},
           { "u",  function() require("dapui").toggle() end, { desc = "Show Debug UI" }},
           { "w", function() require("dapui").float_element "watches" end, { desc = "Watches" }},
           { "y", function() require("dap.ui.widgets").hover() end, { desc = "Inspect" }},
            -- { "u", function() require("dapui").toggle() end},
            -- { "b", function() require("dap").toggle_breakpoint() end },
            -- { "m", function() require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: ')) end },
            -- { "c", function() if vim.bo.filetype ~= "dap-float" then require("dap").continue() end end},
            -- { "k", function() if vim.bo.filetype ~= "dap-float" then require("dap").step_back() end end},
            -- { "h", function() if vim.bo.filetype ~= "dap-float" then require("dap").step_out() end end},
            -- { "j", function() if vim.bo.filetype ~= "dap-float" then require("dap").step_over() end end},
            -- { "l", function() if vim.bo.filetype ~= "dap-float" then require("dap").step_into() end end},
            { "gl", function() debug_run_last() end},
            -- { "x", function() require("dap").terminate() end},
            -- { "*", function() require("dap").run_to_cursor() end},
            -- { "s", function() if vim.bo.filetype ~= "dap-float" then require("dap.ui.widgets").centered_float(require("dap.ui.widgets").scopes) end end},
            { "?", function() if DapHydra.hint.win then DapHydra.hint:close() else DapHydra.hint:show() end end},
            { '<Esc>', nil, { exit = true, nowait = true } },
         }
      })
    end,
}
