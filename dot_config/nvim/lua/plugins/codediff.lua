return {
  'esmuellert/codediff.nvim',
  dependencies = { 'MunifTanjim/nui.nvim' },
  cmd = 'CodeDiff',
  opts = {
    explorer = {
      view_mode = 'tree',
    },
    keymaps = {
      view = {
        next_file = '<tab>',
        prev_file = '<s-tab>',
        close_on_open_in_prev_tab = true,
      },
    },
  },
  keys = {
    {
      '<leader>gg',
      '<cmd>CodeDiff<cr>',
      desc = 'Diff workspace changes',
    },
    {
      '<leader>gG',
      function()
        Snacks.picker.git_branches({
          all = true,
          confirm = function(_, item)
            vim.cmd('CodeDiff ' .. item.branch)
          end,
        })
      end,
      desc = 'Diff with selected branch',
    },
    {
      '<leader>gf',
      '<cmd>CodeDiff history %<cr>',
      desc = 'File history (this file)',
    },
    {
      '<leader>gF',
      '<cmd>CodeDiff history<cr>',
      desc = 'File history',
    },
  },
}
