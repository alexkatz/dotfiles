return {
  'zbirenbaum/copilot.lua',
  event = { 'VimEnter' },
  config = function()
    vim.defer_fn(function()
      require('copilot').setup({
        suggestion = {
          enabled = true,
          auto_trigger = true,
          debounce = 75,
          keymap = {
            accept = '<M-l>',
            accept_word = '<M-.>',
            accept_line = false,
            next = '<M-j>',
            prev = '<M-k>',
            dismiss = '<M-h>',
          },
        },
      })
    end, 100)
  end,
}
