return {
  'braxtons12/blame_line.nvim',
  lazy = false,
  opts = {
    prefix = ' ',
    hl_group = 'BlameLineNvim',
    show_in_insert = false,
  },
  keys = {
    { '<leader>ub', '<cmd>BlameLineToggle<cr>', desc = 'Toggle Blame Line' },
  },
}
