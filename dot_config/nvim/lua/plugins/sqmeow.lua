return {
  {
    '2giosangmitom/sqmeow.nvim',
    version = '*',
    dependencies = { 'MunifTanjim/nui.nvim' },
    build = function()
      require('sqmeow').install()
    end,
    opts = {
      keymaps = {
        -- free up `s` for flash
        drawer = { yank_select = false },
      },
      ui = {
        drawer = {
          width = 60,
        },
        result = {
          height = 64,
        },
        border = 'rounded',
      },
    },
    cmd = 'Sqmeow',
    keys = {
      {
        '<leader>me',
        function()
          -- :Sqmeow drawer only opens, so toggle via the drawer's own visibility
          if require('sqmeow.ui.drawer').is_open() then
            require('sqmeow.api.view').close_drawer()
          else
            -- open_drawer restores the previous window, so focus the drawer it returns
            vim.api.nvim_set_current_win(require('sqmeow.api.view').open_drawer())
          end
        end,
        desc = 'Toggle Sqmeow drawer',
      },
      {
        '<leader>mr',
        function()
          if require('sqmeow.ui.result').is_open() then
            vim.cmd('Sqmeow close')
          else
            vim.cmd('Sqmeow open')
            -- like the drawer, opening keeps the cursor where it was
            local win = require('sqmeow.ui.result').window()
            if win then
              vim.api.nvim_set_current_win(win)
            end
          end
        end,
        desc = 'Toggle results',
      },
      { '<leader>mf', '<cmd>Sqmeow float<cr>', desc = 'Toggle results float' },
      { '<leader>md', '<cmd>Sqmeow stop<cr>', desc = 'Stop Sqmeow engine' },
    },
  },
  {
    'folke/which-key.nvim',
    opts = {
      spec = {
        { '<leader>m', group = 'database', icon = { icon = '󰆼 ', color = 'blue' } },
      },
    },
  },
}
