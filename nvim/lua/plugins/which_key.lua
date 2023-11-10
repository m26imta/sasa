local config = function()
  local which_key = require("which-key")
  which_key.setup({
    plugins = {
      spelling = {
        enabled = true,
        suggestions = 20,
      },
    },
    icons = {
      breadcrumb = " ",
      separator = " ",
      group = " ",
    },
  })

  which_key.register({
  }, { prefix = "<leader>", mode = "n" })
end

return {
  "folke/which-key.nvim",
  event = { "VeryLazy" },
  config = config,
}

