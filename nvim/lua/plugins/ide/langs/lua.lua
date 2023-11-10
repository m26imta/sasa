local M = {}

M.path = vim.fn.stdpath("config") .. "/plugins/ide/langs/lua.lua"

M.treesitter = {
  ensure_installed = {
    "lua"
  }
}

M.mason = {
  ensure_installed = {
    "lua_ls",
    "stylua",
    -- "luaformatter"
  }
}

M.null_ls = {
  sources = {
    formatting = {
      -- "lua_format",  -- luaformatter: null_ls.builtins.formatting.lua_format
      "stylua",
    },
    diagnostics = {
    },
  }
}

M.dap = {}

-- ----------------
-- lspconfig
-- ----------------
local lspconfig_on_attach = function(...)
  require("plugins.ide.langs").default_lsp_on_attach(...)
  -- set some extra key binding
  -- set some autocmd
end

local get_lspconfig_capabilities = function()
  local capabilities = require("plugins.ide.langs").get_default_lsp_capabilities()
  return capabilities
end

local lspconfig_opts = {
  settings = {
    Lua = {
      -- make the language server recognize "vim" global
      diagnostics = { globals = { "vim" } },
      workspace = {
        -- make language server aware of runtime files
        library = {
          [vim.fn.expand("$VIMRUNTIME/lua")] = true,
          [vim.fn.stdpath("config") .. "/lua"] = true
        }
      }
    }
  }
}

M.get_lspconfig = function()
  return vim.tbl_extend(
    "force",
    {
      lsp_name = "lua_ls",
      on_attach = lspconfig_on_attach,
      capabilities = get_lspconfig_capabilities(),
    },
    lspconfig_opts)
end

return M
