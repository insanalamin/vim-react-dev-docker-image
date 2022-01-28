-- Packer
require('plugins')
-- Config
require('settings')
require('settings.color')
require('settings.font')
require('settings.completion')
require('settings.filetype')
-- LSP Config
require('lsp')
-- Keymap
require('settings.keymap')

local Plug = require 'plugins.vimplug'

Plug.begin('~/.config/nvim/plugged')
  -- LSP
  Plug 'neovim/nvim-lspconfig'
  Plug 'onsails/lspkind-nvim'
  Plug('weilbith/nvim-code-action-menu', {
    cmd = 'CodeActionMenu'
  })

  -- Icons
  Plug 'kyazdani42/nvim-web-devicons'
  Plug 'ryanoasis/vim-devicons'
Plug.ends()

require'nvim-tree'.setup {}
require'lspconfig'.tsserver.setup {}
require('lspkind').init()
