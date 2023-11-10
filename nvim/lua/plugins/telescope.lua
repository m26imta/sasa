local config = function()
  local telescope = require("telescope")
  local actions = require("telescope.actions")
  local opts = {
    defaults = {
      prompt_prefix = " ",
      selection_caret = " ",
      path_display = { "smart" },
      mappings = {
        i = {
          ["<C-c>"] = actions.close,
        },
        n = {
          ["<esc>"] = actions.close,
          ["<C-c>"] = actions.close,
          ["q"] = actions.close,
        },
      },
    },
    pickers = {
      -- Default configuration for builtin pickers goes here:
      -- picker_name = {
      --   picker_config_key = value,
      --   ...
      -- }
      -- Now the picker_config_key will be applied every time you call this
      -- builtin picker
    },
    extensions = {
      -- Your extension configuration goes here:
      -- extension_name = {
      --   extension_config_key = value,
      -- }
      -- please take a look at the readme of the extension you want to configure
      -- ["ui-select"] = {
      --   require("telescope.themes").get_dropdown {
      --     -- even more opts
      --   }
      -- }
    },
  }
  telescope.setup(opts)
  telescope.load_extension("fzf")
  
end


return {
  { "nvim-telescope/telescope.nvim",
    tag = "0.1.4",
    -- version = fasle, -- telescope did only one release, so use HEAD for now
    cmd = "Telescope",
    -- keys = require("core.keymaps").plugins_keymaps.telescope,
    dependencies = {
      { "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
      },
      { "nvim-telescope/telescope-ui-select.nvim",
        enabled = false,
        config = function()
          require("telescope").load_extension("ui-select")
          require("telescope").setup({
            extensions = {
              ["ui-select"] = {
                require("telescope.themes").get_dropdown{}
              }
            }
          })
        end,
      },
      { "nvim-lua/plenary.nvim" },
    },
    config = config,
  },
}
