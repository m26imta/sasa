-- token link: https://codeium.com/account/login?redirect_uri=vim-show-auth-token&state=a&redirect_parameters_type=query
return {
  { "Exafunction/codeium.vim",
    event = "BufEnter",
    config = function ()
      -- disable default keybidings
      vim.g.codeim_disable_binding = 1
      -- Change '<C-g>' here to any keycode you like.
      -- vim.keymap.set('i', '<C-g>', function() return vim.fn['codeium#Accept']() end, { expr = true })
      vim.cmd([[imap <script><silent><nowait><expr> <C-g> codeium#Accept()]])
      vim.cmd([[imap <script><silent><nowait><expr> <M-e> codeium#Accept()]])
      vim.cmd([[imap <M-Bslash> <Cmd>call codeium#Complete()<CR>]])
      vim.keymap.set('i', '<M-]>', function() return vim.fn['codeium#CycleCompletions'](1) end, { expr = true })
      vim.keymap.set('i', '<M-[>', function() return vim.fn['codeium#CycleCompletions'](-1) end, { expr = true })
      vim.keymap.set('i', '<M-x>', function() return vim.fn['codeium#Clear']() end, { expr = true })
    end
  }
}
