local M = {}
local enable_this = false
local formatonsave = false

if enable_this then
  M.ensure_installed = {
    "efm",
    -- "lua_ls",
    "stylua",
    -- "jsonls",
    -- "omnisharp",
    -- "mypy",
    -- "ruff",
    -- "black",
    -- "debugpy",
    -- "pyright",
    "black",
    "flake8",
    "isort",
    "prettier",
    "eslint",
  }
end

local config = function()
	local opts = {
		init_options = {
			documentFormatting = true,
			documentRangeFormatting = true,
			hover = true,
			documentSymbol = true,
			codeAction = true,
			completion = true,
		},
		filetypes = {},
		settings = { rootMarkers = { ".git/" }, languages = {} },
	}

	-- lua
	local luacheck = require("efmls-configs.linters.luacheck")
	local stylua = require("efmls-configs.formatters.stylua")
	opts = vim.tbl_deep_extend("force", opts, {
		filetypes = { "lua" },
		settings = {
			languages = {
				lua = {
					stylua, --[[ luacheck ]]
				},
				--
			},
		},
	})

	-- python
	local black = require("efmls-configs.formatters.black")
	local flake8 = require("efmls-configs.linters.flake8")
	opts = vim.tbl_deep_extend("force", opts, {
		filetypes = { "python" },
		settings = {
			languages = {
				python = { black, flake8 },
				--
			},
		},
	})

	-- javascript, typescript, html, css
	local prettier = require("efmls-configs.formatters.prettier")
	local eslint = require("efmls-configs.linters.eslint")
	opts = vim.tbl_deep_extend("force", opts, {
		filetypes = { "typescript", "typescriptreact", "typescript.tsx" },
		settings = {
			languages = {
				["javascript"] = { prettier, eslint },
				["typescript"] = { prettier, eslint },
				["typescriptreact"] = { prettier, eslint },
				["typescript.tsx"] = { prettier, eslint },
				["html"] = { prettier, eslint },
				["css"] = { prettier, eslint },
				--
			},
		},
	})

	-- automactic install efm via mason
	require("mason").setup()
	require("mason-lspconfig").setup({
		ensure_installed = { "efm" },
		automatic_installed = true,
	})

	-- setup efm
	require("lspconfig").efm.setup(vim.tbl_extend("force", opts, {
		-- Pass your custom lsp config below like on_attach and capabilities
		--
		on_attach = require("core.keymaps").lsp_set_keymaps,
		-- capabilities = capabilities,
	}))

	-- format on Save
	if formatonsave then
		local lsp_fmt_group = vim.api.nvim_create_augroup("LspFormattingGroup", {})
		vim.api.nvim_create_autocmd("BufWritePost", {
			group = lsp_fmt_group,
			callback = function(ev)
				local efm = vim.lsp.get_active_clients({
					name = "efm",
					bufnr = ev.buf,
				})
				print(ev.buf)
				if vim.tbl_isempty(efm) then
					return
				end
				print("efm do format")
				vim.lsp.buf.format({ name = "efm" })
			end,
		})
	end
	-- key efm formatting
	vim.keymap.set("n", "<leader>eff", function()
		vim.lsp.buf.format({ name = "efm" })
	end)
end

M = vim.tbl_deep_extend("force", M, {
	"mattn/efm-langserver",
	event = "VeryLazy",
	dependencies = { { "creativenull/efmls-configs-nvim" } },
	enabled = enable_this,
	config = config,
})

return M
