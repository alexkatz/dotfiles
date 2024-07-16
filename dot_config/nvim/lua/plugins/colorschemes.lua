return {
  'catppuccin/nvim',
  name = 'catppuccin',
  opts = {
    flavour = 'macchiato', -- latte, frappe, macchiato, mocha
    transparent_background = true,
    term_colors = false,
    custom_highlights = function(colors)
      return {
        DiffDelete = { bg = 'none', fg = colors.overlay0 },
        BlameLineNvim = { bg = 'none', fg = colors.surface1 },
        Folded = { bg = 'none' },
      }
    end,
  },
}
