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
  ensure_installed = {},
  sources = {}
}

M.dap = {

}

M.do_setup_lang = function()
end

return M
