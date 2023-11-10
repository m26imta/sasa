local M = {}

M.opts = {}
M.config = function (opts)
  local _opts = opts or {}

  --## Two methods are available to jump to the next/previous todo comment.
  vim.keymap.set("n", "]t", function()
  require("todo-comments").jump_next()
  end, { desc = "Next todo comment" })

  vim.keymap.set("n", "[t", function()
    require("todo-comments").jump_prev()
  end, { desc = "Previous todo comment" })

  -- You can also specify a list of valid jump keywords

  vim.keymap.set("n", "]t", function()
    require("todo-comments").jump_next({keywords = { "ERROR", "WARNING" }})
  end, { desc = "Next error/warning todo comment" })

  require("todo-comments").setup(_opts)

end

M = {
  "plugins.extra.todo-comments",
  event = "VeryLazy",
  enabled = false,
  opts = M.opts,
}

return M
