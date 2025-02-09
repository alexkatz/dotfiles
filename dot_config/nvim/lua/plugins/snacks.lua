return {
  'folke/snacks.nvim',
  ---@type snacks.Config
  opts = {
    scroll = { enabled = false },
    bufdelete = { enabled = true },
    picker = {

      win = {
        -- input window
        input = {
          keys = {
            ['<Esc>'] = { 'close', mode = { 'n', 'i' } },
            ['<a-BS>'] = { '<c-s-w>', mode = { 'i' }, expr = true, desc = 'delete word' },
          },
        },
      },
    },
  },
}
