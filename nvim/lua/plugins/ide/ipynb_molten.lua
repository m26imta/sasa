return {
  {
    "benlubas/molten-nvim",
    version = "^1.0.0", -- use version <2.0.0 to avoid breaking changes
    dependencies = { "3rd/image.nvim" },
    build = ":UpdateRemotePlugins",
    init = function()
      -- these are examples, not defaults. Please see the readme
      vim.g.molten_image_provider = "image.nvim"
      vim.g.molten_output_win_max_height = 20
      vim.g.python3_host_prog = 'python3'
      vim.keymap.set("n", "<leader>mip", ":MoltenInit python3<cr>", { desc = "MoltenInit python3" } )
      vim.keymap.set("v", "<leader>mr", ":lua vim.fn.MoltenEvaluateRange(vim.fn.getpos(\"'<\")[2], vim.fn.getpos(\"'>\")[2])<cr>", { desc = "Molten run block of code" })
      vim.keymap.set("n", "<leader>mr", ":MoltenEvaluateLine<cr>")
    end,
  },
  {
    -- see the image.nvim readme for more information about configuring this plugin
    "3rd/image.nvim",
    opts = {
      backend = "kitty", -- whatever backend you would like to use
      max_width = 100,
      max_height = 12,
      max_height_window_percentage = math.huge,
      max_width_window_percentage = math.huge,
      window_overlap_clear_enabled = true, -- toggles images when windows are overlapped
      window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },
    },
  }
}
