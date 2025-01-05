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
            accept = '<M-y>',
            accept_word = '<M-.>',
            accept_line = false,
            next = '<M-n>',
            prev = '<M-p>',
            dismiss = '<M-h>',
          },
        },
      })
    end, 100)
  end,
}
