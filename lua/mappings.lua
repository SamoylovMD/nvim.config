require "nvchad.mappings"
-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

-- Key mappings for debug (outdated, see plugins/dap-keymaps.lua)
-- map('n', '<leader>Xx', function() require("dap").restart() end, { desc = "Restart session" })
-- map('n', '<leader>Xb', function() require("dap").toggle_breakpoint() end, { desc = "Toggle Breakpoints" })
-- map('n', '<leader>XP', function() require("dap").clear_breakpoints() end, { desc = "Clear Breakpoints" })
-- map('n', '<leader>Xc', function() require("dap").continue() end, { desc = "Continue" })
-- map('n', '<leader>Xl', function() require("dap").step_into() end, { desc = "Step Into" })
-- map('n', '<leader>Xk', function() require("dap").step_back() end, { desc = "Step Back" })
-- map('n', '<leader>XL', function() require("dapui").float_element "breakpoints" end, { desc = "List Breakpoints" })
-- map('n', '<leader>Xj', function() require("dap").step_over() end, { desc = "Step Over" })
-- map('n', '<leader>Xh', function() require("dap").step_out() end, { desc = "Step Out" })
-- map('n', '<leader>Xq', function() require("dap").close() require("dapui").close() end, { desc = "Close Session" })
--
-- map('n', '<leader>XQ', function()
--   local dap = require("dap")
--   dap.terminate()
--   dap.close()
--   require("dapui").close()
-- end, { desc = "Terminate and Close All" })
--
-- map('n', '<leader>Xr', function() require("dap").repl.toggle() end, { desc = "REPL" })
-- map('n', '<leader>Xs', function() require("dapui").float_element "scopes" end, { desc = "Scopes" })
-- map('n', '<leader>Xt', function() require("dapui").float_element "stacks" end, { desc = "Threads" })
-- map('n', '<leader>Xu', function() require("dapui").toggle() end, { desc = "Toggle Debugger UI" })
-- map('n', '<leader>Xw', function() require("dapui").float_element "watches" end, { desc = "Watches" })
-- map('n', '<leader>Xy', function() require("dap.ui.widgets").hover() end, { desc = "Inspect" })

-- Key mappings for nvim-tree (file tree window)
map("n", "<C-1>", "<cmd> NvimTreeToggle <cr>", { desc = "Toggle File Tree" })
-- map("n", "<C-2>", "<cmd> NvimTreeFocus <cr>", { desc = "Focus to File Tree" })

