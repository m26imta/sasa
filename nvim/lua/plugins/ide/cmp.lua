local cmp_config = function()

  local cmp = require("cmp")
  local luasnip = require("luasnip")
  local lspkind = require("lspkind")

  -- --- friendly-snippets
  -- https://github.com/rafamadriz/friendly-snippets#with-lazynvim
  require("luasnip.loaders.from_vscode").lazy_load()

  local kindicon = {
    lspkind_default = lspkind.presets.default,
    lspkind_codicons = lspkind.presets.codicons,
    kind_custom = {
      Text = "",
      Method = "",
      Function = "",
      Constructor = "",
      Field = "ﰠ",
      Variable = "",
      Class = "ﴯ",
      Interface = "",
      Module = "",
      Property = "ﰠ",
      Unit = "",
      Value = "",
      Enum = "",
      Keyword = "",
      Snippet = "",
      Color = "",
      File = "",
      Reference = "",
      Folder = "",
      EnumMember = "",
      Constant = "",
      Struct = "פּ",
      Event = "",
      Operator = "",
      TypeParameter = "",
    },
  }
  -- set icon for cmp kind
  local icon = kindicon.lspkind_default

  -- formatting
  local formatting = {
    fields = { 'abbr', 'kind', 'menu', },
    format = lspkind.cmp_format({
      mode = "text_symbol", -- show only symbol annotations
      maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
      ellipsis_char = '...', -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
      -- The function below will be called before any actual modifications from lspkind
      -- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
      before = function(entry, vim_item)
        local shorten_abbr = string.sub(vim_item.abbr, 1, 30)
        if shorten_abbr ~= vim_item.abbr then vim_item.abbr = shorten_abbr .. "..." end
        -- Kind icons  |  Text -->  Text
        vim_item.kind = string.format("%s %s", icon[vim_item.kind], vim_item.kind)
        -- Source
        vim_item.menu = ({
          nvim_lsp = "     LSP",
          nvim_lua = "     API",
          luasnip  = " LuaSnip",
          buffer   = "  Buffer",
          path     = "    Path",
          nvim_lsp_signature_help = "   _help",
          -- cmdline = "[cmdline]",
          -- calc = "[calc]",
          -- latex_symbols = "[LaTeX]",
          -- cmp_tabnine = "[Tabnine]",
          -- emoji = "[Emoji]",
        })[entry.source.name]
        return vim_item
      end
    })
  }

  -- mapping
  local mapping = cmp.mapping.preset.insert({
    ['<C-u>'] = cmp.mapping.scroll_docs(-4), -- Up
    ['<C-d>'] = cmp.mapping.scroll_docs(4), -- Down
    -- C-b (back) C-f (forward) for snippet placeholder navigation.
    ['<C-Space>'] = cmp.mapping.complete(),
    -- Accept currently selected item. If none selected, `select` first item.
    -- Set `select` to `false` to only confirm explicitly selected items.
    ['<CR>'] = cmp.mapping.confirm { behavior = cmp.ConfirmBehavior.Replace, select = false, },
    -- ['.'] = cmp.mapping.confirm { behavior = cmp.ConfirmBehavior.Replace, select = true, },
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  })

  -- cmp setup
  cmp.setup {
    completion = {
      completeopt = "menu,menuone,noselect",
    },
    snippet = {
      expand = function(args)
        luasnip.lsp_expand(args.body)
      end,
    },
    window = {
      completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered(),
    },
    sources = {
      { name = "nvim_lsp" },
      { name = "nvim_lua" },
      { name = "path" },
      { name = "buffer" },
      -- { name = "cmdline" },
      { name = "nvim_lsp_signature_help" },
      -- { name = "calc" },
      -- { name = "rg" },
      -- {}
      {
        name = "luasnip",
        option = {} or {
          -- https://github.com/saadparwaiz1/cmp_luasnip#cmp_luasnip
          { use_show_condition = false }, -- to disable filtering completion candidates by snippet's show_condition
          { show_autosnippets = true },
        },
      },
    },
    mapping = mapping,
    formatting = formatting,
  }

  -- Set configuration for specific filetype.
  cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
      { name = 'git' }, -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
    }, {
        { name = 'buffer' },
      })
  })

  -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'buffer' }
    }
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
        { name = 'cmdline' }
      })
  })

end


return {
  --
  -- Autocompletion
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      -- cmp sources
      {'hrsh7th/cmp-nvim-lsp' },                    -- Required - nvim-cmp source for neovim's built-in language server client. 
      {'hrsh7th/cmp-nvim-lua'},                     -- nvim-cmp source for neovim Lua API. 
      {'hrsh7th/cmp-path' },                        -- nvim-cmp source for filesystem paths. 
      {'hrsh7th/cmp-buffer' },                      -- nvim-cmp source for buffer words. 
      {'hrsh7th/cmp-cmdline' },                     -- nvim-cmp source for vim's cmdline.
      {'hrsh7th/cmp-nvim-lsp-signature-help' },     -- nvim-cmp source for displaying function signatures with the current parameter emphasized
      {'hrsh7th/cmp-calc' },                        -- nvim-cmp source for math calculation.
      {'lukas-reineke/cmp-rg'},                     -- ripgrep source for nvim-cmp

      -- Snippet
      {'L3MON4D3/LuaSnip',                          -- Required - snippet engine
        dependencies = { 'rafamadriz/friendly-snippets' },
      },
      {'saadparwaiz1/cmp_luasnip' },                -- luasnip completion source for nvim-cmp

      -- lsp_kind
      {'onsails/lspkind.nvim'},
    },
    event = { "InsertEnter", "CmdlineEnter" },
    config = cmp_config,
  },
}


