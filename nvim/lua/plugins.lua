vim.cmd 'autocmd BufWritePost plugins.lua PlugUpdate' -- Auto compile when there are changes in plugins.lua

local Plug = require 'plugins.vimplug'

Plug.begin('~/.config/nvim/plugged')
  local lua_path = function(name)
    return string.format("require'plugins.%s'", name)
  end

  -- LSP
  Plug 'neovim/nvim-lspconfig' -- Quickstart configurations for the Nvim LSP client
  Plug 'onsails/lspkind-nvim' -- vscode-like pictograms for neovim lsp completion items
  Plug('weilbith/nvim-code-action-menu', { -- Pop-up menu for code actions to show meta-information and diff preview
    cmd = 'CodeActionMenu'
  })

  -- Autocomplete
  Plug 'hrsh7th/nvim-cmp'
  Plug 'hrsh7th/cmp-nvim-lsp'
  Plug 'hrsh7th/cmp-buffer'
  Plug 'hrsh7th/cmp-vsnip'
  Plug 'hrsh7th/vim-vsnip'
  Plug 'hrsh7th/cmp-path'
  Plug 'hrsh7th/cmp-calc'
  Plug 'hrsh7th/cmp-cmdline'
  -- Plug 'ray-x/cmp-treesitter'
  -- Plug 'lukas-reineke/cmp-rg'
  -- Plug 'quangnguyen30192/cmp-nvim-tags'
  -- Plug 'rafamadriz/friendly-snippets'
  -- Plug 'windwp/nvim-autopairs', config = lua_path"nvim-autopairs"
  -- Plug 'AndrewRadev/tagalong.vim'
  -- Plug 'andymass/vim-matchup'

  -- Explorer
  Plug('kyazdani42/nvim-tree.lua', {config = function() require 'plugins.nvimtree' end})

  -- Icons
  Plug 'kyazdani42/nvim-web-devicons'
  Plug 'ryanoasis/vim-devicons'
Plug.ends()

if isModuleAvailable('lspkind') then
  require('lspkind').init()
end
