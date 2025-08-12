return {
  'catppuccin/nvim',
  name = 'catppuccin',
  opts = {
    flavour = 'macchiato', -- latte, frappe, macchiato, mocha
    transparent_background = true,
    float = { transparent = true },
    term_colors = false,
    custom_highlights = function(colors)
      return {
        DiffDelete = { bg = 'none', fg = colors.overlay0 },
      }
    end,
  },
}
