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
  Plug('windwp/nvim-ts-autotag') -- Auto add closing tag
  Plug('windwp/nvim-autopairs', {config = function() require "plugins.nvim-autopairs" end})
  Plug 'AndrewRadev/tagalong.vim' -- Closing tag follows opening tag
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

  -- Syntax
  Plug('leafgarland/typescript-vim')
  Plug('peitalin/vim-jsx-typescript', {config = function ()
      print('check typescript-vim and vim-jsx-typescript')
      vim.api.nvim_command('autocmd BufNewFile,BufRead *.tsx,*.jsx set filetype=typescriptreact')
  end})

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

  -- Telescope
  Plug 'nvim-lua/popup.nvim'
  Plug 'nvim-lua/plenary.nvim'
  Plug('nvim-telescope/telescope.nvim', {
    config = function() require "plugins.telescope" end
  })
  Plug 'nvim-telescope/telescope-fzy-native.nvim'
  Plug 'nvim-telescope/telescope-project.nvim'
  Plug('pwntester/octo.nvim', {
    config = function() require "plugins.octo" end
  })

  -- Color
  Plug 'lpinilla/vim-codepainter'
  Plug('crivotz/nvim-colorizer.lua', {config = function() require "plugins.colorizer" end})

  -- Git
  Plug('lewis6991/gitsigns.nvim', {config = function() require "plugins.gitsigns" end})
  Plug 'kdheepak/lazygit.nvim'
  Plug 'rhysd/committia.vim'

  -- Registers & clipboard
  Plug 'tversteeg/registers.nvim'
  Plug('AckslD/nvim-neoclip.lua', {config = function() require "plugins.nvim-neoclip" end})

  -- Move & Search & replace
  Plug('dyng/ctrlsf.vim', {config = function() require "plugins.ctrlsf" end})-- *****
  Plug('kevinhwang91/nvim-hlslens', {config = function() require "plugins.hlslens" end})
  Plug('ggandor/lightspeed.nvim', {config = function() require "plugins.lightspeed" end})
  Plug('ThePrimeagen/harpoon', {config = function() require "plugins.harpoon" end})
  Plug('karb94/neoscroll.nvim', {config = function() require "plugins.neoscroll" end})
  Plug 'dstein64/nvim-scrollview'
  -- use { 'nacro90/numb.nvim', config = lua_path"numb" }
  -- use { 'dyng/ctrlsf.vim', config = lua_path"ctrlsf" }
  -- use { 'kevinhwang91/nvim-hlslens', config = lua_path"hlslens" }
  -- use { 'ggandor/lightspeed.nvim', config = lua_path"lightspeed" }
  -- use { 'ThePrimeagen/harpoon', config = lua_path"harpoon" }
  -- use { 'karb94/neoscroll.nvim', config = lua_path"neoscroll" }
  -- use { 'dstein64/nvim-scrollview' }
  -- use { 'chaoren/vim-wordmotion' }
  -- use { 'fedepujol/move.nvim' }

   -- Tim Pope docet
  Plug 'tpope/vim-sensible'
  Plug 'tpope/vim-abolish'
  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-capslock'
  Plug 'tpope/vim-dadbod'
  Plug 'tpope/vim-jdaddy'
  Plug 'tpope/vim-fugitive'
  Plug 'tpope/vim-commentary'
  Plug 'tpope/vim-dispatch'

  -- Colorscheme
  Plug('folke/tokyonight.nvim', {branch = 'main'})

  -- General Plugins
  Plug('rcarriga/nvim-notify', {config = function() require "plugins.nvim-notify" end})
  Plug('airblade/vim-rooter', {config = function() require "plugins.vim-rooter" end})
  Plug 'mhinz/vim-startify'
  Plug('goolord/alpha-nvim', {config = function() require "plugins.alpha-nvim" end})
  Plug('numtostr/FTerm.nvim', {config = function() require "plugins.fterm" end})
  Plug('wfxr/minimap.vim', {config = function() require "plugins.minimap" end})
  Plug('folke/todo-comments.nvim', {config = function() require "plugins.todo-comments" end})
  Plug('simrat39/symbols-outline.nvim', {config = function() require "plugins.symbols-outline" end})
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
