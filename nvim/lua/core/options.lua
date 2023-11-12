vim.cmd("source " .. vim.fn.stdpath("config") .. "/lua/core/.vimrc")

-- Neovide
if vim.g.neovide then
  local cursor_vfx_mode = {"railgun", "torpedo", "pixiedust", "sonicboom", "ripple", "wireframe"}
  vim.g.neovide_cursor_vfx_mode = cursor_vfx_mode[6]
  vim.o.guifont = 'JetBrainsMono Nerd Font:h11'
  vim.g.neovide_transparency = 0.95
  -- vim.g.neovide_fullscreen = true  -- windowed fullscreen mode
  vim.cmd([[ nnoremap <C-A-m> :let g:neovide_fullscreen = !g:neovide_fullscreen<CR> ]])
  vim.g.neovide_cursor_animation_length = 0.08  -- 0.06
  vim.g.neovide_cursor_trail_size = 0.8  -- 0.7
  -- vim.g.neovide_cursor_antialiasing = false  -- Disabling may fix some cursor visual issues.
end
