return {
  'sindrets/diffview.nvim',
  dependencies = 'nvim-lua/plenary.nvim',
  keys = {
    { '<leader>gg', '<cmd>DiffviewOpen<cr>', desc = 'Diff workspace changes' },
    {
      '<leader>gG',
      function()
        Snacks.picker.git_branches({
          confirm = function(_, item)
            require('diffview').open({ item.branch })
          end,
        })
      end,
      desc = 'Diff with selected branch',
    },
    { '<leader>gF', '<cmd>DiffviewFileHistory %<cr>', desc = 'File history (this file)' },
    { '<leader>gf', '<cmd>DiffviewFileHistory<cr>', desc = 'File history' },
  },
}
