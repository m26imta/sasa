return {
  "lukas-reineke/indent-blankline.nvim",
  commit = "9637670", -- stay with v2
  event = "BufEnter",
  config = function()
    require("indent_blankline").setup({
      -- for example, context is off by default, use this to turn it on
      show_current_context = true,
      show_current_context_start = false,
    })
  end,
}
