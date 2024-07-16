return {
  'akinsho/bufferline.nvim',
  opts = {
    highlights = require('catppuccin.groups.integrations.bufferline').get(),
    options = {
      show_buffer_close_icons = false,
      show_buffer_icons = false,
      truncate_names = false,
    },
  },
  enabled = false,
}
