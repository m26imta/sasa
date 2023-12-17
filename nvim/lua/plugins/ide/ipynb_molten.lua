return {
  {
    "benlubas/molten-nvim",
    version = "^1.0.0", -- use version <2.0.0 to avoid breaking changes
    -- dependencies = { "3rd/image.nvim" },
    build = ":UpdateRemotePlugins",
    init = function()
      -- these are examples, not defaults. Please see the readme
      -- vim.g.molten_image_provider = "image.nvim"
      vim.g.molten_image_provider = "none"
      vim.g.molten_output_win_max_height = 20
      vim.g.python3_host_prog = 'python3'

      vim.cmd([[
      :autocmd Filetype python :MoltenInit python3
      ]])

      vim.keymap.set("n", "<leader>mip", ":MoltenInit python3<cr>", { desc = "MoltenInit python3" } )
      vim.keymap.set("n", "<leader>mr", ":MoltenEvaluateLine<cr>")
      vim.keymap.set("v", "<leader>mr", ":lua vim.fn.MoltenEvaluateRange('python3', vim.fn.getpos(\"'<\")[2], vim.fn.getpos(\"'>\")[2])<cr>gv", { desc = "Molten run block of code" })
      vim.keymap.set("v", "<leader>mvr", ":<C-u>MoltenEvaluateVisual<CR>gv", { desc = "execute visual selection", silent = true })
    end,
  },
}
