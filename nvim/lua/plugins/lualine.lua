return {
  "nvim-lualine/lualine.nvim",
  --event = "BufEnter", lazy = true,
  event = "VeryLazy",
  enabled = true,
  config = function()
    require("lualine").setup({})
  end
}
