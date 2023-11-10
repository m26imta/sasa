local config = function()
  local opts = {
    size = 15,
    -- open_mapping = [[<C-\>]],
    open_mapping = [[<M-i>]],
    start_in_insert = true,
    direction = "horizontal",
  }
  vim.cmd([[
    autocmd TermEnter term://*toggleterm#*
          \ tnoremap <silent><C-t> <Cmd>exe v:count1 . "ToggleTerm"<CR>
    " Example: 2<C-t> will open terminal 2
    nnoremap <silent><C-t> <Cmd>exe v:count1 . "ToggleTerm"<CR>
    inoremap <silent><C-t> <Esc><Cmd>exe v:count1 . "ToggleTerm"<CR>
  ]])
  require("toggleterm").setup(opts)
end

return {
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    event = "VeryLazy",
    -- keys = {
    --   { "<M-i>", "<cmd>ToggleTerm<cr>", noremap = true, silent = true },
    -- },
    config = config,
  }
}

