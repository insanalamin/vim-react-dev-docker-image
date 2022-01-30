if isModuleAvailable('FTerm') then
  require 'FTerm'.setup({
    cmd = '/usr/bin/zsh',
    dimensions  = {
      height = 0.8,
      width = 0.8,
      x = 0.5,
      y = 0.5
    },
    border = 'single' -- or 'double'
  })
end
