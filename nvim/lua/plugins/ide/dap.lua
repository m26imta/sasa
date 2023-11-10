-- https://github.com/mfussenegger/nvim-dap
-- https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation

local M = {
  { "rcarriga/nvim-dap-ui",
    dependencies = "mfussenegger/nvim-dap",
    config = function()
      local dap, dapui = require("dap"), require("dapui")
      dapui.setup()
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end

      vim.keymap.set("n", "<leader>du", function() dapui.toggle() end)
      vim.cmd([[vnoremap <M-k> <cmd>lua require('dapui').eval()<CR>]])
      -- keymap repl
      vim.keymap.set("n", "<leader>dr", function() require("dap").repl.open() end)
      vim.keymap.set("n", "<leader>dl", function() require("dap").repl.close() end)

    end
  },
  { "mfussenegger/nvim-dap",
    config = function()
      vim.keymap.set("n", "<leader>db", function() require("dap").toggle_breakpoint() end)
      vim.keymap.set("n", "<leader>dc", function() require("dap").continue() end)
      vim.keymap.set("n", "<leader>di", function() require("dap").step_into() end)
      vim.keymap.set("n", "<leader>do", function() require("dap").step_over() end)
      vim.keymap.set("n", "<leader>dO", function() require("dap").step_out() end)
    end
  },
  { "mfussenegger/nvim-dap-python",
    ft = "python",
    dependencies = {
      "mfussenegger/nvim-dap",
      "rcarriga/nvim-dap-ui",
    },
    config = function()
      local path = vim.fn.stdpath("data") .. "/mason/packages/debugpy/venv/bin/python"
      require("dap-python").setup(path)
      vim.keymap.set("n", "<leader>dbr", function() require("dap-python").test_method() end)
    end,
  },
}

return M
