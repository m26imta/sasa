local config = function()
  -- Attach to certain Filetypes, add special configuration for `html`
  -- Use `background` for everything else.
  require 'colorizer'.setup {
    'css';
    'javascript';
    html = {
      mode = 'foreground';
    }
  }
end

return {
  "norcalli/nvim-colorizer.lua",
  cmd = {
    "ColorizerAttachToBuffer", "ColorizerDetachFromBuffer",
    "ColorizerReloadAllBuffers", "ColorizerToggle",
  },
  config = config,
}
