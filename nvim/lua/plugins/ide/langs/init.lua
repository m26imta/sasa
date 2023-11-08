local M = {}
M.enabled_langs = { "common", "lua", "python", }

local get_mason_ensure_installed = function()
  local ensure_installed = {}
  for _,v in ipairs(M.enabled_langs) do
    local lang = require("plugins.ide.langs." .. v)
    ensure_installed = vim.tbl_deep_extend("force", ensure_installed, lang.mason.ensure_installed)
    ensure_installed = vim.tbl_deep_extend("force", ensure_installed, lang.null_ls.ensure_installed)
  end
  return ensure_installed
end

local get_treesitter_ensure_installed = function()
  local ensure_installed = {}
  for _,v in ipairs(M.enabled_langs) do
    local lang = require("plugins.ide.langs." .. v)
    ensure_installed = vim.tbl_deep_extend("force", ensure_installed, lang.treesitter.ensure_installed)
  end
  return ensure_installed
end

M.get_enabled_lang_packages = function()
  local enabled_lang_packages = {}
  for _,v in pairs(M.enabled_langs) do
    local lang = require("plugins.ide.langs." .. v)
    enabled_lang_packages = vim.tbl_deep_extend("force", enabled_lang_packages, { v = lang})
  end
  return enabled_lang_packages
end

M.get_null_ls_enabled_sources = function()
  local sources = {
    formatting = {},
    diagnostics = {},
  }
  for _,v in ipairs(M.enabled_langs) do
    local lang = require("plugins.ide.langs." .. v)
    for _, vv in pairs(lang.null_ls.sources.formatting or {}) do
      table.insert(sources.formatting, vv)
    end
    for _, vv in pairs(lang.null_ls.sources.diagnostics or {}) do
      table.insert(sources.diagnostics, vv)
    end
  end
  return sources
end

M.mason_ensure_installed = get_mason_ensure_installed()
M.treesitter_ensure_installed = get_treesitter_ensure_installed()
M.get_enabled_langs = function()
  return M.enabled
end

return M
