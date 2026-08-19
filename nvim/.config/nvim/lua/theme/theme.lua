-- How to lazy load a theme

---@diagnostic disable-next-line: missing-fields
require('tokyonight').setup {}

---@type token.Config
local tokenConfig = {
  transparent = false,
  plugins = {
    gitsigns = true,
  },
}
require('token').setup(tokenConfig)

vim.cmd.colorscheme(ConfigSettings.theme)
