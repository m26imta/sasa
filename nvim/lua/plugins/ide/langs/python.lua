local M = {}

M.treesitter = {
  ensure_installed = {
    "python"
  }
}

M.mason = {
  ensure_installed = {
    "pyright",
    "black", "isort",
    -- "flake8",
    "mypy", "ruff",
    "debugpy", -- DAP
  }
}

M.null_ls = {
  sources = {
    formatting = {
      "black", "isort",
    },
    diagnostics = {
      -- "flake8",
      "mypy", "ruff",
    },
  },
}

M.dap = {

}

M.lazy = {
  { "mfussenegger/nvim-dap-python",
    ft = "python",
    dependencies = {
      "mfussenegger/nvim-dap",
      "rcarriga/nvim-dap-ui",
    },
    config = function()
      local path = vim.fn.stdpath("data") .. "/mason/packages/debugpy/venv/bin/python"
      require("dap-python").setup(path)
      vim.keymap.set("n", "<leader>dbr", function() require("dap-python").test_method() end)
    end,
  },
}

-- ----------------
-- lspconfig
-- ----------------
local lspconfig_on_attach = function(client, bufnr)
  require("plugins.ide.langs").default_lsp_on_attach(client, bufnr)
  -- set some extra key binding
  -- set some autocmd
  -- vim.cmd([[autocmd BufWritePre <buffer> lua vim.lsp.buf.format({name="pyright"})]])
  -- vim.cmd([[autocmd BufWritePre <buffer> lua vim.lsp.buf.format({name="null-ls"})]])  -- auto format using null-ls / flake8
  vim.keymap.set("n", "<leader>fmm", ":lua vim.lsp.buf.format({name=\"null-ls\"})<CR>:echo \"Format buffer="..bufnr.." using null-ls\"<CR>", {desc ="Format using null-ls", noremap=true, silent=true, buffer=bufnr})
end

local get_lspconfig_capabilities = function()
  local capabilities = require("plugins.ide.langs").get_default_lsp_capabilities()
  return capabilities
end

local lspconfig_opts = {
  settings = {
    python = {
      analysis = {
        typeCheckingMode = "off",
      },
    },
  },
}

M.get_lspconfig = function()
  return {
    lsp_name = "pyright",
    on_attach = lspconfig_on_attach,
    capabilities = get_lspconfig_capabilities(),
    settings = lspconfig_opts.settings,
  }
end

return M
