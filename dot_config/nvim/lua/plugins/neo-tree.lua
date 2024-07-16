return {
  'nvim-neo-tree/neo-tree.nvim',
  enabled = false,
  dependencies = {
    'nvim-tree/nvim-web-devicons',
    {
      's1n7ax/nvim-window-picker',
      opts = {
        autoselect_one = true,
        include_current = false,
        filter_rules = {
          -- filter using buffer options
          bo = {
            -- if the file type is one of following, the window will be ignored
            filetype = { 'neo-tree', 'neo-tree-popup', 'notify' },

            -- if the buffer type is one of following, the window will be ignored
            buftype = { 'terminal', 'quickfix' },
          },
        },
        other_win_hl_color = '#e35e4f',
      },
      config = function() end,
    },
  },
  opts = {
    view = { adaptive_size = true },
    -- Add this section only if you've configured source selector.
    source_selector = {
      sources = {
        { source = 'filesystem', display_name = ' 󰉓 Files ' },
      },
    },
    sources = {
      'filesystem',
    },
    close_if_last_window = true,
    window = {
      mappings = {
        ['l'] = 'open',
        ['L'] = 'focus_preview',
        ['h'] = 'close_node',
        ['<C-v>'] = 'open_vsplit',
        ['s'] = 'noop',
        ['S'] = 'noop',
        ['/'] = 'noop',
        ['?'] = 'noop',
        ['g?'] = { 'show_help', desc = 'Show Neo-Tree help' },
        ['<esc>'] = 'noop',
        ['z'] = 'noop',
        ['W'] = 'close_all_nodes',
      },
    },
    filesystem = {
      follow_current_file = {
        enabled = true,
      },
    },
  },

  keys = {
    { '<leader>E', '<cmd>Neotree focus<cr>', desc = 'Focus Neotree' },
  },
}
