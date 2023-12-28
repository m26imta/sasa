return {
  {
    "GCBallesteros/NotebookNavigator.nvim",
    ft = "python",
    keys = {
      { "]h", function() require("notebook-navigator").move_cell "d" end },
      { "[h", function() require("notebook-navigator").move_cell "u" end },
      { "<leader>X", "<cmd>lua require('notebook-navigator').run_cell()<cr>" },
      { "<leader>x", "<cmd>lua require('notebook-navigator').run_and_move()<cr>" },
    },
    dependencies = {
      "GCBallesteros/jupytext.nvim",
      "echasnovski/mini.ai",
      "echasnovski/mini.comment",
      "hkupty/iron.nvim", -- repl provider
      -- "akinsho/toggleterm.nvim", -- alternative repl provider
      "anuvyklack/hydra.nvim",
    },
    config = function()
      local nn = require "notebook-navigator"
      nn.setup({ activate_hydra_keys = "<leader>h" })
    end,
  },
  {
    "GCBallesteros/jupytext.nvim",
    event = "VeryLazy",
    config = function()
      require("jupytext").setup(
        {
          style = "hydrogen",
        }
      )
    end,
  },
  {
    "hkupty/iron.nvim",
    -- enabled = false,
    -- event = "VeryLazy",
    version = false,  -- false -> latest commit
    config = function()
      local iron = require("iron.core")
      local view = require("iron.view")
      iron.setup {
        config = {
          -- https://github.com/Vigemus/iron.nvim?tab=readme-ov-file#repl-windows
          -- repl_open_cmd = view.split.vertical.botright(60),
          -- repl_open_cmd = "vertical botright 60 split",
          repl_open_cmd = view.split.vertical.botright(60),
        },
        keymaps = {
          send_motion = "<leader>sc",
          visual_send = "<leader>sc",
          send_file = "<leader>sf",
          exit = "<leader>sq",
          clear = "<leader>cl",
        },
        ignore_blank_lines = true, -- ignore blank lines when sending visual select lines
      }
    end,
  },
  {
    "echasnovski/mini.hipatterns",
    -- event = "VeryLazy",
    dependencies = { "GCBallesteros/NotebookNavigator.nvim" },
    opts = function()
      local nn = require "notebook-navigator"

      local opts = { highlighters = { cells = nn.minihipatterns_spec } }
      return opts
    end,
  },
  {
    "echasnovski/mini.ai",
    -- event = "VeryLazy",
    dependencies = { "GCBallesteros/NotebookNavigator.nvim" },
    opts = function()
      local nn = require "notebook-navigator"

      -- https://github.com/GCBallesteros/NotebookNavigator.nvim?tab=readme-ov-file#yankingdeleting-cells
      -- vah to select the full cell in visual mode.
      local opts = { custom_textobjects = { h = nn.miniai_spec } }
      return opts
    end,
  },
}

