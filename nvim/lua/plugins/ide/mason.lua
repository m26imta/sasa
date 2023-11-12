local langs = require("plugins.ide.langs")
local config = function()
  require("mason").setup({
    ui = {
      -- border = "rounded",
      icons = {
        package_installed = "✓",
        package_pending = "➜",
        package_uninstalled = "✗",
      }
    }
  })
  require("mason-lspconfig").setup({})
  require("mason-tool-installer").setup({
		ensure_installed = langs.mason_ensure_installed,
		auto_update = false, -- Default: false
		run_on_start = false, -- Default: true
		start_delay = 3000, -- 3 second delay
		debounce_hours = 5, -- at least 5 hours between attempts to install/update
  })
	require("mason-tool-installer").check_install(true)
end

return {
  { "williamboman/mason.nvim",
    -- event = "VeryLazy",
    config = config,
  },
  { "williamboman/mason-lspconfig.nvim" },
  { "WhoIsSethDaniel/mason-tool-installer.nvim" },
}
