local M = {}
local enabled_langs  = {
  "common",
  "lua",
  "python",
}

-- topology
M = {
  enabled_langs  = enabled_langs,
  treesitter = {
    ensure_installed = {},
  },
  mason = {
    ensure_installed = {},
  },
  null_ls = {
    sources = {
      formatting = {},
      diagnostics = {},
    },
  },
  lspconfig = {
    -- { <function 1>, <function 2>, ..., <function n> }
    -- [1](): will return opts need for lspconfig setup the lsp server
    -- [2]() => 
      -- {
      --   lsp_name = "pyright",
      --   on_attach = ... ,
      --   capabilities = ... ,
      --   settings = { ... },
      -- }
  }
}

for _,v in ipairs(M.enabled_langs) do
  local lang = require("plugins.ide.langs." .. v)
  if lang.null_ls and lang.null_ls.sources  then
    if lang.null_ls.sources.formatting then
      for _, vv in pairs(lang.null_ls.sources.formatting) do
        table.insert(M.null_ls.sources.formatting, vv)
      end
    end
    if lang.null_ls.sources.diagnostics then
      for _, vv in pairs(lang.null_ls.sources.diagnostics) do
        table.insert(M.null_ls.sources.diagnostics, vv)
      end
    end
  end
  if lang.treesitter and lang.treesitter.ensure_installed then
    for _, vv in pairs(lang.treesitter.ensure_installed) do
      table.insert(M.treesitter.ensure_installed, vv)
    end
  end
  if lang.mason and lang.mason.ensure_installed then
    for _, vv in pairs(lang.mason.ensure_installed) do
      table.insert(M.mason.ensure_installed, vv)
    end
  end
  if lang.get_lspconfig then
    table.insert(M.lspconfig, lang.get_lspconfig)
  end
end

local get_mason_ensure_installed = function()
  return M.mason.ensure_installed
end

local get_treesitter_ensure_installed = function()
  return M.treesitter.ensure_installed
end

local get_null_ls_enabled_sources = function()
  local null_ls = require("null-ls")
  local null_ls_enabled_sources = {}
  for _, v in ipairs(M.null_ls.sources.formatting) do
    table.insert(null_ls_enabled_sources, null_ls.builtins.formatting[v])
  end
  for _, v in ipairs(M.null_ls.sources.diagnostics) do
    table.insert(null_ls_enabled_sources, null_ls.builtins.diagnostics[v])
  end
  return null_ls_enabled_sources
end

M.mason_ensure_installed = get_mason_ensure_installed()
M.treesitter_ensure_installed = get_treesitter_ensure_installed()
M.get_null_ls_enabled_sources = get_null_ls_enabled_sources

M.default_lsp_on_attach = function(...)
  require("core.keymaps").lsp_set_keymaps(...)
end

M.get_default_lsp_capabilities = function()
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.completion.completionItem.snippetSupport = true
  local ok, cmp = pcall(require, "cmp_nvim_lsp")
  if ok and cmp then
    capabilities = cmp.default_capabilities(capabilities)
  else
    print("fail to load plugins \"cmp_nvim_lsp\". This plugin need for lsp auto completion.")
  end
  return capabilities
end

M.get_enabled_lang_packages = function()
  local enabled_lang_packages = {}
  for _,v in pairs(M.enabled_langs) do
    local lang = require("plugins.ide.langs." .. v)
    enabled_lang_packages = vim.tbl_deep_extend("force", enabled_lang_packages, { [v] = lang})
  end
  return enabled_lang_packages
end

return M
