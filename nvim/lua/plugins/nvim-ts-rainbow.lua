if isModuleAvailable('nvim-treesitter') then
  require'nvim-treesitter.configs'.setup {
    rainbow = {
      enable = true
    }
  }
end
