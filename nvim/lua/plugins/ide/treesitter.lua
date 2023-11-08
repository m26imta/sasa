local langs = require("plugins.ide.langs")
local config = function()
---@diagnostic disable-next-line: missing-fields
  require("nvim-treesitter.configs").setup({
    ensure_installed = langs.treesitter_ensure_installed,
    highlight = {
      enable = true, -- false will disable the whole extension
      disable = { "" }, -- list of language that will be disabled
    },
    autopairs = { enable = true }, -- enable plugin nvim-autopairs
    autotag = { enable = true },  -- enable plugin nvim-ts-autotag
    indent = {
      enable = true,
      disable = {
        "python",  -- fix: not indent in funtion()
        "css",
      }
    }
  })
end

return {
  { "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufEnter", "BufReadPost", "BufNewFile" },
    config = config,
    dependencies = {
      require("plugins.ide.treesitter-context"),
      require("plugins.ide.treesitter-refactor"),
      require("plugins.ide.treesitter-textobject"),
      {"windwp/nvim-ts-autotag" },
      {"windwp/nvim-autopairs", opts = {} },
      -- {"JoosepAlviste/nvim-ts-context-commentstring" },
      { "numToStr/Comment.nvim",
        event = "VeryLazy",
        opts = {
          padding = true,     -- Add a space b/w comment and the line
          sticky = true,      -- Whether the cursor should stay at its position
          mappings = {
            basic = true,     -- Includes `gcc`, `gbc`, `gc[count]{motion}` and `gb[count]{motion}`
            extra = true,     -- Includes `gco`, `gcO`, `gcA`
            extended = false, -- Includes `g>`, `g<`, `g>[count]{motion}` and `g<[count]{motion}`
          }
        }
      }
    }
  }
}

