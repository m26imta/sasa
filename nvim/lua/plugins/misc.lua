return {
  { "moll/vim-bbye", lazy = true,
    keys = {
      { "Q", "<cmd>Bdelete!<cr>", desc = "Close current buffer", mode = {"n"}, noremap = true, silent = true },
    }
  },
  -- dependencies
  { "nvim-lua/plenary.nvim", lazy = true },
  { "nvim-tree/nvim-web-devicons", lazy = true },
  { "MunifTanjim/nui.nvim", lazy = true },
}
