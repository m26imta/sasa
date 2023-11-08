local config = function()
  local null_ls = require("null-ls")
  local formatting = null_ls.builtins.formatting
  local diagnostics = null_ls.builtins.diagnostics
  --
  local on_attach = function(client, bufnr)
    print("null_ls on_attach bufnr: " .. bufnr .. " client: " .. client.name)
    if client.supports_method("textDocument/formatting") then
      -- vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting()")
      vim.cmd("autocmd BufWritePre bufnr lua vim.lsp.buf.formatting()")
    end
    if client.supports_method("textDocument/documentHighlight") then
      vim.cmd [[
      augroup document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
      ]]
    end
  end

  local langs = require("plugins.ide.langs")
  local sources = {}
  local _sources = langs.get_null_ls_enabled_sources()
  for _, v in pairs(_sources.formatting) do
    table.insert(sources, formatting[v])
  end
  for _, v in pairs(_sources.diagnostics) do
    table.insert(sources, diagnostics[v])
  end

  null_ls.setup({
    debug = false,
    sources = sources,
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

