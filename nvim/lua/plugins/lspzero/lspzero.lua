local config = function()
  require("neoconf").setup()
  require("neodev").setup()

  local lsp_zero = require('lsp-zero')
  lsp_zero.extend_lspconfig()

  lsp_zero.on_attach(function(client, bufnr)
    -- see :help lsp-zero-keybindings
    -- to learn the available actions
    lsp_zero.default_keymaps({buffer = bufnr})
  end)

  require('mason').setup({})
  require('mason-lspconfig').setup({
    handlers = {
      lsp_zero.default_setup,
    },
    ensure_installed = { "lua_ls" },
  })

  require('lspconfig').tsserver.setup({
    single_file_support = false,
    on_init = function(client)
      -- disable formatting capabilities
      client.server_capabilities.documentFormattingProvider = false
      client.server_capabilities.documentFormattingRangeProvider = false
    end,
  })
  local lua_opts = lsp_zero.nvim_lua_ls({
    single_file_support=false,
    on_attach = function(client, bufnr)
      print("lsp_zero -> lua_ls -> on_attach")
    end
  })
  require('lspconfig').lua_ls.setup(lua_opts)

  local cmp = require('cmp')
  local cmp_action = require('lsp-zero').cmp_action()
  cmp.setup({
    mapping = cmp.mapping.preset.insert({
      -- `Enter` key to confirm completion
      ['<CR>'] = cmp.mapping.confirm({select = false}),

      -- Ctrl+Space to trigger completion menu
      ['<C-Space>'] = cmp.mapping.complete(),

      -- Navigate between snippet placeholder
      ['<C-f>'] = cmp_action.luasnip_jump_forward(),
      ['<C-b>'] = cmp_action.luasnip_jump_backward(),

      -- Scroll up and down in the completion documentation
      ['<C-u>'] = cmp.mapping.scroll_docs(-4),
      ['<C-d>'] = cmp.mapping.scroll_docs(4),
    })
  })
end

return {
  {'folke/tokyonight.nvim'},
  {'williamboman/mason.nvim'},
  {'williamboman/mason-lspconfig.nvim'},
  -- LSP Support
  {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v3.x',
    lazy = false,
    config = config,
  },
  {
    'neovim/nvim-lspconfig',
    branch = "master",
    dependencies = {
      {'hrsh7th/cmp-nvim-lsp'},
      {'folke/neodev.nvim', opts={}},
      {'folke/neoconf.nvim', cmd='Neoconf'},
    }
  },
  -- Autocompletion
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      {'L3MON4D3/LuaSnip'}
    },
  },
}
