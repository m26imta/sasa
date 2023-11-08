local M = {}

M.treesitter = {
  ensure_installed = {
    "lua",
  }
}

M.mason = {
  ensure_installed = {
    "lua_ls",
  }
}

M.null_ls = {
  ensure_installed = {},
  sources = {},
}

M.dap = {

}

local on_attach = function(client, bufnr)
  -- print("ide_langs_lua on_attach: client =  " .. client.name)
  require("plugins.ide.lspconfig").lsp_set_keymaps(client, bufnr)
end

local get_capabilities = function()
  local capabilities = {}
  capabilities = vim.lsp.protocol.make_client_capabilities()
  --capabilities.textDocument.completion.completionItem.snippetSupport = true
  local ok, cmp = pcall(require, "cmp_nvim_lsp")
  if ok then
    capabilities = cmp.default_capabilities(capabilities)
  end
  return capabilities
end

local capabilities = get_capabilities()

local lspconfig_opts = {
  on_attach = on_attach,
  capabilities = capabilities,

  settings = {
    Lua = {
      -- make the language server recognize "vim" global
      diagnostics = {
        globals = { "vim" },
      },
      workspace = {
        -- make language server aware of runtime files
        library = {
          [vim.fn.expand("$VIMRUNTIME/lua")] = true,
          [vim.fn.stdpath("config") .. "/lua"] = true,
        },
      },
    },
  },
}

M.do_setup_lang = function()
  require("lspconfig").lua_ls.setup(lspconfig_opts)
end

return M
