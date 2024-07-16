return {
  {
    'mbbill/undotree',
    config = function()
      vim.g.undotree_DiffAutoOpen = 0
    end,

    keys = {
      { '<leader>U', '<cmd>UndotreeToggle<cr> <cmd>UndotreeFocus<cr>', desc = 'Toggle Undo Tree' },
    },
  },
}
