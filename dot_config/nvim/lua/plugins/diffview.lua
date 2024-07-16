local open_diff_view = function()
  require('fzf-lua').git_branches({
    actions = {
      ['default'] = function(selected)
        local selection = selected[1]

        local current_branch_char = string.find(selection, '*')
        if current_branch_char ~= nil then
          selection = string.sub(selection, 3)
        end

        selection = vim.trim(selection)

        require('diffview').open({ selection })
      end,
    },
  })
end

return {
  'sindrets/diffview.nvim',
  dependencies = 'nvim-lua/plenary.nvim',
  keys = {
    { '<leader>gg', '<cmd>DiffviewOpen<cr>', desc = 'Diff workspace changes' },
    { '<leader>gG', open_diff_view, desc = 'Diff with selected branch' },
    { '<leader>gF', '<cmd>DiffviewFileHistory %<cr>', desc = 'File history (this file)' },
    { '<leader>gf', '<cmd>DiffviewFileHistory<cr>', desc = 'File history' },
    { '<leader>gd', '<cmd>DiffviewClose<cr>', desc = 'Close diffview' },
  },
}
