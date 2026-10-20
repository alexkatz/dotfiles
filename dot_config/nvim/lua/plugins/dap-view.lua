return {
  {
    'https://github.com/igorlfs/nvim-dap-view',
    opts = {
      auto_toggle = true,
      winbar = {
        show = false,
        default_section = 'scopes',
      },
      windows = {
        position = 'right',
      },
      hover = {
        border = 'rounded',
      },
      keymaps = {
        base = {
          next_view = { ']v', '<Tab>' },
          prev_view = { '[v', '<S-Tab>' },
        },
      },
    },
    keys = {
      {
        '<leader>du',
        '<cmd>DapViewToggle<CR>',
        desc = 'DAP View Toggle',
      },
      {
        '<leader>dk',
        '<cmd>DapViewHover!<CR>',
        desc = 'DAP View Hover',
      },
      {
        '<leader>dv',
        '<cmd>DapViewVirtualTextToggle<CR>',
        desc = 'DAP View Virtual Text Toggle',
      },
    },
  },
  {
    'mfussenegger/nvim-dap',
    -- load dap-view alongside nvim-dap so its auto_toggle listeners exist before the first session
    dependencies = { 'https://github.com/igorlfs/nvim-dap-view' },
    keys = {
      { '<leader>dj', false },
      { '<leader>dk', false },
      { '<leader>dl', false },
      { '<leader>dP', false },
    },
  },
}
