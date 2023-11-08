return {
  "nvim-treesitter/nvim-treesitter-refactor",
  config = function ()
---@diagnostic disable-next-line: missing-fields
    require("nvim-treesitter.configs").setup({
      refactor = {
        -- Highlight definitions
        -- Highlights definition and usages of the current symbol under the cursor
        highlight_definitions = {
          enable = true,
          -- Set to false if you have an `updatetime` of ~100.
          -- clear_on_cursor_move = true,
        },
        --
        -- Highlight current scope
        -- Highlights the block from the current scope where the cursor is.
        -- highlight_current_scope = {
        --   enable = true
        -- },
        --
        -- Smart rename
        -- Assign keymaps to false to disable them, e.g. `smart_rename = false`.
        -- smart_rename = {
        --   enable = true,
        --   keymaps = {
        --     smart_rename = "grr",
        --   },
        -- },
        --
        -- Navigation
        -- Provides "go to definition" for the symbol under the cursor
        navigation = {
          enable = true,
          -- Assign keymaps to false to disable them, e.g. `goto_definition = false`.
          keymaps = {
            goto_definition = "gnd",
            list_definitions = "gnD",
            list_definitions_toc = "gO",
            goto_next_usage = "<a-*>",
            goto_previous_usage = "<a-#>",
          },
        },
      },
    })
  end
}
