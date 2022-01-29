vim.cmd 'autocmd BufWritePost plugins.lua PlugUpdate' -- Auto compile when there are changes in plugins.lua

local Plug = require 'plugins.vimplug'

Plug.begin('~/.config/nvim/plugged')

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
  Plug 'ray-x/cmp-treesitter'
  Plug 'lukas-reineke/cmp-rg'
  Plug 'quangnguyen30192/cmp-nvim-tags'
  Plug 'rafamadriz/friendly-snippets'
  Plug('windwp/nvim-autopairs', {config = function() require "plugins.nvim-autopairs" end})
  Plug 'AndrewRadev/tagalong.vim'
  Plug 'andymass/vim-matchup'

  -- Treesitter
  Plug('nvim-treesitter/nvim-treesitter', {
    config = function() require "plugins.treesitter" end
  })
  -- use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate', config = lua_path"treesitter" }
  -- use { 'p00f/nvim-ts-rainbow', config = lua_path"nvim-ts-rainbow" }
  -- use { 'lukas-reineke/indent-blankline.nvim', config = lua_path"indent-blankline" }
  -- use { 'JoosepAlviste/nvim-ts-context-commentstring' }
  -- use { 'romgrk/nvim-treesitter-context' }
  -- use { 'SmiteshP/nvim-gps', config = lua_path"nvim-gps" }

  -- Explorer
  Plug('kyazdani42/nvim-tree.lua', {config = function() require "plugins.nvimtree" end})

  -- Icons
  Plug 'kyazdani42/nvim-web-devicons'
  Plug 'ryanoasis/vim-devicons'

  -- Registers & clipboard
  Plug 'tversteeg/registers.nvim'
  Plug('AckslD/nvim-neoclip.lua', {config = function() require "plugins.nvim-neoclip" end})

  -- Colorscheme
  Plug('folke/tokyonight.nvim', {branch = 'main'})

Plug.ends()
