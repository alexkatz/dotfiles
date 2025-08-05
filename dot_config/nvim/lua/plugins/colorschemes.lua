return {
  'catppuccin/nvim',
  tag = 'v1.11.0',
  name = 'catppuccin',
  opts = {
    flavour = 'macchiato', -- latte, frappe, macchiato, mocha
    transparent_background = true,
    term_colors = false,
    custom_highlights = function(colors)
      return {
        DiffDelete = { bg = 'none', fg = colors.overlay0 },
      }
    end,
  },
}
