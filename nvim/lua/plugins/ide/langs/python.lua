local M = {}

M.treesitter = {
  ensure_installed = {
    "python"
  }
}

M.mason = {
  ensure_installed = {}
}

M.null_ls = {
  ensure_installed = {
    "black", "isort", "flake8"
  },
  sources = {
    formatting = { "black", "isort" },
    diagnostics = { "flake8" },
  },
}

M.dap = {

}

return M
