vim.cmd("source " .. vim.fn.stdpath("config") .. "/lua/core/.vimrc")
require("core.options")
require("core.keymaps")
