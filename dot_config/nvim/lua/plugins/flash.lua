return {
  'folke/flash.nvim',
  opts = {
    modes = {
      char = { autohide = true },
      treesitter = {
        autohide = true,
        label = { before = false, after = false }, --{ style = 'overlay' },
        search = { incremental = true },
      },
    },
  },
}
