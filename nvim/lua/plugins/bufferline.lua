local config = function()
  local bufferline = require("bufferline")
---@diagnostic disable-next-line: missing-fields
  bufferline.setup {
---@diagnostic disable-next-line: missing-fields
    options = {
      separator_style = "slant",
      close_command = "Bdelete! %d", -- can be a string | function, see "Mouse actions"
      right_mouse_command = "Bdelete! %d", -- can be a string | function, see "Mouse actions"
      left_mouse_command = "buffer %d", -- can be a string | function, see "Mouse actions"
      middle_mouse_command = nil, -- can be a string | function, see "Mouse actions"

      -- indicator_icon = nil,
      -- indicator = { style = "icon", icon = "▎"},
      indicator = { style = 'underline',  icon = '▎'},
      -- buffer_close_icon = "",
      buffer_close_icon = '',
      modified_icon = "●",
      close_icon = "",
      -- close_icon = '',
      left_trunc_marker = "",
      right_trunc_marker = "",
    },
  }
end

return {
  {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = {
      { "nvim-tree/nvim-web-devicons"},
      { "moll/vim-bbye", lazy = true,
        keys = {
          { "Q", "<cmd>Bdelete!<cr>", desc = "Close current buffer", mode = {"n"}, noremap = true, silent = true },
        }
      },
    },
    event = "BufEnter",
    config = config,
  },
}

