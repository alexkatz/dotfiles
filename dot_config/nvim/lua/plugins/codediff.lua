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
    -- gF: like codediff's gf (open in previous tab), but keep the diff tab open.
    -- Reuses the buffer-local gf callback with close_on_open_in_prev_tab disabled.
    vim.keymap.set('n', 'gF', function()
      local map = vim.fn.maparg('gf', 'n', false, true)
      local in_session = require('codediff.ui.lifecycle').get_session(vim.api.nvim_get_current_tabpage())
      if not (in_session and map.buffer == 1 and map.callback) then
        return vim.cmd('normal! ' .. vim.v.count1 .. 'gF')
      end
      local view_opts = require('codediff.config').options.keymaps.view
      local close = view_opts.close_on_open_in_prev_tab
      view_opts.close_on_open_in_prev_tab = false
      local ok, err = pcall(map.callback)
      view_opts.close_on_open_in_prev_tab = close
      if not ok then
        vim.notify(err, vim.log.levels.ERROR)
      end
    end, { desc = 'Open buffer in previous tab (keep diff open)' })
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
      '<leader>gc',
      function()
        Snacks.picker.git_log({
          title = 'Select commit (vs working tree) or <Tab> to mark a range',
          confirm = function(picker)
            local items = picker:selected({ fallback = true })
            picker:close()
            if #items == 1 then
              vim.cmd('CodeDiff ' .. items[1].commit)
              return
            end
            -- git log lists newest first, so a higher idx means an older commit
            table.sort(items, function(a, b)
              return a.idx > b.idx
            end)
            local oldest, newest = items[1].commit, items[#items].commit
            -- Diff from the parent of the oldest commit so its own changes are included
            local base = oldest .. '^'
            vim.fn.system({ 'git', 'rev-parse', '--verify', '--quiet', base })
            if vim.v.shell_error ~= 0 then
              base = oldest -- root commit has no parent
            end
            vim.cmd('CodeDiff ' .. base .. ' ' .. newest)
          end,
        })
      end,
      desc = 'Diff commit vs working tree, or commit range',
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
