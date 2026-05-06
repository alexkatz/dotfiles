return {
  'esmuellert/codediff.nvim',
  dependencies = { 'MunifTanjim/nui.nvim' },
  cmd = 'CodeDiff',
  config = function(_, opts)
    require('codediff').setup(opts)
    local group = vim.api.nvim_create_augroup('CodeDiffNoCursorline', { clear = true })
    vim.api.nvim_create_autocmd('User', {
      group = group,
      pattern = 'CodeDiffOpen',
      callback = function(event)
        local tabpage = event.data and event.data.tabpage
        if not tabpage then
          return
        end
        vim.schedule(function()
          for _, win in ipairs(vim.api.nvim_tabpage_list_wins(tabpage)) do
            if vim.api.nvim_win_is_valid(win) then
              vim.wo[win].cursorline = false
            end
          end
        end)
      end,
    })
    vim.api.nvim_create_autocmd('FileType', {
      group = group,
      pattern = { 'codediff-explorer', 'codediff-help' },
      callback = function()
        vim.wo.cursorline = false
      end,
    })
  end,
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
