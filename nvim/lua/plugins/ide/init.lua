require("plugins.ide.tmp")
return {
  require("plugins.ide.treesitter"),
  require("plugins.ide.mason"),
  require("plugins.ide.cmp"),
  require("plugins.ide.lspconfig"),
  -- require("plugins.ide.codeium"),
  -- require("plugins.ide.codeium-nvim"),
  require("plugins.ide.null_ls"),
  require("plugins.ide.dap"),
  require("plugins.ide.navic"),
  require("plugins.ide.illuminate"),
  require("plugins.ide.indent-blankline"),
  require("plugins.ide.code-runner"),
  require("plugins.ide.colorizer"),
  require("plugins.ide.git"),
  require("plugins.ide.ipynb_molten"),
  require("plugins.ide.ipynb_notebooknavigator"),
}
