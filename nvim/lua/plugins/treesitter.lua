if isModuleAvailable('nvim-treesitter') then
  print('nvim-treesitter start')

  require'nvim-treesitter.configs'.setup {
    -- ensure_installed = {"bash", "html", "javascript", "lua", "json", "latex", "make", "python", "php", "typescript", "yaml", "vim", "tsx", "typescript"},
    highlight = {
      enable = true,              -- false will disable the whole extension
    },
    context_commentstring = {
      enable = true
    }
  }
end
