return {
  'folke/sidekick.nvim',
  opts = {
    cli = {
      watch = true, -- notify Neovim of file changes done by AI CLI tools
      ---@class sidekick.win.Opts
      win = {
        ---@type vim.api.keyset.win_config
        split = {
          width = 135, -- set to 0 for default split width
          height = 20, -- set to 0 for default split height
        },
      },
    },
  },
}
