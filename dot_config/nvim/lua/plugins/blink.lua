return {
  'saghen/blink.cmp',
  opts = {
    completion = {
      ghost_text = { enabled = false },
      accept = { auto_brackets = { enabled = false } },
      documentation = {
        window = {
          winblend = 15,
        },
      },
      menu = {
        draw = { treesitter = { 'lsp' } },
        winblend = 15,
      },
    },
  },
}
