if vim.fn.has("termguicolors") == 1 then
  vim.go.t_8f = "[[38;2;%lu;%lu;%lum"
  vim.go.t_8b = "[[48;2;%lu;%lu;%lum"
  vim.opt.termguicolors = true
end

if isModuleAvailable('tokyonight') then
  -- Example config in Lua
  vim.g.tokyonight_style = "night"
  vim.g.tokyonight_italic_functions = true
  vim.g.tokyonight_sidebars = { "qf", "vista_kind", "terminal", "packer" }

  -- Change the "hint" color to the "orange" color, and make the "error" color bright red
  vim.g.tokyonight_colors = { hint = "orange", error = "#ff0000" }

  -- Load the colorscheme
  vim.cmd[[colorscheme tokyonight]]
end
