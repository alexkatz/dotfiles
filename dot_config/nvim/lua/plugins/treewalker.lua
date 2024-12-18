return {
  'aaronik/treewalker.nvim',
  opts = {
    highlight = true, -- Whether to briefly highlight the node after jumping to it
    highlight_duration = 250, -- How long should above highlight last (in ms)
  },
  keys = function()
    local tw = require('treewalker')
    return {
      { '<M-j>', tw.move_down, desc = 'Move down' },
      { '<M-k>', tw.move_up, desc = 'Move up' },
      { '<M-l>', tw.move_in, desc = 'Move in' },
      { '<M-h>', tw.move_out, desc = 'Move out' },
    }
  end,
}
