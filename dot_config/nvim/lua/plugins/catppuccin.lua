return {
  'catppuccin/nvim',
  name = 'catppuccin',
  opts = {
    flavour = 'macchiato', -- latte, frappe, macchiato, mocha
    transparent_background = true,
    float = { transparent = true, rounded = true },
    term_colors = false,
    auto_integrations = true,
    custom_highlights = function(colors)
      return {
        DiffDelete = { bg = 'none', fg = colors.overlay0 },
      }
    end,
  },
}
