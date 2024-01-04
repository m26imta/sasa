return {
  {
    "benlubas/molten-nvim",
    -- enabled = false,
    version = "^1.0.0", -- use version <2.0.0 to avoid breaking changes
    -- dependencies = { "3rd/image.nvim" },
    build = ":UpdateRemotePlugins",
    init = function()
      function MoltenInitPython()
        vim.cmd([[
        :MoltenInit python
        :MagmaEvaluateArgument a=5
        ]])
      end

      function MoltenInitCSharp()
        vim.cmd([[
        :MoltenInit .net-csharp
        :MagmaEvaluateArgument Microsoft.DotNet.Interactive.Formatting.Formatter.SetPreferredMimeTypesFor(typeof(System.Object),"text/plain");
        ]])
      end

      function MoltenInitFSharp()
        vim.cmd([[
        :MoltenInit .net-fsharp
        :MagmaEvaluateArgument Microsoft.DotNet.Interactive.Formatting.Formatter.SetPreferredMimeTypesFor(typeof<System.Object>,"text/plain")
        ]])
      end

      vim.g.magma_automatically_open_output = false
      -- vim.g.molten_image_provider = "image.nvim"
      vim.g.magma_image_provider = "none"
      vim.g.python3_host_prog = "python"

      vim.cmd([[
        nnoremap <silent><expr> <LocalLeader>r  :MoltenEvaluateOperator<CR>
        nnoremap <silent>       <LocalLeader>rr :MoltenEvaluateLine<CR>
        xnoremap <silent>       <LocalLeader>r  :<C-u>MoltenEvaluateVisual<CR>
        nnoremap <silent>       <LocalLeader>rc :MoltenReevaluateCell<CR>
        nnoremap <silent>       <LocalLeader>rd :MoltenDelete<CR>
        nnoremap <silent>       <LocalLeader>ro :MoltenShowOutput<CR>

        :command MoltenInitPython lua MoltenInitPython()
        :command MoltenInitCSharp lua MoltenInitCSharp()
        :command MoltenInitFSharp lua MoltenInitFSharp()
      ]])

      vim.cmd([[
      :autocmd Filetype python :MoltenInit python
      ]])

      vim.keymap.set(
        "v",
        "<LocalLeader>mr",
        ":lua vim.fn.MoltenEvaluateRange('python', vim.fn.getpos(\"'<\")[2], vim.fn.getpos(\"'>\")[2])<cr>gv",
        { desc = "Molten run block of code" }
      )
      vim.keymap.set(
        "v",
        "<LocalLeader>mvr",
        ":<C-u>MoltenEvaluateVisual<CR>gv",
        { desc = "execute visual selection", silent = true }
      )
    end,
  },
}
