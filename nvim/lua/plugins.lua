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
  Plug('p00f/nvim-ts-rainbow', {
    config = function() require "plugins.nvim-ts-rainbow" end
  })
  Plug('lukas-reineke/indent-blankline.nvim', {
    config = function() require "plugins.indent-blankline" end
  })
  Plug 'JoosepAlviste/nvim-ts-context-commentstring'
  Plug 'romgrk/nvim-treesitter-context'
  Plug('SmiteshP/nvim-gps', {
    config = function() require "plugins.nvim-gps" end
  })

  -- Explorer
  Plug('kyazdani42/nvim-tree.lua', {config = function() require "plugins.nvimtree" end})

  -- Icons
  Plug 'kyazdani42/nvim-web-devicons'
  Plug 'ryanoasis/vim-devicons'

  -- Status Line and Bufferline
  Plug('famiu/feline.nvim', {
    config = function() require "plugins.feline" end
  })
  Plug 'romgrk/barbar.nvim'

  -- Registers & clipboard
  Plug 'tversteeg/registers.nvim'
  Plug('AckslD/nvim-neoclip.lua', {config = function() require "plugins.nvim-neoclip" end})

  -- Colorscheme
  Plug('folke/tokyonight.nvim', {branch = 'main'})

  -- General Plugins
  -- use { 'rcarriga/nvim-notify', config = lua_path"nvim-notify" }
  -- use { 'airblade/vim-rooter', config = lua_path"vim-rooter" }
  -- use { 'mhinz/vim-startify' }
  -- use { 'goolord/alpha-nvim', config = lua_path"alpha-nvim" }
  -- use { 'jeffkreeftmeijer/vim-numbertoggle' }
  -- use { 'lambdalisue/suda.vim' }
  -- use { 'numtostr/FTerm.nvim', config = lua_path"fterm" }
  -- use { 'wfxr/minimap.vim', config = lua_path"minimap" }
  -- use { 'folke/todo-comments.nvim', config = lua_path"todo-comments" }
  -- use { 'luukvbaal/stabilize.nvim', config = lua_path"stabilize" }
  -- use { "beauwilliams/focus.nvim", config = lua_path"focus" }

Plug.ends()
