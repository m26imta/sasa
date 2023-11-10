local config = function()
  local lang_api = require("plugins.ide.langs")
  local null_ls = require("null-ls")
  local formatting = null_ls.builtins.formatting
  local diagnostics = null_ls.builtins.diagnostics
  --
  local on_attach = function(client, bufnr)
    -- formatting
    if client.supports_method("textDocument/formatting") then
      -- vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.format({name = \"" .. client.name .. "\"})")
    --   vim.cmd([[autocmd BufWritePre <buffer> lua vim.lsp.buf.format({name="null-ls"})]])
      vim.keymap.set("n", "<leader>fm2", ":lua vim.lsp.buf.format({name=\"null-ls\"})<CR>:echo \"Format buffer="..bufnr.." using null-ls\"<CR>", {desc="Format using null-ls", noremap=true, silent=true, buffer=bufnr})
    end

    -- documentHighlight if supported
    -- if client.supports_method("textDocument/documentHighlight") then
    --   vim.cmd [[
    --   augroup document_highlight
    --     autocmd! * <buffer>
    --     autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
    --     autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
    --   augroup END
    --   ]]
    -- end
  end

  local enabled_sources = lang_api.get_null_ls_enabled_sources()

  null_ls.setup({
    debug = false,
    sources = enabled_sources,
    on_attach = on_attach,
  })

end

return {
  "jose-elias-alvarez/null-ls.nvim",
  dependencies = {
    { "neovim/nvim-lspconfig" },
    { "nvim-lua/plenary.nvim" },
  },
  config = config,
  event = { "BufReadPost", "BufNewFile", "BufEnter" },
}
