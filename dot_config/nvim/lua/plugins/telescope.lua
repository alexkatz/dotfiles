return {
  'nvim-telescope/telescope.nvim',
  enabled = false,
  keys = {
    { '<leader>gc', false },
    { '<leader>gs', false },
    { '<leader>sR', '<cmd>Telescope resume<cr>', desc = 'Resume Search' },
    { '<leader>fR', '<cmd>Telescope resume<cr>', desc = 'Resume Search' },
    { '<leader>s"', '<cmd>Telescope registers<cr>', desc = 'Search Registers' },
  },

  opts = function(_, opts)
    local actions = require('telescope.actions')

    opts.pickers = {
      lsp_references = { show_line = false, include_current_line = true },
      buffers = {
        show_all_buffers = true,
        sort_mru = true,
        mappings = {
          i = {
            ['<c-w>'] = actions.delete_buffer,
          },
        },
      },
    }

    opts.defaults.mappings.i['<C-q>'] = actions.smart_send_to_qflist + actions.open_qflist
    opts.defaults.mappings.i['<cr>'] = actions.select_default
    opts.defaults.mappings.i['<C-j>'] = actions.move_selection_next
    opts.defaults.mappings.i['<C-k>'] = actions.move_selection_previous
    opts.defaults.mappings.i['<esc>'] = actions.close

    opts.defaults.mappings.i['<C-n>'] = function(...)
      actions.results_scrolling_down(...)
    end

    opts.defaults.mappings.i['<C-p>'] = function(...)
      actions.results_scrolling_up(...)
    end
  end,
}
