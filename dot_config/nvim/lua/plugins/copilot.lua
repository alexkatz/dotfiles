return {
  'zbirenbaum/copilot.lua',
  opts = {
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
  },
}
