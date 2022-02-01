if isModuleAvailable('lspconfig') then
  print('lspconfig active')
  require'lspconfig'.tsserver.setup{}
  require'lspconfig'.pylsp.setup{}
  require'lspconfig'.pyright.setup{}
end
