local M = {}

M.treesitter = {
  ensure_installed = {
    "bash", "vim",
    "yaml",
    "markdown",
    "markdown_inline"
  }
}

M.mason = {
  ensure_installed = {}
}

M.null_ls = {
  sources = {}
}

M.dap = {
}
return M
