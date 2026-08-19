vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Netrw
vim.cmd "let g:netrw_list_hide = '.DS_STORE'"
vim.cmd 'let g:netrw_hide = 1'

ConfigSettings = {
  theme = os.getenv 'THEME' or 'token-temper',
}

require 'configs.options'
require 'configs.keymaps'
require 'configs.autocmds'
require 'configs.plugins'

require 'theme.theme'
