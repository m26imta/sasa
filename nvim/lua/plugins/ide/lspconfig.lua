local M = {}

local lsp_config = function()
  require("neodev").setup({
    library = {
      types = true,
      plugins = {
        "nvim-dap-ui",
      },
    },
  })
  require("neoconf").setup({})
  local lspconfig = require("lspconfig")
  local lang_api = require("plugins.ide.langs")
  local lsps = lang_api.lspconfig
  for _, lsp in ipairs(lsps) do
    local opts = lsp()
    local lsp_name = opts.lsp_name
    lspconfig[lsp_name].setup(opts)
  end
end

M = {
  { "neovim/nvim-lspconfig",
    branch = "master",
    event = { "BufReadPost", "BufNewFile", "BufEnter" },
    config = lsp_config,
    dependencies = {
      { "folke/neodev.nvim" },
      { "folke/neoconf.nvim" },
      { "williamboman/mason.nvim" },
      { "williamboman/mason-lspconfig.nvim" },
    },
  },
  { "j-hui/fidget.nvim", tag = "legacy",
    event = "LspAttach", opts = {}
  },
}

return M
