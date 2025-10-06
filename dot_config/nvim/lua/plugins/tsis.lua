return {
  'shushtain/nvim-treesitter-incremental-selection',
  config = function()
    local tsis = require('nvim-treesitter-incremental-selection')

    ---@type TSIS.Config
    tsis.setup({
      ignore_injections = false,
      loop_siblings = true,
      fallback = true,
      quiet = true,
    })

    vim.keymap.set('n', '<M-v>', tsis.init_selection, { desc = 'Initialize TSIS selection' })
    vim.keymap.set('v', '<M-v>', tsis.increment_node, { desc = 'Increment TSIS selection' })
    vim.keymap.set('v', '<BS>', tsis.decrement_node, { desc = 'Decrement TSIS selection' })
    vim.keymap.set('v', '<M-n>', tsis.next_sibling, { desc = 'TSIS next sibling' })
    vim.keymap.set('v', '<M-p>', tsis.prev_sibling, { desc = 'TSIS previous sibling' })
  end,
}
