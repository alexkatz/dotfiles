return {
  'saghen/blink.cmp',
  opts = {
    completion = {
      ghost_text = { enabled = false },
      accept = { auto_brackets = { enabled = false } },
      documentation = {
        window = {
          border = 'rounded',
          winblend = 15,
        },
      },
      menu = {
        draw = { treesitter = { 'lsp' } },
        border = 'rounded',
        winblend = 15,
      },
    },
    signature = {
      enabled = true,
      window = {
        border = 'rounded',
        winblend = 15,
      },
    },
  },
}
