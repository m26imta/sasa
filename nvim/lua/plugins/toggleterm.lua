local ipython1 = function ()
  -- Ipython support
  -- https://github.com/akinsho/toggleterm.nvim/issues/243#issuecomment-1163056922

  local toggleterm = require("toggleterm")

  vim.api.nvim_create_user_command("ToggleTermSendCurrentLineIPython",
    function(opts)
      toggleterm.send_lines_to_terminal("single_line", false, opts.args)
      toggleterm.exec(string.char(13))  -- send ENTER
    end,
    { nargs = "?", force = true }
  )
  vim.api.nvim_create_user_command("ToggleTermSendVisualSelectionIPython",
    function(opts)
      toggleterm.send_lines_to_terminal("visual_selection", false, opts.args)
      toggleterm.exec(string.char(13))  -- send ENTER
    end,
    { range = true, nargs = "?", force = true }
  )
  vim.api.nvim_create_user_command("ToggleTermSendVisualLinesIPython",
    function(opts)
      toggleterm.send_lines_to_terminal("visual_lines", false, opts.args)
      toggleterm.exec(string.char(13))  -- send ENTER
    end,
    { range = true, nargs = "?", force = true }
  )
  vim.api.nvim_create_user_command("ToggleTermSendCurrentLineNoTrimWsIPython",
    function(opts)
      toggleterm.send_lines_to_terminal("single_line", false, opts.args)
      toggleterm.exec(string.char(13))  -- send ENTER
    end,
    { nargs = "?", force = false }
  )
end

-- https://github.com/akinsho/toggleterm.nvim/issues/425#issuecomment-1854373704
local send_lines_to_repl = function()
  vim.cmd("ToggleTerm<cr>")

	-- visual markers only update after leaving visual mode
	local esc = vim.api.nvim_replace_termcodes("<esc>", true, false, true)
	vim.api.nvim_feedkeys(esc, "x", false)

	-- get selected text
	local start_line, start_col = unpack(vim.api.nvim_buf_get_mark(0, "<"))
	local end_line, end_col = unpack(vim.api.nvim_buf_get_mark(0, ">"))
	local lines = vim.fn.getline(start_line, end_line)

	-- send selection with trimmed indent
	local cmd = ""
	local indent = nil
	for _, line in ipairs(lines) do
		if indent == nil and line:find("[^%s]") ~= nil then
			indent = line:find("[^%s]")
		end
		-- (i)python interpreter evaluates sent code on empty lines -> remove
		if not line:match("^%s*$") then
			cmd = cmd .. line:sub(indent or 1) .. string.char(13) -- trim indent
      -- cmd = cmd .. line:sub(indent or 1)
		end
	end
  vim.cmd("ToggleTerm<cr>")
	require("toggleterm").exec(cmd, 1)
  require("toggleterm").exec("", 1)
end

local ipython2 = function ()
  vim.keymap.set('v', "<leader>trr", send_lines_to_repl)
  vim.keymap.set('n', "<leader>tth", "<cmd>ToggleTerm size=15 dir=~ direction=horizontal name=home<CR>")
  vim.keymap.set('n', "<leader>ttv", "<cmd>ToggleTerm size=55 dir=~ direction=vertical name=home<CR>")
end

local config = function()
  local toggleterm = require("toggleterm")
  local opts = {
    size = 15,
    -- open_mapping = [[<C-\>]],
    open_mapping = [[<M-i>]],
    start_in_insert = true,
    direction = "horizontal",
  }
  vim.cmd([[
    autocmd TermEnter term://*toggleterm#*
          \ tnoremap <silent><C-t> <Cmd>exe v:count1 . "ToggleTerm"<CR>
    " Example: 2<C-t> will open terminal 2
    nnoremap <silent><C-t> <Cmd>exe v:count1 . "ToggleTerm"<CR>
    inoremap <silent><C-t> <Esc><Cmd>exe v:count1 . "ToggleTerm"<CR>
  ]])

  ipython2()

  toggleterm.setup(opts)
end

return {
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    event = "VeryLazy",
    -- keys = {
    --   { "<M-i>", "<cmd>ToggleTerm<cr>", noremap = true, silent = true },
    -- },
    config = config,
  }
}

